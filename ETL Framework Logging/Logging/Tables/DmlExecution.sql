CREATE TABLE [Logging].[DmlExecution] (
    [PackageId]       INT           NOT NULL,
    [ExecutionId]     INT           NOT NULL,
    [Channel]         INT           NOT NULL,
    [DatabaseName]    VARCHAR (128) NOT NULL,
    [SchemaName]      VARCHAR (128) NOT NULL,
    [TableName]       VARCHAR (128) NOT NULL,
    [SourceType]      CHAR (2)      NOT NULL,
    [SourceName]      VARCHAR (128) NOT NULL,
    [SqlStatement]    VARCHAR (MAX) NULL,
    [RowsInserted]    INT           DEFAULT ((0)) NULL,
    [RowsUpdated]     INT           DEFAULT ((0)) NULL,
    [RowsDeleted]     INT           DEFAULT ((0)) NULL,
    [RowsRejected]    INT           DEFAULT ((0)) NULL,
    [StartTime]       DATETIME      DEFAULT (getdate()) NOT NULL,
    [EndTime]         DATETIME      NULL,
    [ErrorMessage]    VARCHAR (MAX) NULL,
    [ExecutionStatus] INT           NULL,
    CONSTRAINT [FkDeExecutionStatus] FOREIGN KEY ([ExecutionStatus]) REFERENCES [Logging].[ExecutionStatus] ([Id])
);

