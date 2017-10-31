<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<hr>
<div class="btn-group btn-group-justified">
	<a
		href="${pageContext.request.contextPath}/Admin_controller?action=home"
		class="btn btn-primary col-sm-3"> <i
		class="glyphicon glyphicon-home"></i> <br> Home
	</a> 
	
	<a
		href="${pageContext.request.contextPath}/Admin_controller?action=addStats"
		class="btn btn-primary col-sm-3"> <i
		class="glyphicon glyphicon-plus"></i> <br> Add Statistics
	</a> <a
		href="${pageContext.request.contextPath}/Admin_controller?action=wanted"
		class="btn btn-primary col-sm-3"> <i
		class="glyphicon glyphicon-eye-open"></i> <br> Wanted Criminals
	</a> <a
		href="${pageContext.request.contextPath}/Admin_controller?action=missing"
		class="btn btn-primary col-sm-3"> <i
		class="glyphicon glyphicon-question-sign"></i> <br> Missing
		Persons
	</a> 
	<a
		data-toggle="modal" href="#myModal"
		class="btn btn-primary col-sm-3"> <i
		class="glyphicon glyphicon-envelope"></i> <br> Messages	</a> 
	</div>
<c:import url="admin_view_messages.jsp"></c:import>