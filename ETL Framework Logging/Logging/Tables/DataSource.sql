CREATE TABLE [Logging].[DataSource] (
    [ShortCode]   CHAR (2)      NOT NULL,
    [Description] VARCHAR (128) NOT NULL,
    CONSTRAINT [PkDataSource] PRIMARY KEY CLUSTERED ([ShortCode] ASC)
);

