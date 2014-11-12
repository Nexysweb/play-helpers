package utils

import play.api._
import play.api.Play.current


case class DB_auth(user: String, password: String, db: String, host: String, url: String)

object Constants{

	val online:Boolean 		= {
		if(Play.application.configuration.getString("online").getOrElse("1")=="1"){
			true
		}
		else{
			false
		}
	}

	// cron frequency [min]; every x min automated task is ran
	val path:String			= ""

	val timezone:String 	= "Europe/Zurich"

	val url:String				= {

		import play.Logger

		if(online){
			Logger.debug("online")
			"http://www.URL.ch"
		}
		else{
			Logger.debug("not online")
			"http://localhost:9000"
		}
	}

	// oAuth key
	// url: https://console.developers.google.com/project/secret-helper-516/apiui/credential?authuser=0
	val Google:(String, String) = {
		if(online){
			("blablabla.apps.googleusercontent.com", "blabla")
		}
		else{
			("blabla.apps.googleusercontent.com","blabla")
		}
	}

	/*
		get credentials from conf file and store them in DB_auth case class
	*/
	lazy val credentials:Option[DB_auth] = {
		val user: Option[String] 		= Play.application.configuration.getString("db.default.user")
		val password: Option[String] 	= Play.application.configuration.getString("db.default.password")
		val url: Option[String] 		= Play.application.configuration.getString("db.default.url")

		/* 
			pattern to retrieve db name and host from url.
			note the url must be in the form:
			jdbc:mysql://myHost/myDB?zeroDateTimeBehavior=convertToNull
		*/
		val db_r = """jdbc:mysql:\/\/(.+)/(\w+)\?.*""".r

		val (host, db):(Option[String], Option[String]) = url.get match {
			case db_r(host, db) => (Some(host), Some(db))
			case _  => (None, None)
		}

		if(
			user.isDefined
			&& password.isDefined
			&& url.isDefined
			&& host.isDefined
			&& db.isDefined
		){
			Some(DB_auth(user.get, password.get, db.get, host.get, url.get))
		}
		else{
			None
		}
	}
}


