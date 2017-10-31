<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<c:import url="header.jsp">
	<c:param name="title" value="E Crime File Management System"></c:param>
</c:import>
<c:import url="slider.jsp" />
<c:import url="process.jsp"></c:import>
<sql:setDataSource var="ds" dataSource="jdbc/e_crime" />

<sql:query dataSource="${ds}" sql="select * from missing_person  "
	var="results" />

<c:set var="i" value="0"></c:set>
<c:set var="resultslen" value="${fn:length(results.rows) }"></c:set>
<div id="content"></div>

<%--Showing Each Missing person's Information --%>


<c:forEach var="missing_person" items="${results.rows}" varStatus="row">

	<c:if test="${row.first }">
		<div id="result_list"></div>
		<c:out
			value="<div class='container' id='criminals_container'> <h1 class='text-center heading1'>Missing Persons</h1>"
			escapeXml="false"></c:out>

	</c:if>
	<c:if test="${i%2==0 }">
		<c:out escapeXml="false" value="<div class='row'>"></c:out>
	</c:if>


	<div class="col-lg-6 ">
		<div class="well profile">
			<div class="col-sm-12">
				<!-- personal info-->
				<div class="col-xs-12 col-sm-8 col-sm-offset-1">
					<img src="imgs/ribbon.png" alt="ribbon"
						class="ribbon img-circle img-responsive">

					<h2>${missing_person.first_name}${missing_person.last_name}</h2>

					<p class="pull-left">
						<strong>Sex: </strong>${missing_person.sex}
					</p>
					<p>
						<strong>Age: </strong>${missing_person.age}
					</p>
					<p>
						<strong>Address: </strong>${missing_person.address }
					</p>

				</div>
				<!-- end personal info-->
				<div class="col-xs-12 col-sm-3 text-center">
					<sql:query dataSource="${ds}"
						sql="select * from images where person_id=? and category=?   "
						var="img_results">
						<sql:param value="${(missing_person.missing_person_id) }"></sql:param>
						<sql:param value="missing"></sql:param>
					</sql:query>

					<figure>
						<c:choose>
							<c:when test="${empty img_results.rows[0]}">
								<c:set var="image_name" value="missing_default.PNG" />
							</c:when>
							<c:otherwise>
								<c:set var="image_name"
									value="${img_results.rows[0].image_name }"></c:set>

							</c:otherwise>
						</c:choose>
						<img height="300" width="200" src="imgs/${image_name}"
							alt="missing person" class="img-circle missing img-responsive">
						<br>
						<h5>Reported On:</h5>
						<div class="date">${missing_person.date}</div>
						<br>
					</figure>

				</div>
				<!-- end rating area-->
			</div>
			<div class="col-xs-12 divider text-center">
				<div class="col-xs-12 col-sm-4 emphasis">
					<h4>
						<strong> ${missing_person.psycological_status } </strong>
					</h4>
					<h4>
						<small>psychological Disorder</small>
					</h4>
				</div>
				<div class="col-xs-12 col-sm-4 emphasis">
					<h4>
						<strong>${missing_person.last_seen}</strong>
					</h4>
					<h4>
						<small>Last seen</small>
					</h4>
				</div>
				<div class="col-xs-12 col-sm-4 emphasis">
					<h4>
						<strong>${missing_person.marital_status }</strong>
					</h4>
					<h4>
						<small>Marital Status</small>
					</h4>
				</div>
			</div>
			<!-- end divider-->
		</div>
		<!-- end profile-->
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
	$('.missing').css('height', '110px');
</script>

<c:import url="search_results_window.jsp"></c:import>
<c:import url="missing_person_window.jsp"></c:import>
<c:import url="admin_messages.jsp"></c:import>