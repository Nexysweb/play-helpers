package models

import play.api._
import play.api.db._

import anorm._
import anorm.SqlParser._

import play.api.Play.current

/*
	CRUD stands for
	C: Create
	R: Read
	U: Update
	D: Delete

	I suggest this trait structure for every object that model a table in a DB
*/
abstract class tCRUD[V]{

	val table:String
	val query:String

	/*
		@return returns a list of the type of the object
	*/
	def list:List[V]

	/*
		@return one case class (if exists) otherwise None
		@arg id unique id of the row
	*/
	def detail(id: Long):Option[V]

	/*
		creates/updates a record
		if v.id.isDefined -> updates
		else creates

		@arg v: data to be created/updated
		@return id of the object
	*/
	def update(v: V):Option[Long]

	/*
		@arg id unique id of the row
		@return if successful returns true
		deletes associated record
	*/
	def delete(id: Long):Boolean

	/*
		anorm parser mapped to V for everyhing SQL related
	*/
	val parser:anorm.RowParser[V]
}