CREATE TABLE [Logging].[ProcessedDataDestination] (
    [ExecutionId]             INT           NOT NULL,
    [PackageId]               INT           NOT NULL,
    [DestinationName]         VARCHAR (259) NOT NULL,
    [ArchivedDestinationName] VARCHAR (259) NULL,
    CONSTRAINT [PkProcessedDataDestination] PRIMARY KEY CLUSTERED ([ExecutionId] ASC, [PackageId] ASC, [DestinationName] ASC),
    CONSTRAINT [FkPddExecutionId] FOREIGN KEY ([ExecutionId]) REFERENCES [Logging].[JobExecution] ([Id])
);

