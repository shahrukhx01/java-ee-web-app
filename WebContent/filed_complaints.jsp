<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:if test="${empty user }">
<c:redirect url="/login_signUp.jsp"></c:redirect>
</c:if>

<c:import url="header.jsp">
	<c:param name="title" value="E Crime File Management System"></c:param>
</c:import>
<c:import url="slider.jsp"/>
<c:import url="process.jsp"></c:import>
<sql:setDataSource var="ds" dataSource="jdbc/e_crime" />

<sql:query dataSource="${ds}" sql="select * from complaints where user_id=?  "
	var="results" >
	<sql:param value="${user.userId }"></sql:param>
	</sql:query>

<c:set var="i" value="0"></c:set>
<c:set var="resultslen" value="${fn:length(results.rows) }"></c:set>
<div id="content"></div>

<%--Showing Each Complaint's Information --%>


<c:forEach var="complaint" items="${results.rows}" varStatus="row">

	<c:if test="${row.first }">
	<div id="result_list"></div>
		<c:out
			value="<div class='container' id='criminals_container'> <h1 class='text-center heading1'>Filed Complaints</h1>"
			escapeXml="false"></c:out>

	</c:if>
	<c:if test="${i%2==0 }">
		<c:out escapeXml="false" value="<div class='row'>"></c:out>
	</c:if>


	<div class="col-lg-6 ">
		<div class="well profile">
			<div class="col-lg-12 text-center">
			<h3>Complaint Number # ${i+1 }</h3>
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
					<c:if test="${param.action=='progress' }">
					<div class="btn-group dropup btn-block">
						<a href="Controller?action=comp_progress&id=${complaint.complaint_id }"><button
								type="button" class="btn btn-primary">
								<span class="fa  fa-book"></span> View Details
							</button></a>
					</div>
					</c:if>
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
<c:import url="footer.jsp" />
<script>
	$(".profile").css("min-height", "100px");	
</script>
<c:import url="search_results_window.jsp"></c:import>
<c:import url="missing_person_window.jsp"></c:import>
<c:import url="admin_messages.jsp"></c:import>
