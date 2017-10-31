<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
  <body>
  <div id="map"></div>
  <script>

function initMap() {
	var lati=parseFloat("${loc_lat}");
	var longi=parseFloat("${loc_long}");
	  var myLatLng = {lat: lati, lng: longi};
	//"${results.rows[0].loc_lat}"
	//alert(lati+" "+longi);  
	var map = new google.maps.Map(document.getElementById('map'), {
	    zoom: 7,
	    center: myLatLng
	  });

	  marker = new google.maps.Marker({
          position: new google.maps.LatLng(lati, longi),
          map: map,
      });
	  
	  }


</script>
  
  
        <script async defer
        src="https://maps.googleapis.com/maps/api/js?signed_in=true&callback=initMap"></script>
  </body>
</html>