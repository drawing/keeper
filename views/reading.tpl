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

<title>{%.Post.Title%}</title>
</head>

<style type="text/css">
.markdown img {
	width: 500px;
}
.markdown {
	font-size: 16px;
	color: #220;
}
.markdown table {
	width: 90%;
	margin:20px;
	background-color: #D9EDF7;
}
.markdown td, .markdown th {
	text-align:center;
	border: 1px solid #0184b7;
	padding: 5px;
}
.markdown nav {
	margin: 40px 0;
}
.markdown nav a {
	text-decoration: none;
	font-size: 17px;
}
.markdown h2 {
	border-bottom: 1px solid #0184b7;
	color: #0184b7;
	font-size: 18px;
	margin: 20px auto;
	padding: 2px;
	text-shadow: 1px 1px 1px #808088;
}
.markdown h1 {
	background: none repeat scroll 0 0 #0184b7;
	border-radius: 5px;
	box-shadow: 3px 3px 5px #333344;
	clear: both;
	color: #FFF;
	font-size: 18px;
	line-height: 1.3em;
	margin: 20px auto;
	padding: 4px;
	text-shadow: 2px 2px 2px #000;
}
.markdown li {
	color: #555;
}
.markdown h3 {
	font-size: 17px;
}
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

</style>

<body>

<div class="container">
	<div class="page-header">
		<h1><a href="/category/{%.Post.Category.Slug%}.html" title="{%.SiteTitle%} - {%.Post.Category.Name%}">{%.SiteTitle%}</a><br><small class="col-md-offset-2">{%.SiteDesc%}</small></h1>
	</div>
	<div class="row">
		<div class="col-sm-8">
			<div class="entry col-sm-12">
				<h1 class="text-center">{%.Post.Title%}</h1>
				<p class="text-success text-center">{%dateformat .Post.CreateDate "2006-01-02 15:04:05"%}</p>
				<p class="text-success text-right"><a href="/tag/{%.Post.Tag.Slug%}.html">{%.Post.Tag.Name%}</a></p>
				<hr>
				<p>
				<div class="markdown">
					{% .Post.Content | markdown %}
				</div>
				</p>
				<div class="discuss_container">
					<div id="disqus_thread"></div>
				</div>
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

<script type="text/javascript">
	var disqus_shortname = 'fancymore';
	(function() {
 		var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
 		dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
 		(document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
 	})();
</script>
</body>
</html>

