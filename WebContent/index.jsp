<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:import url="header.jsp">
	<c:param name="title" value="E Crime File Management System"></c:param>
</c:import>
<c:import url="slider.jsp"></c:import>
<sql:setDataSource var="ds" dataSource="jdbc/e_crime" />

<sql:query dataSource="${ds}"
	sql="select * from most_wanted order by criminal_views desc limit 8"
	var="results" />


<c:set var="resultslen" value="${fn:length(results.rows) }"></c:set>

<c:import url="process.jsp"></c:import>
  
<!-- Most Viewed Criminals-->
<c:set var="i" value="0"></c:set>
<c:forEach var="criminal" items="${results.rows}" varStatus="row">

	<c:if test="${row.first }">
	<div id="result_list"></div>
		<c:out
			value="<div class='container' id='criminals_container'> <h1 class='text-center heading1'>Most Viewed Wanted Criminals</h1>"
			escapeXml="false"></c:out>

	</c:if>
	<c:if test="${i%4==0 }">
		<c:out escapeXml="false" value="<div class='row'>"></c:out>
	</c:if>
	<div class=" col-lg-3">
		<div class="well profile">
			<div class="col-sm-12">
				<!-- personal info-->
				<div class="col-xs-12 col-sm-12">
					<h3>${criminal.criminal_fname} ${criminal.criminal_last_name} </h3>
				</div>
				<!-- end personal info-->
				<div class="col-xs-12 col-sm-12 text-center">
					<figure>
						<sql:query dataSource="${ds}"
							sql="select * from images where person_id=? and category=?   "
							var="img_results">
							<sql:param value="${(criminal.criminal_id) }"></sql:param>
							<sql:param value="criminal"></sql:param>
						</sql:query>
						<c:choose>
							<c:when test="${empty img_results.rows[0]}">
								<c:set var="image_name" value="criminal1.PNG" />
							</c:when>
							<c:otherwise>
								<c:set var="image_name"
									value="${img_results.rows[0].image_name }"></c:set>

							</c:otherwise>
						</c:choose>
						<img src="imgs/${image_name }" alt="Most Viewed Criminals"
							class="user img-circle img-responsive">
						<figcaption class="ratings">
							<c:set var="decimal_rating"
								value="${fn:substring(criminal.criminal_rating,0,1)}"></c:set>
							<c:set var="float_rating" value="${criminal.criminal_rating*10}"></c:set>
							<h4>
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
										</h4>
									</figcaption>
					</figure>
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
				<!-- end rating area-->
			</div>
			<div class="col-xs-12 divider text-center">
				<div class="col-xs-12 col-sm-12 emphasis">
					<h2>
						<strong>${criminal.criminal_views}</strong>
					</h2>
					<h4>
						<small>Profile Views</small>
					</h4>
					<a
						href="${pageContext.request.contextPath}/Controller?action=criminal&id=${criminal.criminal_id }">
						<button class="btn btn-primary btn-block">
							<span class="fa fa-user"></span> View Profile
						</button>
					</a>
				</div>
			</div>
			<!-- end divider-->
		</div>
		<!-- end profile-->
	</div>
	<!-- end column-->
	<c:if test="${(i+1) %4==0 }">
		<c:out escapeXml="false" value="</div>"></c:out>
	</c:if>

	<c:set var="i" value="${i+1 }"></c:set>
	<c:if test="${i== resultslen  }">
		<c:out value="</div></div>" escapeXml="false">

		</c:out>
	</c:if>

</c:forEach>
   

<c:import url="footer.jsp"></c:import>

<script>
	$(function() {
		$('.carouselBanner').carousel();
	});
	
	$('.img-responsive').css('width', '200px');
	$('.img-responsive').css('height', '300px');
		
	</script>

</body>
</html>

<c:import url="search_results_window.jsp"></c:import>
<c:import url="missing_person_window.jsp"></c:import>
<c:import url="admin_messages.jsp"></c:import>


