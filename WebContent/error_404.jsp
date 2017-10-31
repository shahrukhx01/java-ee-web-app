<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:import url="header.jsp">
	<c:param name="title" value="Error 404"></c:param>
</c:import>
<c:import url="slider.jsp"></c:import>
<div class="container" style="width:800px;"
	id="criminals_container">
	<div class="row">
		<h1 class="heading1 text-center">Error 404 Page Not Found!!</h1>
		<div class="col-lg-4">
			<h1 style="border: none;" class="heading1">Error 404</h1>
		</div>
		<div class="col-lg-8">
			<p>
				It seems that the page you've requested has not been found or has a
				broken link please check the requested web page again or try again
				Later!! <br /> We are extremely sorry about the inconvenience for
				not finding the requested webpage, Please Do co-operate!! We wish
				you best
			</p>
		</div>
	</div>
</div>


<c:import url="footer.jsp"></c:import>

<script>
	$(function() {
		$('.carouselBanner').carousel();
	});
	$('.img-responsive').css('width', '200px');
	$('.img-responsive').css('height', '300px');
</script>

</body>
</html>

<c:import url="search_results_window.jsp"></c:import>
<c:import url="missing_person_window.jsp"></c:import>
<c:import url="admin_messages.jsp"></c:import>


