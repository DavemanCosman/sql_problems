SELECT
    (a.cntr_value * 1.0 / b.cntr_value) * 100.0 AS BufferCacheHitRatio
FROM
    sys.dm_os_performance_counters a
JOIN
    sys.dm_os_performance_counters b
    ON a.object_name = b.object_name
    AND b.counter_name = 'Buffer cache hit ratio base'
WHERE
    a.counter_name = 'Buffer cache hit ratio'
    AND a.object_name LIKE '%Buffer Manager%';
