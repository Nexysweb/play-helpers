package utils

import play.api._
import play.api.Play.current

import play.api.db._
import anorm._
import anorm.SqlParser._


object File{
	/*
		write a string into a new file
	*/
	def write(fileName: String, data: String) = {
		import java.io.{File, FileWriter} 
 		Misc.using (new FileWriter(fileName)) {
    	fileWriter => fileWriter.write(data)
    	}
	}

	/*
		delete file
	*/
	def delete(path: String){
		import java.io.File
		val f = new File(path)
		f.delete
	}

	/*
		delete file and from associated DB, e.g. for repo
	*/
	def deleteSQL(id: Long, table: String) {		
		// 1. remove from database
		MySQL.delete(id, table)

		// 2. remove from server
		delete(getFilename(id, table))
	}

	/*
		creates full path for repo files
	*/
	def getFilename(id: Long, table: String) : String = {
		Constants.path+table+"."+id.toString
	}


	/** check if file exists*/
	def exists(filepath: String): Boolean = {
		val f = new java.io.File(filepath)
		f.exists() && !f.isDirectory()
	}

	

	def serve(id: Long, timestamp: String, table: String, fieldname: String = "name") : Option[(String,String)] ={


		try{
			DB.withConnection { implicit c =>

				val row = 
				SQL(""" 	
					SELECT id, timestamp, name
					FROM """+table+"""
					WHERE 1
					AND id={id}
					AND timestamp={timestamp}
					ORDER BY id DESC
					LIMIT 0,1
				""")
				.on(
					'id -> id, 
					'timestamp -> timestamp
				)
				.apply().head
				
				val url = getFilename(row[Long]("id"), table)

				Some(row[String](fieldname),url)

			}
		}
		catch{
			case ex: NoSuchElementException => {
         	None
      	}
      }

	}

	
	/* uploads file to repo from multiuploac */
	def upload(request: play.api.mvc.Request[play.api.libs.Files.TemporaryFile], id: Long, table: String) : Boolean = {
		import java.io.File
		
		try {
			val file = new File(getFilename(id, table))
    		request.body.moveTo(file, true)
			true
		} catch {
			case e: Exception => false
			case _: Throwable => false
		}
	}


	/* uploads file - filename here can be chosen freely */
	def upload2(f: Option[play.api.mvc.MultipartFormData.FilePart[play.api.libs.Files.TemporaryFile]], filepath: String){
 		
 		f.map { picture =>
			import java.io.File		
			val file = new File(filepath)
			try {
				picture.ref.moveTo(file, true)
				true
			}
			catch{
				case e: Exception => false
			}
		}
 	}

 	/* check file type */
 	def checkType(filepath: String, filetype: String = "image"): Boolean = {
 		import javax.activation.MimetypesFileTypeMap
 		import java.io.File

 		val f = new File(filepath)

 		val mimetype:String = new MimetypesFileTypeMap().getContentType(f)

 		mimetype.split("/")(0)==filetype
 	}
 }