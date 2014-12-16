package models

import play.api._
import play.api.mvc._
import play.api.data._
import play.api.data.Forms._
import play.api.data.format.Formats._ 

import play.api.libs
import play.api.libs.json._

case class OptionSet(id: Long, name: String, assigned: Option[Long] = Long)

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

	def formError[A](e: play.api.data.Form[A]) = {
		import play.api.i18n._
		val b = JsObject(e.errors.map{a =>
			a.key.replace(".","_") -> JsString(Messages(a.message))
		})
		BadRequest(Json.toJson(b))
	}
}