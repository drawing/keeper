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
.main {
	color:#113;
	margin:50px;
}
.footer {
	margin:20px;
}
.entry {
	background: none repeat scroll 0 0 #FFFFFF;
	box-shadow: 0 2px 6px #CCCCCC;
	float: left;
	margin-bottom: 60px;
	padding: 30px;
}
</style>
</head>

<body>
<div class="container">
	<div class="page-header">
		<h1>{%.SiteTitle%}<br><small class="col-md-offset-2">{%.SiteDesc%}</small></h1>
	</div>
	<div class="row main">
		<div class="col-sm-8 col-sm-offset-2 entry">
			<p>{%.Post.Content | markdown%}</p>
		</div>
	</div>
	<hr>
	<div class="row footer">
		<div class="container">
			<div class="col-sm-8 col-sm-offset-2">
				<p>Copyright@2014 <a href="mailto:cppbreak@gmail.com">cppbreak</a></p>
			</div>
		</div>
	</div>

</div>
</body>
</html>

