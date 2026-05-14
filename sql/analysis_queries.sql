-- 1. Preview the data
SELECT *
FROM student_performance
LIMIT 10;


-- 2. Count total students
SELECT 
    COUNT(*) AS total_students
FROM student_performance;


-- 3. Overall performance summary
SELECT
    ROUND(AVG(final_score), 2) AS average_final_score,
    ROUND(AVG(attendance_percentage), 2) AS average_attendance,
    ROUND(AVG(study_hours_per_day), 2) AS average_study_hours,
    ROUND(AVG(ai_usage_time_minutes), 2) AS average_ai_usage_minutes,
    ROUND(AVG(assignment_scores_avg), 2) AS average_assignment_score
FROM student_performance;


-- 4. AI users vs non-AI users
SELECT
    CASE 
        WHEN uses_ai = 1 THEN 'AI User'
        ELSE 'Non-AI User'
    END AS ai_usage_status,
    COUNT(*) AS total_students,
    ROUND(AVG(final_score), 2) AS average_final_score,
    ROUND(AVG(attendance_percentage), 2) AS average_attendance,
    ROUND(AVG(study_hours_per_day), 2) AS average_study_hours,
    ROUND(AVG(ai_dependency_score), 2) AS average_ai_dependency
FROM student_performance
GROUP BY uses_ai;


-- 5. Pass rate by AI usage
SELECT
    CASE 
        WHEN uses_ai = 1 THEN 'AI User'
        ELSE 'Non-AI User'
    END AS ai_usage_status,
    COUNT(*) AS total_students,
    SUM(passed) AS students_passed,
    ROUND(100.0 * SUM(passed) / COUNT(*), 2) AS pass_rate_percentage
FROM student_performance
GROUP BY uses_ai;


-- 6. Average final score by AI tool
SELECT
    ai_tools_used,
    COUNT(*) AS total_students,
    ROUND(AVG(final_score), 2) AS average_final_score
FROM student_performance
GROUP BY ai_tools_used
ORDER BY average_final_score DESC;


-- 7. Average final score by AI usage purpose
SELECT
    ai_usage_purpose,
    COUNT(*) AS total_students,
    ROUND(AVG(final_score), 2) AS average_final_score
FROM student_performance
GROUP BY ai_usage_purpose
ORDER BY average_final_score DESC;


-- 8. Performance category breakdown
SELECT
    performance_category,
    COUNT(*) AS total_students,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM student_performance), 2) AS percentage
FROM student_performance
GROUP BY performance_category
ORDER BY total_students DESC;


-- 9. Attendance impact on performance
SELECT
    CASE
        WHEN attendance_percentage >= 90 THEN '90-100% Excellent'
        WHEN attendance_percentage >= 75 THEN '75-89% Good'
        WHEN attendance_percentage >= 60 THEN '60-74% Average'
        ELSE 'Below 60% At Risk'
    END AS attendance_group,
    COUNT(*) AS total_students,
    ROUND(AVG(final_score), 2) AS average_final_score,
    ROUND(100.0 * SUM(passed) / COUNT(*), 2) AS pass_rate_percentage
FROM student_performance
GROUP BY attendance_group
ORDER BY average_final_score DESC;


-- 10. Study hours impact on performance
SELECT
    CASE
        WHEN study_hours_per_day >= 5 THEN '5+ Hours'
        WHEN study_hours_per_day >= 3 THEN '3-4.9 Hours'
        WHEN study_hours_per_day >= 1 THEN '1-2.9 Hours'
        ELSE 'Less than 1 Hour'
    END AS study_hours_group,
    COUNT(*) AS total_students,
    ROUND(AVG(final_score), 2) AS average_final_score,
    ROUND(100.0 * SUM(passed) / COUNT(*), 2) AS pass_rate_percentage
FROM student_performance
GROUP BY study_hours_group
ORDER BY average_final_score DESC;


-- 11. AI dependency score impact
SELECT
    CASE
        WHEN ai_dependency_score >= 8 THEN 'High Dependency'
        WHEN ai_dependency_score >= 4 THEN 'Medium Dependency'
        ELSE 'Low Dependency'
    END AS dependency_group,
    COUNT(*) AS total_students,
    ROUND(AVG(final_score), 2) AS average_final_score,
    ROUND(AVG(ai_generated_content_percentage), 2) AS average_ai_generated_content
FROM student_performance
GROUP BY dependency_group
ORDER BY average_final_score DESC;


-- 12. Social media vs performance
SELECT
    CASE
        WHEN social_media_hours >= 5 THEN '5+ Hours'
        WHEN social_media_hours >= 3 THEN '3-4.9 Hours'
        WHEN social_media_hours >= 1 THEN '1-2.9 Hours'
        ELSE 'Less than 1 Hour'
    END AS social_media_group,
    COUNT(*) AS total_students,
    ROUND(AVG(final_score), 2) AS average_final_score
FROM student_performance
GROUP BY social_media_group
ORDER BY average_final_score DESC;


-- 13. Final score by grade level
SELECT
    grade_level,
    COUNT(*) AS total_students,
    ROUND(AVG(final_score), 2) AS average_final_score,
    ROUND(100.0 * SUM(passed) / COUNT(*), 2) AS pass_rate_percentage
FROM student_performance
GROUP BY grade_level
ORDER BY average_final_score DESC;


-- 14. Final score by gender
SELECT
    gender,
    COUNT(*) AS total_students,
    ROUND(AVG(final_score), 2) AS average_final_score,
    ROUND(100.0 * SUM(passed) / COUNT(*), 2) AS pass_rate_percentage
FROM student_performance
GROUP BY gender
ORDER BY average_final_score DESC;


-- 15. Top 10 students by final score
SELECT
    student_id,
    age,
    gender,
    grade_level,
    uses_ai,
    study_hours_per_day,
    attendance_percentage,
    final_score,
    performance_category
FROM student_performance
ORDER BY final_score DESC
LIMIT 10;
