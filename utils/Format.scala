package utils


/*
	creates link to most used calendar

	note: do not indent the method ics and vcs since the final result might change (Microsoft ...)

*/


object Calendar{

	import java.util.Date

	/*

	returns content of link/data for a calendar system {gmail, ics, vcs}
	tip: if end time is not known just put: utils.Date.addNHour(start, 1)

	*/

	def gmail(title: String, description: String, location: String, start: Date, end: Date): String = {
		"http://www.google.com/calendar/event?action=TEMPLATE&trp=true&sprop=&sprop=name:"+
		"&text="+views.html.helper.urlEncode(title)+
  		"&dates="+utils.Date.url(start)+"/"+utils.Date.url(end)+
  		"&location="+views.html.helper.urlEncode(location)+
  		"&details="+views.html.helper.urlEncode(description)
	}

	def ics(title: String, description: String, location: String, start: Date, end: Date, url: String): String = {
"""BEGIN:VCALENDAR
PRODID: -//OpenTable, Inc.//NONSGML ExportToCalendar//EN
VERSION:2.0
BEGIN:VEVENT
URL:"""+url+"""
DTSTART:"""+utils.Date.url(start)+"""
DTEND:"""+utils.Date.url(end)+"""
SUMMARY:"""+title+"""
DESCRIPTION:"""+description+"""
END:VEVENT
END:VCALENDAR"""
	}

	def vcs(title: String, description: String, location: String, start: Date, end: Date, url: String): String = {
"""BEGIN:VCALENDAR
PRODID: -//Microsoft Corporation//Outlook MIMEDIR//EN
VERSION:1.0
BEGIN:VEVENT
URL:"""+url+"""
DTSTART:"""+utils.Date.url(start)+"""
DTEND:"""+utils.Date.url(end)+"""
SUMMARY:"""+title+"""
DESCRIPTION:"""+description+"""
LOCATION:"""+location+"""
END:VEVENT
END:VCALENDAR"""
	}
}

object Date{
	import java.util.Date

	/*
		return a format that is URL ready in the format: 20140711T091700Z
	*/
	def url(d: Date) : String = {
		// Zulu: http://stackoverflow.com/questions/9706688/what-does-the-z-mean-in-unix-timestamp-120314170138z
		str(d, Format.Pattern.dateUrl, "Zulu")
	}

	/*
		add N hours to a date
		param n: number of hours to be added
	*/
	def addNHour(date: Date, n: Int): Date = {
		val hour:Long = 3600*1000; // in milli-seconds.
		new Date(date.getTime() + n * hour);
	}

	/*
		return a date string with the right format and the right timezone
		param d: date to be converted
		param format_pattern date pattern
		param timezone timezone

		additional info: java.util tmezone: http://tutorials.jenkov.com/java-date-time/java-util-timezone.html
	*/

	def str(d: Date, format_pattern: String = Format.Pattern.datetime, timezone: String = utils.Constants.timezone) : String = {

		import java.util._//Date
		import java.text._//SimpleDateFormat

		val tz = TimeZone.getTimeZone(timezone);

		val formatter = new SimpleDateFormat(format_pattern)
		formatter.setTimeZone(tz)
		formatter.format(d)
	}

	/*
			returns a date with the right timezone
			@date java.utils.date
			@timezone timezein, e.g. "America/Chicago"
		*/
		def timezone(date: Date, timezone: String = utils.Constants.timezone): String = {
			import java.util._//Date
      		import java.text._//SimpleDateFormat
      		val formatter = new SimpleDateFormat(utils.Format.Pattern.datetime);
      		val central = TimeZone.getTimeZone(timezone);
        	formatter.setTimeZone(central);
        	formatter.format(date)
		}

		def str(date: org.joda.time.DateTime) : String = {
			import org.joda.time._
			import java.text.SimpleDateFormat

			val format_pattern:String = Format.Pattern.datetime

			new SimpleDateFormat(format_pattern).format(date)
		}

		def str(date: Date) : String = {
			import java.util.Date
			import java.text.SimpleDateFormat

			new SimpleDateFormat(Format.Pattern.date).format(date)
		}

		def year(date: Date = new java.util.Date) : String = {
			import java.util.Date
			import java.text.SimpleDateFormat
			new SimpleDateFormat("yyyy").format(date)
		}

		def hour(date: Date) : String = {
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
		


object Format{

	object Pattern{
		val date:String = "dd.MM.yyyy"

		val dateUrl:String = "yyyyMMdd'T'HHmmss'Z'"//
		val datetime:String = "dd.MM.yyyy HH:mm"

		// date time for the plugin moment.js
		val datetime_moment:String = "DD.MM.YYYY HH:mm"

		object Angular{
			val time = "H:mm"
			val date = "dd.MM.yyyy"
			val datetime = date+" "+time
		}
	}		
}