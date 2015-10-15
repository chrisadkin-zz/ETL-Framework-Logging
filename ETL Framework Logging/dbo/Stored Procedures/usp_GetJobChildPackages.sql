-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetJobChildPackages] @JobName varchar(64)
AS
BEGIN
	SET NOCOUNT ON;

    SELECT  chan1.Name                                         AS PackageName_Channel1
           ,chan1.Id                                           AS PackageId_Channel1
		   ,IntParameter_Channel1                              AS IntParameter_Channel1
		   ,VarcharParameter_Channel1                          AS VarcharParameter_Channel1
           /*
		   * Channel 2 child packages
			*/
           ,CASE chan2.Enabled
			   WHEN 1
			       THEN ISNULL(chan2.Name, 'Disable Channel') 
			   ELSE 'Disable Channel'
		   END	                                              AS PackageName_Channel2
		  ,IntParameter_Channel2                             AS IntParameter_Channel2
		  ,VarcharParameter_Channel2                         AS VarcharParameter_Channel2
           ,CASE chan2.Enabled
			   WHEN 1
			       THEN chan2.Id 
			   ELSE 0
		   END	                                              AS PackageId_Channel2
           /*
		   * Channel 3 child packages 
			*/
           ,CASE chan3.Enabled
			   WHEN 1
			       THEN ISNULL(chan3.Name, 'Disable Channel') 
			   ELSE 'Disable Channel'
 		   END	                                              AS PackageName_Channel3
		  ,IntParameter_Channel3                             AS IntParameter_Channel3
		  ,VarcharParameter_Channel3                         AS VarcharParameter_Channel3
           ,CASE chan3.Enabled
			   WHEN 1
			       THEN chan3.Id 
			   ELSE 0
		   END	                                              AS PackageId_Channel3
           /*
		   * Channel 4 child packages
			*/
           ,CASE chan4.Enabled
			   WHEN 1
			       THEN ISNULL(chan4.Name, 'Disable Channel') 
			   ELSE 'Disable Channel'
		   END	                                              AS PackageName_Channel4
		  ,IntParameter_Channel4                             AS IntParameter_Channel4
		  ,VarcharParameter_Channel4                         AS VarcharParameter_Channel4
           ,CASE chan4.Enabled
			   WHEN 1
			       THEN chan4.Id 
			   ELSE 0
		   END	                                              AS PackageId_Channel4
           /*
		   * Channel 5 child packages 
			*/
           ,CASE chan5.Enabled
			   WHEN 1
			       THEN ISNULL(chan5.Name, 'Disable Channel') 
			   ELSE 'Disable Channel'
		   END	                                              AS PackageName_Channel5
		  ,IntParameter_Channel5                             AS IntParameter_Channel5
		  ,VarcharParameter_Channel5                         AS VarcharParameter_Channel5
           ,CASE chan5.Enabled
			   WHEN 1
			       THEN chan5.Id 
			   ELSE 0
		   END	                                              AS PackageId_Channel5
           /*
		   * Channel 6 child packages
			*/
           ,CASE chan6.Enabled
			   WHEN 1
			       THEN ISNULL(chan6.Name, 'Disable Channel') 
			   ELSE 'Disable Channel'
		   END	                                              AS PackageName_Channel6
		  ,IntParameter_Channel6                             AS IntParameter_Channel6
		  ,VarcharParameter_Channel6                         AS VarcharParameter_Channel6
           ,CASE chan6.Enabled
			   WHEN 1
			       THEN chan6.Id                                           
			   ELSE 0
		   END	                                              AS PackageId_Channel6
           /*
		   * Channel 7 child packages
			*/
           ,CASE chan7.Enabled
			   WHEN 1
			       THEN ISNULL(chan7.Name, 'Disable Channel') 
			   ELSE 'Disable Channel'
		   END	                                              AS PackageName_Channel7
		  ,IntParameter_Channel7                             AS IntParameter_Channel7
		  ,VarcharParameter_Channel7                         AS VarcharParameter_Channel7
           ,CASE chan7.Enabled
			  WHEN 1
			      THEN chan7.Id                                           
			  ELSE 0
		  END	                                              AS PackageId_Channel7
           /*
		   * Channel 8 child packages
			*/
          ,CASE chan8.Enabled
			  WHEN 1
			      THEN ISNULL(chan8.Name, 'Disable Channel') 
			  ELSE 'Disable Channel'
		  END	                                              AS PackageName_Channel8
		 ,IntParameter_Channel8                              AS IntParameter_Channel8
		 ,VarcharParameter_Channel8                          AS VarcharParameter_Channel8
          ,CASE chan8.Enabled
			  WHEN 1
			      THEN chan8.Id                                           
			  ELSE 0
		  END	                                              AS PackageId_Channel8
	FROM      Job j
	JOIN      JobPackageSchedule pro
	ON        pro.JobId = j.Id
	JOIN      Package chan1
	ON        pro.PackageId_Channel1 = chan1.Id
	LEFT JOIN Package chan2
	ON        pro.PackageId_Channel2 = chan2.Id
	LEFT JOIN Package chan3
	ON        pro.PackageId_Channel3 = chan3.Id
	LEFT JOIN Package chan4
	ON        pro.PackageId_Channel4 = chan4.Id
	LEFT JOIN Package chan5
	ON        pro.PackageId_Channel5 = chan5.Id
	LEFT JOIN Package chan6
	ON        pro.PackageId_Channel6 = chan6.Id
	LEFT JOIN Package chan7
	ON        pro.PackageId_Channel7 = chan7.Id
	LEFT JOIN Package chan8
	ON        pro.PackageId_Channel8 = chan8.Id
	WHERE  j.Name = @JobName
	AND    chan1.Enabled = 1
	AND    j.Enabled = 1
	ORDER BY  pro.ExecutionOrder ASC;
END;

