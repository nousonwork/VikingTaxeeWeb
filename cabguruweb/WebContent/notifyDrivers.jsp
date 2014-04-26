
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
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

.next{
	float:right;
	margin-right:20px;
}

</style>
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

	<%!
public String userName = "Guest";
%>

	<%
  userName = (String)session.getAttribute("userName");  
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
						Logged in as <a href="#" class="navbar-link">
							<%out.print(userName.toUpperCase()); %>
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
						<li><a href="./searchDriver.jsp">Search
								Driver</a></li>
						<li class="active"><a href="./notifyDrivers.jsp">Notify Drivers</a></li>
						<li><a href="./currDriversLocation.jsp">Current Drivers
								Location</a></li>
						<li><a href="./pendingBookings.jsp">Pending Bookings</a></li>
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

			<%!
public org.json.simple.JSONArray bookingsArry = null;
public org.json.simple.JSONArray delDriverArry = null;
String delDriverMessage = null;
%>
			<%

String phone = request.getParameter("contactNo");
String name = request.getParameter("name");
String licNumber = request.getParameter("licenceNo");
String driverId = request.getParameter("drvrId");

System.out.println("phone = " + phone);
System.out.println("name = " + name);
System.out.println("licNumber = " + licNumber);
System.out.println("driverId = " + driverId);

if(phone == null || phone.length() < 1
|| name == null || name.length() < 1
|| licNumber == null || licNumber.length() < 1){
	phone = "";
	name = "";
	licNumber = "";
}else{
	
	if(phone == null || phone.length() < 1){
		phone = " ";
	}
	if(name == null || name.length() < 1){
		name = " ";
	}
	if(licNumber == null || licNumber.length() < 1){
		licNumber = " ";
	}
}

try {	
	if(driverId!=null){
		org.json.simple.JSONObject delDriverJson = new org.json.simple.JSONObject();
		delDriverJson.put("driverId", driverId);
		String delDriverData = com.cabguru.util.HTTPConnectionManager.sendPost("http://"
				+ com.cabguru.util.Constants.CABGURU_SERVER_IP_PORT
				+ "/cabserver/drivers/delete",delDriverJson.toJSONString());
		org.json.simple.parser.JSONParser deleDriverParser = new org.json.simple.parser.JSONParser();
		org.json.simple.JSONObject delDriverMsg = (org.json.simple.JSONObject) deleDriverParser.parse(delDriverData);
		delDriverMessage = (String) delDriverMsg.get("msg");
	}
	org.json.simple.JSONObject signupJson = new org.json.simple.JSONObject();
	signupJson.put("phone", phone);
	signupJson.put("name", name);
	signupJson.put("licNumber", licNumber);

	String responseData = com.cabguru.util.HTTPConnectionManager.sendPost("http://"
			+ com.cabguru.util.Constants.CABGURU_SERVER_IP_PORT
			+ "/cabserver/admin/drivers/list",signupJson.toJSONString());
	if (responseData != null) {

		org.json.simple.parser.JSONParser parser = new org.json.simple.parser.JSONParser();
		bookingsArry = (org.json.simple.JSONArray) parser.parse(responseData);		
	}
	
}catch(Exception e ){
	e.printStackTrace();
}



%>



			<div class="span9">

				<div class="row">
					<div class="span12">


						<%
							org.json.simple.JSONObject objMsg = (org.json.simple.JSONObject) bookingsArry
									.get(0);
							String bookingMessage = (String) objMsg.get("msg");
							
							if (delDriverMessage != null) {

								out.println("<div class=\"alert alert-error\">"
										+ "<button class=\"close\" data-dismiss=\"alert\" "
										+ "type=\"button\">×</button>" + "<strong>"
										+ delDriverMessage + "</strong>" + "</div>");
								delDriverMessage = null;

							}
							else if (bookingMessage != null) {

								out.println("<div class=\"alert alert-error\">"
										+ "<button class=\"close\" data-dismiss=\"alert\" "
										+ "type=\"button\">×</button>" + "<strong>"
										+ bookingMessage + "</strong>" + "</div>");

							} else {

							}
						%>

<form class="form-horizontal"
									name="notify" id="notifyfrm"
									accept-charset="UTF-8"  method="POST"
									action="/cabguruweb/compose.jsp" onsubmit="return false;">

						<table class="table table-striped table-condensed">
							<thead>
								<tr>
								    <th><input type="checkbox" name="Check_ctr" value="yes" onClick="checkAll(document.notify.link, this)">Check All</th>
									<th>DriverId</th>
									<th>First Name</th>
									<th>Last Name</th>
									<th>Mobile Number</th>
									<th>Age</th>
									<th>Gender</th>
									<th>License Number</th>
									<th>Permanent Address</th>
									<th>Current Location</th>
									<th>DriverStatus</th>
									<th></th>
								</tr>
							</thead>
							<tbody>


								<%
              					for(int i =0; i < bookingsArry.size(); i++){ 
              		
              					org.json.simple.JSONObject obj = (org.json.simple.JSONObject)bookingsArry.get(i);
              					
              					if(((String) obj.get("driverId")) != null){
              	
              					%>

									<tr>
										<td>
										<input type="checkbox" name="link" id="link<%=i %>" value="something.com">
										</td>
										<td>
											<% out.print((String) obj.get("driverId"));%>
										</td>
										<td>
											<% out.print((String) obj.get("firstName"));%>
										</td>
										<td>
											<% out.print((String) obj.get("lastName"));%>
										</td>
										<td>
											<% out.print((String) obj.get("phone"));%>
										</td>
										<td>
											<% out.print((String) obj.get("age"));%>
										</td>
										<td>
											<% out.print((String) obj.get("sex"));%>
										</td>
										<td>
											<% out.print((String) obj.get("licNumber"));%>
										</td>
										<td>
											<% out.print((String) obj.get("address"));%>
										</td>
										<td>
											<% out.print((String) obj.get("currAddress"));%>
										</td>
										<td>
											<% out.print((String) obj.get("driverStatus"));%>
										</td>

									</tr>
								

								<%
				                  }
              					}
				                %>


							
							</tbody>
						</table>
						<input type="hidden" name="recepienttype" id="recepienttype" value="driver" />
						<input type="hidden" name="driverlist" id="driverlist" value="" />
						<button class="btn btn-success updateButton next"
												type="submit" name="oprType" onclick="prepareDriverList(document.notify.link,this.form);" value="compose">Next</button>
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

	<script type="text/javascript" src="./js/bootstrap.min.js"></script>
	<script type="text/javascript" src="./js/bootstrap-datetimepicker.js"
		charset="UTF-8"></script>
	
</body>
</html>
