<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:import url="header.jsp"></c:import>

<body>
	<div class="modal" id="addImg">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h4 class="modal-title">Add an Image</h4>


				</div>
				<div class="modal-body">
					<div class="container" id="chatbox">
						<div class="row pad-top pad-bottom">
							<br>

							<div class=" col-lg-6 col-md-6 col-sm-6">
								<div class="chat-box-div">

									<div class="chat-box-footer">
										<form
											action="${pageContext.request.contextPath}/AddMissingImage"
											enctype="multipart/form-data" method="post">
											<div class="input-group">
												<input type="file" class="form-control" name="file"
													value="Select image..."> <input type="hidden"
													id="c_hidden_id" name="c_hidden_id"> <input
													type="hidden" id="img_id" name="img_id"> <input
													type="hidden" id="destination" name="destination"
													value="C:\Users\amaar\workspace\E Crime File Management System\WebContent\imgs"> <span
													class="input-group-btn">
													<button id="subm_btn" class="btn btn-info" type="submit">
														<span class="fa  fa-camera "></span> Upload
													</button>
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
	$('#subm_btn').css('width', '80px');
</script>

