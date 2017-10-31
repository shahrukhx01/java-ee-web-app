<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<sql:setDataSource var="ds" dataSource="jdbc/e_crime" />

<sql:query dataSource="${ds}"
	sql="select distinct subject FROM `admin_messages` JOIN `users` ON `admin_messages`.user_id=`users`.user_id where `admin_messages`.user_id=?"
	var="results">
	<sql:param value="${user.userId }"></sql:param>
</sql:query>
<!-- Messages Modal -->
<div class="modal" id="myModal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">×</button>

				<h4 class="modal-title">
					Admin Messages


					<div class="btn-group ">
						<button type="button" id="refresh_btn"
							class="btn btn-info dropdown-toggle" data-toggle="dropdown"
							aria-expanded="false">
							<span class="fa fa-cogs"></span> <span class="sr-only">Toggle
								Dropdown</span>
						</button>

						<button type="button" id="add_btn" class="btn btn-info ">
							<span class="fa fa-plus-square"></span>
						</button>

						<ul class="dropdown-menu" role="menu">
							<li><a href="#"><span class="fa fa-refresh"></span>&nbsp;Refresh</a></li>

						</ul>
					</div>

				</h4>


			</div>
			<div class="modal-body">
				<div class="container pad-top" id="chatbox">
					<div class="row pad-top pad-bottom">


						<div class=" col-lg-6 col-md-6 col-sm-6">
							<div id="inbox" class="container">

								<div class="row">
									<div class="col-sm-6">
										<!-- Nav tabs -->
										<ul class="nav nav-tabs">
											<li class="active"><a href="#home" data-toggle="tab"><span
													class="glyphicon glyphicon-inbox"> </span>Messages</a></li>
										</ul>
										<div class="tab-content">
											<div class="tab-pane fade in active" id="home">
												<div class="list-group">
													<c:if test="${empty user }">
														<h3>Please Login To View Your Messages</h3>

													</c:if>

													<c:forEach var="message" items="${results.rows}"
														varStatus="row">
														<c:if test="${not empty message }">

															<!-- Tab panes -->
															<a id="${message.subject}" href="#myModal1"
																class="msg_link list-group-item"> <span
																class="glyphicon glyphicon-star-empty"></span><span
																class="name"
																style="min-width: 120px; display: inline-block;">Me</span>
																<span class="msg_subjects"> ${message.subject}</span> <span
																class="pull-right">Me </span></a>

														</c:if>
													</c:forEach>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- Message Thread Modal -->
<div class="modal" id="myModal1">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">×</button>

				<h4 class="modal-title">
					Admin Messages


					<div class="btn-group ">
						<button type="button" id="refresh_btn"
							class="btn btn-info dropdown-toggle" data-toggle="dropdown"
							aria-expanded="false">
							<span class="fa fa-cogs"></span> <span class="sr-only">Toggle
								Dropdown</span>
						</button>

						<button type="button" id="add_btn" class="btn btn-info ">
							<span class="fa fa-plus-square"></span>
						</button>

						<ul class="dropdown-menu" role="menu">
							<li><a onclick="refresh_messages()" href="#"><span
									class="fa fa-refresh"></span>&nbsp;Refresh</a></li>

						</ul>
					</div>

				</h4>

			</div>

			<div class="modal-body">
				<div class="container pad-top" id="chatbox">
					<div class="row pad-top pad-bottom">


						<div class=" col-lg-6 col-md-6 col-sm-6">
							<div class="chat-box-div">
								<div id="conversation" class="panel-body chat-box-main"></div>
								<div class="chat-box-footer">
									<div class="input-group">
										<input id="msg" type="text" class="form-control"
											placeholder="Enter Text Here..."> <span
											class="input-group-btn">

											<button class="btn btn-success" id="send_btn" type="button">SEND</button>
										</span>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

