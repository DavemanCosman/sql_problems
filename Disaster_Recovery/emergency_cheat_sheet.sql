/* 
   DBA Emergency Script: What is happening right now?
   Identifies: Active queries, Blocking, Wait Types, and SQL Text.
*/

SELECT 
    r.session_id AS [SPID],
    r.status,
    r.wait_type,
    r.wait_time AS [WaitMS],
    r.blocking_session_id AS [BlockedBy],
    r.cpu_time AS [CPUMS],
    r.total_elapsed_time AS [DurationMS],
    r.reads,
    r.writes,
    r.logical_reads,
    -- Get the actual SQL text
    SUBSTRING(st.text, (r.statement_start_offset/2) + 1,
    ((CASE r.statement_end_offset
        WHEN -1 THEN DATALENGTH(st.text)
        ELSE r.statement_end_offset END 
            - r.statement_start_offset)/2) + 1) AS [QueryText],
    -- Get the query plan (useful for deep diving)
    qp.query_plan,
    DB_NAME(r.database_id) AS [DatabaseName],
    s.login_name,
    s.host_name,
    s.program_name
FROM sys.dm_exec_requests r
JOIN sys.dm_exec_sessions s ON r.session_id = s.session_id
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) st
CROSS APPLY sys.dm_exec_query_plan(r.plan_handle) qp
WHERE s.is_user_process = 1 -- Exclude background system tasks
  AND r.session_id <> @@SPID -- Exclude this script itself
ORDER BY r.cpu_time DESC;

--quick log check
SELECT name, log_reuse_wait_desc FROM sys.databases;
