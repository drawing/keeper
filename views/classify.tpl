<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
var _gaq = _gaq || [];
_gaq.push(['_setAccount', 'UA-33458688-1']);
_gaq.push(['_trackPageview']);
(function() {
 var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
 ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
 var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
 })();
</script>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

<link rel="stylesheet" href="/static/css/bootstrap.css">
<title>{%.SiteTitle%}</title>

<style type="text/css">
.entry {
	background: none repeat scroll 0 0 #FFFFFF;
	box-shadow: 0 2px 6px #CCCCCC;
	float: left;
	margin-bottom: 60px;
	padding: 30px;
}
.side {
	background: none repeat scroll 0 0 #FFFFFF;
	box-shadow: 0 2px 6px #CCCCCC;
	float: left;
	margin-bottom: 60px;
	padding: 15px;
}
.item {
	padding: 15px;
}
.item img {
	width: 350px;
}
.title {
	font-size: 18px;
	margin: 15px 5px;
}
.date {
	font-size: 16px;
}
.summary {
	margin: 8px;
}
.summary p, .summary h1, .summary h2, .summary h3, .summary h4 {
	font-size: 16px;
	color: #331;
}
</style>

</head>

<body>
<div class="container">
	<div class="page-header">
		<h1><a href="/">{%.SiteTitle%}</a><br><small class="col-md-offset-2">{%.SiteDesc%}</small></h1>
	</div>
	<div class="row">
		<div class="col-sm-8">
			<div class="entry col-sm-12">
				<blockquote>
				<center><h2> {%.Classify.Name%} </h2> </center>
				<p>{%.Classify.Desc | markdown %}</p>
				</blockquote>
				<div class="item">
					{%range .Posts%}
					<hr>
					<div class="title">
						<b><a href="/reading/{%.Slug%}.html">{%.Title%}</a></b>
						<div class="date pull-right">{%dateformat .CreateDate "2006-01-02 15:04:05"%}</div>
					</div>
					<div class="summary">
						{% $status := compare .Status "Friend" %}
						{% $forbid := and $status $.ForbidFriend %}
						{% if not $forbid %}
							<p>{% .Content | brief %}</p>
							<!-- span class="badge">ReadMore</span -->
							<a class="pull-right" href="/reading/{%.Slug%}.html"> Continue Reading </a><br>
						{% else %}
							<p>
							此文章需要密码访问，
							如得知密码，请<a href="/reading/{%.Slug%}.html">点击进入</a>输入密码！
							</p>
						{% end %}
					</div>
					{%end%}
				</div>
				<ul class="pager">
					{% if .Previous %}<li><a href="{% .Previous %}">Previous</a></li> {% end %}
					{% if .Next %}<li><a href="{% .Next %}">Next</a></li> {% end %}
				</ul>
			</div>
		</div>
		<div class="col-sm-4">
			<div class="side col-sm-12">
				<iframe width="100%" height="230" class="share_self"  frameborder="0" scrolling="no" src="http://widget.weibo.com/weiboshow/index.php?language=&width=0&height=550&fansRow=1&ptype=1&speed=0&skin=1&isTitle=1&noborder=0&isWeibo=0&isFans=1&uid=1581752253&verifier=014c719a&dpc=1"></iframe>
			</div>
			<div class="side col-sm-12">
				<table class="table">
					<thead><tr><th>Tags:</td></tr></thead>
					<tbody>
					{%range .Tags%}
					<tr><th><a href="/tag/{%.Slug%}.html">{%.Name%}</a></th></tr>
					{%end%}
					</tbody>
				</table>
			</div>
			<div class="side col-sm-12">
				<table class="table">
					<thead><tr><th>分类:</td></tr></thead>
					<tbody>
					{%range .Categories%}
					<tr><th><a href="/category/{%.Slug%}.html">{%.Name%}</a></th></tr>
					{%end%}
					</tbody>
				</table>
			</div>
		</div>
	</div>

</div>
</body>
</html>

