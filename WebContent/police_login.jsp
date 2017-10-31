<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:import url="header.jsp">
	<c:param name="title" value="Police Login"></c:param>
</c:import>
<sql:setDataSource var="ds" dataSource="jdbc/e_crime" />
<body>
	<div class="parallax large-view" id="container">
		<div class="container">
			<div class="row" id="logo">
				<div class="col-lg-6">
					<a class="navbar-brand" href="#">E Crime File Management</a>
				</div>
			</div>
			<!-- end row-->
			<c:choose>
				<c:when test="${ not empty error }">


					<div class="alert alert-danger fade in">
						<a href="#" class="close" data-dismiss="alert">&times;</a>
						<h4>${messageDetail }</h4>
					</div>
				</c:when>
				<c:when test="${ empty email && not empty success }">
					<div class="alert alert-success fade in">
						<a href="#" class="close" data-dismiss="alert">&times;</a>
						<h4>${messageDetail }</h4>
					</div>

				</c:when>
			</c:choose>

		</div>
		<!--end container-->


		<div class="text container  visible" id="login_container">
			<h1 class="text-center">Police Officer Login</h1>
			<form class="form"
				action="${pageContext.request.contextPath }/PoliceLogin"
				method="post">
				<div class="section">
					<sql:query dataSource="${ds}" sql="select * from police_stations  "
						var="station_results" />

					<div class="form-group">
						<select class="form-control"
							style="background-color: rgba(255, 255, 255, 0.5); color: black; font-weight: bold;"
							name="station" id="station" required>
							<option value="" selected="selected">Please Select
								Police Station</option>

							<c:forEach var="station" items="${station_results.rows }">
								<option value="${station.police_station_id }">${station.station_name }</option>
							</c:forEach>
						</select>

					</div>
					<input type="password" class="input-block-level"
						placeholder="Password" name="password">
				</div>

				<button class="btn btn-lg btn-primary btn-block" type="submit">Login</button>
			</form>
			<!-- end sign in form-->
		</div>

	</div>
</body>
</html>


