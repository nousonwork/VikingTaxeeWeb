package com.cabguru.servlet;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.cabguru.util.ConfigDetails;
import com.cabguru.util.HTTPConnectionManager;
import com.cabguru.util.MyUtil;

/**
 * Servlet implementation class ManualBookingConfirmationServlet
 */
public class ManualBookingConfirmationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	static final Logger log = Logger
			.getLogger(com.cabguru.servlet.ManualBookingConfirmationServlet.class
					.getName());

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ManualBookingConfirmationServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		String bookingId = request.getParameter("bookingId");
		String userId = request.getParameter("userId");
		String bookingStatus = request.getParameter("bookingStatus");
		String bookingStatusCode = request.getParameter("bookingStatusCode");
		String driverId = request.getParameter("driverElem");
		if(driverId == null || driverId.equalsIgnoreCase("")){
			driverId = request.getParameter("driverId");			
			log.debug("doPost >> driverElem was null so taking value from  driverId = " + driverId);
		}else{
			log.debug("doPost >> driverElem  = " + driverId);
		}
		
		String oprType = request.getParameter("oprType");
		String datetime = request.getParameter("datetime");
		/*for update booking*/
		String noOfPassengers = request.getParameter("noOfPassengers");
		//log.debug("doPost >> noOfPassengers = " + noOfPassengers);
		String mobileOperator = request.getParameter("mobileOperator");
		//log.debug("doPost >> mobileOperator = " + mobileOperator);
		String airline = request.getParameter("airline");
		//log.debug("doPost >> airline = " + airline);
		String flightNumber = request.getParameter("flightNumber");
		//log.debug("doPost >> flightNumber = " + flightNumber);
		String successPage = request.getParameter("successpage");
		/*for update booking*/
		
		String callerPage = request.getParameter("callerPage");

		//log.debug("doPost >> bookingId = " + bookingId);
		// log.debug("doPost >> userId = " + userId);
		// log.debug("doPost >> bookingStatus = " + bookingStatus);
		// log.debug("doPost >> bookingStatusCode = " + bookingStatusCode);
		// log.debug("doPost >> callerPage = " + callerPage);
		//log.debug("doPost >> driverId = " + driverId);
		//log.debug("doPost >> oprType = " + oprType);

		try {

			JSONObject signupJson = new JSONObject();
			signupJson.put("bookingId", bookingId);
			signupJson.put("userId", userId);
			signupJson.put("bookingStatus", bookingStatus);
			signupJson.put("bookingStatusCode", bookingStatusCode);
			signupJson.put("driverId", driverId != null ? driverId : "0");
			String responseData = "";
			if (oprType.equalsIgnoreCase("deleteDriver")
					|| oprType.equalsIgnoreCase("cancelBooking")) {

				responseData = HTTPConnectionManager
						.sendPost(
								"http://"
										+ ConfigDetails.constants.get("CABGURU_SERVER_IP_PORT")
										+ "/cabserver/admin/bookings/delete-driver-cancel-booking",
								signupJson.toString());

				//log.debug("doPost >> responseData=" + responseData);
				if (responseData != null) {

					JSONParser parser = new JSONParser();
					JSONObject obj = (JSONObject) parser.parse(responseData);

					String code = (String) obj.get("code");
					String msg = (String) obj.get("msg");

					// log.debug("doPost >> code"+code);

					if (code.equalsIgnoreCase("200")) {

						dispatch(request, response, "/abhs",
								"Manual Booking Updated.");
						// dispatch(request, response, callerPage,
						// "Manual Booking Updated.");
					} else {
						dispatch(request, response, callerPage, msg);
					}
				}
			} else if (oprType.equalsIgnoreCase("updateBookingPageForward")) {
				dispatch(request, response, "/updateBooking.jsp",
						"");

			} else if (oprType.equalsIgnoreCase("updateBooking")) {

				String name = request.getParameter("name");
				String from = request.getParameter("from");
				String to = request.getParameter("to");	
				String phone = request.getParameter("phone");	

				HashMap<String, String> dateComponents = MyUtil
						.getDateComponents(datetime);
				
				//log.debug("doPost >> name = " + name);
				//log.debug("doPost >> from = " + from);
				//log.debug("doPost >> to = " + to);
				//log.debug("doPost >>> datetime = " + datetime);
				

				signupJson.put("userId", userId);
				signupJson.put("phone", phone);
				signupJson.put("bookingId", bookingId);
				signupJson.put("bookingStatus", bookingStatus);
				signupJson.put("bookingStatusCode", bookingStatusCode);
				signupJson.put("driverId", driverId != null ? driverId : "0");				
				signupJson.put("name", name);
				signupJson.put("from", from);
				signupJson.put("to", to);
				signupJson.put("date", dateComponents.get("date"));
				signupJson.put("month", dateComponents.get("month"));
				signupJson.put("year", dateComponents.get("year"));
				signupJson.put("hour", dateComponents.get("hour"));
				signupJson.put("min", dateComponents.get("min"));
				signupJson.put("ampm", dateComponents.get("ampm"));
				signupJson.put("noOfPassengers", noOfPassengers != null ? noOfPassengers.trim(): "1");
				signupJson.put("mobileOperator", mobileOperator.trim());
				signupJson.put("airline", airline != null ? airline.trim(): "");
				signupJson.put("flightNumber", flightNumber != null ? flightNumber.trim(): "");

				responseData = HTTPConnectionManager.sendPost("http://"
						+ ConfigDetails.constants.get("CABGURU_SERVER_IP_PORT")
						+ "/cabserver/admin/bookings/update-booking-data",
						signupJson.toString());

				//log.debug("doPost >> responseData=" + responseData);
				if (responseData != null) {

					JSONParser parser = new JSONParser();
					JSONObject obj = (JSONObject) parser.parse(responseData);

					String code = (String) obj.get("code");
					String msg = (String) obj.get("msg");
					String bookingTime = (String) obj.get("bookingTime");

					//log.debug("doPost >> code" + code);

					if (code.equalsIgnoreCase("200")) {

						dispatch(request, response, "/"+successPage,
								"Booking Data Updated.");

					} else {
						if(bookingTime != null){
							request.setAttribute("bookingTime", bookingTime);
						}
						dispatch(request, response, callerPage, msg);
					}
				}

			}

		} catch (ParseException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	private void dispatch(HttpServletRequest request,
			HttpServletResponse response, String callerPage, String msg) {

		try {
			request.setAttribute("msg", msg);
			RequestDispatcher rd = request.getRequestDispatcher(callerPage);
			rd.forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

}
