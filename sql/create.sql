-- create database apachepit;
CREATE USER 'apachepit'@'localhost' IDENTIFIED BY 'apachepit';
GRANT ALL PRIVILEGES ON apachepit.* TO 'apachepit'@'localhost';
flush privileges;
