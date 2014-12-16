package controllers

import play.api.mvc._

import play.api.libs
import play.api.libs.json._

import models._

// if one the method is not implemented just set it = TODO
// e.g. def detail = TODO

abstract class tControllerCRUD[V] extends Controller with Secured{
	implicit val myJsonFormat:play.api.libs.json.OFormat[V]

	val myForm:play.api.data.Form[V]

	def listing:play.api.mvc.EssentialAction

	// todo: go beyond simple definition
	/* = IsAuthenticated{user => implicit request =>
  		gCtrl.singleF.bindFromRequest.fold(
  			e => BadRequest("error"),
  			v => Ok("ok")
		)
	}*/

	def detail:play.api.mvc.EssentialAction

	def update:play.api.mvc.EssentialAction

	def delete:play.api.mvc.EssentialAction	
}