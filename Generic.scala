package models

import play.api._
import play.api.mvc._
import play.api.data._
import play.api.data.Forms._
import play.api.data.format.Formats._ 

import play.api.libs
import play.api.libs.json._

case class OptionSet(id: Long, name: String, assigned: Boolean = false)

/*
	gCtrl (generic Controller) allows to reuse form parser often used
*/
object gCtrl extends Controller{
	val singleF = Form(
		single("id" -> longNumber)
	)

	val singleOF = Form(
		single("id" -> optional(longNumber))
	)

	val doubleF = Form(
		tuple(
			"id1" -> longNumber,
			"id2" -> longNumber
		)
	)
}