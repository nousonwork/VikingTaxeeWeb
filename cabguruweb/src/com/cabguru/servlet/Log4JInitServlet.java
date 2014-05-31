package com.cabguru.servlet;

import java.io.File;
import java.io.InputStream;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import org.apache.log4j.BasicConfigurator;
import org.apache.log4j.PropertyConfigurator;

import com.cabguru.util.ConfigDetails;

public class Log4JInitServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void init(ServletConfig config) throws ServletException {
		System.out
				.println("init >> CabGuru Log4JInitServlet is initializing log4j");
		String log4jLocation = config
				.getInitParameter("log4j-properties-location");

		ServletContext sc = config.getServletContext();

		if (log4jLocation == null) {
			System.err
					.println("*** init >> CabGuru No log4j-properties-location init param, "
							+ "so initializing log4j with BasicConfigurator");
			BasicConfigurator.configure();
		} else {
			String webAppPath = sc.getRealPath("/");
			String log4jProp = webAppPath + log4jLocation;
			File log4jFile = new File(log4jProp);
			if (log4jFile.exists()) {
				System.out.println("initi >> CabGuru Initializing log4j with: "
						+ log4jProp);
				PropertyConfigurator.configure(log4jProp);
			} else {
				System.err.println("*** init >> CabGuru " + log4jProp
						+ " file not found, so "
						+ "initializing log4j with BasicConfigurator");
				BasicConfigurator.configure();
			}
		}
		super.init(config);

		String constantsLocation = config
				.getInitParameter("constants-properties-location");

		try {

			Properties props = new Properties();
			InputStream stream = sc.getResourceAsStream(constantsLocation);
			props.load(stream);
			stream.close();

			Iterator keyIterator = props.keySet().iterator();
			while (keyIterator.hasNext()) {
				String key = (String) keyIterator.next();
				String value = (String) props.getProperty(key);
				// System.out.println("key:" + key + " value: " + value);
				ConfigDetails.constants.put(key, value);
			}

			/*Iterator it = ConfigDetails.constants.entrySet().iterator();
			while (it.hasNext()) {
				Map.Entry pairs = (Map.Entry) it.next();
				System.out.println(pairs.getKey() + " = " + pairs.getValue());

			}*/

		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}