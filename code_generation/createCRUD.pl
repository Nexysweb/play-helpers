use strict;


# todo: order by name

# set variable/class/file names
my $controller_object		= "ExampleCtrl";
my $model_object			= "Example";
my $folder_name 			= "example";

my $table_name				= "example";


#my $model_case_list		= "Tasks";
my $model_case				= "Example";

my $route_path				= "example";

my $prefix_translator		= "example";


### html template filenames
#my $html_name_add 		= "add";
#my $html_name_edit 		= "edit";
#my $html_name_list 		= "list";
#my $html_name_detail		= "detail";




#prepare variables
my $myForm 						="";

my $model_case_fields=""; 	# generates case class(id: Long, ...)
my $model_case_get=""; 		# generates get[Long])("id")~
my $model_case_get2=""; 	# generates id~name~...
my $model_case_get3=""; 	# generates id, name, 
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
	$mysql_fields		= $mysql_fields."\n\t\t\t'".$fields_name[$i]."\t-> v.".$fields_name[$i].",";

	if($fields_name[$i] ne "id"){
		$form_content				= $form_content."\t\t"."\@inputText(myForm(\"".$fields_name[$i]."\"), '_label -> Messages(\"".$fields_name[$i]."\"))\n";

		$detail_content				= $detail_content."\t\t\t<tr><td>\@Messages(\"".$fields_name[$i]."\")</td><td>\@values.".$fields_name[$i]."</td></tr>\n";

		$mysql_set					= $mysql_set.$fields_name[$i]."={".$fields_name[$i]."},";
		
	}
}


$myForm						= substr($myForm,0,-2);
$model_case_fields	= substr($model_case_fields,0,-2);
$model_case_get		= substr($model_case_get,0,-2)." map {\n\t\t\t\tcase ".substr($model_case_get2,0,-1)." => ".$model_case."(".substr($model_case_get3,0,-2).")\n\t\t\t}";
$mysql_fields				= substr($mysql_fields,0,-1);
$mysql_set					= substr($mysql_set,0,-1);

###
				
my $routes = "# $controller_object
POST\t/$route_path/list\tcontrollers.$controller_object.list
POST\t/$route_path/detail\tcontrollers.$controller_object.detail
POST\t/$route_path/update\tcontrollers.$controller_object.update
POST\t/$route_path/delete\tcontrollers.$controller_object.delete

POST\t/$route_path\tcontrollers.$controller_object.index
POST\t/$route_path/edit\tcontrollers.$controller_object.edit";


					
my $model="
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


# my $controller ="object $controller_object extends Controller{
# 	def list = Action{
# 		Ok(views.html.$folder_name.".$html_name_list."($model_object.list))
# 	}
# 	
# 	def detail(id: Long) = Action{
# 		Ok(views.html.$folder_name.".$html_name_detail."($model_object.detail(id)))
# 	}
# 	
# 	def add = Action{
# 		Ok(views.html.".$folder_name.".".$html_name_add."(myForm))
# 	}
# 	
# 	def insert = Action { implicit request =>
# 		myForm.bindFromRequest.fold(
# 			errors => BadRequest(views.html.$folder_name.".$html_name_add."(errors)),
# 			values => {
# 				$model_object.insert(values)
# 				Redirect(routes.$controller_object.list)
# 			}
# 		)
# 	}
# 	
# 	def edit(id: Long) = Action{
# 		Ok(views.html.$folder_name.".$html_name_edit."(id, myForm.fill($model_object.detail(id))))
# 	}
# 	
# 	def update(id: Long) = Action { implicit request =>
# 		myForm.bindFromRequest.fold(
# 			errors => BadRequest(views.html.$folder_name.".$html_name_edit."(id, errors)),
# 			values => {
# 				$model_object.update(id, values)
# 				Redirect(routes.$controller_object.list)
# 			}
# 		)
# 	}
# 	
# 	def delete(id: Long) = Action{
# 		$model_object.delete(id)
# 		Redirect(routes.$controller_object.list)
# 	}
# 	
# 	val myForm = Form(
# 		mapping(
# $myForm
# 		)
# 		($model_case_detail.apply)($model_case_detail.unapply)
# 	)
# }";
# 
# 
# 
# #### HTML
# 
# 
# my $html_add = "\@(myForm: Form[$model_case_detail])
# 
# \@import helper._
# 
# \@import play.api.i18n._
# 
# \@main(Messages(\"".$prefix_translator."_title_add\")) {
# 	\@form(routes.".$controller_object.".insert) {\n".
# 	$form_content."	
# 		<input type=\"submit\" value=\"\@Messages(\"add\")\">		
# 
# 	}
# }";
# 
# my $html_edit = "\@(id: Long, myForm: Form[$model_case_detail])
# 
# \@import helper._
# 
# \@import play.api.i18n._
# 
# \@main(Messages(\"".$prefix_translator."_title_edit\")) {
# 	\@form(routes.".$controller_object.".update(id)) {\n".
# 	$form_content."	
# 		<input type=\"submit\" value=\"\@Messages(\"edit\")\">		
# 
# 	}
# }";
# 
# 
# my $html_list = "\@(values: List[$model_case_list])
# 
# \@import helper._
# 
# \@main(Messages(\"".$prefix_translator."_list_title\")) {
#    
# 	<p><a href=\"\@routes.".$controller_object.".add\">\@Messages(\"add\")</a></p>
# 
# \@if(values.size>0){
# 	
# 
# 	<h2>\@values.size</h2>
#     <table>
#         \@values.map { value =>
#             <tr>".
# $list_content."
# 				<td><a href=\"\@routes.$controller_object.detail(value.id.get)\">\@Messages(\"view\")</a></td>
# 				<td><a href=\"\@routes.$controller_object.edit(value.id.get)\">\@Messages(\"edit\")</a></td>
# 				<td><a href=\"\@routes.$controller_object.delete(value.id.get)\">\@Messages(\"delete\")</a></td>	
#             </tr>
#         }
#     </table>
# }else{
# 	<p><i>\@Messages(\"no_num_row\")</i></p>
# }
# 
# 
# <ul>
# </ul>
# }";
# 
# 
# 
# my $html_detail ="\@(values: $model_case_detail)
# 
# \@import helper._
# 
# \@main(Messages(\"".$prefix_translator."_detail_title\")) {
# 	
# 
# 
#     <table>".
# $detail_content."
#     </table>
# 
# 	<ul>
# 		<li><a href=\"\@routes.".$controller_object.".list\">\@Messages(\"back\")</a></li>
# 		<li><a href=\"\@routes.".$controller_object.".edit(values.id.get)\">\@Messages(\"edit\")</a></li>
#     </ul>
# 
# }";

#print $html_add;


## write into files

# create dir
# mkdir($folder_name);

#open(WFILE, '>'.$folder_name."/".$html_name_add.'.scala.html');
# print WFILE $html_add;

# open(WFILE, '>'.$folder_name."/".$html_name_edit.'.scala.html');
# print WFILE $html_edit;

# open(WFILE, '>'.$folder_name."/".$html_name_list.'.scala.html');
# print WFILE $html_list;

# open(WFILE, '>'.$folder_name."/".$html_name_detail.'.scala.html');
# print WFILE $html_detail;

open(WFILE, '>out.txt');
my $controller="bullshit";
print WFILE "##### routes #####\n\n".$routes."\n\n##### controller #####\n\n".$controller."\n\n##### model #####\n\n".$model;

