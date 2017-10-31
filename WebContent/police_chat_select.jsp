<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<sql:setDataSource var="ds" dataSource="jdbc/e_crime" />

<sql:query dataSource="${ds}"
	sql="select  * from police_messages where complaint_id=? " var="results">
	<sql:param value="${sessionScope.complaint_id}"></sql:param>
</sql:query>

<h4 class="text-center">Complaint Chat</h4>
<hr class="hr-clas" />
<c:forEach var="message" items="${results.rows}" varStatus="row">

	<c:if test="${message.status=='s' }">
		<div class="chat-box-left">${message.msg}</div>
		<div class="chat-box-name-left">
			<span class="fa-stack "> <i
				class="fa fa-circle fa-4x circle_icon"></i> <i
				class="fa fa-user fa-2x user_icon" style="color: black;"></i>
			</span>
			<div class="pull-left">
				User<br>${message.date }&nbsp;</div>
		</div>
		<br />

		<hr class="hr-clas" />

	</c:if>
	<c:if test="${message.status=='r' }">
		<div class="chat-box-right">${message.msg }</div>
		<div class="chat-box-name-right">
			<span class="fa-stack pull-right"> <i
				class="fa fa-circle fa-4x admin_circle_icon"></i> <i
				class="fa fa-user fa-2x admin_user_icon" style="color: black;"></i>
			</span>
			<div class="pull-right">
				Police<br>${message.date } &nbsp;
			</div>
		</div>
		<br />
		<br />
		<hr class="hr-clas" />

	</c:if>
</c:forEach>

<input id="subject" type="hidden" value="${sessionScope.complaint_id }" class="form-control">