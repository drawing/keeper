<div class="panel panel-default">
	<div class="panel-heading">
		<h3 class="panel-title">{{Req.Desc}} 编辑:</h3>
	</div>
	<div class="panel-body">
		<alert ng-if="Alert.show" type="Alert.type" close="CloseAlert($index)">{{Alert.msg}}</alert>
		<form class="form-horizontal" role="form">
			<div class="form-group">
				<label class="col-sm-4 control-label">NickName:</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" placeholder="NickName" ng-model="One.Name" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-4 control-label">Email:</label>
				<div class="col-sm-6">
					<input type="email" class="form-control" placeholder="Email" ng-model="One.Email" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-4 control-label">Privilege:</label>
				<div class="col-sm-6">
					<select class="form-control" ng-model="One.Privilege" required>
						<option>super</option>
						<option>friend</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-4 control-label">Password:</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" placeholder="Password" ng-model="One.Password" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-4 control-label">一次性密码:</label>
				<div class="col-sm-6">
					<img height="250" width="250" src="/qrcode/qr?secret={{One.Password}}&issuer={{One.Name}}"></img>
				</div>
			</div>
			<br>
			<div class="form-group">
				<div class="col-sm-offset-4">
					<button class="btn btn-primary col-sm-4" ng-click="SaveElement()"> Save </button>
				</div>
			</div>
		</form>
	</div>
</div>
