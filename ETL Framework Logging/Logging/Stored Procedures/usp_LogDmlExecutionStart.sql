

CREATE PROCEDURE [Logging].[usp_LogDmlExecutionStart]  @PackageId           int
                                                     ,@ExecutionId         int
													,@Channel             int
   										             ,@SourceType          char
													,@SourceName          varchar(128)
													,@DatabaseName        varchar(128)
													,@SchemaName          varchar(128)
													,@TableName           varchar(128)
													,@SqlStatement        varchar(MAX)
AS
BEGIN
	SET NOCOUNT ON;

    DECLARE  @AlecsServiceUrl nvarchar(max)	= ''
	       ,@AlecsFmtMessage nvarchar(max)	
	       ,@AlecsMessage    nvarchar(max)	= N'DML Statement Start Of Execution'
			,@Rv              nvarchar(max)
			,@ApplicationId   int           = 1
			,@EnvironmentId   int           = 1
			,@Severity        int           = 8
			,@Priority        int           = 1
			,@LogType         int           = 1
			,@StartTime         datetime      = GETDATE();

	IF NOT EXISTS (SELECT 1
					FROM   [Logging].[DmlExecution]
					WHERE  [PackageId]                      = @PackageId
					AND    [ExecutionId]                    = @ExecutionId
					AND    [TableName]                      = @TableName
					AND    [SchemaName]                     = @TableName
					AND    [DatabaseName]                   = @DatabaseName
					AND    ISNULL([SqlStatement], 'ABCXYC') = ISNULL(@SqlStatement, 'ABCXYC') )
	BEGIN
		INSERT INTO [Logging].[DmlExecution]
					([PackageId]
					,[ExecutionId]
					,[Channel]
					,[DatabaseName]
					,[SchemaName]
					,[TableName]
					,[SourceType]
					,[SourceName]
					,[SqlStatement]
					,[StartTime])
		VALUES    ( @PackageId
				   ,@ExecutionId
				   ,@Channel 
				   ,@DatabaseName
				   ,@SchemaName
				   ,@TableName
				   ,@SourceType
				   ,@SourceName
				   ,@SqlStatement
				   ,@StartTime    );
	END;
END;










