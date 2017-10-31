<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="org.json.simple.JSONObject"%>


<c:import url="header.jsp">
	<c:param name="title" value="E Crime File Management System"></c:param>
</c:import>
<c:import url="slider.jsp" />
<c:import url="process.jsp"></c:import>
<sql:setDataSource var="ds" dataSource="jdbc/e_crime" />

<sql:query dataSource="${ds}" sql="select * from most_wanted  "
	var="results" />

<c:set var="i" value="0"></c:set>
<c:set var="resultslen" value="${fn:length(results.rows) }"></c:set>

<div id="content"></div>
<%--Showing Each Criminal's Information --%>


<c:forEach var="criminal" items="${results.rows}" varStatus="row">

	<c:if test="${row.first }">
		<div id="result_list"></div>
		<c:out
			value="<div class='container' id='criminals_container'> <h1 class='text-center heading1'>Most Wanted Criminals</h1>"
			escapeXml="false"></c:out>

	</c:if>
	<c:if test="${i%2==0 }">
		<c:out escapeXml="false" value="<div class='row'>"></c:out>
	</c:if>


	<div class="col-lg-6 ">
		<div class="well profile">
			<div class="col-sm-12">
				<!-- personal info-->
				<div class="col-xs-12 col-sm-8">
					<h2>${criminal.criminal_fname}${criminal.criminal_last_name}</h2>

					<p class="pull-left">
						<strong>Sex: </strong>${criminal.criminal_sex}
					</p>
					<p>
						<strong>Age: </strong>${criminal.criminal_age}
					</p>
					<p>
						<strong>Last address: </strong>${criminal.criminal_last_address }
					</p>
					<sql:query dataSource="${ds}"
						sql="select * from criminal_categories where criminal_id=?"
						var="cat_results">
						<sql:param value="${criminal.criminal_id }"></sql:param>
					</sql:query>
					<p class="text-center">
						<strong>Categories</strong><br />
						<c:set var="categories" value="${criminal.criminal_category}"></c:set>

						<c:forEach var="cats" items="${cat_results.rows}">
							<span class="tags">${cats.criminal_category}</span>
						</c:forEach>
					</p>

				</div>
				<!-- end personal info-->
				<div class="col-xs-12 col-sm-4 text-center">
					<sql:query dataSource="${ds}"
						sql="select * from images where person_id=? and category=?   "
						var="img_results">
						<sql:param value="${(criminal.criminal_id) }"></sql:param>
						<sql:param value="criminal"></sql:param>
					</sql:query>

					<figure>
						<c:choose>
							<c:when test="${empty img_results.rows[0]}">
								<c:set var="image_name" value="criminal1.PNG" />
							</c:when>
							<c:otherwise>
								<c:set var="image_name"
									value="${img_results.rows[0].image_name }"></c:set>

							</c:otherwise>
						</c:choose>
						<img height="300" width="200" src="imgs/${image_name}"
							alt="Wanted Criminal" class="img-circle img-responsive">

						<figcaption class="ratings">
							<c:set var="decimal_rating"
								value="${fn:substring(criminal.criminal_rating,0,1)}"></c:set>
							<c:set var="float_rating" value="${criminal.criminal_rating*10}"></c:set>
							<p>
								Criminal Rating <br />

								<%--Rating stars before decimal point --%>
								<c:forEach begin="1" end="${decimal_rating}">
									<a> <span class="fa fa-star fa-2x"></span>
									</a>
								</c:forEach>
								<c:choose>
									<c:when test="${float_rating%10 ==5 }">
										<a> <span class="fa fa-star-half-o fa-2x"></span>
										</a>
									</c:when>

									<c:when test="${decimal_rating!=5}">
										<a> <span class="fa fa-star-o fa-2x"></span>
										</a>
										<c:forEach begin="1" end="${4-(decimal_rating)}">
											<a> <span class="fa fa-star-o fa-2x"></span>
											</a>
										</c:forEach>

									</c:when>
								</c:choose>
							</p>
						</figcaption>
					</figure>

				</div>
				<!-- end rating area-->
			</div>
			<div class="col-xs-12 divider text-center">
				<div class="col-xs-12 col-sm-4 emphasis">
					<h2>
						<strong> ${criminal.criminal_bounty } $</strong>
					</h2>
					<h4>
						<small>Bounty</small>
					</h4>
				</div>
				<div class="col-xs-12 col-sm-4 emphasis">
					<h2>
						<strong>${criminal.criminal_status} time(s)</strong>
					</h2>
					<h4>
						<small>Arrested Before</small>
					</h4>
				</div>
				<div class="col-xs-12 col-sm-4 emphasis">
					<h2>
						<strong>${criminal.criminal_views }</strong>
					</h2>
					<h4>
						<small>Profile Views </small>
					</h4>
					<div class="btn-group dropup btn-block">
						<a href="Controller?action=criminal&id=${criminal.criminal_id }"><button
								type="button" class="btn btn-primary">
								<span class="fa fa-user"></span> View Profile
							</button></a>
					</div>
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

	$('.img-responsive').css('width', '200px');
	$('.img-responsive').css('height', '300px');
	$(window).load(function() {
		
	});
	</script>



<c:import url="search_results_window.jsp"></c:import>
<c:import url="missing_person_window.jsp"></c:import>
<c:import url="admin_messages.jsp"></c:import>