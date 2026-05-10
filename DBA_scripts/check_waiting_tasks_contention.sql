SELECT 
    session_id, 
    wait_type, 
    wait_duration_ms, 
    resource_description
FROM sys.dm_os_waiting_tasks
WHERE wait_type LIKE 'PAGELATCH_%'
  AND (resource_description LIKE '%:1:1' -- PFS
       OR resource_description LIKE '%:1:2'); -- GAM
