import play.api._
import play.api.mvc._
import play.api.mvc.Results._


// resources at http://alvinalexander.com/scala/handling-scala-play-framework-2-404-500-errors

object Global extends GlobalSettings {
	
 	// onStart 
	override def onStart(app: Application) {
		Logger.info("Application has started")
	}  

	// onStop
	override def onStop(app: Application) {
		Logger.info("Application shutdown...")
	}
	
	// 500 - internal server error
	override def onError(request: RequestHeader, throwable: Throwable) = {
		InternalServerError(views.html.errors.onError(throwable))
	}  

  	// 404 - page not found error
	override def onHandlerNotFound(request: RequestHeader): Result = {
		NotFound(views.html.errors.onHandlerNotFound(request))
	}
	
	override def onBadRequest(request: RequestHeader, error: String) = {
	    BadRequest("Bad Request: " + error)
	}
    
}