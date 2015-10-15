CREATE TABLE [Logging].[ProcessedDataSource] (
    [ExecutionId]        INT           NOT NULL,
    [PackageId]          INT           NOT NULL,
    [SourceName]         VARCHAR (259) NOT NULL,
    [ArchivedSourceName] VARCHAR (259) NULL,
    CONSTRAINT [PkProcessedDataSource] PRIMARY KEY CLUSTERED ([ExecutionId] ASC, [PackageId] ASC, [SourceName] ASC),
    CONSTRAINT [FkPdsExecutionId] FOREIGN KEY ([ExecutionId]) REFERENCES [Logging].[JobExecution] ([Id])
);

