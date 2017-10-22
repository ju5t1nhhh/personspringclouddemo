<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8"/>
	<title>demo</title>
	<link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<style type="text/css">
		th{
			width: 160px;
		}
		td{
			font-size: 15px;
			width: 160px;
			height: 61px;
		}
		img{
			height: 50px;
			width: 50px;
		}
		thead{
			display: table;
			width: 100%;
			table-layout: fixed;
		}
		tbody{
			width: calc(100%+1em);
			height: 500px;
			display: block;
			overflow-y: scroll;
		}
		tr{
			table-layout: fixed;
			display: table;
		}
		label+input{
			margin-bottom: 10px;
		}
	</style>
</head>
<body>
	<div class="container">
		<br><br>
		<br><br>
		<div>
			<div style="display: inline-block;float: right;margin: 50px 60px 10px 0;">
				<button id="refresh" type="button" class="btn btn-default" style="display: inline-block;"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span></button>
				<div style="line-height: 50px;text-align: center;display: inline-block;"><button type="button" class="btn btn-info" data-toggle="modal" data-target="#loginModal">Login</button></div>
			</div>
		</div>
		<table class="table table-hover table-condensed" style="word-break: break-all;word-wrap: break-word;">
			<thead>
				<tr>
					<th>Avatar</th>
					<th>Id</th>
					<th>Name</th>
					<th>Sex</th>
					<th>Mobile</th>
					<th>Email</th>
					<th><span id="thStatus" data-toggle="tooltip" data-placement="top" title="0-Free 1-Duty 2-Mult">Status</span></th>
				</tr>
			</thead>
			<tbody>
				<#if people??>
				<#list people as person>
				<tr>
					<td>
						<#if person.avatar??>
							<img src="${person.avatar}" alt="My Avatar" class="img-rounded">
						</#if>
					</td>
					<td>${person.id!}</td>
					<td>${person.name!}</td>
					<td>${person.sex!}</td>
					<td>${person.mobile!}</td>
					<td>${person.email!}</td>
					<td>${person.status!}</td>
				</tr>
				</#list>
				</#if>
			</tbody>
		</table>
	</div>
    <div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title text-primary" id="updateModalLabel">Sign In</h4>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-group">
                            <label>Name</label>
                            <input type="text" class="form-control" id="name" name="name">
                        </div>
                        <div class="form-group">
                            <label>Password</label>
                            <input type="password" class="form-control" id="pwd" name="pwd">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button id="loginFormBtn" type="button" class="btn btn-primary">Login</button>
                </div>
            </div>
        </div>
    </div>
</body>
<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script>
	var nullToBlank=function (item) {
	    return item==null?"":item;
    };
	$('#thStatus').tooltip();
	$('#refresh').click(function(){
	   $.get("/visitorList",function(res){
           $('tbody').html("");
           $.each(res.data,function(i,person){
               var img=person.avatar==null?"":"<img src='"+person.avatar+"' alt='Avatar' class='img-rounded'>";
               $('tbody').append("" +
                       "<tr>" +
                       "<td>"+img+"</td>" +
                       "<td>"+nullToBlank(person.id)+"</td>" +
                       "<td>"+nullToBlank(person.name)+"</td>" +
                       "<td>"+nullToBlank(person.sex)+"</td>" +
                       "<td>"+nullToBlank(person.mobile)+"</td>" +
                       "<td>"+nullToBlank(person.email)+"</td>" +
                       "<td>"+nullToBlank(person.status)+"</td>" +
                       "</tr>" +
                       "");
           });
	   });
	});
	$('#loginFormBtn').click(function () {
	    $.post("/login",{name:$('#name').val(),pwd:$('#pwd').val()},function (res) {
			if(res.status==200){
			    location.reload();
			}else{
			    $('.modal-body').append("" +
						"<div class='alert alert-danger alert-dismissible' role='alert'>" +
						"<button type='button' class='close' data-dismiss='alert' aria-label='Close'>" +
						"<span aria-hidden='true'>&times;</span>" +
						"</button>" +
						"<strong>Error!</strong>&nbsp;" +
						res.msg +
						"</div>" +
						"");
			}
        });
    });
</script>
</html>