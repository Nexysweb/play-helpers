package utils

import play.api._
import play.api.Play.current

/*
	methods associated for creating dumps
*/
object Dump{

	/*
		creates a Zip archive from a folder
		@arg filepath: location where it is saved
	*/
	def filder(filepath: String="/srv/dump/dumps.zip"){
		import scala.sys.process._
		import java.io.File
		val sh = "zip -r "+file+" "+utils.Constants.path !
	}

	/*
		creates a SQL backup file of the database currently used
		@arg filepath: location where it is saved

		note: the db info are taken from credentials which are stored in utils.Constants.scala
	*/
	def mysql(filepath: String ="/srv/dump/dumps.sql") = {

		//source here http://alvinalexander.com/scala/scala-execute-exec-external-system-commands-in-scala
		// and http://www.scala-lang.org/api/current/index.html#scala.sys.process.package
		if(utils.Constants.credentials.isDefined){
			import scala.sys.process._
			import java.io.File
			val ssh = "mysqldump -u "+utils.Constants.credentials.get.user+" -p"+utils.Constants.credentials.get.password+" "+utils.Constants.credentials.get.db
			val sh = ssh #> new File(filepath) !
		}
	}
}