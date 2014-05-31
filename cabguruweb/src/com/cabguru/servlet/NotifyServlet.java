package com.cabguru.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.cabguru.util.ConfigDetails;
import com.cabguru.util.HTTPConnectionManager;

/**
 * Servlet implementation class ForgotpasswordServlet
 */
public class NotifyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final Logger log = Logger
			.getLogger(com.cabguru.servlet.NotifyServlet.class
					.getName());

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public NotifyServlet() {
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

		String subject = request.getParameter("subject");
		String body = request.getParameter("messagebody");
		String recepientType = request.getParameter("recepienttype");
		String callerPage = request.getParameter("callerPage");
		String driverList = request.getParameter("driverlist");

		log.debug("doPost >> messagebody = " + body);
		log.debug("doPost >> subject = " + subject);
		log.debug("doPost >> driverList = " + driverList);

		response.setContentType("text/html");

		try {

			if( subject == null || subject.trim().length() < 1 ){

				dispatch(request, response, callerPage,
						"Please enter a subject.");
			}
			else if (body == null || body.trim().length() < 1) {
				dispatch(request, response, callerPage, "Please enter a message.");			
			} 
			else {

				JSONObject notifyJson = new JSONObject();
				notifyJson.put("subject", subject.trim());
				notifyJson.put("body", body.trim());

				JSONArray recepients = new JSONArray();  
				
				String responseData = "";

				if(recepientType!=null && recepientType.equals("driver")){
					String[] driverIds = driverList.split(",");
					int noOfDrivers = driverIds.length;
					for (int i = 0; i < noOfDrivers; i++) {
						recepients.add(driverIds[i]);  
					}
					notifyJson.put("drivers", recepients);
					
					responseData = HTTPConnectionManager.sendPost("http://"
							+ ConfigDetails.constants.get("CABGURU_SERVER_IP_PORT")
							+ "/cabserver/admin/notify/drivers",
							notifyJson.toString());
				}
				else if(recepientType!=null && recepientType.equals("user")){
					recepients.add("ALL");
					notifyJson.put("users", recepients);
					
					responseData = HTTPConnectionManager.sendPost("http://"
							+ ConfigDetails.constants.get("CABGURU_SERVER_IP_PORT")
							+ "/cabserver/admin/notify/customers",
							notifyJson.toString());
				}
				

				if (responseData != null) {

					JSONParser parser = new JSONParser();
					JSONObject obj = (JSONObject) parser.parse(responseData);

					String code = (String) obj.get("code");
					String msg = (String) obj.get("msg");

					if (code.equalsIgnoreCase("200")) {

						log.debug("doPost >> Notification Sent.");

						request.setAttribute("msg", msg);
						RequestDispatcher rd = request
								.getRequestDispatcher(callerPage);
						rd.forward(request, response);

					} else {

						log.debug("doPost >> Notification Error. Please try again.");
						dispatch(request, response, callerPage, msg);
					}

				}

			}

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
