<div class="panel panel-default">
	<div class="panel-heading">
		<h3 class="panel-title">{{Req.Desc}} 列表:</h3>
	</div>
	<div class="panel-body">
		<alert ng-if="Alert.show" type="Alert.type" close="CloseAlert($index)">{{Alert.msg}}</alert>
		<table class="table table-striped">
			<thead>
				<tr>
					<th>昵称</th>
					<th>EMail</th>
					<th>权限</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<tr ng-repeat="User in List">
					<td>{{User.Name}}</td>
					<td>{{User.Email}}</td>
					<td>{{User.Privilege}}</td>
					<td><a href="#/user/{{User.Id}}">编辑</a></td>
				</tr>
			</tbody>
		</table>
	</div>
</div>