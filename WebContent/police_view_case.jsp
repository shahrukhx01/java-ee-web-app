<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<sql:setDataSource var="ds" dataSource="jdbc/e_crime" />
<c:if test="${empty police }">
	<c:redirect url="/police_login.jsp"></c:redirect>
</c:if>

<c:import url="header.jsp"></c:import>
<c:import url="police_header.jsp"></c:import>
<%-- 
<c:if test="${empty police }">
	<c:redirect url="/police_login.jsp"></c:redirect>
</c:if>
--%>
<c:if test="${ empty param.id}">
	<jsp:forward page="/Police_Controller?action=home" />
</c:if>
<sql:setDataSource var="ds" dataSource="jdbc/e_crime" />
<sql:query dataSource="${ds}"
	sql="select * from complaints left outer join police_officer on complaints.jurisdiction_station=police_officer.station_id left outer join police_stations on police_officer.station_id=police_stations.police_station_id left outer join case_progress on complaints.complaint_id=case_progress.complaint_id where complaints.complaint_id=?"
	var="results">
	<sql:param value="${param.id }"></sql:param>
</sql:query>

<!-- Main -->
<div class="container">
	<div class="row">
		
		<br />

		<div class="col-lg-10 col-lg-offset-1">
			
			<c:import url="police_nav.jsp"></c:import>
			<hr>
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


			<div class="container" style="width: 925px;" id="criminals_container">
				<h1 class=" heading1">Crime Complaint</h1>

				<div class="row">
					<div class="col-lg-7">

						<h1>Incident Description</h1>
						<c:set var="crime_description" scope="page"
							value="${results.rows[0].incident_details}"></c:set>

						<c:forEach var="description" items="${crime_description }">
			
			${description}
			</c:forEach>

					</div>
					<!--  end column-->

					<div class="col-lg-5">
						<div class="col-lg-2">
							<a data-toggle="modal" href="#UpdStatus"><button
									type="button" class="btn   btn-primary ">Update
									Progress</button></a>
						</div>
						<div class="col-lg-2 col-lg-offset-1" style="margin-left: 100px">
							<a data-toggle="modal" href="#myModal1"><button type="button"
									class="btn   btn-primary ">Chat with complainee</button></a>
						</div>
						<br> <br>
						<%-- --%>
						<sql:query dataSource="${ds}"
							sql="select * from evidence_images where complaint_id=?   "
							var="img_results">
							<sql:param value="${param.id }"></sql:param>
						</sql:query>
						<c:choose>
							<c:when test="${empty img_results.rows}">
								<img class="img-rounded img-responsive BigImgBox" alt=""
									src="imgs/evidence_default.jpg" />
								<a href="imgs/evidence_default.jpg" data-lightbox="evidence"
									rel="lightbox" data-title="Case Evidence"> <img
									class="img-rounded img-responsive SmallImgBox"
									src="imgs/evidence_default.jpg" alt="" />
								</a>
							</c:when>
							<c:otherwise>
								<img class="img-rounded img-responsive BigImgBox" alt=""
									src="imgs/${img_results.rows[0].image_name }" />

								<div>
									<table class="mugshots">
										<tr>
											<c:forEach var="imgs" items="${img_results.rows }">
												<td><a href="imgs/${imgs.image_name}"
													data-lightbox="evidence" rel="lightbox"
													data-title="Evidence"><img
														class="img-rounded img-responsive SmallImgBox"
														src="imgs/${imgs.image_name}" alt="" /></a></td>
											</c:forEach>
										</tr>
									</table>
								</div>
							</c:otherwise>
						</c:choose>

						<hr>
						<c:set var="loc_lat" scope="session"
							value="${results.rows[0].loc_lat}"></c:set>
						<c:set var="loc_long" scope="session"
							value="${results.rows[0].loc_long}"></c:set>
						<h3>Incident Location</h3>
						<c:import url="incident_location.jsp"></c:import>
					</div>
				</div>
				<!-- end row-->

				<div class="row">
					<div class=" col-lg-4">
						<h1>Brief Details</h1>
						<table class="table">
							<tr class="active">
								<td>
									<h5>Incident Place</h5>
								</td>

								<td>
									<h5>${results.rows[0].incident_place}</h5>
								</td>

							</tr>
							<tr class="success">
								<td>
									<h5>Incident Time</h5>
								</td>
								<td>
									<h5>${results.rows[0].incident_time }</h5>
								</td>
							</tr>
							<tr class="info">
								<td>
									<h5>Incident date</h5>

								</td>

								<td>
									<h5>${results.rows[0].incident_date }</h5>
								</td>
							</tr>
							<tr class="warning">
								<td>
									<h5>Jurisdiction station</h5>
								</td>

								<td>
									<h5>${results.rows[0].station_name }</h5>
								</td>
							</tr>
							<tr class="success">
								<td>
									<h5>Case status</h5>
								</td>

								<td>
									<h5>${results.rows[0].comp_status }</h5>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
			<!-- end container-->
		</div>

	</div>
	<sql:query dataSource="${ds}"
		sql="select * from case_progress where complaint_id=?"
		var="cmp_results">
		<sql:param value="${param.id }"></sql:param>
	</sql:query>
	<c:set scope="session" var="complaint_id" value="${param.id}"></c:set>
	<c:choose>
		<c:when test="${ empty cmp_results.rows[0] }">
			<c:set scope="session" var="witnesses" value="N/A"></c:set>
			<c:set scope="session" var="evidences" value="N/A"></c:set>
			<c:set scope="session" var="prgress" value="0"></c:set>
			<c:set scope="session" var="warrants" value="N/A"></c:set>
			<c:set scope="session" var="arrests" value="N/A"></c:set>
			<c:set scope="session" var="law_sections" value="N/A"></c:set>
			<c:set scope="session" var="insert" value="insert"></c:set>


		</c:when>

		<c:otherwise>
			<c:set scope="session" var="witnesses"
				value="${results.rows[0].witnesses}"></c:set>
			<c:set scope="session" var="evidences"
				value="${results.rows[0].evidences}"></c:set>
			<c:set scope="session" var="prgress"
				value="${results.rows[0].prgress}"></c:set>
			<c:set scope="session" var="warrants"
				value="${results.rows[0].warrants}"></c:set>
			<c:set scope="session" var="arrests"
				value="${results.rows[0].arrests}"></c:set>
			<c:set scope="session" var="law_sections"
				value="${results.rows[0].law_sections}"></c:set>

		</c:otherwise>
	</c:choose>

	<div class="row">
		<div class="col-lg-10 col-lg-offset-1">
			<div class="container main_cont" style="width: 925px;"
				id="criminals_container">
				<h1 class=" heading1">Complaint Progress</h1>

				<div class="row">
					<div class="col-lg-9"></div>
					<!-- end column-->

					<div class="col-lg-3"></div>
				</div>
				<!-- end row-->

				<div class="row">
					<div class=" col-lg-8 col-lg-offset-2">
						<h1 class="text-center">Investigation Details</h1>
						<table class="table">
							<tr class="active">
								<td>
									<h5>Law Sections</h5>
								</td>

								<td>
									<h5>${law_sections}</h5>
								</td>

							</tr>
							<tr class="success">
								<td>
									<h5>Witnesses interrogated</h5>
								</td>
								<td>
									<h5>${witnesses }</h5>
								</td>
							</tr>
							<tr class="info">
								<td>
									<h5>Warrants Issued</h5>

								</td>

								<td>
									<h5>${warrants }</h5>
								</td>
							</tr>
							<tr class="warning">
								<td>
									<h5>Arrests made</h5>
								</td>

								<td>
									<h5>${arrests }</h5>
								</td>
							</tr>
							<tr class="danger">
								<td>
									<h5>Evidences Found</h5>
								</td>

								<td>
									<h5>${evidences }</h5>
								</td>
							</tr>
							<tr class="primary">
								<td colspan="2">
									<div class="progress " style="height: 27px;">
										<div
											class="progress-bar progress-bar-success progress-bar-striped"
											role="progressbar" aria-valuenow="${prgress}"
											aria-valuemin="0" aria-valuemax="100"
											style="width: ${prgress}% ; height :27px;">
											<h5 class="" style="margin-bottom: 5px;">${prgress}%
												Progress Made</h5>
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<td></td>
								<td><a href="Police_Controller?action=update_progress"><button
											type="button" class="btn  btn-block btn-primary ">Update
											Progress</button></a></td>
							</tr>
						</table>
					</div>
				</div>
			</div>
			<!-- end container-->
		</div>
	</div>
</div>
<!-- /Main -->


<style>
.form input, .form textarea {
	background: white;
	border-color: #ddd;
}
</style>
<script type="text/javascript">
	$('.main_cont').css('margin-top', '0px');
	$('.profile').css('min-height', '250px');
</script>
<script
	src="${pageContext.request.contextPath}/js/lightbox-plus-jquery.js"></script>

<c:import url="update_case_status.jsp"></c:import>
<c:import url="police_messages.jsp"></c:import>
<input id="user_id" type="hidden" value="${results.rows[0].user_id }"
	class="form-control">