
<html ng-app="manager">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

<script src="/static/js/angular.min.js"></script>
<script src="/static/js/angular-route.js"></script>
<script src="/static/js/ui-bootstrap-tpls-0.10.0.js"></script>

<script src="/static/js/codemirror.js"></script>
<script src="/static/js/ui-codemirror.js"></script>
<script src="/static/js/markdown.js"></script>

<link rel="stylesheet" href="/static/css/codemirror.css">

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
							<li class="divider"></li>
							<li><a href="#/posts?status=Draft"> <b>Draft</b> </a></li>
							<li><a href="#/posts?status=Secret"> Secret </a></li>
							<li><a href="#/posts?status=Friend"> Friend </a></li>
							<li><a href="#/posts?status=Publish"> Publish </a></li>
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
							<li><a href="/manager/login.html"> 注销 </a></li>
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

<script type="text/ng-template" id="Main.html">
	<div class="well"><h2>Wellcome!</h2></div>
</script>

</body>

</html>

