CREATE TABLE [Logging].[JobExecution] (
    [Id]              INT           IDENTITY (1, 1) NOT NULL,
    [JobId]           INT           NOT NULL,
    [ApplicationId]   INT           NOT NULL,
    [UserName]        VARCHAR (256) NOT NULL,
    [MachineName]     VARCHAR (256) NOT NULL,
    [StartTime]       DATETIME      NOT NULL,
    [EndTime]         DATETIME      NULL,
    [ExecutionStatus] INT           NOT NULL,
    [ErrorMessage]    VARCHAR (MAX) NULL,
    CONSTRAINT [PkJobExecution] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FkJeExecutionStatus] FOREIGN KEY ([ExecutionStatus]) REFERENCES [Logging].[ExecutionStatus] ([Id])
);

