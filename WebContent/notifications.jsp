<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<sql:setDataSource var="ds" dataSource="jdbc/e_crime" />
<sql:query dataSource="${ds}"
	sql="select  * from notifications" var="results">
</sql:query>



<c:forEach var="notification" items="${results.rows}" varStatus="row">

<c:choose>
<c:when test="${notification.category=='criminal' }">


<sql:query dataSource="${ds}"
	sql="select * from most_wanted where criminal_id=?" var="criminal_result">
	<sql:param value="${notification.person_id}"></sql:param>
</sql:query>

		<div class="result_item">				
<h5 class="search_caption">${criminal_result.rows[0].criminal_fname } ${criminal_result.rows[0].criminal_last_name }  new criminal has been added. <a href="${pageContext.request.contextPath}/Controller?action=criminal&id=${criminal_result.rows[0].criminal_id }" class="search_links">View details.</a></h5>
<c:if test="${not row.last }">
<hr>
</c:if>

</div>
</c:when>
<c:when test="${notification.category=='missing' }">


<sql:query dataSource="${ds}"
	sql="select * from missing_person where missing_person_id=?" var="missing_result">
	<sql:param value="${notification.person_id}"></sql:param>
</sql:query>
<div class="result_item">				
<h5 class="search_caption">${missing_result.rows[0].first_name } ${missing_result.rows[0].last_name } new missing person has been added. <a data-toggle="modal" href="#missing_result" onclick="show_missing(this)" id="${missing_result.rows[0].missing_person_id }" class="missing_link">View Details</a> </h5>
<c:if test="${not row.last }">
<hr>
</c:if>

</div>
</c:when>
</c:choose>
</c:forEach>
