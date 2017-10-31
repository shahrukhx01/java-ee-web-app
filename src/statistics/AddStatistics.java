package statistics;

import java.io.IOException;
import java.io.PrintWriter;
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
import javax.sql.DataSource;

/**
 * Servlet implementation class AddStatistics
 */
@WebServlet("/AddStatistics")
public class AddStatistics extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DataSource ds;
	private Connection conn = null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddStatistics() {
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
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
		String month,year,homocide,rape,robbery,theft,assault,date;

		boolean isRegistered = false;

		String messageUrl = "/add_missing_person.jsp";
		RequestDispatcher dispatchMessage = request.getServletContext().getRequestDispatcher(messageUrl);
		date = request.getParameter("date");
		homocide = request.getParameter("homocide");
		rape = request.getParameter("rape");
		robbery = request.getParameter("robbery");
		theft = request.getParameter("theft");
		assault = request.getParameter("assault");
		String temp[]=date.split("-");
		year=temp[0];
		month=theMonth((Integer.parseInt(temp[1])-1));
		//out.println(bounty);
			
		try {
				String sql = "INSERT INTO `crime_statistics`( `month`, `year`, `homocide`, `rape`, `robbery`, `vehicle_theft`, `assault`) VALUES (?,?,?,?,?,?,?)";

				PreparedStatement psmt = conn.prepareStatement(sql);
			//	String today="";
				psmt.setString(1, month);
				psmt.setString(2, year);
				psmt.setString(3, homocide);
				psmt.setString(4, rape);
				psmt.setString(5, robbery);
				psmt.setString(6, theft);
				psmt.setString(7, assault);
				
				int i = psmt.executeUpdate();

				if (i == 1) {
					isRegistered = true;
					

					messageDetail = "Statistcs for the month "+month+" has been successfully added!";
					request.setAttribute("success", "success");
					request.setAttribute("messageDetail", messageDetail);
					dispatchMessage.forward(request, response);
				}
				else{
					
					isRegistered=false;
				} 
			if (isRegistered == false) {
				request.setAttribute("error", "error");
				request.setAttribute("message", message);
				request.setAttribute("messageDetail", messageDetail);
				 dispatchMessage.forward(request, response);
			}

			// try ends here
		} catch (SQLIntegrityConstraintViolationException ex) {
			// user exsts but wrong passwotd ask to CHANGE THE PASSWORD
			messageDetail = ex.getMessage();
			out.print(" nOT Success!!" + ex);
			request.setAttribute("error", "error");
			request.setAttribute("message", message);
			request.setAttribute("messageDetail", messageDetail);
			dispatchMessage.forward(request, response);
		} catch (Exception ex) {
			messageDetail = ex.getMessage();
			message = "There was a problem in registering your account please do retry again later...";
			out.print(" nOT Success!!" + ex);
			request.setAttribute("error", "error");
			request.setAttribute("message", message);
			request.setAttribute("messageDetail", messageDetail);
			dispatchMessage.forward(request, response);
			//response.sendError(404);
		}

		try {
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	public static String theMonth(int month){
	    String[] monthNames = {"january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december"};
	    return monthNames[month];
	}

}
