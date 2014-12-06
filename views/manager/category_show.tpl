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
				<label class="col-sm-4 control-label">Desc:</label>
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
