CREATE TABLE course_tags (
    course_tag_id SERIAL PRIMARY KEY,
    course_id INTEGER NOT NULL,
    tag_id INTEGER NOT NULL,
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (tag_id) REFERENCES tags(tag_id),
    UNIQUE (course_id, tag_id)
);