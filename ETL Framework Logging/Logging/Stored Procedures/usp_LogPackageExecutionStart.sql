


CREATE PROCEDURE [Logging].[usp_LogPackageExecutionStart]  @JobId               int
                                                         ,@PackageId           int
                                                         ,@ExecutionId         int
														 ,@ISServerExecutionId int
													     ,@Channel             int
														 ,@DatabaseName        varchar(128)
														 ,@SchemaName          varchar(128)
														 ,@TableName           varchar(128)
														 ,@SourceType          char
														 ,@SourceName          varchar(128)

AS
BEGIN
	SET NOCOUNT ON;

    DECLARE  @ApplicationId   int           = 1
			,@EnvironmentId   int           = 1
			,@Severity        int           = 8
			,@Priority        int           = 1
			,@LogType         int           = 1
			,@SqlStatement    varchar(2)    = NULL;

	BEGIN TRANSACTION
		BEGIN TRY
			IF NOT EXISTS (SELECT 1
						   FROM   [Logging].[PackageExecution]
						   WHERE  [JobId]       = @JobId
						   AND    [PackageId]   = @PackageId
						   AND    [ExecutionId] = @ExecutionId)
			BEGIN
				INSERT INTO [Logging].[PackageExecution]
						   ( [JobId]
							,[PackageId]
							,[ExecutionId]
							,[Channel]
							,[StartTime]
							,[ExecutionStatus])
					VALUES ( @JobId
							,@PackageId
							,@ExecutionId
							,@Channel
							,GETDATE()
							,1);
				/*
				 * Permissable Source Types are P -> stored Procedure
				 *                          or  D -> data flow
				 */
				IF ISNULL(@SourceType, 'X') = ('D')
				BEGIN
					EXECUTE [Logging].[usp_LogDmlExecutionStart]  @PackageId
																 ,@ExecutionId
																 ,@Channel
																 ,@SourceType
																 ,@SourceName
																 ,@DatabaseName
																 ,@SchemaName
																 ,@TableName
																 ,@SqlStatement;
				END;
			END;
		END TRY
		BEGIN CATCH
			IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK;
			END;

			DECLARE @ErrorMessage VARCHAR(MAX);

			SELECT @ErrorMessage = ERROR_MESSAGE();

			UPDATE JobExecution
			SET    ErrorMessage = @ErrorMessage
			WHERE  JobId        = @JobId
			AND    id           = @ExecutionId;
		END CATCH;

	IF @@TRANCOUNT > 0
	BEGIN
		COMMIT;
	END;	
END;



