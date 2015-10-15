
CREATE PROCEDURE [Logging].[usp_GetExecutionId]
     @JobId         int
	,@ApplicationId int
	,@UserName      varchar(256)
	,@MachineName   varchar(256)
	,@ExecutionId   int          OUTPUT
AS
BEGIN
	DECLARE @Execution TABLE
	(
		id INT
	);


	INSERT INTO [Logging].[JobExecution] 
			   ( [JobId]
			    ,[ApplicationId]
			    ,[UserName]
			    ,[MachineName]
			    ,[StartTime]
			    ,[ExecutionStatus]) 
	OUTPUT INSERTED.Id INTO @Execution(Id)
		VALUES ( @JobId
			    ,@ApplicationId
			    ,@UserName
			    ,@MachineName
			    ,GETDATE()
			    ,1);

	SELECT @ExecutionId = Id
	FROM   @Execution;
END;
