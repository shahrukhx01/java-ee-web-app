<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<sql:setDataSource var="ds" dataSource="jdbc/e_crime" />
<c:set var="search_item" value="${param.search_item }"></c:set>
<sql:query dataSource="${ds}"
	sql="select  * from most_wanted where criminal_fname like '%${search_item}%' or criminal_last_name like '%${search_item}%'  " var="results">
</sql:query>

<sql:query dataSource="${ds}"
	sql="select  * from missing_person where first_name like '%${search_item}%' or last_name like '%${search_item}%'  " var="missing_results">
</sql:query>


<c:forEach var="criminal" items="${results.rows}" varStatus="row">
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
		<div class="result_item">				
<a href="${pageContext.request.contextPath}/Controller?action=criminal&id=${criminal.criminal_id }" class="search_links"><h5 class="search_caption">${criminal.criminal_fname } ${criminal.criminal_last_name } <span><img src="imgs/${image_name }" alt="Most Wanted Criminal" class="pull-right search_img"></span></h5></a>
<hr>
</div>

</c:forEach>
<c:forEach var="missing" items="${missing_results.rows}" varStatus="row">
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
								<c:set var="image_name"
									value="${img_results.rows[0].image_name }"></c:set>

							</c:otherwise>
						</c:choose>
		<div class="result_item">				
<a data-toggle="modal" href="#missing_result" onclick="show_missing(this)" id="${missing.missing_person_id }" class="missing_link"><h5 class="search_caption">${missing.first_name } ${missing.last_name } <span><img src="imgs/${image_name }" alt="Missing Person" class="pull-right search_img"></span></h5></a>
<c:if test="${not row.last }">
<hr>
</c:if>

</div>
</c:forEach>
<c:if test="${empty missing_results.rows && empty results.rows}">
<h5 class="search_caption"> no results found...</h5>
</c:if>