<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:import url="header.jsp">
	<c:param name="title" value="Admin Login"></c:param>
</c:import>
<c:if test="${empty messageDetail || not empty success}">
	<c:set var="message" value=""></c:set>
	<c:set var="cnic" value=""></c:set>
	<c:set var="fname" value=""></c:set>
	<c:set var="lname" value=""></c:set>
	<c:set var="mobile" value=""></c:set>
	<c:set var="address" value=""></c:set>
	<c:set var="email" value=""></c:set>
</c:if>
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
			<h1 class="text-center">Administrator Login</h1>
			<form class="form"
				action="${pageContext.request.contextPath }/AdminLogin"
				method="post">
				<div class="section">
					<input type="email" class="input-block-level" placeholder="email"
						name="email"> <input type="password"
						class="input-block-level" placeholder="Password" name="password">
				</div>
				
				<button class="btn btn-lg btn-primary btn-block" type="submit">Login</button>
			</form>
			<!-- end sign in form-->
		</div>

	</div>
</body>
</html>
