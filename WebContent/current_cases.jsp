<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<sql:setDataSource var="ds" dataSource="jdbc/e_crime" />
<c:if test="${empty police }">
	<c:redirect url="/police_login.jsp"></c:redirect>
</c:if>

<c:import url="header.jsp"></c:import>
<c:import url="police_header.jsp"></c:import>
<sql:query dataSource="${ds}"
	sql="select * from complaints where jurisdiction_station=? and comp_status='investigating'"
	var="results">
	<sql:param value="${police.station_id }"></sql:param>
</sql:query>

<!-- Main -->
<div class="container">
	<div class="row">
		<div class="col-lg-10 col-lg-offset-1">
		<c:import url="police_nav.jsp"></c:import>
			<hr>
			<div class="row">
				<!-- center left-->
				<div class="col-lg-12">
					<c:set var="i" value="0"></c:set>
					<c:set var="resultslen" value="${fn:length(results.rows) }"></c:set>


					<%--Showing Each Complaint's Information --%>


					<c:forEach var="complaint" items="${results.rows}" varStatus="row">

						<c:if test="${row.first }">
							<c:out
								value="<div class='container' style='width:925px;' id='criminals_container'> <h1 class='text-center heading1'>Filed Complaints</h1>"
								escapeXml="false"></c:out>

						</c:if>
						<c:if test="${i%2==0 }">
							<c:out escapeXml="false" value="<div class='row'>"></c:out>
						</c:if>


						<div class="col-lg-6">
							<div class="well profile">
								<div class="col-lg-12 text-center">
									<h3 class="heading1">Complaint Number # ${i+1 }</h3>
								</div>
								<div class="col-xs-12 divider text-center">
									<div class="col-xs-12 col-sm-4 emphasis">
										<h4>
											<strong> ${complaint.incident_date }</strong>
										</h4>
										<h4>
											<small>Incident Date</small>
										</h4>
									</div>
									<div class="col-xs-12 col-sm-4 emphasis">
										<h4>
											<strong> ${ complaint.comp_status}</strong>
										</h4>
										<h4>
											<small>Status</small>
										</h4>
									</div>
									<div class="col-xs-12 col-sm-4 emphasis">
										<h4>
											<strong>${complaint.incident_place }</strong>
										</h4>
										<h4>
											<small>Incident Place</small>
										</h4>
									</div>


									<div class="btn-group dropup btn-block col-xs-offset-4">
										<a
											href="Police_Controller?action=comp_progress&id=${complaint.complaint_id }"><button
												type="button" class="btn btn-primary">
												<span class="fa  fa-book"></span> View Details
											</button></a>
									</div>

								</div>
								<!-- end divider-->
							</div>
						</div>
						<!-- end column-->
						<c:if test="${(i+1) %2==0 }">
							<c:out escapeXml="false" value="</div>"></c:out>
						</c:if>

						<c:set var="i" value="${i+1 }"></c:set>
						<c:if test="${i== resultslen  }">
							<c:out value="</div></div>" escapeXml="false">

							</c:out>
						</c:if>

					</c:forEach>
				</div>
				<!--/col-->

			</div>
			<!--/row-->

			<hr>



		</div>
		<!--/col-span-9-->
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
	$('#criminals_container').css('margin-top', '0px');
	$('.profile').css('min-height', '250px');
	$('#current').css('background-color', '#fb2');
</script>
