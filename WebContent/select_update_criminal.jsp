<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:import url="header.jsp">
	<c:param name="title" value="E Crime File Management System"></c:param>
</c:import>

<sql:setDataSource var="ds" dataSource="jdbc/e_crime" />
<c:import url="admin_header.jsp"></c:import>
<sql:query dataSource="${ds}" sql="select * from most_wanted "
	var="results" />


<c:set var="resultslen" value="${fn:length(results.rows) }"></c:set>
<div class="container">
	<div class="row">
		<div class="col-lg-3">
			<!-- Left column -->
			<a href="#"><strong><i
					class="glyphicon glyphicon-wrench"></i> Tools</strong></a>

			<hr>

			<c:import url="admin_sidebar.jsp"></c:import>
			<hr>

		</div>
		<div class="col-lg-9">
			<c:import url="admin_nav.jsp"></c:import>
			<c:if test="${not empty success }">
				<div class="alert alert-success fade in">
					<a href="#" class="close" data-dismiss="alert">&times;</a>
					<h4>${messageDetail }</h4>
				</div>

			</c:if>

			<!-- Most Viewed Criminals-->
			<c:set var="i" value="0"></c:set>
			<c:forEach var="criminal" items="${results.rows}" varStatus="row">

				<c:if test="${row.first }">
					<c:choose>

						<c:when test="${not empty success }">
							<div class="alert alert-success fade in">
								<a href="#" class="close" data-dismiss="alert">&times;</a>
								<h4>${messageDetail }</h4>
							</div>

						</c:when>
					</c:choose>

					<c:out
						value="<div style='margin-top:40px;' class='container' id='criminals_container'> <h1 class='text-center heading1'>Update Most Wanted Criminals</h1>"
						escapeXml="false"></c:out>

				</c:if>
				<c:if test="${i%3==0 }">
					<c:out escapeXml="false" value="<div class='row'>"></c:out>
				</c:if>
				<div class=" col-lg-3 criminal">
					<div class="well profile">
						<div class="col-sm-12">
							<!-- personal info-->
							<div class="col-xs-12 col-sm-12">
								<h3>${criminal.criminal_fname}
									${criminal.criminal_last_name}</h3>
							</div>
							<!-- end personal info-->
							<div class="col-xs-12 col-sm-12 text-center">
								<figure>
									<sql:query dataSource="${ds}"
										sql="select * from images where person_id=? and category=?   "
										var="img_results">
										<sql:param value="${(criminal.criminal_id) }"></sql:param>
										<sql:param value="criminal"></sql:param>
									</sql:query>
									<c:choose>
										<c:when test="${empty img_results.rows[0]}">
											<c:set var="image_name" value="criminal1.PNG" />
										</c:when>
										<c:otherwise>
											<c:set var="image_name"
												value="${img_results.rows[0].image_name }"></c:set>

										</c:otherwise>
									</c:choose>
									<img src="imgs/${image_name }" alt="Most Viewed Criminals"
										class="user img-circle img-responsive" style="height:230px;">
									<figcaption class="ratings">
										<c:set var="decimal_rating"
											value="${fn:substring(criminal.criminal_rating,0,1)}"></c:set>
										<c:set var="float_rating"
											value="${criminal.criminal_rating*10}"></c:set>
										<h4>
											Criminal Rating <br />
											<%--Rating stars before decimal point --%>
											<c:forEach begin="1" end="${decimal_rating}">
												<a> <span class="fa fa-star fa-2x"></span>
												</a>
											</c:forEach>
											<c:choose>
												<c:when test="${float_rating%10 ==5 }">
													<a> <span class="fa fa-star-half-o fa-2x"></span>
													</a>
												</c:when>

												<c:when test="${decimal_rating!=5}">
													<a> <span class="fa fa-star-o fa-2x"></span>
													</a>
													<c:forEach begin="1" end="${4-(decimal_rating)}">
														<a> <span class="fa fa-star-o fa-2x"></span>
														</a>
													</c:forEach>

												</c:when>
											</c:choose>
										</h4>
									</figcaption>
								</figure>
								<sql:query dataSource="${ds}"
									sql="select * from criminal_categories where criminal_id=?"
									var="cat_results">
									<sql:param value="${criminal.criminal_id }"></sql:param>
								</sql:query>
								<p class="text-center">
									<strong>Categories</strong><br />
									<c:set var="categories" value="${criminal.criminal_category}"></c:set>

									<c:forEach var="cats" items="${cat_results.rows}">
										<span class="tags">${cats.criminal_category}</span>
									</c:forEach>
								</p>
							</div>
							<!-- end rating area-->
						</div>
						<div class="col-xs-12 divider text-center">
							<div class="col-xs-12 col-sm-12 emphasis">
								<h2>
									<strong>${criminal.criminal_views}</strong>
								</h2>
								<h4>
									<small>Profile Views</small>
								</h4>
								<a
									href="${pageContext.request.contextPath}/Admin_controller?action=update_criminal&id=${criminal.criminal_id }">
									<button class="btn btn-primary btn-block">
										<span class="fa fa-pencil-square-o "></span> Update Criminal
									</button>
								</a>
							</div>
						</div>
						<!-- end divider-->
					</div>
					<!-- end profile-->
				</div>
				<!-- end column-->
				<c:if test="${(i+1) %3==0 }">
					<c:out escapeXml="false" value="</div>"></c:out>
				</c:if>

				<c:set var="i" value="${i+1 }"></c:set>
				<c:if test="${i== resultslen  }">
					<c:out value="</div></div>" escapeXml="false">

					</c:out>
				</c:if>

			</c:forEach>
		</div>
	</div>
</div>

</body>
</html>

<script type="text/javascript">
	$('#criminals_container').css('width', '950px');
	$('.well').css('width', '255px');
	$('.criminal').css('margin-right', '35px');
	$('.criminal').css('margin-left', '20px');
	$('.btn-block').css('width', '105%');
	$('#upcrim').css('background-color', '#fb2');
</script>



