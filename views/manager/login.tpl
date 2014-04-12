
<!doctype html>
<html ng-app=>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

<title>{% .SiteTitle %} - 登录</title>
<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.2.6/angular.min.js"></script>
<script src="http://angular-ui.github.io/bootstrap/ui-bootstrap-tpls-0.10.0.js"></script>

<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css">
<script>
var LoginCtrl = function($scope, $http) {
	$scope.User = new Object();
	
	$scope.Login = function() {
		user = $scope.User
		if (user == null || user.Email == null || user.Password == "") {
			alert("登录需要填写邮箱密码");
			return;
		}
		
		$http({
			method:'POST',
			url:'/api/login',
			data:user
		}).success(
			function(response, status, headers, config) {
				if (response.Code == 0) {
					document.location = response.Message;
				}
				else {
					alert("登录失败，请检查用户密码");
				}
			}
		).error(
			function(response, status, headers, config) {
				alert("登录失败，请稍候重试");
			}
		)
	};
}
</script>
</head>
<body>

<div class="item active">
	<center><img height="320" src="http://www.blender.org/wp-content/uploads/2013/05/caminandes_01.jpg"></center>
</div>
<br>
<div class="container" ng-controller="LoginCtrl">

<div class="row">
	<div class="form-group col-md-4 col-md-offset-4">
		<label for="exampleInputEmail1">Email:</label>
		<input type="email" class="form-control" ng-model="User.Email" placeholder="Email">
	</div>
</div>

<div class="row">
	<div class="form-group col-md-4 col-md-offset-4">
		<label>密码:</label>
		<input type="password" class="form-control" id="exampleInputPassword1" placeholder="Password" ng-model="User.Password">
	</div>
</div>
<div class="row">
	<div class="form-group col-md-4 col-md-offset-4">
		<center>
		<button type="submit" class="btn btn-default" ng-click="Login()">登录</button>
		</center>
	</div>
</div>
</div>
</body>
</html>

