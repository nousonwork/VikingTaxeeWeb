
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>ITaxi--SearchCustomer</title>
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

.form-horizontal input,.form-horizontal textarea{
		width:300px;
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
						<li><a href="./searchCust.jsp">Search
								Customer</a></li>
						<li id="notifycust"><a href="./compose.jsp">Notify Customers</a></li>
						<li><a href="./addDriver.jsp">Add Driver</a></li>
						<li><a href="./searchDriver.jsp">Search Driver</a></li>
						<li id="notifydrv" class="active"><a href="./notifyDrivers.jsp">Notify Drivers</a></li>
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

			<div class="span9">
				<div class="">


					<form class="form-horizontal" accept-charset="UTF-8" role="form"
						method="POST" action="/cabguruweb/ns">


						<!-- Form Name -->
						<legend>Send Notification</legend>
	<%
							String msg = (String) request.getAttribute("msg");
							if (msg != null) {

								out.println("<div class=\"alert alert-error\">"
										+ "<button class=\"close\" data-dismiss=\"alert\" "
										+ "type=\"button\">�</button>" + "<strong>"
										+ msg + "</strong>" + "</div>");

							} else {

							}
						%>

						<!-- Search input-->
						
						<div class="control-group">
							<label class="control-label" for="subject">Subject</label>
							<div class="controls">
								<input id="subject" name="subject" type="text" placeholder=""
									class="input-medium search-query">
							</div>
						</div>

						<div class="control-group">
							<label class="control-label" for="messagebody">Your Message</label>
							<div class="controls">
									<textarea id="messagebody" name="messagebody" placeholder="" class="input-medium search-query"></textarea>
							</div>
						</div>

						<input type="hidden" name="recepienttype" id="recepienttype" value="<%=(request.getParameter("recepienttype")!=null?request.getParameter("recepienttype"):"user")%>" />
						<input type="hidden" id="callerPage" name="callerPage"	value="compose.jsp" />
						<input type="hidden" name="driverlist" value="<%= request.getParameter("driverlist") %>" />

						<div class="control-group">
							<label class="control-label" for="name"></label>
							<div class="controls">
								<button class="btn btn-success" type="submit">Send</button>
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


	<script type="text/javascript" src="./js/bootstrap.min.js"></script>
	<script>
		$( document ).ready(function() {
			if( $("#recepienttype").val()=="user" ){
				 $("#notifycust").addClass("active");
				 $("#notifydrv").removeClass("active");
			}
			else if(  $("#recepienttype").val()=="driver" ){
				 $("#notifydv").addClass("active");
				 $("#notifycust").removeClass("active");
			}
		});
	</script>
	
</body>
</html>
