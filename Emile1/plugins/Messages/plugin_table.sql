CREATE TABLE IF NOT EXISTS `messages` (
    `id` INTEGER,
    `title` TEXT  NOT NULL,
    `message` TEXT NOT NULL,
    `sender` TEXT NOT NULL,
    `date` TEXT  NOT NULL,
    PRIMARY KEY(`id`)
);
