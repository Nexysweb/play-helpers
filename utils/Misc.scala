package utils

import play.api._
import play.api.mvc._
import play.api.db._
import play.api.Play.current

import anorm._
import anorm.SqlParser._

import java.util.Date

object Misc{
	// random password pgeneration
	// taken from     http://www.bindschaedler.com/2012/04/07/elegant-random-string-generation-in-scala/

	// Random generator
	//val random = new scala.util.Random
	val random = new scala.util.Random(new java.security.SecureRandom())

	// Generate a random string of length n from the given alphabet
	def randomString(alphabet: String)(n: Int): String = 
	Stream.continually(random.nextInt(alphabet.size)).map(alphabet).take(n).mkString

	// Generate a random alphabnumeric string of length n
	def randomAlphanumericString(n: Int) = 
		randomString("ABCDEFGHIJKLMNOPQRSTUVWXYSabcdefghijklmnopqrstuvwxyz0123456789")(n)
	// end random password generation


	def returnJSONfromSeq(in: Seq[(String,String)]): String ={
		var out:String =""

		for ((k,v) <- in) {
			out = out+ "{\"k\":\""+k.toString+"\",\"v\":\""+v+"\"},"  
		}  

		// remove last character
		out=out.dropRight(1)

		return "["+out+"]" 
	}

	//todo: add stuff with BCrypy here

}