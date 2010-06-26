CREATE TABLE  `comments` (
 `memo_id` INT( 11 ) NOT NULL DEFAULT  '1',
 `comment_id` INT( 11 ) NOT NULL AUTO_INCREMENT,
 `message` VARCHAR( 140 ) NOT NULL ,
  `author` VARCHAR( 50 ) NOT NULL DEFAULT '',
PRIMARY KEY (  `memo_id` ,  `comment_id` )
) ENGINE = MYISAM ;

○
mysql -u root lifepack_production;


