<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:import url="header.jsp">
	<c:param name="title" value="E Crime File Management System"></c:param>
</c:import>
<c:if test="${empty admin }">
	<c:redirect url="/admin_login.jsp"></c:redirect>
</c:if>

<sql:setDataSource var="ds" dataSource="jdbc/e_crime" />
<c:import url="admin_header.jsp"></c:import>
<sql:query dataSource="${ds}" sql="select * from most_wanted "
	var="results" />


<c:set var="resultslen" value="${fn:length(results.rows) }"></c:set>
<div class="container">
	<div class="row">
		<div class="col-sm-10 col-lg-offset-1">
					<c:import url="admin_nav.jsp"></c:import>
			<br> <br>
			<c:choose>
				<c:when test="${not empty error }">
					<br>
					<br>
					<div class="alert alert-danger fade in">
						<a href="#" class="close" data-dismiss="alert">&times;</a>
						<h4>${messageDetail }</h4>
					</div>
				</c:when>
				<c:when test="${not empty success }">
					<br>
					<br>
					<div class="alert alert-success fade in">
						<a href="#" class="close" data-dismiss="alert">&times;</a>
						<h4>${messageDetail }</h4>
					</div>
				</c:when>
			</c:choose>

			<!-- Most Viewed Criminals-->
			<c:set var="i" value="0"></c:set>
			<c:forEach var="criminal" items="${results.rows}" varStatus="row">

				<c:if test="${row.first }">
					<c:out
						value="<div  class='container' id='criminals_container'> <h1 class='text-center heading1'>Most Wanted Criminals</h1><div class='col-lg-4 col-lg-offset-7'><a  href='${pageContext.request.contextPath}/Admin_controller?action=addCriminal'><button class='btn btn-primary btn-block img_link'><span class='fa fa-plus'></span> Add Criminal</button></a></div> "
						escapeXml="false"></c:out>

				</c:if>
				<c:if test="${i%2==0 }">
					<c:out escapeXml="false" value="<div class='row'>"></c:out>
				</c:if>
				<div class=" col-lg-5 criminal">
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
											<c:set var="imgslen" value="1"></c:set>
										</c:when>
										<c:otherwise>
											<c:set var="imgslen"
												value="${(fn:length(img_results.rows))+1 }"></c:set>
											<c:set var="image_name"
												value="${img_results.rows[0].image_name }"></c:set>

										</c:otherwise>
									</c:choose>
									<img src="imgs/${image_name }" alt="Most Viewed Criminals"
										class="user img-circle img-responsive">
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

							</div>
						</div>
						<!-- end divider-->
						<div class="col-xs-6 col-sm-6 btn_ctn">
							<a data-toggle="modal" href="#addCat"> <span
								class=" cat_link" id="${criminal.criminal_id }"> <span
									class="fa fa-plus "></span> Add Category
							</span>
							</a>
						</div>
						<div class="col-xs-6 col-sm-6 btn_ctn">
							<a data-toggle="modal" href="#addImg"> <span
								class=" img_link"
								id="${imgslen} ${'_' } ${criminal.criminal_id }"> <span
									class="fa fa-camera"></span> Add Image
							</span>
							</a>
						</div>

						<div class="col-xs-6 col-sm-6 btn_ctn ">
							<a
								href="${pageContext.request.contextPath}/DeleteCriminal?id=${criminal.criminal_id }">
								<span>&nbsp; <span class="fa fa-times"></span> Delete Criminal
							</span>
							</a>
						</div>
						<div class="col-xs-6 col-sm-6 btn_ctn">
							<a href="${pageContext.request.contextPath}/Admin_controller?action=update_criminal&id=${criminal.criminal_id }">  
							&nbsp;<span class="fa fa-pencil"></span> Update Info
							</a>
						</div>

					</div>
					<!-- end profile-->
				</div>
				<!-- end column-->
				<c:if test="${(i+1) %2==0 }">
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
	$('#criminals_container').css('width', '870px');
	$('.btn_ctn').css('padding', '0px');
//	$('.btn_ctn').css('padding-left', '9px');
	$('.criminal').css('margin-right', '35px');
	$('.criminal').css('margin-left', '20px');
	$('.btn-block').css('width', '105%');
	$('.img-responsive').css('width', '200px');
	$('.img-responsive').css('height', '300px');
</script>


<c:import url="add_criminal_category.jsp"></c:import>
<c:import url="upload_image.jsp"></c:import>