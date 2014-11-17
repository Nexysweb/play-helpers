package utils

import play.api._
import play.api.Play.current

object File{
	/*
		delete file on server
	*/
	def delete(filepath: String): Boolean = {
		val file = new java.io.File(filepath)
		file.delete()
	}

	/** check if file exists*/
	def exists(filepath: String): Boolean = {
		val f = new java.io.File(filepath)
		f.exists() && !f.isDirectory()
	}


	def upload(request: play.api.mvc.Request[play.api.libs.Files.TemporaryFile], filepath: String) : Boolean = {
 		import java.io.File
		val file = new File(filepath)

		try {
		   	request.body.moveTo(file, true)
			true
		} catch {
			case e: Exception => false
		}
 	}


 	/*
		check specific file type
 	*/
 	def checkType(filepath: String, filetype: String = "image"): Boolean = {
 		import javax.activation.MimetypesFileTypeMap
 		import java.io.File

 		val f = new File(filepath)

 		val mimetype:String = new MimetypesFileTypeMap().getContentType(f)

 		mimetype.split("/")(0)==filetype
 	}
	
}