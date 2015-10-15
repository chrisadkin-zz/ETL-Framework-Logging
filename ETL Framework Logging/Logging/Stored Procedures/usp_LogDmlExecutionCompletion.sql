
CREATE PROCEDURE [Logging].[usp_LogDmlExecutionCompletion]  @PackageId    int
                                                          ,@ExecutionId  int
													      ,@Channel      int
													      ,@SourceType   char
   													      ,@SourceName   varchar(128)
													      ,@DatabaseName varchar(128)
														  ,@SchemaName   varchar(128)
														  ,@TableName    varchar(128)
														  ,@SqlStatement varchar(MAX) = NULL
														  ,@RowsInserted int
														  ,@RowsUpdated  int
														  ,@RowsDeleted  int
														  ,@RowsRejected int
AS
BEGIN
	SET NOCOUNT ON;

    DECLARE  @Rv              nvarchar(max)
			,@ApplicationId   int           = 1
			,@EnvironmentId   int           = 1
			,@Severity        int           = 8
			,@Priority        int           = 1
			,@LogType         int           = 1
			,@EndTime         datetime      = GETDATE();

	UPDATE  [Logging].[DmlExecution]
	SET     [RowsInserted]                = @RowsInserted
		   ,[RowsUpdated]                 = @RowsUpdated
		   ,[RowsDeleted]                 = @RowsDeleted
		   ,[RowsRejected]                = @RowsRejected
		   ,[EndTime]                     = @EndTime
           ,[ExecutionStatus]             = 2
	WHERE  PackageId                      = @PackageId           
    AND    ExecutionId                    = @ExecutionId         
    AND    Channel                        = @Channel         
   	AND    SourceType                     = @SourceType
	AND    TableName                      = @TableName           
	AND    SchemaName                     = @SchemaName          
	AND    DatabaseName                   = @DatabaseName
	AND    ISNULL(SqlStatement, 'ABCXYZ') = ISNULL(@SqlStatement, 'ABCXYZ')       																	
END;


