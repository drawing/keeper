<div class="panel panel-default">
	<div class="panel-heading">
		<h3 class="panel-title"> {{Req.Desc}} : {{Post.Title}} </h3>
	</div>
	<div class="panel-body form-horizontal">
		<alert ng-if="Alert.show" type="Alert.type" close="CloseAlert(false, $index)">{{Alert.msg}}</alert>
		
		<form class="col-sm-12" name="ContentForm">
			<input type="text" class="form-control" placeholder="Title" ng-model="Post.Title" ng-change="CloseAlert()">
			<hr>
			<textarea ui-codemirror ui-codemirror-opts="EditorOptions" ng-model="Post.Content" ng-change="CloseAlert()"></textarea>
		</form>

		<div class="col-sm-6">
			<form class="form-horizontal" role="form" name="CategoryForm">
				<div class="form-group">
						<label class="control-label col-sm-4">Custom URL:</label>
						<div class="col-sm-8">
							<input type="text" class="form-control" placeholder="Custom URL" ng-model="Post.Slug" ng-change="CloseAlert()">
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
