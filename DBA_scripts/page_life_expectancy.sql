--formula: (Max Server Memory in GB / 4) * 300

SELECT [object_name], [counter_name], [cntr_value] AS [PLE_Seconds]
FROM sys.dm_os_performance_counters
WHERE [object_name] LIKE '%Buffer Manager%' 
AND [counter_name] = 'Page life expectancy';

/*
Interpreting Results:
Sustained Low PLE: Strong indicator of internal memory pressure or insufficient RAM.
Sudden Dips: Often caused by a "bad query" (like a massive table scan) or maintenance tasks like index rebuilds.
High PLE: Generally indicates healthy memory, but if it stays high while users complain of slowness, the bottleneck is likely elsewhere (e.g., CPU or locking).
*/
