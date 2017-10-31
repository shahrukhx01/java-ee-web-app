<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:if test="${empty user }">
	<c:redirect url="/login_signUp.jsp"></c:redirect>
</c:if>
<c:import url="slider.jsp"></c:import>

<c:if test="${ empty param.id}">
	<jsp:forward page="/Controller?action=home" />
</c:if>
<sql:setDataSource var="ds" dataSource="jdbc/e_crime" />
<c:import url="header.jsp"></c:import>
<sql:query dataSource="${ds}"
	sql="select * from complaints left outer join police_officer on complaints.jurisdiction_station=police_officer.station_id left outer join police_stations on police_officer.station_id=police_stations.police_station_id left outer join case_progress on complaints.complaint_id=case_progress.complaint_id where complaints.complaint_id=? "
	var="results">
	<sql:param value="${param.id }"></sql:param>

</sql:query>
<div id="content"></div>
<c:choose>

	<c:when test="${not empty success }">
		<div class="alert alert-success fade in">
			<a href="#" class="close" data-dismiss="alert">&times;</a>
			<h4>${messageDetail }</h4>
		</div>

	</c:when>
</c:choose>


<div class="container" id="criminals_container">
	<h1 class=" heading1">Crime Complaint</h1>

	<div class="row">
		<div class="col-lg-7">
			<div style="top: -853px; left: 888px;" id="result_list"></div>
			<h1>Incident Description</h1>
			<c:set var="crime_description" scope="page"
				value="${results.rows[0].incident_details}"></c:set>

			<c:forEach var="description" items="${crime_description }">
			
			${description}
			</c:forEach>

		</div>
		<!-- end column-->

		<div class="col-lg-5" style="padding-left: 80px;">

			<sql:query dataSource="${ds}"
				sql="select * from evidence_images where complaint_id=?   "
				var="img_results">
				<sql:param value="${param.id }"></sql:param>
			</sql:query>
			<c:choose>
				<c:when test="${empty img_results.rows[0]}">
					
					<c:set var="imgslen" value="1"></c:set>
				</c:when>
				<c:otherwise>
					<c:set var="imgslen" value="${(fn:length(img_results.rows))+1 }"></c:set>

					<c:set var="image_name" value="${img_results.rows[0].image_name }"></c:set>

				</c:otherwise>
			</c:choose>





			<a data-toggle="modal" href="#myModal1"><button type="button"
					class="btn   btn-primary ">Chat with Police</button></a> <a
				data-toggle="modal" href="#addImg"><button type="button"
					id="${imgslen}${'_' }${param.id }"
					class="img_link btn btn-primary ">Add Evidence Image</button> </a> <br>
			<br>
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

			<br>
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
			</table>
		</div>
	</div>
</div>
<!-- end container-->


<div class="container main_cont" id="criminals_container">
	<h1 class=" heading1">Complaint Progress</h1>


	<div class="row">
		<div class=" col-lg-8 col-lg-offset-2">
			<h1 class="text-center">Investigation Details</h1>
			<table class="table">
				<tr class="active">
					<td>
						<h5>Law Sections</h5>
					</td>

					<td>
						<h5>${results.rows[0].law_sections}</h5>
					</td>

				</tr>
				<tr class="success">
					<td>
						<h5>Witnesses interrogated</h5>
					</td>
					<td>
						<h5>${results.rows[0].witnesses }</h5>
					</td>
				</tr>
				<tr class="info">
					<td>
						<h5>Warrants Issued</h5>

					</td>

					<td>
						<h5>${results.rows[0].warrants }</h5>
					</td>
				</tr>
				<tr class="warning">
					<td>
						<h5>Arrests made</h5>
					</td>

					<td>
						<h5>${results.rows[0].arrests }</h5>
					</td>
				</tr>
				<tr class="danger">
					<td>
						<h5>Evidences Found</h5>
					</td>

					<td>
						<h5>${results.rows[0].evidences }</h5>
					</td>
				</tr>
				<tr class="success">
					<td colspan="2">
						<div class="progress">
							<div
								class="progress-bar progress-bar-success progress-bar-striped"
								role="progressbar" aria-valuenow="${ results.rows[0].prgress}"
								aria-valuemin="0" aria-valuemax="100"
								style="width: ${results.rows[0].prgress}%">${results.rows[0].prgress}%
								Progress Made</div>
						</div>
					</td>
				</tr>

			</table>
		</div>
	</div>
</div>
<!-- end container-->
<c:import url="add_evidence_Image.jsp"></c:import>
<script
	src="${pageContext.request.contextPath}/js/lightbox-plus-jquery.js"></script>
<c:set scope="session" var="complaint_id" value="${param.id}"></c:set>
<c:import url="user_police_messages.jsp"></c:import>
<input id="user_id" type="hidden" value="${results.rows[0].user_id }"
	class="form-control">
<c:import url="admin_messages.jsp"></c:import>
<c:import url="search_results_window.jsp"></c:import>
<c:import url="missing_person_window.jsp"></c:import>
<c:import url="footer.jsp"></c:import>