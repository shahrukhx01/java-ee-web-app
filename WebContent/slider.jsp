<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<header class="theme-header">
	<div class="container">
		<div class="logo-box text-left">


			<a href=""> <img src="imgs/logo.png" class="site-logo"
				alt="E Crime File">
			</a>

			<div class="name-box">
				<a href="${pageContext.request.contextPath}/Controller?action=home">
					<h1 class="site-name">E Crime File Management</h1> <span
					class="site-tagline">Eradicating Crime...</span>
				</a>
			</div>
		</div>
		<button class="site-search-toggle">
			<span class="sr-only">Toggle search</span> <i
				class="fa fa-search fa-2x"></i>
		</button>
		<button class="site-nav-toggle">
			<span class="sr-only">Toggle navigation</span> <i
				class="fa fa-bars fa-2x"></i>
		</button>
		<form role="search" class="search-form">
			<div>
				<label class="sr-only">Search for:</label> <input type="text"
					name="main_search" id="main_search" placeholder="Search...">
				<a href="#search_results" id="search_btn" data-toggle="modal"><input
					type="button"></a>
			</div>
		</form>
		<nav class="site-nav" role="navigation">
			<ul id="menu-main" class="main-nav">
				<li class="nav_links"><a
					href="${pageContext.request.contextPath}/Controller?action=home"><span>Home</span></a></li>
			<c:if test="${not empty user }">
			<li class="nav_links notifications_link" ><a 
					href="#"><span>Notifications</span></a></li>
			</c:if>
				<li class="nav_links"><a
					href="${pageContext.request.contextPath}/Controller?action=contact"><span>Contact
							</span></a></li>
				<c:if test="${not empty user }">
					<li class="nav_links"><a data-toggle="modal" href="#myModal"><span>Messages</span></a></li>
				</c:if>
				<c:if test="${empty user }">
					<li class="nav_links"><a
						href="${pageContext.request.contextPath}/Controller?action=login"><span>Login</span></a></li>
				</c:if>

				<c:if test="${not empty user }">
					<li class="nav_links"><form
							action="${pageContext.request.contextPath}/Logout" method="post">
							<i style="margin-left: 15px;"></i> <input
								style="background-color: rgba(0, 0, 0, 0); margin-top: 18px; border: none;"
								type="submit" value="Logout">
						</form></li>


				</c:if>


			</ul>
		</nav>
	</div>
</header>
<section class="homepage-slider">
	<div id="mycarousel" style="top: -123px;" class="carousel slide"
		data-interval="5000" data-ride="carousel">
		<ol class="carousel-indicators">
			<li data-target="#mycarousel" data-slide-to="0" class=""></li>
			<li data-target="#mycarousel" data-slide-to="1" class=""></li>
			<li data-target="#mycarousel" data-slide-to="2" class=""></li>
			<li data-target="#mycarousel" data-slide-to="3" class="active"></li>
		</ol>
		<div class="carousel-inner">
			<div class="item">
				<img src="imgs/slider1.jpg" alt="">

				<div class="carousel-caption">
					<h1>
						UpToDate <strong><s>Crime Statistics</s> </strong>
					</h1>
					<a class="heading btn-link" style="text-decoration: none"
						href="${pageContext.request.contextPath}/Controller?action=stats"><button
							class="btn btn-primary">View Statistics</button></a>
				</div>
			</div>
			<div class="item">
				<img src="imgs/slider2.jpg" alt="">

				<div class="carousel-caption">
					<h1>
						Report<s> Criminal Activity</s> to<strong> POLICE </strong>
					</h1>
					<a class="heading btn-link" style="text-decoration: none"
						href="${pageContext.request.contextPath}/Controller?action=complaint"><button
							class="btn btn-primary">Report Now!</button></a>
				</div>
			</div>
			<div class="item">
				<img src="imgs/slider3.jpg" alt="">

				<div class="carousel-caption">
					<h1>
						View Details of<strong> <s>Missing Persons</s>
						</strong>
					</h1>
					<a class="heading btn-link" style="text-decoration: none"
						href="${pageContext.request.contextPath}/Controller?action=missing"><button
							class="btn btn-primary">Missing Persons</button></a>
				</div>
			</div>
			<div class="item active">
				<img src="imgs/hero-unit.jpg" alt="">

				<div class="carousel-caption">
					<h1>
						View Details of<strong> <s>Wanted Criminals</s>
						</strong>
					</h1>
					<a class="heading btn-link" style="text-decoration: none"
						href="${pageContext.request.contextPath}/Controller?action=wanted"><button
							class="btn btn-primary">Wanted Criminals</button></a>
				</div>
			</div>
		</div>
		<a class="left carousel-control" href="#mycarousel" data-slide="prev">
			<span class="fa fa-angle-left"></span>
		</a> <a class="right carousel-control" href="#mycarousel"
			data-slide="next"> <span class="fa fa-angle-right"></span>
		</a>
	</div>
	
	
	<div id="notifications_menu" class="scrollbar" style="display: none;">
	<div id="contentss">
	</div>
	</div>
	
</section>
<script type="text/javascript">

$(document).ready(function () {
	
$('.notifications_link').unbind().click(function(){
	 $('#notifications_menu').fadeToggle( "fast", "swing" );
	$.post('notifications.jsp',{},function(msg){
	    msg=msg.trim(); 
		$('#contentss').html(msg);
	    });
});
	
});
</script>
