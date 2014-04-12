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
</head>

<body>
<div class="container">
	<div class="page-header">
		<h1>{%.SiteTitle%}<br><small class="col-md-offset-2">{%.SiteDesc%}</small></h1>
	</div>
	<div class="row">
		{%range .Categories%}
		<div class="col-sm-6 col-md-4">
			<div class="thumbnail">
				<img height="300" src="http://www.blender.org/wp-content/uploads/2012/11/rendering.jpg" alt="...">
				<div class="caption">
					<h3>{%.Name%}</h3>
					<p>{%.Desc | markdown%}</p>
					<p><a href="/category/{% .Slug %}.html" class="btn btn-primary" role="button">View</a></a></p>
				</div>
			</div>
		</div>
		{%end%}
	</div>

</div>
</body>
</html>

