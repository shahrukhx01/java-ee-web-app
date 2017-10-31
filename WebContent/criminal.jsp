<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:if test="${ empty param.id}">
<jsp:forward page="/Controller?action=home"/>
</c:if>



<sql:setDataSource var="ds" dataSource="jdbc/e_crime" />
<div id="result_list"></div>
<sql:query dataSource="${ds}"
	sql="select * from most_wanted where criminal_id=?" var="results">
	<sql:param value="${param.id }"></sql:param>
</sql:query>
<c:import url="header.jsp">
	<c:param name="title" value="${ results.rows[0].criminal_fname}"></c:param>
</c:import>
<c:import url="slider.jsp"/>
<c:import url="process.jsp"></c:import>
<div id="content"></div>
<div class="container" id="criminals_container">
	<h1 class=" heading1">${results.rows[0].criminal_fname }
		${results.rows[0].criminal_last_name }</h1>

	<div class="row">
		<div class="col-lg-9">
		<div id="result_list"></div>
			<sql:query dataSource="${ds}"
				sql="select * from criminal_categories where criminal_id=?"
				var="cat_results">
				<sql:param value="${param.id }"></sql:param>
			</sql:query>
			<h4>
				<strong>Categories : </strong>
				<c:set var="categories" value="${criminal.criminal_category}"></c:set>

				<c:forEach var="cats" items="${cat_results.rows}">
					<span class="tags">${cats.criminal_category}</span>
				</c:forEach>
			</h4>
			<c:set var="criminal" value="${results.rows[0]}"></c:set>
			<figure>
				<figcaption class="ratings">
					<c:set var="decimal_rating"
						value="${fn:substring(criminal.criminal_rating,0,1)}"></c:set>
					<c:set var="float_rating" value="${criminal.criminal_rating*10}"></c:set>
					<h4>
						Criminal's Rating

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
			<h1>Criminal Description</h1>
			<c:set var="criminal_description" scope="page"
				value="${results.rows[0].criminal_description}"></c:set>

			<c:forEach var="description" items="${criminal_description }">
			
			${description}
			</c:forEach>

		</div>
		<!-- end column-->
		
		<div class="col-lg-3">
			<sql:query dataSource="${ds}"
				sql="select * from images where person_id=? and category=?" var="img_results">
				<sql:param value="${param.id }"></sql:param>
				<sql:param value="criminal"></sql:param>
			</sql:query>
			<c:choose>
				<c:when test="${empty img_results.rows}">
					<img class="img-rounded img-responsive BigImgBox" alt=""
						src="imgs/criminal1.PNG" />
					<a href="imgs/criminal1.PNG" data-lightbox="mugshots"
						rel="lightbox" data-title="Criminal's Mugshots"> <img
						class="img-rounded img-responsive SmallImgBox"
						src="imgs/criminal1.PNG" alt="" />
					</a>
				</c:when>
				<c:otherwise>
					<img class="img-rounded img-responsive BigImgBox" alt=""
						src="imgs/${img_results.rows[0].image_name }" />

					<div>
						<table class="mugshots">
							<tr>
								<c:forEach var="imgs" items="${img_results.rows }">
									<td><a href="imgs/${imgs.image_name}"
										data-lightbox="mugshots" rel="lightbox"
										data-title="Criminal's Mugshots"><img
											class="img-rounded img-responsive SmallImgBox"
											src="imgs/${imgs.image_name}" alt="" /></a></td>
								</c:forEach>
							</tr>
						</table>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<!-- end row-->

	<div class="row">
		<div class=" col-lg-4">
			<h1>Brief Details</h1>
			<table class="table">
				<tr class="active">
					<td>
						<h5>Age</h5>
					</td>

					<td>
						<h5>${criminal.criminal_age} years</h5>
					</td>

				</tr>
				<tr class="success">
					<td>
						<h5>Sex</h5>
					</td>
					<td>
						<h5>${criminal.criminal_sex }</h5>
					</td>
				</tr>
				<tr class="info">
					<td>
						<h5>Height</h5>

					</td>

					<td>
						<h5>${criminal.criminal_height }</h5>
					</td>
				</tr>
				<tr class="warning">
					<td>
						<h5>Last Address</h5>
					</td>

					<td>
						<h5>${criminal.criminal_last_address }</h5>
					</td>
				</tr>
				<tr class="danger">
					<td>
						<h5>Bounty</h5>
					</td>

					<td>
						<h5>${criminal.criminal_bounty } $</h5>
					</td>
				</tr>
			</table>
		</div>
	</div>
</div>
<!-- end container-->
<%-- Updating the number of views of this criminal. --%>
<c:set var="hits" value="${criminal.criminal_views+1 }"></c:set>
						<sql:update dataSource="${ds }" sql="update most_wanted set criminal_views=? where criminal_id=?">
						<sql:param value="${hits }"></sql:param>
						<sql:param value="${param.id }"/>
						</sql:update>

<c:import url="search_results_window.jsp"></c:import>
<c:import url="missing_person_window.jsp"></c:import>
<c:import url="admin_messages.jsp"></c:import>

<c:import url="footer.jsp" />
<script
	src="${pageContext.request.contextPath}/js/lightbox-plus-jquery.js"></script>
