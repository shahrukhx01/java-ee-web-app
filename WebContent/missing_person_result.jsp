<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<sql:setDataSource var="ds" dataSource="jdbc/e_crime" />
<c:set var="search_item" value="${param.search_item }"></c:set>

<sql:query dataSource="${ds}"
	sql="select  * from missing_person where missing_person_id=? "
	var="missing_results">
	<sql:param>${search_item }</sql:param>
</sql:query>

<div class="container">


	
<c:if test="${not empty missing_results.rows }">
	<h1 class="heading1" style="border:none;">Missing Person</h1>
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
					<h4><span style="color:#fb2f3a">Age :</span> 	${missing.age}</h4>
					<h4><span style="color:#fb2f3a">Sex :</span> 	${missing.sex}</h4>
					<h4><span style="color:#fb2f3a">Last Seen :</span> 	${missing.last_seen}</h4>
					<h4><span style="color:#fb2f3a">Address : </span>	${missing.address}</h4>
					<h4><span style="color:#fb2f3a">Marital Status : </span>	${missing.marital_status}</h4>
					<h4><span style="color:#fb2f3a">Psychological Disorder : </span>	${missing.psycological_status}</h4>
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