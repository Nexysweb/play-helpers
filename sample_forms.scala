// sample Forms

// only one id
val idForm = Form(
	single(
		"id" 	-> number
	)
)

// does not map 1:1 with case class
val myForm = Form(
		tuple(
		"salon" ->
			mapping(
				"id" -> optional(longNumber),
				"name" -> nonEmptyText,
				"description" -> nonEmptyText,
				"treatment_types" -> list(longNumber),
				"email" -> email,
				"address" -> nonEmptyText,
				"zip" -> nonEmptyText,
				"city" -> longNumber
			){(id, name, description, treatment_types, email, address, zip, city) =>
				Salon(
					id
					, name
					, description
					, treatment_types
					, email
					, address
					, zip
					, city
				)
			}{salon => Some(
				salon._id
				, salon.name
				, salon.description
				, salon.treatment_types
				, salon.email
				, salon.address
				, salon.zip
				, salon.city
			)},
		"passwords" -> tuple(
			"p1" -> nonEmptyText
			, "p2" -> nonEmptyText
		).verifying("passwords must match", result => result match{
			case(a, b) => a == b
		}))
	)



