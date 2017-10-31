<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:if test="${empty user }">
	<c:redirect url="/login_signUp.jsp"></c:redirect>
</c:if>
<c:import url="header.jsp">
	<c:param name="title" value="Contact Us"></c:param>
</c:import>
<c:import url="slider.jsp" />
<c:import url="process.jsp"></c:import>
<c:if test="${empty messageDetail || not empty success}">
	<c:set var="subject" value=""></c:set>
	<c:set var="con_message" value=""></c:set>
	</c:if>
<body>
<div id="content"></div>
	<div class="container form_container">

		<h1 class="text-center heading1">Send a Message</h1>
		<c:choose>
			<c:when test="${not empty error }">


				<div class="alert alert-danger fade in">
					<a href="#" class="close" data-dismiss="alert">&times;</a>
					<h4>${messageDetail }</h4>
				</div>
			</c:when>
			<c:when test="${not empty success }">
				<div class="alert alert-success fade in">
					<a href="#" class="close" data-dismiss="alert">&times;</a>
					<h4>${messageDetail }</h4>
				</div>

			</c:when>
		</c:choose>

		<br />

		<div class="row">
			<!--Sign in form-->

			<form id="cont_form"
				action="${pageContext.request.contextPath}/AdminMessages"
				method="post" role="form">

				<div class="col-lg-10 col-lg-offset-1">
					<h3>Message to Admin</h3>
					<p>Please enter following details.</p>


					<div class="form-white">
						<div class="form-group">
							<label for="fname">Subject</label> <input type="text"
								class="form-control  has-feedback" name="subject"
								value="${subject }" id="sub" placeholder="Enter message's subject"
								required>
						</div>
						<div class="form-group">
							<label for="message">Message</label>
							<textarea class="form-control" name="c_message" id="message"
								placeholder="Enter your message" required>${con_message}</textarea>
						</div>
						<button id="contact_btn" type="button"
							class="btn  btn-block btn-primary ">Send Message</button>

						<div class="form-avatar hidden-xs">
							<span class="fa-stack fa-4x"> <i
								class="fa fa-circle fa-stack-2x"></i> <i
								class="fa fa-user fa-stack-1x"></i>
							</span>
						</div>
					</div>

				</div>
			</form>
		</div>
		<!--end row-->
	</div>
	<!--end container-->
	<c:import url="footer.jsp"></c:import>
</body>
<script>
	$("body").css("background-color", "white");
	$(".form_container").css("width", "920px");
	$(".fa-stack-1x").css("top", "5px");
	$(".btn-block").css("width", "130px");
	
	
</script>