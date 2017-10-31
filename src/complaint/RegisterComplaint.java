package complaint;

import helpers.SecureSHA1;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import user.user;

/**
 * Servlet implementation class RegisterComplaint
 */
@WebServlet("/RegisterComplaint")
public class RegisterComplaint extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DataSource ds;
	private Connection conn = null;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RegisterComplaint() {
		super();
		// TODO Auto-generated constructor stub
	}

	public void init(ServletConfig config) throws ServletException {
		try {
			InitialContext initContext = new InitialContext();

			Context env = (Context) initContext.lookup("java:comp/env");

			ds = (DataSource) env.lookup("jdbc/e_crime");

		} catch (NamingException e) {
			throw new ServletException();
		}
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
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		try {
			conn = ds.getConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return;
		}

		// use connection
		PrintWriter out = response.getWriter();

		String message, messageDetail;
		message = null;
		messageDetail = null;
		String  loc_lat,loc_long,firstname, lastname, fathername, address, cnic, mobile, home_dist, home_station, incident_date, incident_place, incident_time, incident_dist, incident_details, juridiction_station, station_visit, visit_details, visit_time, visit_date;

		boolean isRegistered = false;

		String messageUrl = "/complaint_register.jsp";
		RequestDispatcher dispatchMessage = request.getServletContext()
				.getRequestDispatcher(messageUrl);
		mobile = request.getParameter("mobile");
		cnic = request.getParameter("cnic");
		firstname = request.getParameter("fname");
		lastname = request.getParameter("lname");
		fathername = request.getParameter("ftname");
		address = request.getParameter("address");
		home_dist = request.getParameter("district");
		home_station = request.getParameter("home_station");
		incident_date = request.getParameter("idate");
		incident_place = request.getParameter("iplace");
		incident_time = request.getParameter("itime");
		incident_dist = request.getParameter("idistrict");
		juridiction_station = request.getParameter("istation");
		incident_details = request.getParameter("idescrp");
		station_visit = request.getParameter("station_visited");
		visit_details = request.getParameter("visit_details");
		visit_time = request.getParameter("vtime");
		visit_date = request.getParameter("vdate");
		loc_lat=request.getParameter("Lat");
		loc_long=request.getParameter("Lng");
		try {
			mobile = SecureSHA1.getSHA1(mobile);
			cnic = SecureSHA1.getSHA1(cnic);
		} catch (NoSuchAlgorithmException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		HttpSession userSession = request.getSession();

		user User1 = (user) userSession.getAttribute("user");
		
		try {

			if (cnic.equals(User1.getCnicNum())
					&& mobile.equals(User1.getMobileNum())) {

				String sql = "INSERT INTO `complaints`( `user_id`, `fathername`, `home_dist`, `home_station`, `incident_date`, `incident_place`, `incident_time`, `incident_dist`, `jurisdiction_station`, `incident_details`, `station_visited`, `visit_details`, `visit_time`, `visit_date`,`comp_status`,`loc_lat`,`loc_long`) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) ";

				PreparedStatement psmt = conn.prepareStatement(sql);

				String user_id = "" + User1.getUserId();
				psmt.setString(1, user_id);
				psmt.setString(2, fathername);
				psmt.setString(3, home_dist);
				psmt.setString(4, home_station);
				psmt.setString(5, incident_date);
				psmt.setString(6, incident_place);
				psmt.setString(7, incident_time);
				psmt.setString(8, incident_dist);
				psmt.setString(9, juridiction_station);
				psmt.setString(10, incident_details);
				psmt.setString(11, station_visit);
				psmt.setString(12, visit_details);
				psmt.setString(13, visit_time);
				psmt.setString(14, visit_date);
				psmt.setString(15, "pending");
				psmt.setString(16, loc_lat);
				psmt.setString(17, loc_long);

				
				int i = psmt.executeUpdate();

				if (i == 1) {
					isRegistered = true;
					messageDetail = "Complaint successfully registered. You'll soon receive a response from us.";
					request.setAttribute("success", "success");
					request.setAttribute("messageDetail", messageDetail);
					dispatchMessage.forward(request, response);
				}
				else{
					
					isRegistered=false;
				}

			} else {
				isRegistered = false;
				if (!cnic.equals(User1.getCnicNum())) {

					messageDetail = "Please provide the  cnic card number associated with your account";

				} else if (!mobile.equals(User1.getMobileNum())) {
					messageDetail = "Please provide the mobile number associated with your account";
				}

			}

			if (isRegistered == false) {
				request.setAttribute("fname", firstname);
				request.setAttribute("lname", lastname);
				request.setAttribute("cnic", cnic);
				request.setAttribute("mobile", mobile);
				request.setAttribute("address", address);
				request.setAttribute("ftname", fathername);
				request.setAttribute("address", address);
				request.setAttribute("idate", incident_date);
				request.setAttribute("iplace", incident_place);
				request.setAttribute("itime", incident_time);
				request.setAttribute("idescrp", incident_details);
				request.setAttribute("vdetails", visit_details);
				request.setAttribute("vtime", visit_time);
				request.setAttribute("vdate", visit_date);
				request.setAttribute("error", "error");
				request.setAttribute("message", message);
				request.setAttribute("messageDetail", messageDetail);
				 dispatchMessage.forward(request, response);
			}

			// try ends here
		} catch (SQLIntegrityConstraintViolationException ex) {
			// user exsts but wrong passwotd ask to CHANGE THE PASSWORD
			messageDetail = ex.getMessage();
			message = "You have been registered earlier please try your right password again, else change your password...";
			out.print(" nOT Success!!" + ex);
			request.setAttribute("fname", firstname);
			request.setAttribute("lname", lastname);
			request.setAttribute("cnic", cnic);
			request.setAttribute("mobile", mobile);
			request.setAttribute("address", address);
			request.setAttribute("ftname", fathername);
			request.setAttribute("address", address);
			request.setAttribute("idate", incident_date);
			request.setAttribute("iplace", incident_place);
			request.setAttribute("itime", incident_time);
			request.setAttribute("idescrp", incident_details);
			request.setAttribute("vdetails", visit_details);
			request.setAttribute("vtime", visit_time);
			request.setAttribute("vdate", visit_date);
			request.setAttribute("error", "error");
			request.setAttribute("message", message);
			request.setAttribute("messageDetail", messageDetail);
			dispatchMessage.forward(request, response);
		} catch (Exception ex) {
			messageDetail = ex.getMessage();
			message = "There was a problem in registering your account please do retry again later...";
			out.print(" nOT Success!!" + ex);
			request.setAttribute("fname", firstname);
			request.setAttribute("lname", lastname);
			request.setAttribute("cnic", cnic);
			request.setAttribute("mobile", mobile);
			request.setAttribute("address", address);
			request.setAttribute("ftname", fathername);
			request.setAttribute("address", address);
			request.setAttribute("idate", incident_date);
			request.setAttribute("iplace", incident_place);
			request.setAttribute("itime", incident_time);
			request.setAttribute("idescrp", incident_details);
			request.setAttribute("vdetails", visit_details);
			request.setAttribute("vtime", visit_time);
			request.setAttribute("vdate", visit_date);
			request.setAttribute("error", "error");
			request.setAttribute("message", message);
			request.setAttribute("messageDetail", messageDetail);
			dispatchMessage.forward(request, response);
			response.sendError(404);
		}

		try {
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
