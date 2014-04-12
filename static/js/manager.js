angular.module('manager',
		['ui.bootstrap', 'ngRoute', 'ui.ace'],
		function($routeProvider) {
			$routeProvider.when("/posts", {
				templateUrl: 'PostList.html',
				controller: PostListCtrl,
				resolve: {
					req: function ($route) {
						req = new Object();
						if (typeof $route.current.params.page == 'undefined') {
							req.Page = 0;
						}
						else {
							req.Page = Number($route.current.params.page);
						}
						return req;
					},
				}
			}).when("/post/:id", {
				templateUrl: 'PostShow.html',
				controller: PostShowCtrl,
				resolve: {
					req: function ($route) {
						req = new Object();
						req.Id = Number($route.current.params.id);
						return req;
					},
				}
			}).when("/users", {
				templateUrl: 'UserList.html',
				controller: ShortListCtrl,
				resolve: {
					req: function ($route) {
						req = new Object();
						req.Id = 0;
						req.Desc = "用户";
						req.URI = "/api/users";
						req.Target = "user";
						return req;
					},
				}
			}).when("/user/:id", {
				templateUrl: 'UserShow.html',
				controller: ShortListCtrl,
				resolve: {
					req: function ($route) {
						req = new Object();
						req.Id = Number($route.current.params.id);
						req.Desc = "用户";
						req.URI = "/api/users";
						req.Target = "user";
						return req;
					},
				}
			}).when("/categories", {
				templateUrl: 'CategoryList.html',
				controller: ShortListCtrl,
				resolve: {
					req: function ($route) {
						req = new Object();
						req.Id = 0;
						req.Desc = "Category";
						req.URI = "/api/categories";
						req.Target = "category";
						return req;
					},
				}
			}).when("/category/:id", {
				templateUrl: 'CategoryShow.html',
				controller: ShortListCtrl,
				resolve: {
					req: function ($route) {
						req = new Object();
						req.Id = Number($route.current.params.id);
						req.Desc = "Category";
						req.URI = "/api/categories";
						req.Target = "category";
						return req;
					},
				}
			}).when("/tags", {
				templateUrl: 'CategoryList.html',
				controller: ShortListCtrl,
				resolve: {
					req: function ($route) {
						req = new Object();
						req.Id = 0;
						req.Desc = "Tag";
						req.URI = "/api/tags";
						req.Target = "tag";
						return req;
					},
				}
			}).when("/tag/:id", {
				templateUrl: 'CategoryShow.html',
				controller: ShortListCtrl,
				resolve: {
					req: function ($route) {
						req = new Object();
						req.Id = Number($route.current.params.id);
						req.Desc = "Tag";
						req.URI = "/api/tags";
						req.Target = "tag";
						return req;
					},
				}
			}).otherwise({
				templateUrl: 'Main.html',
				controller: MainCtrl,
			})
		}
);

var PostListCtrl = function ($scope, $http, req) {
	$scope.Posts = [];
	$scope.Alert = new Object();
	$scope.Alert.show = false;
	
	$scope.Pages = [];
	$scope.CurPage = req.Page;
	$scope.PageNum = 0;
	$scope.Count = 0;
	
	$scope.CloseAlert = function(index) {
		$scope.Alert.show = false;
	};
	
	$http({
		method: 'GET',
		url: '/api/posts',
		params:{page:req.Page}
	}).success(
		function(response, status, headers, config) {
			if (response.Code == 0) {
				$scope.Posts = response.List;
				$scope.Count = response.Count;
				$scope.CurPage = response.CurPage;
				$scope.PageNum = response.PageNum;
				
				var start = $scope.CurPage - 3;
				if (start <= 0) {
					start = 0;
				}
				var end = $scope.PageNum + 3;
				if (end >= $scope.PageNum) {
					end = $scope.PageNum;
				}
				
				for (var cur = start; cur < end; cur++) {
					$scope.Pages.push(cur);
				}
			}
			else {
				$scope.Alert.show = true;
				$scope.Alert.type = 'danger';
				$scope.Alert.msg = response.Message;
			}
		}
	).error(
		function(response, status, headers, config) {
			$scope.Alert.show = true;
			$scope.Alert.type = 'danger';
			$scope.Alert.msg = "服务器错误：" + status;
		}
	);
}

var PostShowCtrl = function ($scope, req, $http, $modal, $location) {
	$scope.Req = req;
	
	$scope.Post = new Object();
	$scope.Post.Id = req.Id;
	$scope.Post.Category = new Object();
	$scope.Post.Tag = new Object();

	$scope.Categories = [];
	$scope.Tags = [];
	$scope.PubActions = ["Publish", "Draft", "Secret"];

	$scope.Post.Status = $scope.PubActions[0];
	
	$scope.ErrorMsg = [];
	$scope.Alert = new Object();
	$scope.UploadAlert = new Object();
	
	$scope.SelectFile = "";

	if ($scope.Post.Id == 0) {
		$scope.Req.Desc = "创建";
	}
	else {
		$scope.Req.Desc = "编辑";
	}

	$scope.setFile = function (elem) {
		$scope.RealFile = elem.files[0];
	};
			
	$scope.Upload = function () {
		var fd = new FormData();
		
		if ($scope.Post.Id == 0) {
			alert("请先保存博文生成ID");
			return
		}
		
		if ($scope.SelectFile == "") {
			alert("请先选择文件");
			return;
		}
		
		var path = $scope.SelectFile.replace(/\\/g, '/');
		name = path.substring(path.lastIndexOf("/")+1, path.length)
		
		fd.append('file', $scope.RealFile);
		fd.append('PostId', $scope.Post.Id);
		fd.append('Name', name);

		$http.post("/api/resource", fd, {
			transformRequest: angular.identity,
			headers: {'Content-Type': undefined}
		}).success(
			function(response, status, headers, config) {
				if (response.Code == 0) {
					if ($scope.Post.Resource == null) {
						$scope.Post.Resource = [];
					}
					$scope.Post.Resource.push(response.One);
					$scope.UploadAlert.show = true;
					$scope.UploadAlert.type = 'success';
					$scope.UploadAlert.msg = "上传成功";
				}
				else {
					$scope.UploadAlert.show = true;
					$scope.UploadAlert.type = 'danger';
					$scope.UploadAlert.msg = response.Message;
				}
			}
		).error(
			function(response, status, headers, config) {
				$scope.UploadAlert.show = true;
				$scope.UploadAlert.type = 'danger';
				$scope.UploadAlert.msg = "服务器错误：" + status;
			}
		);
	}
	$scope.Publish = function () {
		if ($scope.Post.Id == 0) {
			targetUrl = '/api/posts';
			targetMethod = 'POST';
		}
		else {
			targetUrl = '/api/posts/' + $scope.Post.Id;
			targetMethod = 'PUT';
		}
		$http({
			method : targetMethod,
			url : targetUrl,
			data : $scope.Post
		}).success(
			function(response, status, headers, config) {
				if (response.Code == 0) {
					$scope.Post = response.One;

					$scope.Alert.show = true;
					$scope.Alert.type = 'success';
					$scope.Alert.msg = "保存成功";
					
					$scope.Req.Desc = "编辑";
				}
				else {
					$scope.Alert.show = true;
					$scope.Alert.type = 'danger';
					$scope.Alert.msg = response.Message;
				}
			}
		).error(
			function(response, status, headers, config) {
				$scope.Alert.show = true;
				$scope.Alert.type = 'danger';
				$scope.Alert.msg = "服务器错误：" + status;
			}
		);
	};
	
	$scope.SelectCategory = function (index) {
		$scope.Post.Category = $scope.Categories[index]
	}
	$scope.SelectTag = function (index) {
		$scope.Post.Tag = $scope.Tags[index]
	}
	$scope.SelectPubAction = function (index) {
		$scope.Post.Status = $scope.PubActions[index]
	}
	
	$scope.CloseAlert = function(bUpload, index) {
		if (bUpload) {
			$scope.UploadAlert.show = false;
		}
		else {
			$scope.Alert.show = false;
		}
	};

	
	$scope.FetchCategoryList = function () {
		$http({
			method: 'GET',
			url: '/api/categories',
		}).success(
			function(response, status, headers, config) {
				if (response.Code == 0) {
					$scope.Categories = response.List;
					if ($scope.Post.Id == 0 && $scope.Categories.length > 0) {
						$scope.Post.Category = $scope.Categories[0];
					}
				}
				else {
					$scope.Alert.show = true;
					$scope.Alert.type = 'danger';
					$scope.Alert.msg = response.Message;
				}
			}
		).error(
			function(response, status, headers, config) {
				$scope.Alert.show = true;
				$scope.Alert.type = 'danger';
				$scope.Alert.msg = req_uri + "服务器错误：" + status;
			}
		);
	}
	$scope.FetchTagList = function () {
		$http({
			method: 'GET',
			url: '/api/tags',
		}).success(
			function(response, status, headers, config) {
				if (response.Code == 0) {
					$scope.Tags = response.List;
					if ($scope.Post.Id == 0 && $scope.Tags.length > 0) {
						$scope.Post.Tag = $scope.Tags[0];
					}
				}
				else {
					$scope.Alert.show = true;
					$scope.Alert.type = 'danger';
					$scope.Alert.msg = response.Message;
				}
			}
		).error(
			function(response, status, headers, config) {
				$scope.Alert.show = true;
				$scope.Alert.type = 'danger';
				$scope.Alert.msg = req_uri + "服务器错误：" + status;
			}
		);
	}
	
	$scope.FetchCategoryList();
	$scope.FetchTagList();
	
	// get post
	if ($scope.Post.Id == 0) {
		return
	}
	
	$http({
		method:'GET',
		url:'/api/posts/' + $scope.Post.Id,
	}).success(
		function(response, status, headers, config) {
			if (response.Code == 0) {
				$scope.Post = response.One;
			}
			else {
				$scope.Alert.show = true;
				$scope.Alert.type = 'danger';
				$scope.Alert.msg = response.Message;
			}
		}
	).error(
		function(response, status, headers, config) {
			$scope.Alert.show = true;
			$scope.Alert.type = 'danger';
			$scope.Alert.msg = req_uri + "服务器错误：" + status;
		}
	);
};

var ShortListCtrl = function ($scope, $http, req) {
	$scope.List = [];
	$scope.One = new Object();
	$scope.One.Id = req.Id;
	
	$scope.Alert = new Object();
	$scope.Alert.show = false;
	
	$scope.Req = req;

	$scope.GetList = function () {
		$http({
			method: 'GET',
			url: req.URI,
		}).success(
			function(response, status, headers, config) {
				if (response.Code == 0) {
					$scope.List = response.List;
					for (var i = 0; i < $scope.List.length; i++) {
						if ($scope.List[i].Id == $scope.One.Id) {
							$scope.One = $scope.List[i];
						}
					}
				}
				else {
					$scope.Alert.show = true;
					$scope.Alert.type = 'danger';
					$scope.Alert.msg = response.Message;
				}
			}
		).error(
			function(response, status, headers, config) {
				$scope.Alert.show = true;
				$scope.Alert.type = 'danger';
				$scope.Alert.msg = "服务器错误：" + status;
			}
		)
	}
	$scope.SaveElement = function () {
		curMethod = "PUT";
		curMessage = "保存成功"
		if ($scope.One.Id == 0) {
			curMethod = "POST";
			curMessage = "创建成功"
		}
		
		$http({
			method: curMethod,
			url: req.URI,
			params: $scope.One
		}).success(
			function(response, status, headers, config) {
				if (response.Code == 0) {
					$scope.One = response.One;
					$scope.Alert.show = true;
					$scope.Alert.type = 'success';
					$scope.Alert.msg = curMessage;
				}
				else{
					$scope.Alert.show = true;
					$scope.Alert.type = 'danger';
					$scope.Alert.msg = response.Message;
				}
			}
		).error(
			function(response, status, headers, config) {
				$scope.Alert.show = true;
				$scope.Alert.type = 'danger';
				$scope.Alert.msg = "服务器错误：" + status;
			}
		)
	};
	$scope.CloseAlert = function(index) {
		$scope.Alert.show = false;
	};
	
	$scope.GetList()
};

var MainCtrl = function($scope) {
	
}
