





CREATE PROCEDURE [Logging].[usp_LogJobExecutionError]  @JobId        int
                                                      ,@ExecutionId  int
													  ,@UserName     varchar(256)
													  ,@MachineName  varchar(256)
											          ,@ErrorMessage varchar(max) = ''
AS
BEGIN
	SET NOCOUNT ON;

    DECLARE  @ApplicationId   int           = 1
			,@Severity        int           = 8
			,@Priority        int           = 1
			,@LogType         int           = 1;
			
	IF    EXISTS (SELECT 1
	             FROM   [Logging].[JobExecution]
			     WHERE  JobId           = @JobId
			     AND    ExecutionStatus = 1)
       OR NOT EXISTS (SELECT 1
	                 FROM   [Logging].[JobExecution]
			         WHERE  JobId           = @JobId)
	BEGIN
		INSERT INTO [Logging].[JobExecution]
			  ([JobId]
			  ,[ApplicationId]
			  ,[UserName]
			  ,[MachineName]
			  ,[StartTime]
			  ,[EndTime]
			  ,[ExecutionStatus]
			  ,[ErrorMessage])
		VALUES
			  (@JobId
			  ,1
			  ,@UserName
			  ,@MachineName
			  ,GETDATE()
			  ,GETDATE()
			  ,3
			  ,@ErrorMessage);
	END
	ELSE
	BEGIN
		UPDATE   [Logging].[JobExecution]
		SET      [EndTime]         = GETDATE()
				,[ExecutionStatus] = 3
				,[ErrorMessage]    = @ErrorMessage
		WHERE    [Id]              = @ExecutionId
		AND      [JobId]           = @JobId;                  
	END;	
END;
