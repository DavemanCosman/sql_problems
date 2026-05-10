-- Enable output to the messages tab
DBCC TRACEON (3604);
GO

-- Syntax: DBCC PAGE ('DatabaseName', FileID, PageID, OutputMode)
-- View PFS (Page 1)
DBCC PAGE ('YourDatabaseName', 1, 1, 3); 

-- View GAM (Page 2)
DBCC PAGE ('YourDatabaseName', 1, 2, 3);
GO

-- Turn off output when finished
DBCC TRACEOFF (3604);
