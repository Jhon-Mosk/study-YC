CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT,
    nickname VARCHAR(128) NOT NULL,
    avatar VARCHAR(255),
    mail VARCHAR(255),
        PRIMARY KEY (user_id)
) ENGINE=INNODB;
