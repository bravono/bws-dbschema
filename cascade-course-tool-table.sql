ALTER TABLE course_tools
DROP CONSTRAINT course_tools_course_id_fkey,
ADD CONSTRAINT course_tools_course_id_fkey
FOREIGN KEY (course_id)
REFERENCES courses(course_id)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE course_tools
DROP CONSTRAINT course_tools_tool_id_fkey,
ADD CONSTRAINT course_tools_tool_id_fkey
FOREIGN KEY (tool_id)
REFERENCES tools(tool_id)
ON DELETE CASCADE
ON UPDATE CASCADE;