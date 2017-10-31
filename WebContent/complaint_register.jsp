<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:if test="${empty user }">
	<c:redirect url="/login_signUp.jsp"></c:redirect>
</c:if>

<c:import url="header.jsp">
	<c:param name="title" value="Register Complaint"></c:param>
</c:import>
<c:import url="slider.jsp" />
<c:import url="process.jsp"></c:import>
<c:if test="${empty messageDetail || not empty success}">
	<c:set var="fname" value=""></c:set>
	<c:set var="lname" value=""></c:set>
	<c:set var="mobile" value=""></c:set>
	<c:set var="address" value=""></c:set>
	<c:set var="ftname" value=""></c:set>
	<c:set var="cnic" value=""></c:set>
	<c:set var="home_dist" value=""></c:set>
	<c:set var="home_station" value=""></c:set>
	<c:set var="idate" value=""></c:set>
	<c:set var="iplace" value=""></c:set>
	<c:set var="itime" value=""></c:set>
	<c:set var="idistrict" value=""></c:set>
	<c:set var="istation" value=""></c:set>
	<c:set var="idescrp" value=""></c:set>
	<c:set var="station_visit" value=""></c:set>
	<c:set var="vdetails" value=""></c:set>
	<c:set var="vtime" value=""></c:set>
	<c:set var="vdate" value=""></c:set>
</c:if>

<sql:setDataSource var="ds" dataSource="jdbc/e_crime" />

<body>
<div id="content"></div>
	<div class="container form_container">

		<h1 class="text-center heading1">Report Complaint</h1>
		<c:choose>
			<c:when test="${not empty error }">


				<div class="alert alert-danger fade in">
					<a href="#" class="close" data-dismiss="alert">&times;</a>
					<h4>${messageDetail }</h4>
				</div>
			</c:when>
			<c:when test="${not empty success }">
				<div class="alert alert-success fade in">
					<a href="#" class="close" data-dismiss="alert">&times;</a>
					<h4>${messageDetail }</h4>
				</div>

			</c:when>
		</c:choose>

		<br />

		<div class="row">
			<!--Sign in form-->
			<div id="result_list"></div>
			<form id="comp_form"
				action="${pageContext.request.contextPath}/RegisterComplaint"
				method="post" role="form">

				<div class="col-sm-5 col-sm-offset-1">
					<h3>Personal Information</h3>
					<p>Please enter your personal details.</p>


					<div class="form-white">
						<div class="form-group">
							<label for="fname">First name</label> <input type="text"
								class="form-control  has-feedback" name="fname"
								value="${fname }" id="fname" placeholder="Enter First Name"
								required>
						</div>
						<div class="form-group">
							<label for="lname">Last name</label> <input type="text"
								class="form-control  has-feedback" value="${lname }"
								name="lname" id="lname" placeholder="Enter Last Name" required>
						</div>
						<div class="form-group  has-feedback">
							<label for="mobile">Mobile number</label> <input type="number"
								class="form-control" name="mobile" value="${mobile}" id="mobile"
								placeholder="Enter Mobile number" required>
						</div>
						<div class="form-group  has-feedback">
							<label for="address">Present address</label> <input type="text"
								class="form-control" name="address" value="${address }"
								id="address" placeholder="Enter present address" required>
						</div>
						<div class="form-group  has-feedback">
							<label for="ftname">Father name</label> <input type="text"
								class="form-control" name="ftname" value="${ftname }"
								id="ftname" placeholder="Enter Father's name" required>
						</div>

						<div class="form-group  has-feedback">
							<label for="cnic">CNIC number</label> <input type="number"
								class="form-control" name="cnic" value="${ cnic}" id="cnic"
								placeholder="Enter CNIC number" required>
						</div>
						<sql:query dataSource="${ds}" sql="select * from districts  "
							var="district_results" />

						<div class="form-group ">
							<label for="district">Home district</label> <select
								class="form-control" name="district" id="district" required>

								<option value="" selected="selected">Please Select</option>
								<c:forEach var="dist" items="${district_results.rows }">
									<option value="${dist.district_id }">${dist.district_name }</option>
								</c:forEach>

							</select>

						</div>

						<sql:query dataSource="${ds}"
							sql="select * from police_stations  " var="station_results" />

						<div class="form-group">
							<label for="home_station">Home police station</label> <select
								class="form-control" name="home_station" id="home_station"
								required>
								<option value="" selected="selected">Please Select</option>

								<c:forEach var="station" items="${station_results.rows }">
									<option value="${station.police_station_id }">${station.station_name }</option>
								</c:forEach>
							</select>

						</div>
						<div class="form-avatar hidden-xs">
							<span class="fa-stack fa-4x"> <i
								class="fa fa-circle fa-stack-2x"></i> <i
								class="fa fa-user fa-stack-1x"></i>
							</span>
						</div>
					</div>
					<!--end personal information form-->
				</div>

				<!--Incident information-->
				<div class="col-sm-5">
					<h3>Incident Information</h3>
					<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Please
						enter your incident details.</p>
					<div class="form-white">
						<div class="form-group">
							<label for="idate">Incident Date</label> <input type="date"
								class="form-control" name="idate" id="idate"
								placeholder="Enter Incident's Date" required>
						</div>
						<div class="form-group">
							<label for="iplace">Incident Place</label> <input type="text"
								class="form-control" value="${ iplace}" name="iplace"
								id="iplace" placeholder="Enter Incident's Place" required>
						</div>
						<div class="form-group">
							<label for="itime">Incident Time</label> <input type="time"
								class="form-control" value="${itime }" name="itime" id="itime"
								placeholder="Enter Incident's Time" required>
						</div>
						<div class="form-group">
							<label for="idistrict">Incident district</label> <select
								class="form-control" name="idistrict" id="idistrict" required>
								<option value="" selected="selected">Please Select</option>
								<c:forEach var="dist" items="${district_results.rows }">
									<option value="${dist.district_id }">${dist.district_name }</option>
								</c:forEach>
							</select>
						</div>
						<div class="form-group">
							<label for="istation">Jurisdiction police station</label> <select
								class="form-control" name="istation" id="istation" required>
								<option value="" selected="selected">Please Select</option>
								<c:forEach var="station" items="${station_results.rows }">
									<option value="${station.police_station_id }">${station.station_name }</option>
								</c:forEach>
							</select>

						</div>

						<div class="idescrp">
							<label for="itime">Incident Description</label>
							<textarea class="form-control" name="idescrp" id="idescrp"
								placeholder="Enter Incident Description" required>${idescrp}</textarea>
						</div>

						<div class="form-group">
							<label for="station_visited">Already Visited Police
								Station</label><br> <label><input type="radio"
								name="station_visited" value="Yes">&nbsp; Yes &nbsp;</label> <label><input
								type="radio" name="station_visited" value="No">&nbsp; No</label>
						</div>


						<div class="form-group">
							<label for="visit_details">Visit Details (Name/Rank of
								Police Officer visited)</label>
							<textarea class="form-control" name="visit_details"
								placeholder="Enter visit Details">${vdetails }</textarea>
						</div>

						<div class="form-group">
							<label for="vtime">Visit time</label> <input type="time"
								class="form-control" value="${vtime }" name="vtime"
								placeholder="Enter visit time">
						</div>
						<div class="form-group">
							<label for="vdate">Visit date</label> <input type="date"
								class="form-control" value="${vdate }" name="vdate"
								placeholder="Enter visit date">
						</div>
						<input type="hidden" id="Lat" name="Lat" /> <input type="hidden"
							id="Lng" name="Lng" />
						<button id="complaint_btn" type="button"
							class="btn btn-lg btn-block btn-primary btn-xxl">Submit
							Report</button>


						<!--end form-->
					</div>
					<!--end personal information form-->
				</div>
			</form>
		</div>
		<!--end row-->
	</div>
	<!--end container-->
	<c:import url="footer.jsp"></c:import>
</body>
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&libraries=places"></script>	
<script>
	$("body").css("background-color", "white");
	$(".form_container").css("width", "920px");
	$(".fa-stack-1x").css("top", "5px");

	function initialize() {
		var options = {
			componentRestrictions : {
				country : "pk"
			}
		};

		var input = document.getElementById('iplace');
		var autocomplete = new google.maps.places.Autocomplete(input, options);
		google.maps.event
				.addListener(
						autocomplete,
						'place_changed',
						function() {
							var place = autocomplete.getPlace();
							document.getElementById('Lat').value = place.geometry.location
									.lat();
							document.getElementById('Lng').value = place.geometry.location
									.lng();

						});
	}

	google.maps.event.addDomListener(window, 'load', initialize);
</script>

<c:import url="search_results_window.jsp"></c:import>
<c:import url="missing_person_window.jsp"></c:import>
<c:import url="admin_messages.jsp"></c:import>

