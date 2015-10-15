


CREATE PROCEDURE [Logging].[usp_LogPackageExecutionError] @JobId                     int
                                                        ,@ExecutionId               int
                                                        ,@PackageId                 int
													    ,@Channel                   int
														,@DatabaseName              varchar(128)
														,@SchemaName                varchar(128)
														,@TableName                 varchar(128)
														,@SourceType                char
														,@SourceName                varchar(128)
														,@ErrorMessage              varchar(max) = ''
AS
BEGIN
	SET NOCOUNT ON;

    DECLARE  @RowsInserted    int = 0
			,@RowsUpdated     int = 0
			,@RowsDeleted     int = 0
			,@RowsRejected    int = 0
	        ,@ErrorRaiseD     bit = 1
			,@ApplicationId   int = 1
			,@EnvironmentId   int = 1
			,@Severity        int = 8
			,@Priority        int = 1
			,@LogType         int = 1;
				
	BEGIN TRANSACTION
		BEGIN TRY
			UPDATE  [Logging].[PackageExecution]
			SET     [EndTime]         = GETDATE()
				   ,[ExecutionStatus] = 3
				   ,[ErrorMessage]    = @ErrorMessage								       
			WHERE   [JobId]           = @JobId
			AND     [PackageId]       = @PackageId
			AND     [ExecutionId]     = @ExecutionId
			AND     [Channel]         = @Channel
			AND     [ExecutionStatus] = 1;	
				
			IF @SourceType = 'D'
			BEGIN
				EXECUTE [Logging].[usp_LogDmlExecutionCompletion]  @PackageId
																  ,@ExecutionId
																  ,@Channel
																  ,@SourceType
																  ,@SourceName
																  ,@DatabaseName
																  ,@SchemaName
																  ,@TableName
																  ,@RowsInserted
																  ,@RowsUpdated
																  ,@RowsDeleted
																  ,@RowsRejected
																  ,@ErrorRaised
																  ,@ErrorMessage			
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



