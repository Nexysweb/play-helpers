package utils

import play.api._
import play.api.mvc._
import play.api.db._
import play.api.Play.current

import anorm._
import anorm.SqlParser._

object MySQL{
	// returns a string with element separated with ,
	def listToSQL(l: List[Long]): Option[String] = {
		if(l.length==0){
			None
		}
		else{
			Some(l.mkString(","))
		}
	}

	/*
		duplicate a DB row
		@arg table: table from whic row needs to be copied
		@arg id: id to be copied
		@return: new id
	*/
	def duplicateRow(id: Long, table: String) : Option[Long] = {
		
		val query:String 	= "CREATE TABLE table_temp SELECT * FROM "+table+" WHERE id={id}"
		
		doQuery("DROP TABLE IF EXISTS table_temp")
		
		DB.withConnection{implicit c =>
			SQL(query)
			.on('id -> id)
			.executeUpdate()
		}
		
		doQuery("UPDATE table_temp SET id = (1+(SELECT id FROM "+table+" ORDER BY id DESC LIMIT 0,1))")
		doQuery("INSERT INTO "+table+" SELECT * FROM table_temp")
		
		// get new id
		val new_id = getLastId(table)

		doQuery("DROP TABLE IF EXISTS table_temp")
		
		new_id
	}


	/*
		@arg table: table name
		@arg key: column name, e.g. `id`
		@return last id

		note when inserting use this http://stackoverflow.com/questions/9859700/how-to-retrieve-the-primary-key-when-saving-a-new-object-in-anorm
	*/
	def getLastId(table: String, key:String = "id") : Option[Long] = {
		DB.withConnection { implicit c =>
			val row = 
				SQL(""" 	
					SELECT """+key+"""
					FROM """+table+"""
					WHERE 1
					ORDER BY id DESC
					LIMIT 0,1
				""")
				.apply().head
					
			row[Option[Long]](key)
		}
	}

	def fieldTaken(value:String, field:String ="email", table:String="user"): Boolean = {
	
		val query:String = 
		"""
			SELECT COUNT(*) as c
			FROM """+table+"""
			WHERE """+field+"""={value}
		"""

		DB.withConnection{implicit c =>
			val rows = SQL(query)
			.on('value -> value)
			.apply
			.head
			
			val count = rows[Long]("c")

			if(count==0){
				true
			}
			else{
				false
			}
		}
	}

	def doQuery(query: String){
		DB.withConnection{implicit c =>
			SQL(query)
			.executeUpdate()
		}
	}

	/*
		deletes an entry from a DB by id
		@arg id : row to be deleted
		@arg table: DB table to be modified
		@arg ass_field: associated_field: if another condition needs to be fulfilled (e.g. user_id)
	*/
	def delete(id: Long, table: String, ass_field: Option[(Long, String)] = None):Int = {
		DB.withConnection{implicit c =>
			SQL("DELETE FROM "+table+" WHERE id={id}"+{if(ass_field.isDefined){" AND "+ass_field.get._2+"={id2}"}else{""}})
			.on('id -> id, 'id2 -> {if(ass_field.isDefined){ass_field.get._1}else{0}})
			.executeUpdate
		}
	}

	/*
		makes the link for a n:n relationship
		@arg id1: the id and associated field name, e.g. (1, "user_id")
		@arg id2: same as id1
		@arg table: table to be modified
		@return {true: relation created, false: relation deleted}
	*/
	def assignment(id1: (Long, String), id2: (Long, String), table: String): Boolean = {
		DB.withConnection{implicit c =>

			val tail:String = " WHERE "+id1._2+"={id1} AND "+id2._2+"={id2}"

			val q0 = "SELECT * FROM "+table+tail

			val numR = SQL(q0).on('id1 -> id1._1, 'id2 -> id2._1)().size>0

			val q1 = {
				if(numR){
					"DELETE FROM "+table+tail
				}else{
					"INSERT INTO "+
					table+
					" SET "+
					id1._2+"={id1}, "+id2._2+"={id2}"
				}
			}
				
			SQL(q1)
			.on('id1 -> id1._1, 'id2 -> id2._1)
			.executeUpdate

			!numR
		}

	}

	/*
		insert mulitple associated id for n:n relationships without deleting previously inserted data
		@arg id: associated id and column name
		@arg ids: list of new ids and their column name
		@table: table name
	*/
	def insertMultiple(id: (Long, String), ids: (List[Long], String), table: String) {
		// new to be inserted
		var n = ids._1
			
		val q0 = "SELECT "+ids._2+" FROM "+table+" WHERE "+ids._2+" IN("+ids._1.mkString(",")+") AND "+id._2+"={id}"

		val q1 = "INSERT INTO "+
			table+
			" ("+id._2+", "+ids._2+")VALUES"+
			n.map{a => "("+id._1+", "+a+")"}.mkString(",")

		val q2 = 
			"DELETE FROM "+table+" WHERE "+id._2+"={id}"+
			{if(ids._1.size>0){" AND "+ids._2+" NOT IN("+ids._1.mkString(",")+")"}else{""}}

		DB.withConnection{implicit c =>
		if(ids._1.size>0){
			SQL(q0)
			.on('id -> id._1)()
			.map{r =>
				n = n.filter(x => x!=r[Long](ids._2))
			}.toList

			SQL(q1)
			.executeUpdate
		}

			SQL(q2)
			.on('id -> id._1)
			.executeUpdate
		}
	}

}