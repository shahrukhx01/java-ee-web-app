<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<sql:setDataSource var="ds" dataSource="jdbc/e_crime" />
<c:if test="${empty admin }">
	<c:redirect url="/admin_login.jsp"></c:redirect>
</c:if>

<c:import url="header.jsp"></c:import>
<c:import url="admin_header.jsp"></c:import>
<!-- Main -->
<div class="container">
	<div class="row">
				<div class="col-sm-10 col-lg-offset-1">

			<c:import url="admin_nav.jsp"></c:import>
		
			<div class="row">
				<!-- center left-->
				<div class="col-md-12">

					<hr>
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4>Notices</h4>
						</div>
						<div class="panel-body">
							<div class="alert alert-info">
								<button type="button" class="close" data-dismiss="alert">×</button>
								This is a dismissable alert.. just sayin'.
							</div>
							<p>This is a dashboard-style layout that uses Bootstrap 3.
								You can use this template as a starting point to create
								something more unique.</p>
							<p>
								Visit the Bootstrap Playground at <a href="http://bootply.com">Bootply</a>
								to tweak this layout or discover more useful code snippets.
							</p>
						</div>
					</div>


					<hr>

					<div class="panel panel-default">
						<div class="panel-heading">
							<div class="panel-title">
								<i class="glyphicon glyphicon-wrench pull-right"></i>
								<h4>Post Request</h4>
							</div>
						</div>
						<div class="panel-body">
							<form class="form form-vertical">
								<div class="control-group">
									<label>Name</label>
									<div class="controls">
										<input type="text" class="form-control"
											placeholder="Enter Name">
									</div>
								</div>
								<div class="control-group">
									<label>Message</label>
									<div class="controls">
										<textarea class="form-control"></textarea>
									</div>
								</div>
								<div class="control-group">
									<label>Category</label>
									<div class="controls">
										<select class="form-control">
											<option>options</option>
										</select>
									</div>
								</div>
								<div class="control-group">
									<label></label>
									<div class="controls">
										<button type="submit" class="btn btn-primary">Post</button>
									</div>
								</div>
							</form>
						</div>
						<!--/panel content-->
					</div>
					<!--/panel-->


				</div>
				<!--/col-->
				<div class="col-md-6">
					<h2>Stats come here complaints vs users</h2>
					<hr>
					<div class="panel panel-default">
						<div class="panel-heading">
							<div class="panel-title">
								<h4>Engagement</h4>
							</div>
						</div>
						<div class="panel-body">
							<div class="col-xs-4 text-center">
								<img src="http://placehold.it/80/BBBBBB/FFF"
									class="img-circle img-responsive">
							</div>
							<div class="col-xs-4 text-center">
								<img src="http://placehold.it/80/EFEFEF/555"
									class="img-circle img-responsive">
							</div>
							<div class="col-xs-4 text-center">
								<img src="http://placehold.it/80/EEEEEE/222"
									class="img-circle img-responsive">
							</div>
						</div>
					</div>
					<!--/panel-->

				</div>
				<!--/col-span-6-->

			</div>
			<!--/row-->

		 
		</div>
		<!--/col-span-9-->
	</div>
</div>
<!-- /Main -->


<style>
.form input, .form textarea {
	background: white;
	border-color: #ddd;
}
</style>

<script>
	$('#home').css('background-color', '#fb2');
</script>