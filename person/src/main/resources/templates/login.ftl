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
			<div style="display: inline-block;float: right;margin: 50px 60px 10px 0;">
				<button type="button" class="btn btn-info" id="addBtn">Add</button>
				<button id="refresh" type="button" class="btn btn-default" style="display: inline-block;"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span></button>
				<div style="line-height: 50px;text-align: center;display: inline-block;"><button type="button" id="logoutBtn" class="btn btn-warning">Logout</button></div>
			</div>
		</div>
		<table class="table table-hover table-condensed" style="word-break: break-all;word-wrap: break-word;">
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
			</tbody>
		</table>
	</div>
	<div class="modal fade" id="templateModal" tabindex="-1" aria-labelledby="templateModalLabel">
  		<div class="modal-dialog">
	    	<div class="modal-content">
		      	<div class="modal-header">
		        	<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        	<h4 class="modal-title text-primary" id="updateModalLabel">Update Person</h4>
		      	</div>
		      	<div class="modal-body">
		        <form id="templateForm" class="form-inline" enctype="multipart/form-data">
		        	<div class="form-group" style="display: block;text-align: center;">
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
		        	<div class="form-group" id="idGlass">
		        		<label>Id</label>
		        		<input type="text" class="form-control" id="id" name="id" placeholder="System Default" readonly>
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
		        		<input type="file" class="form-control" id="avatarFile" name="avatarFile" placeholder="Suggestions:50px*50px">
		        	</div>
					<input type="hidden" id="avatar" name="avatar"/>
		        </form>
		      	</div>
		      	<div class="modal-footer">
		        	<button id="saveBtn" type="button" class="btn btn-primary">Save</button>
		      	</div>
    		</div>
  		</div>
	</div>
	<div class="modal fade" id="errorModal" tabindex="-1" aria-labelledby="errorModalLabel">
		<div class="modal-dialog">
			<div class="alert alert-danger alert-dismissible" role="alert">
				<buttun type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></buttun>
				<strong>Error!</strong>&nbsp;<span id="errorMsg"></span>
			</div>
		</div>
	</div>
	<input type="hidden" id="window" value="1"/>
</body>
<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script>
	var add0=function (m) {
		return m<10?'0'+m:m;
    };
	var formatDate=function (ts) {
		var time=new Date(ts);
		var year=time.getFullYear();
		var month=time.getMonth()+1;
		var date=time.getDate();
		var hour=time.getHours();
		var minute=time.getMinutes();
		var second=time.getSeconds();
		return year+'-'+add0(month)+'-'+add0(date)+'  '+add0(hour)+':'+add0(minute)+':'+add0(second);
    };
    var nullToBlank=function (item) {
        return item==null?"":item;
    };
    var loadData=function(){
            $.post("/loginList", function (res) {
                $('tbody').html("");
                $.each(res.data, function (i, person) {
                    var img = person.avatar == null ? "" : "<img src='" + person.avatar + "' alt='Avatar' class='img-rounded'>";
                    $('tbody').append("" +
                            "<tr>" +
                            "<td>" + img + "</td>" +
                            "<td>" + nullToBlank(person.id) + "</td>" +
                            "<td>" + nullToBlank(person.name) + "</td>" +
                            "<td>" + nullToBlank(person.pwd) + "</td>" +
                            "<td>" + nullToBlank(person.sex) + "</td>" +
                            "<td>" + nullToBlank(person.mobile) + "</td>" +
                            "<td>" + nullToBlank(person.email) + "</td>" +
                            "<td>" + nullToBlank(person.status) + "</td>" +
                            "<td>" + formatDate(person.createTime) + "</td>" +
                            "<td>" + formatDate(person.updateTime) + "</td>" +
                            "<td>" +
                            "<div class='btn-group' role='group'>" +
                            "<button type='button' class='btn btn-primary' style='font-size: 6px;' onclick='updatePersonWindow("+person.id+")'>" +
                            "<span class='glyphicon glyphicon-edit' aria-hidden='true'></span>" +
                            "</button>" +
                            "<button type='button' class='btn btn-danger' style='font-size: 6px;' onclick='delPerson("+person.id+")'>" +
                            "<span class='glyphicon glyphicon-remove' aria-hidden='true'></span>" +
                            "</button>" +
                            "</div>" +
                            "</td>" +
                            "</tr>" +
							"");
                });
            });
	};
    var updatePersonWindow=function(id){
        $('#window').val(2);
        $('#updateModalLabel').text("Update Person");
        $.post("/select",{id:id},function (res) {
            var person=res.data;
			$('#id').val(person.id);
			$('#name').val(person.name);
			$('#pwd').val(person.pwd);
			$("input[name='sex'][value="+person.sex+"]").attr("checked",true);
			$('#mobile').val(person.mobile);
			$('#email').val(person.email);
			$('#avatar').val(person.avatar);
            $("input[name='status'][value="+person.status+"]").attr("checked",true);
        });
        $('#templateModal').modal();
	};
	$('#thStatus').tooltip();
    $('#refresh').click(function(){
        loadData();
    });
    $('#logoutBtn').click(function () {
		$.post("/logout",function (res) {
			if(res.status==200){
			    location.reload();
			}else{
                $('#errorMsg').text(res.msg);
                $('#errorModal').modal();
			}
        });
    });
    $('#addBtn').click(function () {
        $('#window').val(1);
        $('#updateModalLabel').text("Add Person");
		$('#avatar').val(null);
		$('#id').val(null);
        $('#name').val(null);
        $('#pwd').val(null);
        $('#sex').val(null);
        $('#mobile').val(null);
        $('#email').val(null);
        $('#status').val(null);
        $('#createTime').val(null);
        $('#updateTime').val(null);
        $('#templateModal').modal();
    });
    $('#saveBtn').click(function () {
        var formData=new FormData($('#templateForm')[0]);
        var toUrl="/add";
        if($('#window').val()==2)toUrl="/update";
        $.ajax({
			url:toUrl,
			type:"post",
			data:formData,
			async:false,
			cache:false,
			contentType: false,
			processData: false,
			success: function (res) {
				if(res.status==200){
				    location.reload();
				}else{
				    alert(res.status);
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
            },
			error: function (e) {
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
    loadData();
    var delPerson=function (id) {
        $.post("/del",{id:id},function (res) {
			if(res.status==200){
			    location.reload();
			}else{
			    $('#errorMsg').text(res.msg);
				$('#errorModal').modal();
			}
        });
    };
</script>
</html>