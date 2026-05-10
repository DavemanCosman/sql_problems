--formula: (Max Server Memory in GB / 4) * 300

SELECT [object_name], [counter_name], [cntr_value] AS [PLE_Seconds]
FROM sys.dm_os_performance_counters
WHERE [object_name] LIKE '%Buffer Manager%' 
AND [counter_name] = 'Page life expectancy';
