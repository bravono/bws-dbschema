CREATE TABLE course_tools (
    course_tool_id SERIAL PRIMARY KEY,
    course_id INTEGER NOT NULL,
    tool_id INTEGER NOT NULL,
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (tool_id) REFERENCES tools(tool_id),
    UNIQUE (course_id, tool_id)
);