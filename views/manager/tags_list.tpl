<div class="panel panel-default">
	<div class="panel-heading">
		<h3 class="panel-title">{{Req.Desc}} 列表:</h3>
	</div>
	<div class="panel-body">
		<alert ng-if="Alert.show" type="Alert.type" close="CloseAlert($index)">{{Alert.msg}}</alert>
		<table class="table table-striped">
			<thead>
				<tr>
					<th>名称</th>
					<th>Custom URL</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<tr ng-repeat="Category in List">
					<td>{{Category.Name}}</td>
					<td><a href="/{{Req.Target}}/{{Category.Slug}}.html" target="_blank">{{Category.Slug}}</a></td>
					<td><a href="#/{{Req.Target}}/{{Category.Id}}">编辑</a></td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
