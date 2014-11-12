package utils

import play.api._
import play.api.mvc._
import play.api.db._
import play.api.Play.current

import anorm._
import anorm.SqlParser._

import java.util.Date

object Format{

	object Pattern{
		val date:String = "dd.MM.yyyy"

		val datetime:String = "dd.MM.yyyy HH:mm"

		// date time for the plugin moment.js
		val datetime_moment:String = "DD.MM.YYYY HH:mm"

		
		object Angular{
			val date:String = "dd.MM.yyyy"
			val time:String = "H:mm"
			val datetime:String = date_angular+" "+time_angular
		}
	}
		
		def date(date: Date) : String = {
			import java.util.Date
			import java.text.SimpleDateFormat

			val format_pattern:String = Pattern.datetime

			new SimpleDateFormat(format_pattern).format(date)
		}

		/*
			returns a date with the right timezone
			@date java.utils.date
			@timezone timezein, e.g. "America/Chicago"
		*/
		def dateTimezone(date: Date, timezone: String = utils.Constants.timezone) = {
			import java.util._//Date
      		import java.text._//SimpleDateFormat
      		val formatter = new SimpleDateFormat(utils.Format.Pattern.datetime);
      		val central = TimeZone.getTimeZone(timezone);
        	formatter.setTimeZone(central);
        	formatter.format(date)
		}

		def date(date: org.joda.time.DateTime) : String = {
			import org.joda.time._
			import java.text.SimpleDateFormat

			val format_pattern:String = Pattern.datetime

			new SimpleDateFormat(format_pattern).format(date)
		}

		def date(date: String) : String = {
			date
		}

		def dateO(date: Date) : String = {
			import java.util.Date
			import java.text.SimpleDateFormat

			new SimpleDateFormat(Pattern.date).format(date)
		}

		def hourO(date: Date) : String = {
			import java.util.Date
			import java.text.SimpleDateFormat

			val format_pattern:String = "HH:mm"

			new SimpleDateFormat(format_pattern).format(date)
		}

		def hour(h: Long):String = {
			import java.text.DecimalFormat
			import java.text.DecimalFormatSymbols
			import java.text.NumberFormat
			val symbols= DecimalFormatSymbols.getInstance()
			symbols.setGroupingSeparator('\'')
			val formatter = new DecimalFormat("00",symbols)
			formatter.format(h)
		}

	}
