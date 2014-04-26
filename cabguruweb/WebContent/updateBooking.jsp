
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>ITaxi-UpdateBooking</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">

<!-- Le styles -->
<link href="./css/bootstrap.css" rel="stylesheet">
<style type="text/css">
body {
	padding-top: 60px;
	padding-bottom: 40px;
}

.sidebar-nav {
	padding: 9px 0;
}

@media ( max-width : 980px) {
	/* Enable use of floated navbar text */
	.navbar-text.pull-right {
		float: none;
		padding-left: 5px;
		padding-right: 5px;
	}
}

.addrtoggle {
	display: inline;
	margin: 10px;
	font-weight: bold;
}
</style>


<link type="text/css" rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto:300,400,500">
<script
	src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&libraries=places"></script>
<script>
// This example displays an address form, using the autocompletefrom feature
// of the Google Places API to help users fill in the information.

var placeSearch, autocompleteto, autocompletefrom;
var componentForm = {
  street_number: 'short_name',
  route: 'long_name',
  locality: 'long_name',
  administrative_area_level_1: 'short_name',
  country: 'long_name',
  postal_code: 'short_name'
};

function initializefrom() {
  // Create the autocompletefrom object, restricting the search
  // to geographical location types.
  autocompletefrom = new google.maps.places.Autocomplete(
      /** @type {HTMLInputElement} */(document.getElementById('locationFieldFromText')),
      { types: ['geocode'] });
  // When the user selects an address from the dropdown,
  // populate the address fields in the form.
  google.maps.event.addListener(autocompletefrom, 'place_changed', function() {
    fillInAddress();
  });
}

function initializeto() {
  // Create the autocompleteto object, restricting the search
  // to geographical location types.
  autocompleteto = new google.maps.places.Autocomplete(
      /** @type {HTMLInputElement} */(document.getElementById('locationFieldToText')),
      { types: ['geocode'] });
  // When the user selects an address from the dropdown,
  // populate the address fields in the form.
  google.maps.event.addListener(autocompleteto, 'place_changed', function() {
    fillInAddress();
  });
}

function initFunction(){
	initializeto();
    initializefrom();

}

// [START region_geolocation]
// Bias the autocompletefrom object to the user's geographical location,
// as supplied by the browser's 'navigator.geolocation' object.
function geolocatefrom() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var geolocation = new google.maps.LatLng(
          position.coords.latitude, position.coords.longitude);
      autocompletefrom.setBounds(new google.maps.LatLngBounds(geolocation,
          geolocation));
    });
  }
}

function geolocateto() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var geolocation = new google.maps.LatLng(
          position.coords.latitude, position.coords.longitude);
      autocompleteto.setBounds(new google.maps.LatLngBounds(geolocation,
          geolocation));
    });
  }
}
// [END region_geolocation]

    </script>
<link href="./css/bootstrap-responsive.css" rel="stylesheet">

<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
      <script src="../assets/js/html5shiv.js"></script>
    <![endif]-->

<!-- Fav and touch icons -->
<link rel="apple-touch-icon-precomposed" sizes="144x144"
	href="./ico/taxi_car.png">
<link rel="apple-touch-icon-precomposed" sizes="114x114"
	href="./ico/taxi_car.png">
<link rel="apple-touch-icon-precomposed" sizes="72x72"
	href="./ico/taxi_car.png">
<link rel="apple-touch-icon-precomposed" href="./ico/taxi_car.png">
<link rel="shortcut icon" href="./ico/taxi_car.png">

<link href="./css/bootstrap-datetimepicker.min.css" rel="stylesheet"
	media="screen">


</head>

<body>
	<%@ page import="org.json.simple.JSONObject"%>
	<%@ page import="java.util.ArrayList"%>
	<%!
public String userName = "Guest";
%>

	<%
		userName = (String) session.getAttribute("userName");
		ArrayList<JSONObject> noncompanyDrivers = com.cabguru.util.MyUtil
				.getNonCompanyDrivers(); //(ArrayList<JSONObject>)session.getAttribute("noncompanyDrivers"); 
		ArrayList<JSONObject> companyDrivers = com.cabguru.util.MyUtil
				.getCompanyDrivers(); //(ArrayList<JSONObject>)session.getAttribute("companyDrivers");
		int companyDriversCount = 0;
		int noncompanyDriversCount = 0;

		if (companyDrivers != null) {
			companyDriversCount = companyDrivers.size();
		}
		;
		if (noncompanyDrivers != null) {
			noncompanyDriversCount = noncompanyDrivers.size();
		}
		;
	%>

	<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container-fluid">
				<button type="button" class="btn btn-navbar" data-toggle="collapse"
					data-target=".nav-collapse">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="brand" href="./index.jsp"><img
					class="img-circle img-responsive text-center"
					src="./ico/taxi_car-small.png"></a>
				<div class="nav-collapse collapse">
					<p class="navbar-text pull-right">
						Logged in as <a href="#" class="navbar-link"> <%out.print(userName.toUpperCase()); %>
						</a>
					</p>

				</div>
				<!--/.nav-collapse -->
			</div>
		</div>
	</div>

	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span3">
				<div class="well sidebar-nav">
					<ul class="nav nav-list">
						<li class="nav-header">Menu</li>
						<li><a href="./adminMain.jsp">Book Taxi</a></li>
						<li><a href="./addCust.jsp">Add Customer</a></li>
						<li><a href="./searchCust.jsp">Search Customer</a></li>
						<li><a href="./compose.jsp">Notify Customers</a></li>
						<li><a href="./addDriver.jsp">Add Driver</a></li>
						<li><a href="./searchDriver.jsp">Search Driver</a></li>
						<li><a href="./notifyDrivers.jsp">Notify Drivers</a></li>
						<li><a href="./currDriversLocation.jsp">Current Drivers
								Location</a></li>
						<li class="active"><a href="./pendingBookings.jsp">Pending
								Bookings</a></li>
						<li><a href="./adminBookingHistory.jsp">Bookings History</a></li>
						<li><a href="/cabguruweb/logout">Log Out</a></li>


						<!-- <li class="nav-header">Sidebar</li>
              <li><a href="#">Link</a></li>
              <li><a href="#">Link</a></li>
              <li><a href="#">Link</a></li>
              <li><a href="#">Link</a></li>
              <li><a href="#">Link</a></li>
              <li><a href="#">Link</a></li>
              <li class="nav-header">Sidebar</li>
              <li><a href="#">Link</a></li>
              <li><a href="#">Link</a></li>
              <li><a href="#">Link</a></li> -->


					</ul>
				</div>
				<!--/.well -->
			</div>
			<!--/span-->


			<div class="span9">
				<div class="">

					<legend>Update Booking</legend>

					</br>

					<div class="area">

						<%
														String msg = (String) request.getAttribute("msg");
														if (msg != null && msg.length() > 1) {
							
															out.println("<div class=\"alert alert-error\">"
																	+ "<button class=\"close\" data-dismiss=\"alert\" "
																	+ "type=\"button\">�</button>" + "<strong>" + msg
																	+ "</strong>" + "</div>");
							
														} else {
							
														}
													%>
						<form class="form-horizontal" accept-charset="UTF-8" role="form"
							method="POST" action="/cabguruweb/mbcs">
							<div class="heading"></div>

							<input type="hidden" id="callerPage" name="callerPage"
								value="updateBooking.jsp" /> <input type="hidden"
								id="termsandconds" name="termsandconds" value="on" /> <input
								type="hidden" id="userId" name="userId"
								value="<%out.print(request.getParameter("userId")); %>" /> <input
								type="hidden" id="bookingStatusCode" name="bookingStatusCode"
								value="<%out.print(request.getParameter("bookingStatusCode")); %>" />


							<div class="control-group">
								<label class="control-label" for="inputUser">BookingId</label>

								<div class="controls">
									<input id="inputUser" placeholder="E.g. 123" type="text"
										readonly="readonly" name="bookingId"
										value="<%out.print(request.getParameter("bookingId")); %>">
								</div>
							</div>


							<div class="control-group">
								<label class="control-label" for="inputFirst">Name</label>

								<div class="controls">
									<input id="inputFirst" placeholder="E.g. Shankar" type="text"
										name="name"
										value="<%out.print(request.getParameter("name")); %>">
								</div>
							</div>


							<div class="control-group">
								<label class="control-label" for="inputUser">Mobile
									Number</label>

								<div class="controls">
									<input id="inputUser" placeholder="E.g. 9525647320" type="text"
										readonly="readonly" name="phone"
										value="<%out.print(request.getParameter("phone")); %>">
								</div>
							</div>

							<div class="control-group">
								<label class="control-label" for="inputUser">Mobile
									Operator</label>

								<div class="controls">

									<select id="mobileOperator" name="mobileOperator"
										class="input-medium">
										<option>Sprint</option>
										<option>ATnT</option>
										<option>Verizon</option>
										<option>TMobile</option>
										<option>VirginMobile</option>
										<option>BoostMobile</option>
									</select>


								</div>
							</div>


							<div class="control-group">
								<label class="control-label" for="inputLast">Booking
									Date</label>
									
									<%!
										String dateTime = "";
									
									%>
									
									<%
										String bookingTime = (String)request.getAttribute("bookingTime");
										System.out.println("Old bookingTime fetched = "+ bookingTime);
										if(bookingTime != null && bookingTime.length() > 1){
											dateTime = bookingTime;
										}else{
											dateTime = request.getParameter("datetime");
										}
									
									%>

								<div class="form-group">
											<div class="input-group date form_datetime col-md-5"
												data-date-format="dd MM yyyy - HH:ii p"
												data-link-field="dtp_input1">
												<input class="form-control" size="6" type="text"
													value="<%= com.cabguru.util.MyUtil.doConvert(dateTime) %>" name="datetime" readonly>
												<span class="input-group-addon"><span
													class="glyphicon glyphicon-remove"></span></span> <span
													class="input-group-addon"><span
													class="glyphicon glyphicon-th"></span></span>
											</div>

											<input type="hidden" id="dtp_input1" value="" />


								</div>
								
								<!-- <div class="controls">
									<input id="inputLast" placeholder="E.g. 30" type="text"
										name="datetime"
										value="">
								</div> -->
							</div>

							<div class="control-group">
								<!-- <input type="checkbox" name="checkboxes" id="checkboxes-0"
													value="1" onclick="disableFromBox()"><label class="control-label" for="checkboxes">Book
												from Favourites</label>	-->
								<input type="radio" checked="checked" name="addrradioFrom"
									id="addrUserTypedFrom" onclick="disableFromBox();"> <label
									class="addrtoggle" for="addrUserTypedFrom">Enter PickUp
									Address</label> <input type="radio" name="addrradioFrom"
									onclick="enableFromBox();" id="addrPreConfFrom"> <label
									class="addrtoggle" for="addrPreConfFrom">Select PickUp
									from Favourites</label>

							</div>

							<div class="control-group">
								<label class="control-label" for="textarea">PickUp
									Address</label>
								<div class="controls" id="locationFieldFrom">
									<input class="form-control" id="locationFieldFromText"
										onFocus="geolocatefrom()" placeholder="PickUp Address"
										name="from" type="text"
										value="<%= request.getParameter("from") %>">
								</div>
							</div>


							<div class="controls" id="fromOption" style="display: none;">
								<select id="fromOptionSelect" name="fromtemp">
											<option>Terminal 1 - 4300 Glumack Dr Minneapolis, MN</option>
											<option>Terminal 2 - 7150 Humphrey Dr, Minneapolis, MN 55450</option>
											<option>MN RST Airport - Rochester International Airport 7600 Helgerson Dr SW Rochester, MN 55902, United States</option>
								</select>
							</div>

							<div class="control-group">
								<!-- <input type="checkbox" name="checkboxes" id="checkboxes-0"
													value="1" onclick="disableFromBox()"><label class="control-label" for="checkboxes">Book
												from Favourites</label>	-->
								<input type="radio" checked="checked" name="addrradioTo"
									id="addrUserTypedTo" onclick="disableToBox();"> <label
									class="addrtoggle" for="addrUserTypedTo">Enter DropOff
									Address</label> <input type="radio" name="addrradioTo"
									onclick="enableToBox();" id="addrPreConfTo"> <label
									class="addrtoggle" for="addrUserTypedTo">Select DropOff
									from Favourites</label>

							</div>

							<div class="control-group">
								<label class="control-label" for="textarea">Drop Address</label>
								<div class="controls" id="locationFieldTo">
									<input class="form-control" id="locationFieldToText"
										onFocus="geolocateto()" placeholder="Drop Address" name="to"
										type="text" value="<%= request.getParameter("to") %>">
								</div>
							</div>



							<div class="controls" id="toOption" style="display: none;">
								<select id="toOptionSelect" name="totemp">
											<option>Terminal 1 - 4300 Glumack Dr Minneapolis, MN</option>
											<option>Terminal 2 - 7150 Humphrey Dr, Minneapolis, MN 55450</option>
											<option>MN RST Airport - Rochester International Airport 7600 Helgerson Dr SW Rochester, MN 55902, United States</option>
								</select>
							</div>

							<div class="control-group">
								<label class="control-label" for="inputFirst">Flight
									Number</label>

								<div class="controls">
									<input id="inputFirst" placeholder="Flight Number" type="text"
										name="flightNumber"
										value="<%= request.getParameter("flightNumber") %>">
								</div>
							</div>


							<div class="control-group">
								<label class="control-label" for="inputFirst">Airline</label>

								<div class="controls">
									<input id="inputFirst" placeholder="airline" type="text"
										name="airline" value="<%= request.getParameter("airline") %>">
								</div>
							</div>

							<div class="control-group">
								<label class="control-label" for="inputLast">BookingStatus</label>

								<div class="controls">
									<input id="inputLast" placeholder="E.g. 30" type="text"
										readonly="readonly" name="bookingStatus"
										value="<%out.print(request.getParameter("bookingStatus")); %>">
								</div>
							</div>

							<div class="form-group">
								<label class="addrtoggle" for="selectbasic">No. of
									Passengers</label> <select id="noOfPassengers" name="noOfPassengers"
									class="input-medium">
									<option>1</option>
									<option>2</option>
									<option>3</option>
									<option>4</option>
									<option>5</option>
								</select>

							</div>

							<div id="driverSelection">
								<div class="form-group">
									<label class="addrtoggle" for="selectbasic">Assign
										Driver</label> <input type="radio" checked="checked"
										name="addrradioDriver" id="addrradioCompany"
										onclick="showCompanyDrivers();"> <label
										class="addrtoggle" for="addrradioCompany">Company</label> <input
										type="radio" name="addrradioDriver"
										onclick="showNonCompanyDrivers();" id="addrradioNonCompany">
									<label class="addrtoggle" for="addrradioNonCompany">Non-Company</label>



								</div>
								
								<input type="hidden" name="driverId"
											value="<%=request.getParameter("driverId")%>" />	

								<input type="hidden" id="driverElemId" name="driverElem"
									value="" /> <select id="companydrivers" name="companydrivers"
									style="margin-top: 15px;"
									onchange="$('#driverElemId').val($(this).val());">
									<option>SelectDriver</option>
									<% for(int i = 0; i < companyDriversCount; i++)	{ %>
									<option
										value="<%= (String)companyDrivers.get(i).get("driverId") %>"><%=(String)companyDrivers.get(i).get("firstName")
														+(String)companyDrivers.get(i).get("lastName")+"-"+(String)companyDrivers.get(i).get("driverId") %></option>
									<%} %>
								</select> <select id="noncompanydrivers" name="companydrivers"
									style="display: none; margin-top: 15px;"
									onchange="$('#driverElemId').val($(this).val());">
									<option>SelectDriver</option>
									<% for(int i = 0; i < noncompanyDriversCount; i++)	{ %>
									<option
										value="<%= (String)noncompanyDrivers.get(i).get("driverId") %>"><%= (String)noncompanyDrivers.get(i).get("firstName")
														+(String)noncompanyDrivers.get(i).get("lastName")+"-"+(String)noncompanyDrivers.get(i).get("driverId") %></option>
									<%} %>
								</select>
								
							</div>
							
							<input type="hidden" name="successpage" value="<%=(request.getParameter("prevpage")!=null?request.getParameter("prevpage"):"pendingBookings.jsp")%>" />

							<div class="control-group">
								<div class="controls">
									<button class="btn btn-success" type="submit" name="oprType"
										value="updateBooking">Update</button>
								</div>
							</div>





						</form>
					</div>


				</div>



				<div class="row-fluid">
					<div class="span4">
						<h2></h2>
						<p></p>

					</div>
					<!--/span-->
					<div class="span4">
						<h2></h2>
						<p></p>

					</div>
					<!--/span-->
					<div class="span4">
						<h2></h2>
						<p></p>

					</div>
					<!--/span-->
				</div>
				<!--/row-->

			</div>
			<!--/span-->
		</div>
		<!--/row-->

		<hr>

		<footer>
			<p>Copyright &copy; NousOnWork 2013</p>
		</footer>

	</div>
	<!--/.fluid-container-->

	<!-- Le javascript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="./js/jquery.js"></script>
	<script src="./js/bootstrap-transition.js"></script>
	<script src="./js/bootstrap-alert.js"></script>
	<script src="./js/bootstrap-modal.js"></script>
	<script src="./js/bootstrap-dropdown.js"></script>
	<script src="./js/bootstrap-scrollspy.js"></script>
	<script src="./js/bootstrap-tab.js"></script>
	<script src="./js/bootstrap-tooltip.js"></script>
	<script src="./js/bootstrap-popover.js"></script>
	<script src="./js/bootstrap-button.js"></script>
	<script src="./js/bootstrap-collapse.js"></script>
	<script src="./js/bootstrap-carousel.js"></script>
	<script src="./js/bootstrap-typeahead.js"></script>
	<script src="./js/util.js"></script>


	<script type="text/javascript" src="./js/jquery-1.8.3.min.js"
		charset="UTF-8"></script>
	<script type="text/javascript" src="./js/bootstrap.min.js"></script>
	<script type="text/javascript" src="./js/bootstrap-datetimepicker.js"
		charset="UTF-8"></script>
	<script type="text/javascript"
		src="./js/locales/bootstrap-datetimepicker.fr.js" charset="UTF-8"></script>
	<script type="text/javascript">
	    $('.form_datetime').datetimepicker({
	        //language:  'fr',
	        weekStart: 1,
	        todayBtn:  1,
			autoclose: 1,
			todayHighlight: 1,
			startView: 2,
			forceParse: 0,
	        showMeridian: 1
	    });
		$('.form_date').datetimepicker({
	        language:  'fr',
	        weekStart: 1,
	        todayBtn:  1,
			autoclose: 1,
			todayHighlight: 1,
			startView: 2,
			minView: 2,
			forceParse: 0
	    });
		$('.form_time').datetimepicker({
	        language:  'fr',
	        weekStart: 1,
	        todayBtn:  1,
			autoclose: 1,
			todayHighlight: 1,
			startView: 1,
			minView: 0,
			maxView: 1,
			forceParse: 0
	    });
</script>
	<script>
		$( document ).ready(function() {
			initFunction();
			$('#mobileOperator').val("<%=request.getParameter("mobileOperator")%>");
			$('#noOfPassengers').val("<%=request.getParameter("noOfPassengers")%>");
		});
		</script>
</body>
</html>
