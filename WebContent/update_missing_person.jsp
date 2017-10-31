<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<sql:setDataSource var="ds" dataSource="jdbc/e_crime" />
<c:if test="${empty admin }">
	<c:redirect url="/admin_login.jsp"></c:redirect>
</c:if>

<c:if test="${empty param.id }">
	<c:redirect url="/admin_home.jsp"></c:redirect>
</c:if>
<sql:query dataSource="${ds}"
	sql="select * from missing_person  where missing_person_id=?"
	var="results">
	<sql:param value="${param.id }"></sql:param>
</sql:query>

<c:import url="header.jsp"></c:import>
<c:import url="admin_header.jsp"></c:import>
<c:set var="fname" value="${ results.rows[0].first_name}"></c:set>
<c:set var="lname" value="${ results.rows[0].last_name}"></c:set>
<c:set var="sex" value="${ results.rows[0].sex}"></c:set>
<c:set var="age" value="${ results.rows[0].age}"></c:set>
<c:set var="address" value="${ results.rows[0].address}"></c:set>
<c:set var="psyco" value="${ results.rows[0].psycological_status}"></c:set>
<c:set var="last_seen" value="${ results.rows[0].last_seen}"></c:set>
<c:set var="marital" value="${ results.rows[0].marital_status}"></c:set>


<!-- Main -->
<div class="container">
	<div class="row">
		<div class="col-lg-10 col-lg-offset-1">
			<c:import url="admin_nav.jsp"></c:import>
			<div class="row">
				<!-- center left-->
				<hr>
				<div class="col-xs-10 col-xs-offset-1 step_head">
					<ul class="nav nav-pills nav-justified thumbnail setup-panel">
						<li class="active"><a href="#step-1">
								<h4 class="list-group-item-heading">Missing Person</h4>
								<p class="list-group-item-text">Missing Person's Personal
									information</p>
						</a></li>
						<li><a href="#step-2">
								<h4 class="list-group-item-heading">Finish</h4>
								<p class="list-group-item-text">Complete Process</p>
						</a></li>
					</ul>
				</div>
			</div>
			<div class="container form_container">

				<h1 class="text-center heading1">Update Missing Person</h1>
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

					<form id="add_criminals"
						action="${pageContext.request.contextPath}/UpdateMissingPerson"
						method="post" role="form">

						<div class="row setup-content" id="step-1">

							<div class="col-lg-8 col-lg-offset-2">
								<p>Please enter following details.</p>


								<div class="form-white">
									<div class="form-group">
										<label for="fname">First Name</label> <input type="text"
											class="form-control  has-feedback" name="fname"
											value="${fname }" id="fname"
											placeholder="Enter person's firstname" required>
									</div>
									<div class="form-group">
										<label for="lname">Last Name</label> <input type="text"
											class="form-control  has-feedback" name="lname"
											value="${lname }" id="lname"
											placeholder="Enter person's lastname" required>
									</div>
									<div class="form-group">
										<label for="psycho">Psychological Illness</label>
										<c:choose>
											<c:when test="${psyco=='yes'}">
												<div class="radio">
													<label><input type="radio" name="psycho" value=yes
														id="psycho" checked="checked">Yes</label>&nbsp;&nbsp;&nbsp;&nbsp;
													<label><input type="radio" name="psycho" value="no"
														id="psycho">No</label>
												</div>

											</c:when>
											<c:when test="${psyco=='no' }">
												<div class="radio">
													<label><input type="radio" name="psycho" value=yes
														id="psycho">Yes</label>&nbsp;&nbsp;&nbsp;&nbsp; <label><input
														type="radio" name="psycho" value="no" checked="checked"
														id="psycho">No</label>
												</div>

											</c:when>
										</c:choose>

									</div>

									<div class="form-group">
										<label for="age">Age</label> <input type="number"
											class="form-control  has-feedback" name="age" value="${age }"
											id="age" placeholder="Enter person's age" required>
									</div>
									<div class="form-group">
										<input type="hidden" name="id" value="${param.id }" id="id">
									</div>

									<div class="form-group">
										<label for="marital">Marital Status</label>
										<c:choose>
											<c:when test="${marital=='married' }">
												<div class="radio">
													<label><input type="radio" name="marital"
														value="married" checked="checked" id="marital">Married</label>&nbsp;&nbsp;&nbsp;&nbsp;
													<label><input type="radio" name="marital"
														value="single" id="marital">Single</label>
												</div>
											</c:when>
											<c:when test="${ marital=='single'}">
												<div class="radio">
													<label><input type="radio" name="marital"
														value="married" id="marital">Married</label>&nbsp;&nbsp;&nbsp;&nbsp;
													<label><input type="radio" name="marital"
														value="single" checked="checked" id="marital">Single</label>
												</div>
											</c:when>
										</c:choose>

									</div>

									<div class="form-group">
										<label for="age">Last Seen</label> <input type="date"
											class="form-control  has-feedback" name="last_seen"
											value="${last_seen }" id="last_seen"
											placeholder="Enter date person was last seen" required>
									</div>
									<div class="form-group">
										<label for="sex">Gender</label>
										<c:choose>
											<c:when test="${sex=='male' }">
												<div class="radio">
													<label><input type="radio" name="sex"
														checked="checked" value="male" id="sex">Male</label>&nbsp;&nbsp;&nbsp;&nbsp;
													<label><input type="radio" name="sex"
														value="female" id="sex">Female</label>
												</div>
											</c:when>
											<c:when test="${sex=='female' }">
												<div class="radio">
													<label><input type="radio" name="sex" value="male"
														id="sex">Male</label>&nbsp;&nbsp;&nbsp;&nbsp; <label><input
														type="radio" name="sex" checked="checked" value="female"
														id="sex">Female</label>
												</div>
											</c:when>
										</c:choose>


									</div>

									<div class="form-group">
										<label for="address">Address</label>
										<textarea class="form-control" name="address" id="address"
											placeholder="Enter person's address" required>${address}</textarea>
									</div>

								</div>

							</div>
						</div>
						<div class="row setup-content" id="step-2">



							<div class="row">
								<div class="col-xs-12">
									<div class="col-md-12 well text-center">

										<button id="add_crimi" class="btn btn-primary btn-lg">
											<h4>Finish</h4>
										</button>
									</div>
								</div>
							</div>
							<!--end row-->

						</div>
					</form>
				</div>
				<!--end row-->
			</div>
			<!--end container-->
		</div>
	</div>
	<!--/row-->
</div>




<script type="text/javascript">
	$('.well').css('width', '825px');
	$('.well').css('margin-left', '82px');
	$('#addmiss').css('background-color', '#fb2');
	$('.form_container').css('width', '860px');
	$('.form_container').css('background', '#fff');
	$('.form_container').css('margin-top', '10px');
	$('.form-white').css('background', '#ddd');
	$('.form-white').css('border-radius', '12px');
	$('.form-white').css('-webkit-box-shadow', '0 1px 4px rgba(0, 0, 0, 0.60)');
	$('.btn-primary').css('height', '50px');
	$('.btn-primary').css('width', '150px');
	$('#upmiss').css('background-color', '#fb2');
</script>

