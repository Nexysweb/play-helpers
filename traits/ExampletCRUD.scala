package models

import play.api._
import play.api.db._

import anorm._
import anorm.SqlParser._

import play.api.Play.current

case class Example(id: Option[Long], name: String)

object Example extends tCRUD[Example]{
	val table="myTable"
	
	val query="SELECT * FROM "+table

	def list:List[Example] = {
		DB.withConnection{implicit c=>
			SQL(query)
			.as(parser *)
		}
	}

	def detail(id: Long) : Option[Example] = {
		DB.withConnection{implicit c =>
			SQL(query+" WHERE id={id}")
			.on('id -> id)
			.as(parser singleOpt)
		}
	}

	def update(v: Example) : Option[Long] = {
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
			case id~name => Example(id, name)
		}
	}
}