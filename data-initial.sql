/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

LOCK TABLES `company` WRITE;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` VALUES (1,0,'1048576 times better than the competition','MegaCorp','http://megacorp.com'),(2,0,'We have big jobs, little jobs, and every job in between. No job too out there!','Jobs Co, Ltd.','http://jobsjobsandmorejobs.co');
/*!40000 ALTER TABLE `company` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `job_listing` WRITE;
/*!40000 ALTER TABLE `job_listing` DISABLE KEYS */;
INSERT INTO `job_listing` VALUES (1,0,'Operate Computers','Computer Operator',1,'','Washington, D.C.','2014-05-30 10:48:13','Show up to our job interview, and bring $100 to give us','Must have at least 100 years experience in operating computers. Must have 4+ years of Swift, 5+ years of Golang, and 30+ years of Ruby experience'),(5,0,'A Customer Service Assistant is responsible for working with our customers, responding to their problems, collecting revenue, and smoothing relations between our business and the consumer.','Customer Service Assistant',2,'','Washington, D.C.','2014-09-08 09:00:00','Show up to the job interview. You are not required to have any previous experience working in customer service','No previous experience required');
/*!40000 ALTER TABLE `job_listing` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
INSERT INTO `message` VALUES (9,0,2,'The new version of FindMeAJob is so easy to use! I love what you\'ve done with the place and how secure it is now',25,'Great Job on the new site!'),(10,0,25,'Thanks for all your support Dave. Glad to see you on the new version of the best job portal around',2,'RE: Great Job on the new site!'),(13,0,2,'Are you the developer of FindMeAJob?',1,'Who are you?');
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,5,'2014-05-28 15:45:34','cyrus@nvisium.com','Cyrus','Malekpour','bc308e93ba35b915374af43b846c8786',NULL,NULL,NULL,NULL,NULL,'Cyrus Malekpour',0,0,0,0,NULL,NULL),(2,24,'2014-05-28 16:23:49','test@test.com','David','Letterman','7f2ababa423061c509f4923dd04b6cf1',NULL,NULL,NULL,'I am David Letterman','CyrusMalekpour.pdf','David Letterman',0,0,0,0,NULL,'123-45-6789'),(25,0,'2014-05-28 16:23:49','admin@findmeajob.com','Admin','User','$2a$12$dIsFvp4lWOs2tK5vQOhvR.r5q3HIS1VAHtGilI37qQFgnHmWavZDm',NULL,NULL,NULL,'I created FindMeAJob, the best ultra-secure job portal on the web!',NULL,'Admin User',1,0,0,0,NULL,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
