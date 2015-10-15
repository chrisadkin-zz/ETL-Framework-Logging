





CREATE PROCEDURE [Logging].[usp_LogDmlExecutionError]  @PackageId    int
                                                     ,@ExecutionId  int
													 ,@Channel      int
													 ,@SourceType   char
   													 ,@SourceName   varchar(128)
													 ,@DatabaseName varchar(128)
													 ,@SchemaName   varchar(128)
													 ,@TableName    varchar(128)
													 ,@StartTime    datetime
													 ,@ErrorMessage varchar(MAX)
AS
BEGIN
	SET NOCOUNT ON;

    DECLARE  @Rv              nvarchar(max)
			,@ApplicationId   int           = 1
			,@EnvironmentId   int           = 1
			,@Severity        int           = 8
			,@Priority        int           = 1
			,@LogType         int           = 1;

	INSERT INTO [Logging].[DmlExecution]
            ( [PackageId]
             ,[ExecutionId]
             ,[Channel]
             ,[DatabaseName]
             ,[SchemaName]
             ,[TableName]
             ,[SourceType]
             ,[SourceName]
             ,[StartTime]
             ,[EndTime]
             ,[ErrorMessage]
             ,[ExecutionStatus])
     VALUES ( @PackageId
             ,@ExecutionId
             ,@Channel
             ,@DatabaseName
             ,@SchemaName
             ,@TableName
             ,@SourceType
             ,@SourceName
             ,@StartTime
             ,GETDATE()
             ,@ErrorMessage
             ,3);
END;


