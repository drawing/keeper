<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title"> 博文列表: </h3>
		</div>
		<div class="panel-body">
			<alert ng-if="Alert.show" type="Alert.type" close="CloseAlert($index)">{{Alert.msg}}</alert>
			<table class="table table-striped">
				<thead>
					<tr>
						<th>标题</th>
						<th>状态</th>
						<th>创建时间</th>
						<th>操作</th>
					</tr>
				</thead>
				</tbody>
					<tr ng-repeat="Post in Posts">
						<td><a href="/reading/{{Post.Slug}}.html" target="_blank">{{Post.Title}}</a></td>
						<td>{{Post.Status}}</td>
						<td>{{Post.CreateDate}}</td>
						<td><a href="#/post/{{Post.Id}}">编辑</a></td>
					</tr>
				</tbody>
			</table>
			<ul class="pagination">
				<li class="disabled"><a>&laquo;</a></li>
				<li ng-repeat="Page in Pages" ng-class="{active: $index==CurPage}"><a href="#/posts?page={{Page}}"> {{Page+1}} <span class="sr-only">(current)</span></a></li>
				<li class="disabled"><a>&raquo;</a></li>
			</ul>
		</div>
		<div class="panel-footer">
		<p>文章总数：{{Count}}</p>
		</div>
	</div>