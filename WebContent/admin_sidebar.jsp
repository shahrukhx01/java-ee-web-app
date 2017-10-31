<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
				href="${pageContext.request.contextPath}/Admin_controller?action=home"><i
					class="glyphicon glyphicon-home"></i> Home</a></li>
			<li><a data-toggle="modal" href="#myModal"><i
					class="glyphicon glyphicon-envelope"></i> Messages <span
					class="badge badge-info">4</span></a></li>
			<li id="addcrim"><a
				href="${pageContext.request.contextPath}/Admin_controller?action=addCriminal"><i
					class="glyphicon glyphicon-user"></i> Add Criminal</a></li>
			<li id="upcrim"><a
				href="${pageContext.request.contextPath}/Admin_controller?action=updateCriminal"><i
					class="glyphicon glyphicon-pencil"></i> Update Criminal</a></li>
			<li id="delcrim"><a
				href="${pageContext.request.contextPath}/Admin_controller?action=deleteCriminal"><i
					class="glyphicon glyphicon-remove"></i> Delete Criminal</a></li>

			<li id="addmiss"><a
				href="${pageContext.request.contextPath}/Admin_controller?action=addMissing"><i
					class="glyphicon glyphicon-question-sign"></i> Add Missing Person</a></li>
			<li id="upmiss"><a
				href="${pageContext.request.contextPath}/Admin_controller?action=updateMissing"><i
					class="glyphicon glyphicon-pencil"></i> Update Missing Person</a></li>
			<li id="delmiss"><a
				href="${pageContext.request.contextPath}/Admin_controller?action=deleteMissing"><i
					class="glyphicon glyphicon-remove"></i> Delete Missing Person</a></li>
			<li><form action="${pageContext.request.contextPath}/Logout" method="post"><i style="margin-left:15px;" class="glyphicon glyphicon-off"></i>
					
							<input style="background-color: rgba(0,0,0,0); border: none; " type="submit" value="Logout">
						</form></li>
		</ul></li>
</ul>
