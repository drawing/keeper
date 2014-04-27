
<html ng-app="manager">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.2.8/angular.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.2.8/angular-route.js"></script>
<script src="http://angular-ui.github.io/bootstrap/ui-bootstrap-tpls-0.10.0.js"></script>

<script src="http://cdnjs.cloudflare.com/ajax/libs/ace/1.1.3/ace.js"></script>
<script src="/static/js/ui-ace.js"></script>

<script src="/static/js/manager.js"></script>
<!-- link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css" -->
<link rel="stylesheet" href="/static/css/bootstrap.css">

<title> {% .SiteTitle %} - 管理系统 </title>
</head>


<style type="text/css">
.ace_editor {
	height: 640px;
	font-size: 15px;
}
</style>
<body>

<div class="container">
	<div class="page-header">
		<h1>博客管理平台 <small>Beta</small></h1>
	</div>

	<nav class="navbar navbar-default" role="navigation">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#">管理</a>
		    </div>
		
			<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<li class="dropdown">
						<a class="dropdown-toggle" data-toggle="dropdown"> 博文管理 <b class="caret"></b></a>
						<ul class="dropdown-menu">
							<li><a href="#/posts"> 博文列表 </a></li>
							<li class="divider"></li>
							<li><a href="#/post/0"> 创建博文 </a></li>
						</ul>
					</li>
					<li class="dropdown">
						<a class="dropdown-toggle" data-toggle="dropdown"> Classify管理 <b class="caret"></b></a>
						<ul class="dropdown-menu">
							<li><a href="#/categories"> Category 列表 </a></li>
							<li><a href="#/category/0"> Category 创建 </a></li>
							<li class="divider"></li>
							<li><a href="#/tags"> Tag 列表 </a></li>
							<li><a href="#/tag/0"> Tag 创建 </a></li>
						</ul>
					</li>
					<li class="dropdown">
						<a class="dropdown-toggle" data-toggle="dropdown"> 用户管理 <b class="caret"></b></a>
						<ul class="dropdown-menu">
							<li><a href="#/users"> 用户列表 </a></li>
							<li class="divider"></li>
							<li><a href="#/user/0"> 新建用户 </a></li>
						</ul>
					</li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown">
						<a class="dropdown-toggle" data-toggle="dropdown"> 用户 <b class="caret"></b></a>
						<ul class="dropdown-menu">
							<li><a href="#"> 注销 </a></li>
						</ul>
					</li>
				</ul>
			</div><!-- /.navbar-collapse -->
		</div><!-- /.container-fluid -->
	</nav>

	<div class="row">
		<div ng-view class="col-sm-12"></div>
	</div>
</div>


<script type="text/ng-template" id="PostList.html">
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
</script>

<script type="text/ng-template" id="PostShow.html">
<div class="panel panel-default">
	<div class="panel-heading">
		<h3 class="panel-title"> {{Req.Desc}} : {{Post.Title}} </h3>
	</div>
	<div class="panel-body form-horizontal">
		<alert ng-if="Alert.show" type="Alert.type" close="CloseAlert(false, $index)">{{Alert.msg}}</alert>
		
		<form class="col-sm-12">
			<input type="text" class="form-control" placeholder="Title" ng-model="Post.Title">
			<hr>
			<div ui-ace="{theme:'twilight', mode: 'markdown', useWrapMode : true}" ng-model="Post.Content"></div>
		</form>

		<div class="col-sm-6">
			<form class="form-horizontal" role="form">
				<div class="form-group">
						<label class="control-label col-sm-4">Custom URL:</label>
						<div class="col-sm-8">
							<input type="text" class="form-control" placeholder="Custom URL" ng-model="Post.Slug">
						</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-4">Category:</label>
					<div class="btn-group col-sm-8">
						<button class="btn btn-default dropdown-toggle col-sm-12" type="button" data-toggle="dropdown">{{Post.Category.Name}} <span class="caret"></span></button>
						<ul class="dropdown-menu">
							<li ng-repeat="Category in Categories"><a ng-click="SelectCategory($index)">{{Category.Name}}</a></li>
						</ul>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-4">Tag:</label>
					<div class="btn-group col-sm-8">
						<button class="btn btn-default dropdown-toggle col-sm-12" type="button" data-toggle="dropdown">{{Post.Tag.Name}} <span class="caret"></span></button>
						<ul class="dropdown-menu">
							<li ng-repeat="Tag in Tags"><a ng-click="SelectTag($index)">{{Tag.Name}}</a></li>
						</ul>
					</div>
				</div>
			</form>
		</div>
		<div class="col-sm-6">
			<alert ng-if="UploadAlert.show" type="UploadAlert.type" close="CloseAlert(true, $index)">{{UploadAlert.msg}}</alert>
			<table class="col-sm-12 table table-striped">
				<thead>
					<tr>
						<th>附件</th>
						<th>URI</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<tr ng-repeat="Resource in Post.Resource">
						<td><a href="{{Resource.ReqURI}}" target="_blank"> {{Resource.Name}} </a></td>
						<td>{{Resource.ReqURI}}</td>
						<th><a>删除</a></td>
					</tr>
					<tr>
						<td><button class="btn btn-danger btn-sm" ng-click="Upload()">上传</button></td>
						<td colspan="2"><input class="btn btn-default" type="file" ng-model="SelectFile" onchange="angular.element(this).scope().setFile(this)"></td>
					</tr>
				</tbody>
			</table>
			<form class="form-horizontal" role="form">
				<div class="form-group">
					
					
				</div>
			</form>
		</div>

		<div class="form-group">
			<div class="btn-group col-sm-8">
				<button class="btn btn-primary col-sm-4" ng-click="Publish()"> {{Post.Status}} </button>
				<button class="btn btn-primary dropdown-toggle" data-toggle="dropdown"> &nbsp <span class="caret"></span></button>
				<ul class="dropdown-menu" role="menu">
					<li ng-repeat="PubAction in PubActions"><a ng-click="SelectPubAction($index)">{{PubAction}}</a></li>
				</ul>
			</div>
		</div>
	</div>
</div>
</script>


<script type="text/ng-template" id="CategoryList.html">
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
</script>

<script type="text/ng-template" id="CategoryShow.html">
<div class="panel panel-default">
	<div class="panel-heading">
		<h3 class="panel-title">{{Req.Desc}} 编辑:</h3>
	</div>
	<div class="panel-body">
		<alert ng-if="Alert.show" type="Alert.type" close="CloseAlert($index)">{{Alert.msg}}</alert>
		<form class="form-horizontal" role="form">
			<div class="form-group">
				<label class="col-sm-4 control-label">分类:</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" placeholder="{{Req.Desc}}" ng-model="One.Name" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-4 control-label">Custom URL:</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" placeholder="Custom URL" ng-model="One.Slug">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-4 control-label">介绍:</label>
				<div class="col-sm-6">
					<textarea class="form-control" rows="3" placeholder="Support Markdown" ng-model="One.Desc"></textarea>
					<br>
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-4">
					<button class="btn btn-primary col-sm-4" ng-click="SaveElement()"> Save </button>
				</div>
			</div>
		</form>
	</div>
</div>
</script>

<script type="text/ng-template" id="UserList.html">
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
</script>

<script type="text/ng-template" id="UserShow.html">
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
					<input type="text" class="form-control" placeholder="Password" ng-model="One.Password" required><br>
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-4">
					<button class="btn btn-primary col-sm-4" ng-click="SaveElement()"> Save </button>
				</div>
			</div>
		</form>
	</div>
</div>
</script>

<script type="text/ng-template" id="Main.html">
	<div class="well"><h2>Wellcome!</h2></div>
</script>

</body>

</html>

