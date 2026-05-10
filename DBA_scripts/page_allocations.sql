SELECT 
    allocated_page_file_id AS [FileID],
    allocated_page_page_id AS [PageID],
    allocation_unit_type_desc AS [Type],
    page_type_desc AS [PageType], -- Look for PFS_PAGE or GAM_PAGE here
    is_allocated AS [IsAllocated]
FROM sys.dm_db_database_page_allocations(
    DB_ID('YourDatabaseName'), 
    OBJECT_ID('YourTableName'), 
    NULL, -- Index ID (NULL for all)
    NULL, -- Partition ID (NULL for all)
    'DETAILED'
);
