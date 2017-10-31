<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:import url="header.jsp">
	<c:param name="title" value="Crime Statistics"></c:param>
</c:import>
<c:import url="slider.jsp" />
<c:import url="process.jsp"></c:import>
<sql:setDataSource var="ds" dataSource="jdbc/e_crime" />

<sql:query dataSource="${ds}"
	sql="select * from crime_statistics where month=? and year=? "
	var="results">
	<sql:param value="${param.month }"></sql:param>
	<sql:param value="${param.year }"></sql:param>
</sql:query>
<c:set var="current_robbery" value="${results.rows[0].robbery }"></c:set>
<c:set var="current_homocide" value="${results.rows[0].homocide }"></c:set>
<c:set var="current_theft" value="${results.rows[0].vehicle_theft }"></c:set>
<c:set var="current_rape" value="${results.rows[0].rape }"></c:set>
<c:set var="current_assault" value="${results.rows[0].assault }"></c:set>
<sql:query dataSource="${ds}" sql="select * from crime_statistics"
	var="all_results">
</sql:query>

<input type="hidden" id="current_robbery" value="${current_robbery }" />
<input type="hidden" id="current_homocide" value="${current_homocide }" />
<input type="hidden" id="current_theft" value="${current_theft }" />
<input type="hidden" id="current_rape" value="${current_rape }" />
<input type="hidden" id="current_assault" value="${ current_assault}" />
<div id="content"></div>
<div class="container form_container stats_container">
	<h1 class="text-center heading1">Criminal Statistics
		${results.rows[0].month }${" "}${results.rows[0].year }</h1>
	<div class="row">
		<div class="col-lg-6 col-lg-offset-3">
			<div style="top: -1116px; left: 622px;" id="result_list"></div>
			<div class="form-group ">
				<h3 class="text-center">
					<label for="all_stats">Choose Month</label>
				</h3>
				<select class="form-control statBox" name="all_stats" id="all_stats"
					required>
					<option selected="selected" value="">Select month</option>
					<c:forEach var="all_stat" items="${all_results.rows }"
						varStatus="stat_row">
						<c:choose>
							<c:when
								test="${param.month== all_stat.month && param.year==all_stat.year}">
								<option selected="selected"
									value="${ all_stat.month}_${all_stat.year}">${ all_stat.month}${" "}${all_stat.year}</option>
							</c:when>
							<c:otherwise>
								<option value="${ all_stat.month}_${all_stat.year}">${ all_stat.month}${" "}${all_stat.year}</option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</select> <br>
				<div class="col-lg-4 col-lg-offset-4">
					<a
						href="${pageContext.request.contextPath}/Controller?action=stats&month=${param.month }&year=${param.year}"
						id="stat_link">
						<button class="btn btn-primary btn-block">
							<span class="fa fa-refresh"></span> Refresh
						</button>
					</a>
				</div>
			</div>
		</div>
	</div>
	<br />

	<div class="row">
		<div class="col-lg-10 col-lg-offset-1">
			<h2 class="stats_head  heading1">Crime rate for this month</h2>

			<canvas id="canvas" height="180" width="600"></canvas>
			<table>
				<tr>
					<td><div style="background-color: rgba(220, 220, 220, 0.5)"
							class="rects"></div></td>
					<td>Homocide</td>
					<td><div style="background-color: rgba(151, 187, 205, 0.5)"
							class="rects"></div></td>
					<td>Rape</td>
					<td><div style="background-color: rgba(100, 187, 100, 0.5)"
							class="rects"></div></td>
					<td>Robbery</td>
					<td><div style="background-color: rgba(80, 80, 100, 0.5)"
							class="rects"></div></td>
					<td>Vehicle Theft</td>
					<td><div style="background-color: rgba(180, 180, 100, 0.5)"
							class="rects"></div></td>
					<td>Assault</td>

				</tr>
			</table>


			<script>
				var barChartData = {
					labels : [ "Stats for ${results.rows[0].month} " ],
					datasets : [ {
						fillColor : "rgba(220,220,220,0.5)",
						strokeColor : "rgba(220,220,220,0.8)",
						highlightFill : "rgba(220,220,220,0.75)",
						highlightStroke : "rgba(220,220,220,1)",
						data : [ $('#current_homocide').val() ]
					}, {
						fillColor : "rgba(151,187,205,0.5)",
						strokeColor : "rgba(151,187,205,0.8)",
						highlightFill : "rgba(151,187,205,0.75)",
						highlightStroke : "rgba(151,187,205,1)",
						data : [ $('#current_rape').val() ]
					}, {
						fillColor : "rgba(100,187,100,0.5)",
						strokeColor : "rgba(100,187,100,0.8)",
						highlightFill : "rgba(100,187,100,0.75)",
						highlightStroke : "rgba(100,187,100,1)",
						data : [ $('#current_robbery').val() ]
					}, {
						fillColor : "rgba(80,80,100,0.6)",
						strokeColor : "rgba(80,80,100,0.8)",
						highlightFill : "rgba(80,80,100,0.75)",
						highlightStroke : "rgba(80,80,100,1)",
						data : [ $('#current_theft').val() ]
					}, {
						fillColor : "rgba(180,180,100,0.5)",
						strokeColor : "rgba(180,180,100,0.8)",
						highlightFill : "rgba(180,180,100,0.75)",
						highlightStroke : "rgba(180,180,100,1)",
						data : [ $('#current_assault').val() ]
					}

					]

				}
			</script>


		</div>

	</div>
	<!--end row-->
	<div class="row">
		<div class="col-lg-10 col-lg-offset-1">
			<h2 class="stats_head  heading1">Crime Category Percentage</h2>

			<div id="canvas-holder">
				<canvas id="chart-area"></canvas>
			</div>
			<c:set var="sum_incidents"
				value="${current_robbery+current_rape+current_homocide+current_theft+current_assault }"></c:set>
			<input type="hidden" id="sum_incidents" value="${sum_incidents }">


			<script>
				var doughnutData = [
						{
							value : (($('#current_homocide').val() / $(
									'#sum_incidents').val()) * 100).toFixed(2),
							color : "#F7464A",
							highlight : "#FF5A5E",
							label : "Homocide (%)"
						},
						{
							value : (($('#current_rape').val() / $(
									'#sum_incidents').val()) * 100).toFixed(2),
							color : "#46BFBD",
							highlight : "#5AD3D1",
							label : "Rape (%)"
						},
						{
							value : (($('#current_robbery').val() / $(
									'#sum_incidents').val()) * 100).toFixed(2),
							color : "#FDB45C",
							highlight : "#FFC870",
							label : "Robbery (%)"
						},
						{
							value : (($('#current_theft').val() / $(
									'#sum_incidents').val()) * 100).toFixed(2),
							color : "#949FB1",
							highlight : "#A8B3C5",
							label : "Vehicle Theft (%)"
						},
						{
							value : (($('#current_assault').val() / $(
									'#sum_incidents').val()) * 100).toFixed(2),
							color : "#4D5360",
							highlight : "#616774",
							label : "Assault (%)"
						}

				];
			</script>

			<table>
				<tr>
					<td><div style="background-color: #F7464A" class="rects"></div></td>
					<td>Homocide<strong>: </strong><span style="color: #F7464A">
							<script type="text/javascript">
								document.write("<strong>"
										+ (($('#current_homocide').val() / $(
												'#sum_incidents').val()) * 100)
												.toFixed(1) + "%</strong>");
							</script>
					</span>
					</td>
					<td><div style="background-color: #46BFBD" class="rects"></div></td>
					<td>Rape<strong>: </strong><span style="color: #46BFBD"><script
								type="text/javascript">
						document.write("<strong>"
								+ (($('#current_rape').val() / $(
										'#sum_incidents').val()) * 100)
										.toFixed(1) + "%</strong>");
					</script></span>
					</td>
					<td><div style="background-color: #FDB45C" class="rects"></div></td>
					<td>Robbery<strong>: </strong><span style="color: #FDB45C"><script
								type="text/javascript">
						document.write("<strong>"
								+ (($('#current_robbery').val() / $(
										'#sum_incidents').val()) * 100)
										.toFixed(1) + "%</strong>");
					</script></span>
					</td>
					<td><div style="background-color: #949FB1" class="rects"></div></td>
					<td>Vehicle Theft<strong>: </strong><span
						style="color: #949FB1"><script type="text/javascript">
							document.write("<strong>"
									+ (($('#current_theft').val() / $(
											'#sum_incidents').val()) * 100)
											.toFixed(1) + "%</strong>");
						</script></span>
					</td>
					<td><div style="background-color: #4D5360" class="rects"></div></td>
					<td>Assault<strong>: </strong><span style="color: #4D5360"><script
								type="text/javascript">
						document.write("<strong>"
								+ (($('#current_assault').val() / $(
										'#sum_incidents').val()) * 100)
										.toFixed(1) + "%</strong>");
					</script></span>
					</td>

				</tr>
			</table>


		</div>

	</div>
	<!--end row-->

	<sql:query dataSource="${ds}"
		sql="select * from crime_statistics where stat_id<=? order by stat_id desc limit 6"
		var="comp_results">
		<sql:param value="${results.rows[0].stat_id }"></sql:param>

	</sql:query>

	<div class="row">
		<div class="col-lg-10 col-lg-offset-1">
			<h2 class="stats_head  heading1">Crime Rate Comparison</h2>
			<div>
				<div>
					<canvas id="line_canvas" height="300" width="600"></canvas>
				</div>
			</div>

			<table>
				<tr>
					<td><div style="background-color: rgba(220, 220, 220, 1)"
							class="rects"></div></td>
					<td>Homocide</td>
					<td><div style="background-color: rgba(151, 187, 205, 1)"
							class="rects"></div></td>
					<td>Rape</td>
					<td><div style="background-color: rgba(100, 187, 100, 1)"
							class="rects"></div></td>
					<td>Robbery</td>
					<td><div style="background-color: rgba(80, 80, 100, 1)"
							class="rects"></div></td>
					<td>Vehicle Theft</td>
					<td><div style="background-color: rgba(180, 180, 100, 1)"
							class="rects"></div></td>
					<td>Assault</td>

				</tr>
			</table>



			<script>
				var lineChartData = {
					labels : [ "${comp_results.rows[0].month }",
							"${comp_results.rows[1].month }",
							"${comp_results.rows[2].month }",
							"${comp_results.rows[3].month }",
							"${comp_results.rows[4].month }",
							"${comp_results.rows[5].month }" ],
					datasets : [
							{
								label : "My First dataset",
								fillColor : "rgba(220,220,220,0.2)",
								strokeColor : "rgba(220,220,220,1)",
								pointColor : "rgba(220,220,220,1)",
								pointStrokeColor : "#fff",
								pointHighlightFill : "#fff",
								pointHighlightStroke : "rgba(220,220,220,1)",
								data : [ "${comp_results.rows[0].homocide }",
										"${comp_results.rows[1].homocide }",
										"${comp_results.rows[2].homocide }",
										"${comp_results.rows[3].homocide }",
										"${comp_results.rows[4].homocide }",
										"${comp_results.rows[5].homocide }" ]
							},
							{
								label : "My Second dataset",
								fillColor : "rgba(151,187,205,0.2)",
								strokeColor : "rgba(151,187,205,1)",
								pointColor : "rgba(151,187,205,1)",
								pointStrokeColor : "#fff",
								pointHighlightFill : "#fff",
								pointHighlightStroke : "rgba(151,187,205,1)",
								data : [ "${comp_results.rows[0].rape }",
										"${comp_results.rows[1].rape }",
										"${comp_results.rows[2].rape }",
										"${comp_results.rows[3].rape }",
										"${comp_results.rows[4].rape }",
										"${comp_results.rows[5].rape }" ]
							},
							{
								label : "My Third dataset",
								fillColor : "rgba(100,187,100,0.2)",
								strokeColor : "rgba(100,187,100,1)",
								pointColor : "rgba(100,187,100,1)",
								pointStrokeColor : "#fff",
								pointHighlightFill : "#fff",
								pointHighlightStroke : "rgba(100,187,100,1)",
								data : [ "${comp_results.rows[0].robbery }",
										"${comp_results.rows[1].robbery }",
										"${comp_results.rows[2].robbery }",
										"${comp_results.rows[3].robbery }",
										"${comp_results.rows[4].robbery }",
										"${comp_results.rows[5].robbery }" ]
							},
							{
								label : "My Fourth dataset",
								fillColor : "rgba(80,80,100,0.2)",
								strokeColor : "rgba(80,80,100,1)",
								pointColor : "rgba(80,80,100,1)",
								pointStrokeColor : "#fff",
								pointHighlightFill : "#fff",
								pointHighlightStroke : "rgba(80,80,100,1)",
								data : [
										"${comp_results.rows[0].vehicle_theft }",
										"${comp_results.rows[1].vehicle_theft }",
										"${comp_results.rows[2].vehicle_theft }",
										"${comp_results.rows[3].vehicle_theft }",
										"${comp_results.rows[4].vehicle_theft }",
										"${comp_results.rows[5].vehicle_theft }" ]

							},
							{
								label : "My Fifth dataset",
								fillColor : "rgba(180,180,100,0.2)",
								strokeColor : "rgba(180,180,100,1)",
								pointColor : "rgba(180,180,100,1)",
								pointStrokeColor : "#fff",
								pointHighlightFill : "#fff",
								pointHighlightStroke : "rgba(180,180,100,1)",
								data : [ "${comp_results.rows[0].assault }",
										"${comp_results.rows[1].assault }",
										"${comp_results.rows[2].assault }",
										"${comp_results.rows[3].assault }",
										"${comp_results.rows[4].assault }",
										"${comp_results.rows[5].assault }" ]

							} ]

				};

				window.onload = function() {
					var ctx2 = document.getElementById("line_canvas")
							.getContext("2d");
					window.myLine = new Chart(ctx2).Line(lineChartData, {
						responsive : true
					});
					var ctx = document.getElementById("chart-area").getContext(
							"2d");
					window.myDoughnut = new Chart(ctx).Doughnut(doughnutData, {
						responsive : true
					});
					var ctx1 = document.getElementById("canvas").getContext(
							"2d");

					window.myBar = new Chart(ctx1).Bar(barChartData, {
						responsive : true
					});

				};
			</script>
		</div>

	</div>
	<!--end row-->
</div>
<!--end container-->
</body>
<script>
	$(".stats_container").css("background-color", "white");
	$(".stats_head").css("margin-right", "560px");
	$(document)
			.ready(
					function() {

						$("#all_stats")
								.on(
										"change",
										function() {

											var str = $('option:selected', this)
													.attr('id');
											var value = $('option:selected',
													this).attr('value');

											var values = value.split('_');
											var url = '${pageContext.request.contextPath}/Controller?action=stats&month='
													+ values[0]
													+ '&year='
													+ values[1] + '';
											$('#stat_link').attr('href', url);

											//var str = this.id; 
											//    var value = this.value;

										});
					});
</script>

<c:import url="search_results_window.jsp"></c:import>
<c:import url="missing_person_window.jsp"></c:import>
<c:import url="admin_messages.jsp"></c:import>
<c:import url="footer.jsp"></c:import>