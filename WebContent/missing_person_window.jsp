<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:import url="header.jsp"></c:import>
<div class="modal" id="missing_result">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">×</button>

				<h4 class="modal-title">Missing person result</h4>

			</div>

			<div class="modal-body">
				<div class="container pad-top" id="chatbox">
					<div class="row pad-top pad-bottom">


						<div class=" col-lg-6 col-md-6 col-sm-6">
							<div class="chat-box-div">
								<div id="missing_content" class="panel-body chat-box-main">

								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

