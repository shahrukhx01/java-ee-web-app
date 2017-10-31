<head>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/admin_styles.css"
	type="text/css" />

</head>
<ul class="nav nav-stacked" id="sidebar">
	<li class="nav-header"><a class="list-group-item active" href="#"
		data-toggle="collapse" data-target="#userMenu">Settings <i
			class="glyphicon glyphicon-chevron-down"></i></a>
		<ul class="nav nav-stacked collapse in" id="userMenu">
			<li id="home"><a
				href="${pageContext.request.contextPath}/Police_Controller?action=home"><i
					class="glyphicon glyphicon-home"></i> Home</a></li>
			<li id="pending"><a
				href="${pageContext.request.contextPath}/Police_Controller?action=pending"><i
					class="glyphicon glyphicon-pause"></i> Pending Cases</a></li>
			<li id="closed"><a
				href="${pageContext.request.contextPath}/Police_Controller?action=closed"><i
					class="glyphicon glyphicon-remove"></i> Closed Cases</a></li>
			<li id="current"><a
				href="${pageContext.request.contextPath}/Police_Controller?action=current"><i
					class="glyphicon glyphicon-book"></i> Current Cases</a></li>
			<li><form action="${pageContext.request.contextPath}/Logout"
					method="post">
					<i style="margin-left: 15px;" class="glyphicon glyphicon-off"></i>

					<input style="background-color: rgba(0, 0, 0, 0); border: none;"
						type="submit" value="Logout">
				</form></li>
		</ul></li>
</ul>
