<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8"/>
	<title>demo</title>
	<link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<style type="text/css">
		th{
			width: 102px;
		}
		td{
			font-size: 15px;
			width: 102px;
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
		label{
			width: 70px;
			text-align: right;
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
			<div style="display: inline-block;float: right;margin-right: 60px;">
				<div style="">
					<img src="https://springcloud.cc/images/spring-cloud-config.png" alt="My Avatar" class="img-circle">
					<strong style="margin-left: 5px;">Name</strong>
				</div>
				<button type="button" class="btn btn-info">Add</button>
				<button type="button" class="btn btn-default" style="display: inline-block;"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span></button>
				<div style="line-height: 50px;text-align: center;display: inline-block;"><button type="button" class="btn btn-warning">Logout</button></div>
			</div>
		</div>
		<table class="table table-hover table-condensed">
			<thead>
				<tr>
					<th>Avatar</th>
					<th>Id</th>
					<th>Name</th>
					<th>Pwd</th>
					<th>Sex</th>
					<th>Mobile</th>
					<th>Email</th>
					<th><span id="thStatus" data-toggle="tooltip" data-placement="top" title="0-Free 1-Duty 2-Mult">Status</span></th>
					<th>Create Time</th>
					<th>Update Time</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><img src="https://springcloud.cc/images/spring-cloud-config.png" alt="My Avatar" class="img-rounded"></td>
					<td>1001</td>
					<td>1001</td>
					<td>1001</td>
					<td>1001</td>
					<td>1001</td>
					<td>1001</td>
					<td>1001</td>
					<td>1001</td>
					<td>1001</td>
					<td>
						<div class="btn-group" role="group">
  							<button type="button" class="btn btn-primary" style="font-size: 6px;">Edit</button>
  							<button type="button" class="btn btn-danger" style="font-size: 6px;">Del</button>
						</div>
					</td>
				</tr>
				<tr>
					<td>1001</td>
					<td>1001</td>
					<td>1001</td>
					<td>1001</td>
					<td>1001</td>
					<td>1001</td>
					<td>1001</td>
					<td>1001</td>
					<td>1001</td>
					<td>1001</td>
					<td>
						<div class="btn-group" role="group">
  							<button type="button" class="btn btn-primary" style="font-size: 6px;">Edit</button>
  							<button type="button" class="btn btn-danger" style="font-size: 6px;">Del</button>
						</div>
					</td>
				</tr>
				<tr>
					<td>1001</td>
					<td>1001</td>
					<td>1001</td>
					<td>1001</td>
					<td>1001</td>
					<td>1001</td>
					<td>1001</td>
					<td>1001</td>
					<td>1001</td>
					<td>1001</td>
					<td>
						<div class="btn-group" role="group">
  							<button data-toggle="modal" data-target="#updateModal" type="button" class="btn btn-primary" style="font-size: 6px;">Edit</button>
  							<button type="button" class="btn btn-danger" style="font-size: 6px;">Del</button>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="modal fade" id="updateModal" tabindex="-1" aria-labelledby="updateModalLabel">
  		<div class="modal-dialog">
	    	<div class="modal-content">
		      	<div class="modal-header">
		        	<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        	<h4 class="modal-title text-primary" id="updateModalLabel">Update Person</h4>
		      	</div>
		      	<div class="modal-body">
		        <form class="form-inline">
		        	<div class="form-group">
		        		<label style="margin-bottom: 25px;">Status</label>
		        		<label class="radio-inline">
  							<input type="radio" name="status" id="statusRadio1" value="0"> Free
						</label>
						<label class="radio-inline">
  							<input type="radio" name="status" id="statusRadio2" value="1"> Duty
						</label>
						<label class="radio-inline">
  							<input type="radio" name="status" id="statusRadio3" value="2"> Mult
						</label>
		        	</div>
		        	<div class="form-group">
		        		<label>Id</label>
		        		<input type="text" class="form-control" id="id" name="id">
		        	</div>
		        	<div class="form-group">
		        		<label>Name</label>
		        		<input type="text" class="form-control" id="name" name="name">
		        	</div>
		        	<div class="form-group">
		        		<label>Password</label>
		        		<input type="password" class="form-control" id="pwd" name="pwd">
		        	</div>
		        	<div class="form-group">
		        		<label>Sex</label>
		        		<label class="radio-inline">
  							<input type="radio" name="sex" id="sexRadio1" value="M"> Male
						</label>
						<label class="radio-inline">
  							<input type="radio" name="sex" id="sexRadio2" value="F"> FeMale
						</label>
		        	</div>
		        	<div class="form-group">
		        		<label>Mobile</label>
		        		<input type="text" class="form-control" id="mobile" name="mobile">
		        	</div>
		        	<div class="form-group">
		        		<label>Email</label>
		        		<input type="email" class="form-control" id="email" name="email">
		        	</div>
		        	<br><br>
		        	<div class="form-group">
		        		<label>Avatar</label>
		        		<input type="file" class="form-control" id="avatar" name="avatar">
		        		<img style="margin-left: 60px;" src="https://springcloud.cc/images/spring-cloud-config.png" alt="My Avatar" class="img-rounded">
		        	</div>
		        </form>
		      	</div>
		      	<div class="modal-footer">
		        	<button type="button" class="btn btn-primary">Save</button>
		      	</div>
    		</div>
  		</div>
	</div>
</body>
<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script>
	$('#thStatus').tooltip();
</script>
</html>