CREATE TABLE [Logging].[SourceType] (
    [ShortCode]   CHAR (2)      NOT NULL,
    [Description] VARCHAR (128) NOT NULL,
    CONSTRAINT [PkSourceType] PRIMARY KEY CLUSTERED ([ShortCode] ASC)
);

