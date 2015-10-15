CREATE TABLE [Logging].[PackageExecution] (
    [JobId]                      INT           NOT NULL,
    [PackageId]                  INT           NOT NULL,
    [ExecutionId]                INT           NOT NULL,
    [ISServerExecutionId]        INT           DEFAULT ((0)) NOT NULL,
    [Channel]                    INT           NOT NULL,
    [StartTime]                  DATETIME      DEFAULT (getdate()) NOT NULL,
    [EndTime]                    DATETIME      NULL,
    [ErrorMessage]               VARCHAR (MAX) NULL,
    [ExecutionStatus]            INT           NULL,
    [PrecedenceConstraintPassed] BIT           DEFAULT ((1)) NULL,
    CONSTRAINT [FkPeExecutionStatus] FOREIGN KEY ([ExecutionStatus]) REFERENCES [Logging].[ExecutionStatus] ([Id])
);

