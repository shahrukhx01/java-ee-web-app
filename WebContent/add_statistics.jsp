<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<sql:setDataSource var="ds" dataSource="jdbc/e_crime" />
<c:if test="${empty admin }">
	<c:redirect url="/admin_login.jsp"></c:redirect>
</c:if>

<c:import url="header.jsp"></c:import>
<c:import url="admin_header.jsp"></c:import>
<c:set var="date" value=""></c:set>
<c:set var="homocide" value=""></c:set>
<c:set var="rape" value=""></c:set>
<c:set var="robbery" value=""></c:set>
<c:set var="theft" value=""></c:set>
<c:set var="assault" value=""></c:set>


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
								<h4 class="list-group-item-heading">Criminal Statistics</h4>
								<p class="list-group-item-text">Criminal Statistics
									information</p>
						</a></li>
						<li class="disabled"><a href="#step-2">
								<h4 class="list-group-item-heading">Finish</h4>
								<p class="list-group-item-text">Complete Process</p>
						</a></li>
					</ul>
				</div>
			</div>
			<div class="container form_container">

				<h1 class="text-center heading1">Add Criminal Statistics</h1>
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
						action="${pageContext.request.contextPath}/AddStatistics"
						method="post" role="form">

						<div class="row setup-content" id="step-1">

							<div class="col-lg-8 col-lg-offset-2">
								<p>Please enter following details.</p>


								<div class="form-white">
									<div class="form-group">
										<label for="date">Month & Year</label> <input type="month"
											class="form-control  has-feedback" name="date"
											value="${date }" id="date" required>
									</div>
									<div class="form-group">
										<label for="homocide">Homocide</label> <input type="text"
											class="form-control  has-feedback" name="homocide"
											value="${homocide }" id="homocide"
											placeholder="Enter number of homocides" required>
									</div>

									<div class="form-group">
										<label for="rape">Rape</label> <input type="number"
											class="form-control  has-feedback" name="rape"
											value="${rape }" id="rape"
											placeholder="Enter number of rapes" required>
									</div>
									<div class="form-group">
										<label for="robbery">Robbery</label> <input type="number"
											class="form-control  has-feedback" name="robbery"
											value="${robbery }" id="robbery"
											placeholder="Enter number of robberies" required>
									</div>
									<div class="form-group">
										<label for="theft">Theft</label> <input type="number"
											class="form-control  has-feedback" name="theft"
											value="${theft }" id="theft"
											placeholder="Enter number of thefts" required>
									</div>

									<div class="form-group">
										<label for="assault">Assault</label> <input type="number"
											class="form-control  has-feedback" name="assault"
											value="${assault }" id="assault"
											placeholder="Enter number of assaults" required>
									</div>
									<button id="act-step-2" type="button"
										class="btn  btn-block btn-primary ">Next Step</button>
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
</script>

