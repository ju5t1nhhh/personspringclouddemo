CREATE TABLE `person`(
	`id` INT(8) UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(100) NOT NULL,
	`pwd` VARCHAR(100) NOT NULL,
	`sex` CHAR,
	`mobile` VARCHAR(11),
	`email` VARCHAR(100),
	`avatar` VARCHAR(200),
	`status` TINYINT,
	`create_time` DATETIME NOT NULL,
	`update_time` DATETIME NOT NULL,
	PRIMARY KEY(`id`),
	UNIQUE KEY `person_name_UNIQUE` (`name`),
	KEY `person_create_time_INDEX` (`create_time`),
	KEY `person_update_time_INDEX` (`update_time`)
)ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8;

INSERT INTO `person`(`name`,`pwd`,`sex`,`mobile`,`email`,`status`,`create_time`,`update_time`)
VALUES('Justin','123456','M','17854230489','qd2017hst@163.com',1,now(),now());