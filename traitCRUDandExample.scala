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
abstract class CRUD[V]{

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

case class Essai(id: Option[Long], name: String)

object Essai extends CRUD[Essai]{
	val table="myTable"
	
	val query="SELECT * FROM "+table

	def list:List[Essai] = {
		DB.withConnection{implicit c=>
			SQL(query)
			.as(parser *)
		}
	}

	def detail(id: Long) : Option[Essai] = {
		DB.withConnection{implicit c =>
			SQL(query+" WHERE id={id}")
			.on('id -> id)
			.as(parser singleOpt)
		}
	}

	def update(v: Essai) : Option[Long] = {
		val q = 
			if(v.id.isDefined){"UPDATE"}else{"INSERT INTO"}+" "+
			table+
			"""
			SET
				id={id}
				, name={name}
			"""+
			{if(v.id.isDefined){" WHERE id={id}"}}

		DB.withConnection{implicit c =>
			SQL(q)
			.on('id -> v.id)
			.executeInsert()
		} 
		match {
        	case Some(long) => Some(long)
        	case None       => v.id
    	}
	}

	def delete(id: Long) = utils.MySQL.delete(id, table)>0

	val parser = {
		get[Option[Long]]("id")~
		get[String]("name") map{
			case id~name => Essai(id, name)
		}
	}


}

