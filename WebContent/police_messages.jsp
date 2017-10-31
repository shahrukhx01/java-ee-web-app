<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<sql:setDataSource var="ds" dataSource="jdbc/e_crime" />

	<!-- Message Thread Modal -->
	<div class="modal" id="myModal1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>

					<h4 class="modal-title">
						Police Messages


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
								<li><a onclick="refresh_messages()" href="#"><span class="fa fa-refresh"></span>&nbsp;Refresh</a></li>

							</ul>
						</div>

					</h4>
					
			</div>

			<div class="modal-body">
				<div class="container pad-top" id="chatbox">
					<div class="row pad-top pad-bottom">


						<div class=" col-lg-6 col-md-6 col-sm-6">
							<div class="chat-box-div">
								<div id="conversation" class="panel-body chat-box-main">
								<c:import url="police_chat_select.jsp"></c:import>
																	</div>
								<div class="chat-box-footer">
									<div class="input-group">
										<input id="msg" type="text" class="form-control"
											placeholder="Enter Text Here...">
											 <span
											class="input-group-btn">
											
											<button class="btn btn-success" id="police_send_btn" type="button">SEND</button>
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

