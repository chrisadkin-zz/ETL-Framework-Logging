




CREATE PROCEDURE [Logging].[usp_LogJobExecutionCompletion]  @JobId        int
                                                           ,@ExecutionId  int
AS
BEGIN
	SET NOCOUNT ON;

    DECLARE  @ApplicationId   int           = 1
			,@EnvironmentId   int           = 1
			,@Severity        int           = 8
			,@Priority        int           = 1
			,@LogType         int           = 1;
			
	IF NOT EXISTS (SELECT 1
					FROM   [Logging].[JobExecution]
					WHERE  [JobId]           = @JobId
					AND    [Id]              = @ExecutionId
					AND    [ExecutionStatus] > 1)
	BEGIN
		IF EXISTS (SELECT 1
			       FROM    [Logging].[PackageExecution]
                   WHERE  ExecutionId     = @ExecutionId
 				   AND    JobId           = @JobId
				   AND    ExecutionStatus = 3)
		BEGIN
			UPDATE   [Logging].[JobExecution]
			SET      [EndTime]         = GETDATE()
                    ,[ExecutionStatus] = 3
					,[ErrorMessage]    = 'Errors encountered during child package execution'
			WHERE    [Id]    = @ExecutionId
			AND      [JobId] = @JobId;								   
		END
		ELSE
		BEGIN
			UPDATE   [Logging].[JobExecution]
			SET      [EndTime]         = GETDATE()
                    ,[ExecutionStatus] = 2
			WHERE    [Id]              = @ExecutionId
			AND      [JobId]           = @JobId; 		END;
	END;
END;
