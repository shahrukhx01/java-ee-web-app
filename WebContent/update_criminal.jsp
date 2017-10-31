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
	sql="select * from most_wanted where criminal_id=?" var="results">
	<sql:param value="${param.id }"></sql:param>
</sql:query>


<c:import url="header.jsp"></c:import>
<c:import url="admin_header.jsp"></c:import>
<c:set var="fname" value="${ results.rows[0].criminal_fname}"></c:set>
<c:set var="lname" value="${ results.rows[0].criminal_last_name}"></c:set>
<c:set var="sex" value="${ results.rows[0].criminal_sex}"></c:set>
<c:set var="age" value="${ results.rows[0].criminal_age}"></c:set>
<c:set var="feet" value="${ fn:substring(results.rows[0].criminal_height,0,1)}"></c:set>
<c:set var="inches" value="${fn:trim( fn:substring(results.rows[0].criminal_height,5,7))}"></c:set>
<c:set var="address" value="${ results.rows[0].criminal_last_address}"></c:set>
<c:set var="arrested" value="${ results.rows[0].criminal_status}"></c:set>
<c:set var="bounty" value="${ results.rows[0].criminal_bounty}"></c:set>
<c:set var="descrp" value="${ results.rows[0].criminal_description}"></c:set>
<c:set var="rating" value="${ results.rows[0].criminal_rating}"></c:set>
<!-- Main -->
<div class="container">
	<div class="row">
				<div class="col-sm-10 col-lg-offset-1 ">
			<c:import url="admin_nav.jsp"></c:import>
			<div class="row">
				<!-- center left-->
				<hr>
				<div class="col-xs-10 col-xs-offset-1 step_head">
					<ul class="nav nav-pills nav-justified thumbnail setup-panel">
						<li class="active"><a href="#step-1">
								<h4 class="list-group-item-heading">Personal Information</h4>
								<p class="list-group-item-text">Criminal's Personal
									information</p>
						</a></li>
						<li ><a href="#step-2">
								<h4 class="list-group-item-heading">Criminal Information</h4>
								<p class="list-group-item-text">All criminal information</p>
						</a></li>
						<li ><a href="#step-3">
								<h4 class="list-group-item-heading">Finish</h4>
								<p class="list-group-item-text">Complete process</p>
						</a></li>
					</ul>
				</div>
			</div>
			<div class="container form_container">

				<h1 class="text-center heading1">Update Criminal</h1>
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
						action="${pageContext.request.contextPath}/UpdateCriminals"
						method="post" role="form">

						<div class="row setup-content" id="step-1">

							<div class="col-lg-8 col-lg-offset-2">
								<p>Please update following details.</p>


								<div class="form-white">
									<div class="form-group">
										<label for="fname">First Name</label> <input type="text"
											class="form-control  has-feedback" name="fname"
											value="${fname }" id="fname"
											placeholder="Enter criminal's firstname" required>
									</div>
									<div class="form-group">
										<label for="lname">Last Name</label> <input type="text"
											class="form-control  has-feedback" name="lname"
											value="${lname }" id="lname"
											placeholder="Enter criminal's lastname" required>
									</div>
									<div class="form-group">
										<label for="sex">Sex</label>
										<div class="radio">
										<c:if test="${sex=='male' }">
											<label><input type="radio" name="sex" value="male" checked="checked"
												id="sex">Male</label>&nbsp;&nbsp;&nbsp;&nbsp; <label><input 
												type="radio" name="sex" value="no" id="sex">Female</label>
												
												</c:if>
												<c:if test="${sex=='female' }">
												
											<label><input type="radio" name="sex" value="male" 
												id="sex">Male</label>&nbsp;&nbsp;&nbsp;&nbsp;
												<label><input checked="checked"
												type="radio" name="sex" value="no" id="sex">Female</label>
									</c:if>
										</div>
									
									</div>
									<div class="form-group">
										<label for="age">Age</label> <input type="number"
											class="form-control  has-feedback" name="age" value="${age }"
											id="age" placeholder="Enter criminal's age" required>
									</div>

									<div class="form-group">
										<label for="feet">Height</label> <input type="number"
											class="form-control  has-feedback" name="feet"
											value="${feet }" id="feet"
											placeholder="Enter criminal's height feet, i.e 5" required>
										<br> <input type="number"
											class="form-control  has-feedback" name="inches"
											value="${inches }" id="inches"
											placeholder="Enter criminal's height inches i.e 11" required>
									</div>

									<div class="form-group">
										<label for="address">Last Address</label>
										<textarea class="form-control" name="address" id="address"
											placeholder="Enter criminal's last address" required>${address}</textarea>
									</div>
									
								</div>

							</div>
						</div>
						<div class="row setup-content" id="step-2">



							<div class="row">
								<!--Sign in form-->


								<div class="col-lg-8 col-lg-offset-2">
									<p>Please update following details.</p>


									<div class="form-white">
										<div class="form-group">
											<label for="fname">Times Arrrested</label> <input
												type="number" class="form-control  has-feedback"
												name="arrested" value="${arrested }" id="arrested"
												placeholder="Enter the times criminal has been arrested"
												required>
										</div>

										<div class="form-group">
											<label for="sex">Bounty</label> <input type="text"
												class="form-control  has-feedback" name="bounty"
												value="${bounty }" id="bounty"
												placeholder="Enter criminal's bounty" required>
										</div>
										<div class="form-group">
											<input type="hidden"
												class="form-control  has-feedback" name="id"
												value="${param.id }" id="id"
												placeholder="Enter criminal's bounty" required>
										</div>
										
										<div class="form-group ">
											<label for="rating">Criminal Rating</label> <select
												class="form-control" name="rating" id="rating" required>

												<option value="">Please Select</option>
												<c:set var="count" value="1"></c:set>
												<c:forEach begin="1" end="9">
												<c:choose>
												<c:when test="${count== rating }">
												<option selected="selected" value="${count }">${count }</option>
												</c:when>
												<c:when test="${count!= rating }">
												<option value="${count }">${count }</option>
												</c:when>
												</c:choose>
												<c:set var="count" value="${count +0.5}"></c:set>
												
												</c:forEach>
											</select>

										</div>
										<div class="form-group">
											<label for="descrp">Criminal Description</label>
											<textarea class="form-control" name="descrp" id="descrp"
												placeholder="Enter criminal's description" required>${descrp}</textarea>
										</div>
										

									</div>

								</div>
							</div>
							<!--end row-->

						</div>
						<div class="row setup-content" id="step-3">
							<div class="col-xs-12">
								<div class="col-md-12 well text-center">

									<button id="add_crimi" class="btn btn-primary btn-lg">
										<h4>Finish</h4>
									</button>
								</div>
							</div>
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
	$('.well').css('margin-left', '52px');
	$('#upcrim').css('background-color', '#fb2');
	$('.btn-primary').css('height', '50px');
	$('.btn-primary').css('width', '150px');
	$('.form_container').css('width', '860px');
	$('.form-white').css('-webkit-box-shadow', '0 1px 4px rgba(0, 0, 0, 0.60)');
	$('.form_container').css('background', '#fff');
	$('.form_container').css('margin-top', '10px');
	$('.form-white').css('background', '#ddd');
	$('.form-white').css('border-radius', '12px');
</script>

