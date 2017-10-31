<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<sql:setDataSource var="ds" dataSource="jdbc/e_crime" />
<c:set var="search_item" value="${param.search_item }"></c:set>
<sql:query dataSource="${ds}"
	sql="select  * from most_wanted where criminal_fname like '%${search_item}%' or criminal_last_name like '%${search_item}%'  "
	var="results">
</sql:query>

<sql:query dataSource="${ds}"
	sql="select  * from missing_person where first_name like '%${search_item}%' or last_name like '%${search_item}%'  "
	var="missing_results">
</sql:query>

<div class="container">

<c:if test="${not empty results.rows }">
	<h1 class="heading1" style="border:none;">Wanted Criminals</h1>
</c:if>

	<c:forEach var="criminal" items="${results.rows}" varStatus="row">
		<div class="result_row row">
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
					<c:set var="image_name" value="${img_results.rows[0].image_name }"></c:set>

				</c:otherwise>
			</c:choose>
			<div class=" col-lg-6 result_box">
				<div class="col-lg-8">
				<h3 class="search_caption " style="color:#fb2f3a;">${criminal.criminal_fname }
					${criminal.criminal_last_name }</h3>
				<h4>Criminal's Bounty: ${criminal.criminal_bounty } $</h4>
				<a href="${pageContext.request.contextPath}/Controller?action=criminal&id=${criminal.criminal_id }"><button class="btn btn-primary">View Details</button></a>
				</div>
				<div class="col-lg-4">
					<span><img src="imgs/${image_name }"
						alt="Most Wanted Criminal" class="result_image"></span>
				</div>
				

			</div>
		</div>
	</c:forEach>

<c:if test="${not empty missing_results.rows }">
	<h1 class="heading1" style="border:none;">Missing Persons</h1>
</c:if>
	
	<c:forEach var="missing" items="${missing_results.rows}"
		varStatus="row">
		<div class="result_row row">
			<sql:query dataSource="${ds}"
				sql="select * from images where person_id=? and category=?   "
				var="img_results">
				<sql:param value="${(missing.missing_person_id) }"></sql:param>
				<sql:param value="missing"></sql:param>
			</sql:query>
			<c:choose>
				<c:when test="${empty img_results.rows[0]}">
					<c:set var="image_name" value="missing_default.PNG" />
				</c:when>
				<c:otherwise>
					<c:set var="image_name" value="${img_results.rows[0].image_name }"></c:set>

				</c:otherwise>
			</c:choose>
			<div class=" col-lg-6 result_box">
			<div class="col-lg-8">
				<h3 class="search_caption " style="color:#fb2f3a;">${missing.first_name }
					${missing.last_name } </h3>
					
					<h4>Last Seen: 	${missing.last_seen}</h4>
					<a data-toggle="modal" href="#missing_result" onclick="show_missing(this)" id="${missing.missing_person_id }" class="missing_link"><button class="btn btn-primary">View Details</button></a>
					</div>
					
					<div class="col-lg-4"><span><img src="imgs/${image_name }"
						alt="Missing Person" class="result_image"></span>
						</div>
				
			</div>
		</div>
	</c:forEach>
</div>

<c:if test="${empty missing_results.rows && empty results.rows}">
	<h5 class="search_caption">no results found...</h5>
</c:if>