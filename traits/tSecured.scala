

/**
 * Provide security features
 */
trait Secured {
  
  private def check(request: RequestHeader) = {

    if(request.session.get("id").isDefined){
      Some(
        User(
          request.session.get("id").get.toLong
          ,request.session.get("email").get
          ,request.session.get("name").get
        )
      )
    }
    else{
      None
    }
  }
  
  /**
  * Redirect to login if the user in not authorized.
  */
  private def onUnauthorized(request: RequestHeader) = Results.Redirect(routes.Application.index)


  // --

  /** 
  * Action for authenticated users.
  */
  def IsAuthenticated(f: => User => Request[AnyContent] => Result):EssentialAction = Security.Authenticated(check, onUnauthorized) { user =>
    Action(request => f(user)(request))
  }

  /*def IsAuthenticated(b: BodyParser[Any])(f: User => Request[Any] => Result) = Security.Authenticated(check, onUnauthorized) { user =>
    Action(b)(request => f(user)(request))
  }*/

  // overriding for file upload
  def IsAuthenticated(b: BodyParser[play.api.mvc.MultipartFormData[play.api.libs.Files.TemporaryFile]])(f: User => Request[play.api.mvc.MultipartFormData[play.api.libs.Files.TemporaryFile]] => Result) = Security.Authenticated(check, onUnauthorized) { user =>
    Action(b)(request => f(user)(request))
  }

}