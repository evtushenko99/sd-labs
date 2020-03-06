CREATE TABLE IF NOT EXISTS study_group
(
    `id`   INT  NOT NULL AUTO_INCREMENT,
    `name` TEXT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS subject
(
    `id`         INT  NOT NULL AUTO_INCREMENT,
    `name`       TEXT NULL,
    `short_name` TEXT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS exam_type
(
    `id`   INT  NOT NULL AUTO_INCREMENT,
    `type` TEXT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS mark
(
    `id`    INT  NOT NULL AUTO_INCREMENT,
    `name`  TEXT NULL,
    `value` TEXT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS student
(
    `id`             INT         NOT NULL AUTO_INCREMENT,
    `surname`        TEXT        NULL,
    `name`           TEXT        NULL,
    `second_name`    VARCHAR(45) NULL,
    `study_group_id` INT         NOT NULL,
    PRIMARY KEY (`id`, `study_group_id`),
    CONSTRAINT fk_student_study_group
        FOREIGN KEY (`study_group_id`)
            REFERENCES study_group (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS study_plan
(
    `id`           INT NOT NULL AUTO_INCREMENT,
    `subject_id`   INT NOT NULL,
    `exam_type_id` INT NOT NULL,
    PRIMARY KEY (`id`, `subject_id`, `exam_type_id`),

    CONSTRAINT fk_study_plan_exam_type1
        FOREIGN KEY (`exam_type_id`)
            REFERENCES exam_type (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT fk_study_plan_subject1
        FOREIGN KEY (`subject_id`)
            REFERENCES subject (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS journal
(
    `id`            INT     NOT NULL AUTO_INCREMENT,
    `student_id`    INT     NULL,
    `study_plan_id` INT     NOT NULL,
    `in_time`       TINYINT NULL,
    `count`         INT     NULL,
    `mark_id`       INT     NOT NULL,
    PRIMARY KEY (`id`, `student_id`, `study_plan_id`, `mark_id`),
    CONSTRAINT fk_journal_student1
        FOREIGN KEY (`student_id`)
            REFERENCES student (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT fk_journal_study_plan1
        FOREIGN KEY (`study_plan_id`)
            REFERENCES study_plan (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT fk_journal_mark1
        FOREIGN KEY (`mark_id`)
            REFERENCES mark (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

INSERT INTO PUBLIC.SUBJECT (id, name, short_name)
VALUES (1, 'Проектирование информационных систем', 'ПрИС'),
       (2, 'Системы искусственного интеллекта', 'СИИ'),
       (3, 'Программная инженерия', 'ПИ'),
       (4, 'Национальная система информационной безопасности', 'НСИБ'),
       (5, 'Системный анализ', 'СисАнал'),
       (6, 'Распределенные базы данных', 'РБД'),
       (7, 'Системное программное обеспечение', 'СПО');

INSERT INTO PUBLIC.EXAM_TYPE (id, type)
VALUES (1, 'Экзамен'),
       (2, 'Зачет'),
       (3, 'Зачет с оценкой'),
       (4, 'Курсовая');

INSERT INTO PUBLIC.STUDY_PLAN (id, subject_id, exam_type_id)
VALUES (1, 1, 1),
       (2, 1, 4),
       (3, 2, 1),
       (4, 3, 1),
       (5, 4, 2),
       (6, 5, 1),
       (7, 6, 2),
       (8, 7, 1);

INSERT INTO PUBLIC.MARK (id, name, value)
VALUES (1, 'Отлично', 5),
       (2, 'Хорошо', 4),
       (3, 'Удовлетворительно', 3),
       (4, 'Неудовлетворительно', 2),
       (5, 'Зачет', 'з'),
       (6, 'Незачет', 'н'),
       (7, 'Неявка', '');