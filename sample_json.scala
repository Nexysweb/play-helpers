// json example

// create parser from case class
implicit val userFormat1 = Json.format[CoB]

// merge two Json (e.g. to add uri)

JsArray(Lunch.list(user.id).map{a =>
	val uri = 
	JsObject(
		Seq(
			"url" 			-> JsString(utils.Constants.url+routes.LunchCtrl.detailS(a.id.get, a.key.get)),
			"url_google"    -> JsString(utils.Constants.url+routes.LunchCtrl.detail(a.id.get, a.key.get))
		)
	)
	Json.toJson(a).as[JsObject].deepMerge(uri)
})