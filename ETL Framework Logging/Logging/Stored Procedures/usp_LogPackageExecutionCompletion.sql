

CREATE PROCEDURE [Logging].[usp_LogPackageExecutionCompletion]  @JobId                      int
                                                              ,@PackageId                  int
                                                              ,@ExecutionId                int
													          ,@Channel                    int
														      ,@DatabaseName               varchar(128)
														      ,@SchemaName                 varchar(128)
														      ,@TableName                  varchar(128)
															  ,@SourceType                 char
														      ,@SourceName                 varchar(128)
														      ,@RowsInserted               int
													  	      ,@RowsUpdated                int
														      ,@RowsDeleted                int
														      ,@RowsRejected               int
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE  @ApplicationId   int           = 1
		    ,@EnvironmentId   int           = 1
		    ,@Severity        int           = 8
		    ,@Priority        int           = 1
		    ,@LogType         int           = 1
		    ,@ErrorMessage    varchar(MAX)
			,@SqlStatement    varchar(2)    = NULL;

	BEGIN TRANSACTION
		BEGIN TRY
			IF EXISTS (SELECT 1
					   FROM   [Logging].[PackageExecution]
					   WHERE  [JobId]           = @JobId
					   AND    [PackageId]       = @PackageId
					   AND    [ExecutionId]     = @ExecutionId
					   AND    [Channel]         = @Channel
					   AND    [ExecutionStatus] = 1)
			BEGIN
				UPDATE [Logging].[PackageExecution]
				SET     [EndTime]                    = GETDATE()
					   ,[ExecutionStatus]            = 2
			    WHERE  [JobId]                       = @JobId
				AND    [PackageId]                   = @PackageId
				AND    [ExecutionId]                 = @ExecutionId
			    AND    [Channel]                     = @Channel
				AND    [ExecutionStatus]             = 1;	
				
				EXECUTE [Logging].[usp_LogDmlExecutionCompletion]  @PackageId
																  ,@ExecutionId
																  ,@Channel
																  ,@SourceType
																  ,@SourceName
																  ,@DatabaseName
																  ,@SchemaName
																  ,@TableName
																  ,@SqlStatement
																  ,@RowsInserted
																  ,@RowsUpdated
																  ,@RowsDeleted
																  ,@RowsRejected;
			END;
		END TRY
		BEGIN CATCH
			IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK;
			END;

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



