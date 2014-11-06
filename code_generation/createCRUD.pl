use strict;


# todo / missing

# - formy
# - SQL table generation

# set variable/class/file names
my $controller_object		= "ExampleCtrl";
my $model_object			= "Example";
my $folder_name 			= "example";

my $table_name				= "example";

my $model_case				= $model_object;

my $route_path				= "example";

my $prefix_translator		= "example";


#prepare variables
my $myForm 						="";

my $model_case_fields=""; 	# generates case class(id: Long, ...)
my $model_case_get=""; 		# generates get[Long])("id")~
my $model_case_get2=""; 	# generates id~name~...
my $model_case_get3=""; 	# generates id, name, 
my $model_case_get4=""; 	# generates "id", "name", 
my $mysql_set="";			# defines SET name={name}
my $mysql_fields="";		# defines 'name -> v.name
my $form_content ="";
my $list_content ="";
my $detail_content ="";

############
#
# set fields					
#
############
my @fields_name = ("id","name", "age");
my @fields_type = ("Option[Long]","String", "Long");
my @fields_form = ("optional(longNumber)","nonEmptyText", "longNumber");


for(my $i=0;$i<@fields_type;++$i){
	$myForm				= $myForm."\t\"".$fields_name[$i]."\"\t-> ".$fields_form[$i].",\n";
	$model_case_fields	= $model_case_fields.$fields_name[$i].": ".$fields_type[$i].", ";
	$model_case_get		= $model_case_get."\tget[".$fields_type[$i]."](\"".$fields_name[$i]."\")~\n";
	$model_case_get2	= $model_case_get2.$fields_name[$i]."~";
	$model_case_get3	= $model_case_get3.$fields_name[$i].", ";
	$model_case_get4	= "\"".$model_case_get4.$fields_name[$i]."\", ";
	$mysql_fields		= $mysql_fields."\n\t\t\t'".$fields_name[$i]."\t-> v.".$fields_name[$i].",";

	if($fields_name[$i] ne "id"){
		$form_content				= $form_content."\t\t"."\@inputText(myForm(\"".$fields_name[$i]."\"), '_label -> Messages(\"".$fields_name[$i]."\"))\n";

		$detail_content				= $detail_content."\t\t\t<tr><td>\@Messages(\"".$fields_name[$i]."\")</td><td>\@values.".$fields_name[$i]."</td></tr>\n";

		$mysql_set					= $mysql_set.$fields_name[$i]."={".$fields_name[$i]."},";
		
	}
}


$myForm						= substr($myForm,0,-2);
$model_case_fields			= substr($model_case_fields,0,-2);
$model_case_get				= substr($model_case_get,0,-2)." map {\n\t\t\t\tcase ".substr($model_case_get2,0,-1)." => ".$model_case."(".substr($model_case_get3,0,-2).")\n\t\t\t}";
$mysql_fields				= substr($mysql_fields,0,-1);
$mysql_set					= substr($mysql_set,0,-1);
$model_case_get4 			= substr($model_case_get4, 0, -2);

###
				
my $routes = "# $controller_object
POST\t/$route_path/list\tcontrollers.$controller_object.list
POST\t/$route_path/detail\tcontrollers.$controller_object.detail
POST\t/$route_path/update\tcontrollers.$controller_object.update
POST\t/$route_path/delete\tcontrollers.$controller_object.delete

POST\t/$route_path\tcontrollers.$controller_object.index
POST\t/$route_path/edit\tcontrollers.$controller_object.edit";


					
my $model="
package models

import play.api._
import play.api.mvc._
import play.api.db._
import play.api.Play.current

import anorm._
import anorm.SqlParser._

import java.util.Date

case class $model_case($model_case_fields)


object $model_object extends tCRUD[$model_case]{


	val table = \"$table_name\"
	val query = \"SELECT * FROM \"+table

	def list = {
		DB.withConnection { implicit c =>
			SQL(query)
			.as(parser *)
		}
	}

	def detail(id: Long) = {
		DB.withConnection {implicit c =>
			SQL(query+\" WHERE id={id}\")
			.on('id -> id)
			.as(parser singleOpt)
		}
	}

	def update(v: $model_case) = {

		val q:String = 
			{if(v.id.isDefined){\"UPDATE \"}else{\"INSERT INTO \"}}+
			table+
			\" SET $mysql_set\"+
			{if(v.id.isDefined){\" WHERE id={id}\"}}

		DB.withConnection { implicit c =>
			SQL(q)
			.on(
				$mysql_fields
			) 
			.executeUpdate()
		}

		if(v.id.isDefined){
			v.id
		}
		else{
			utils.MySQL.getLastId(table)
		}
	}

	def delete(id: Long) = utils.MySQL.delete(id, table)>0



	val parser = {
".$model_case_get."
	}


}";


my $controller = "
package controllers

import play.api._
import play.api.mvc._

import play.api.data._
import play.api.data.Forms._
import play.api.data.format.Formats._ 

import play.api.libs.json._
import play.api.libs.json.Json


import models._

object $controller_object extends Controller {

  implicit val userFormat1 = Json.format[$model_case]

  def index = Action{
    Ok(views.html.$folder_name.index())
  }

  def edit = Action{implicit request =>
    simpleOForm.bindFromRequest.fold(
      e => BadRequest(\"error\"), 
      v => Ok(views.html.$folder_name.update(v))
    )
  }

  def list = Action{
    Ok(Json.toJson($model_object.list))
  }

  def update = Action{implicit request =>
    myForm.bindFromRequest.fold(
      e => {
        import play.api.i18n._
        val b = JsObject(e.errors.map{a =>
          a.key.replace(\".\",\"_\") -> JsString(Messages(a.message))
        })
        BadRequest(Json.toJson(b))
      }
      , v => {
        val id = $model_object.update(v)
        if(id.isDefined){
          Ok(Json.toJson($model_object.detail(id.get).get))
        }
        else{
          BadRequest(\"error\")
        }
      }
    )
  }

  def detail = Action{implicit request =>
    simpleForm.bindFromRequest.fold(
      e => Ok(JsNull),
      v => {
        Ok(Json.toJson($model_object.detail(v)))
      }
    )
  }


  val myForm = Form(
    mapping(
      $myForm
    )($model_object.apply)($model_object.unapply)
  )

  val simpleForm = Form(
    single(
      \"id\" -> longNumber
    )
  )

  val simpleOForm = Form(
    single(
      \"id\" -> optional(longNumber)
    )
  )

  

  def delete = Action{implicit request =>
    simpleForm.bindFromRequest.fold(
      e => BadRequest(\"error\"),
      v => {
        $model_object.delete(v)
        Ok(\"deleted\")
      }
    )
  }
}
";



# 
# #### HTML
# 
#


my $html_index = "
\@()

\@tableHeader(name: String) = {
   <th>\@name <a ng-click=\"predicate='\@name';reverse=!reverse\"><span class=\"glyphicon glyphicon-sort\"></span></a></th>
}

\@tableElement(name: String) = {
  <td>{{item.\@name}}</td>
}

\@main(\"\"){
<article ng-app=\"myApp\">
<h2>List</h2>

<section ng-controller=\"crud\" ng-init=\"list()\">

<a class=\"btn btn-primary\" href=\"\@routes.$controller_object.edit\"><span class=\"glyphicon glyphicon-plus\"></span></a>

<table class=\"table table-striped table-hover\">

<thead>
<tr>
\@Seq($model_case_get4).map{name =>
\@tableHeader(name)
}
<th></th>
</tr>
</thead>

<tbody>
  <tr ng-repeat=\"item in values | orderBy:predicate:reverse\">
  \@Seq($model_case_get4).map{name =>
    \@tableElement(name)
  }
  <td>
    <form id=\"{{item.id}}\" action=\"\@routes.$controller_object.edit\" method=\"GET\">
      <input type=\"hidden\" name=\"id\" value=\"{{item.id}}\">
      <button class=\"btn btn-primary\"><span class=\"glyphicon glyphicon-edit\"></span></button>
    </form>
    <a ng-click=\"delete(item.id)\" class=\"btn btn-danger\"><span class=\"glyphicon glyphicon-remove\"></span></a>
  </td>
  </tr>
</tbody>

</table>


</section>

</article>
\@widget.js_tag(\"bower_components/angular/angular.min.js\")
<script type=\"text/javascript\">


var app = angular.module('myApp', []);
function crud(\$scope, \$http, \$filter) {
    \$scope.values = []
    \$scope.predicate = '-first_name';

    \$scope.list = function(){
        \$http({
            method: \"POST\", 
            url: '\@routes.$controller_object.list',
            data: \$scope.value
        })
        .success(function (jdata) {
            console.log(\"success\")
            \$scope.values = jdata
                 
        })
        .error(function(jdata){
        })
    }

    \$scope.delete = function(id){

      \$http({
            method: \"POST\", 
            url: '\@routes.$controller_object.delete',
            data: {id: 0}
        })
        .success(function (jdata) {
          var c = angular.copy(\$scope.values)

          angular.forEach(c, function(v, k){
            if(v.id == id){
              \$scope.values.splice(k, 1)
            }
          })
          
        })
        .error(function(jdata){        })

    }
}

</script>

}
";


# todo do collection formy input
my $html_update = "
\@(id: Option[Long] = None)


\@main(\"\"){
<article ng-app=\"myApp\">
<h2>Update </h2>

<section ng-controller=\"crud\" ng-init=\"\@if(id.isDefined){detail()}\">
<form ng-submit=\"update()\">
  \@formy.input(\"fname\")

  <input class=\"btn btn-primary\" type=\"submit\">
    <a class=\"btn btn-default\" href=\"\@routes.Users.index\">Back</a>
  </form>

</section>


</article>
\@widget.js_tag(\"bower_components/angular/angular.min.js\")
<script type=\"text/javascript\">


var app = angular.module('myApp', []);
function crud(\$scope, \$http,\$filter) {
    \$scope.value = {}
    \$scope.error = {}

    \$scope.connections = []

    \$scope.detail = function(){
        \$http({
            method: \"POST\", 
            url: '\@routes.$controller_object.detail',
            data: {id: \@id.getOrElse(\"null\")}
        })
        .success(function (jdata) {
            \$scope.value = jdata
                 
        })
        .error(function(jdata){
        })
    }

    \$scope.update = function(){
        \$http({
            method: \"POST\", 
            url: '\@routes.$controller_object.update',
            data: \$scope.value
        })
        .success(function (jdata) {
            console.log(\"success\")
            \$scope.value = jdata
            \$scope.error = null
            \$scope.show = true          
        })
        .error(function(jdata){
            console.log('error')
            \$scope.error = jdata
        })
    }

    
}

</script>

}
";




## write into files

# create dir
 mkdir($folder_name);

open(WFILE, '>'.$folder_name."/".'index.scala.html');
 print WFILE $html_index;

open(WFILE, '>'.$folder_name."/".'update.scala.html');
 print WFILE $html_update;

open(WFILE, '>'.$model_object.'.scala');
 print WFILE $model;

open(WFILE, '>'.$controller_object.'.scala');
 print WFILE $controller;

print "##### routes #####\n\n".$routes."\n\n";

