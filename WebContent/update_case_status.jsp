<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:import url="header.jsp"></c:import>

<body>


	<div class="modal" id="UpdStatus">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h4 class="modal-title">Update Case Status</h4>


				</div>
				<div class="modal-body">
					<div class="container" id="chatbox">
						<div class="row pad-top pad-bottom">
							<br>

							<div class=" col-lg-6 col-md-6 col-sm-6">
								<div class="chat-box-div">

									<div class="chat-box-footer">
										<form
											action="${pageContext.request.contextPath}/UpdateCaseStatus"
											method="post">
											<div class="input-group">
												<select class="form-control" name="status" id="status"
													required>
													<option value="pending">Pending</option>
													<option value="investigating">Investigating</option>
													<option value="closed">Closed</option>
												</select> <input type="hidden" value="${param.id }" id="hidden_id" name="hidden_id">
												<span class="input-group-btn">
													<button style="width:66px;" class="btn btn-info" type="submit">Update</button>
												</span>
											</div>
										</form>
									</div>

								</div>

							</div>

						</div>
					</div>


				</div>
			</div>
		</div>
	</div>


</body>

</html>
<script>
	$('#openBtn').click(function() {
		$('#UpdStatus').modal({
			show : true
		})
	});
</script>

