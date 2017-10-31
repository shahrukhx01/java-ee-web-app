<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:import url="header.jsp">
	<c:param name="title" value="Login/SignUp"></c:param>
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
				<c:when test="${not empty signup && empty success }">


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
			<h1 class="text-center">Login</h1>
			<form class="form"
				action="${pageContext.request.contextPath }/loginServlet"
				method="post">
				<div class="section">
					<input type="email" class="input-block-level" placeholder="email"
						name="email"> <input type="password"
						class="input-block-level" placeholder="Password" name="password">
				</div>
				<h5>
					<a href="#" id="signup" class="pull-left login_links">Create
						Account</a><a href="#" class="pull-right login_links">Forgot
						Password</a>
				</h5>
				<button class="btn btn-lg btn-primary btn-block" type="submit">Login</button>
			</form>
			<!-- end sign in form-->
		</div>

		<div class="text container hiden hidden_container"
			id="signup_container">
			<h1 class="text-center">Create Account</h1>
			<form class="form" id="registerform"
				action="${pageContext.request.contextPath }/RegisterUser"
				method="post">
				<div class="section">
					<div class="form-group has-success has-feedback">
						<input id="registerfname" type="text" value="${fname }"
							class="input-block-level" placeholder="Enter first name"
							name="fname" required>
					</div>
					<div class="form-group has-success has-feedback">
						<input id="registerlname" type="text" value="${lname }"
							class="input-block-level" placeholder="Enter last name"
							name="lname" required>
					</div>
					<div class="form-group has-success has-feedback">

						<input id="registercnic" type="number" value="${cnic }"
							class="input-block-level" placeholder="Enter CNIC number"
							name="cnic" required>
					</div>
					<div class="form-group has-success has-feedback">

						<input id="registermob" type="number" value="${mobile }"
							class="input-block-level" placeholder="Enter mobile number"
							name="mobile" required>
					</div>
					<div class="form-group has-success has-feedback">

						<input id="registeraddr" type="text" value="${address }"
							class="input-block-level" placeholder="Enter present address"
							name="address" required>
					</div>
					<div class="form-group has-success has-feedback">

						<input type="email" id="registeremail" value="${email }"
							class="input-block-level" placeholder="Enter email" name="email"
							required>
					</div>
					<div class="form-group has-success has-feedback">

						<input type="password" id="registerpass" class="input-block-level"
							placeholder="Enter password" name="password" required>
					</div>
					<div class="form-group has-success has-feedback">

						<input type="password" id="registerpassrepeat"
							class="input-block-level" placeholder="Retype password"
							name="passwordRepeat" required>
					</div>
					<div class="form-group has-success has-feedback">

						<input type="hidden" class="input-block-level"
							placeholder="Password" name="action">
					</div>
				</div>
				<h5>
					<a class="pull-right login_links" id="login" href="#">Sign in</a>
				</h5>
				<br />
				<button class="btn btn-lg btn-primary btn-block" id="registerbtn"
					type="button">Create Account</button>
			</form>
			<!-- end sign in form-->
		</div>
	</div>
</body>
</html>
<c:if test="${not empty signup }">
	<script>
		showSignup();
	</script>
</c:if>