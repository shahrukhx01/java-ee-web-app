<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<sql:setDataSource var="ds" dataSource="jdbc/e_crime" />
<c:if test="${empty police }">
	<c:redirect url="/police_login.jsp"></c:redirect>
</c:if>

<c:import url="header.jsp"></c:import>
<c:import url="police_header.jsp"></c:import>
<c:set var="action" value="UpdateCaseProgress"></c:set>
<c:if test="${not empty sessionScope.insert }">
	<c:set var="action" value="AddCaseProgress"></c:set>
	<c:set var="tabs" value="disabled"></c:set>
	<c:remove var="witnesses" ></c:remove>
	<c:remove var="evidences" ></c:remove>
	<c:remove var="prgress" ></c:remove>
	<c:remove var="warrants"></c:remove>
	<c:remove var="arrests" ></c:remove>
	<c:remove var="law_sections" ></c:remove>
</c:if>
<!-- Main -->
<div class="container">
	<div class="row">
		<div class="col-sm-3">
			<!-- Left column -->
			<a href="#"><strong><i
					class="glyphicon glyphicon-wrench"></i> Tools</strong></a>

			<hr>

			<c:import url="police_sidebar.jsp"></c:import>
			<hr>

		</div>
		<!-- /col-3 -->
		<div class="col-sm-9 ">
			<c:import url="admin_nav.jsp"></c:import>
			<div class="row">
				<!-- center left-->
				<hr>
				<div class="col-xs-12 step_head">
					<ul class="nav nav-pills nav-justified thumbnail setup-panel">
						<li class="active"><a href="#step-1">
								<h4 class="list-group-item-heading">Case Progress</h4>
								<p class="list-group-item-text">Update Case Progress</p>
						</a></li>
						<li class="${tabs }"><a href="#step-2">
								<h4 class="list-group-item-heading">Finish</h4>
								<p class="list-group-item-text">Complete Process</p>
						</a></li>
					</ul>
				</div>
			</div>
			<div class="container form_container">

				<h1 class="text-center heading1">Update Case Progress</h1>
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
						action="${pageContext.request.contextPath}/${action}"
						method="post" role="form">

						<div class="row setup-content" id="step-1">

							<div class="col-lg-8 col-lg-offset-2">
								<p>Please enter following details.</p>


								<div class="form-white">

									<div class="form-group">
										<label for="witnesses">Number of witnesses
											interrogated</label> <input type="number"
											class="form-control  has-feedback" name="witnesses"
											value="${sessionScope.witnesses }" id="witnesses"
											placeholder="Enter number of witnesses interrogated" required>
									</div>
									<div class="form-group">
										<label for="evidences">Number of evidences</label> <input
											type="number" class="form-control  has-feedback"
											name="evidences" value="${sessionScope.evidences }"
											id="evidences"
											placeholder="Enter number of evidences interrogated" required>
									</div>
									<div class="form-group">
										<label for="progress">Percentage of progress</label> <input
											type="number" class="form-control  has-feedback"
											name="progress" value="${sessionScope.prgress }"
											id="progress" placeholder="Enter percentage of case progress"
											required>
									</div>
									<div class="form-group">
										<label for="warrants">Number of warrants</label> <input
											type="number" class="form-control  has-feedback"
											name="warrants" value="${sessionScope.warrants }"
											id="warrants" placeholder="Enter number of warrants issued"
											required>
									</div>
									<div class="form-group">
										<label for="arrests">Number of arrests made</label> <input
											type="number" class="form-control  has-feedback"
											name="arrests" value="${sessionScope.arrests }" id="arrests"
											placeholder="Enter number of arrests made" required>
									</div>
									<div class="form-group">
										<input type="hidden" value="${sessionScope.complaint_id }"
											name="complaint_id" required>
									</div>



									<div class="form-group">
										<label for="law_sections">Law Sections of current case</label>
										<textarea class="form-control" name="law_sections"
											id="law_sections" placeholder="Enter law sections" required>${sessionScope.law_sections}</textarea>
									</div>
									<c:if test="${not empty sessionScope.insert }">
										<button id="go-step-2" type="button"
											class="btn  btn-block btn-primary ">Next Step</button>
									</c:if>

								</div>

							</div>
						</div>
<c:if test="${not empty sessionScope.insert }">
	<c:remove var="insert"/>
</c:if>


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
	

	$('#go-step-2').on(
	'click',
	function(e) {
		
		if(!validateText('witnesses')){
			return false;
		}
		if(!validateText('evidences')){
			return false;
		}
		
		if(!validateText('progress')){
			return false;
		}
		if(!validateText('warrants')){
			return false;
		}
		if(!validateText('arrests')){
			return false;
		}
		if(!validateText('law_sections')){
			return false;
		}
		
		
		$('ul.setup-panel li:eq(1)').removeClass(
				'disabled');
		$('ul.setup-panel li a[href="#step-2"]')
				.trigger('click');
		$(this).remove();
	});

</script>

