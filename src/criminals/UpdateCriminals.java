package criminals;



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
 * Servlet implementation class UpdateCriminals
 */
@WebServlet("/UpdateCriminals")
public class UpdateCriminals extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DataSource ds;
	private Connection conn = null;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateCriminals() {
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
		String id,fname,lname,sex,age,inches,feet,address,arrest,bounty,rating,descrp,height;

		boolean isRegistered = false;

		String messageUrl = "/admin_view_wanted_criminals.jsp";
		RequestDispatcher dispatchMessage = request.getServletContext().getRequestDispatcher(messageUrl);
		fname = request.getParameter("fname");
		lname = request.getParameter("lname");
		sex = request.getParameter("sex");
		age = request.getParameter("age");
		inches = request.getParameter("inches");
		feet = request.getParameter("feet");
		address = request.getParameter("address");
		arrest = request.getParameter("arrested");
		bounty = request.getParameter("bounty");
		rating = request.getParameter("rating");
		descrp = request.getParameter("descrp");
		id = request.getParameter("id");
		height= feet+" ft " +inches+" inches";
		//out.println(bounty);
			
		try {
				String sql = "UPDATE `most_wanted` SET `criminal_fname`=?,`criminal_age`=?,`criminal_last_address`=?,`criminal_sex`=?,`criminal_height`=?,`criminal_status`=?,`criminal_description`=?,`criminal_bounty`=?,`criminal_last_name`=?,`criminal_rating`=? WHERE `criminal_id`=?";

				PreparedStatement psmt = conn.prepareStatement(sql);
					
				psmt.setString(1, fname);
				psmt.setString(2, age);
				psmt.setString(3, address);
				psmt.setString(4, sex);
				psmt.setString(5, height);
				psmt.setString(6, arrest);
				psmt.setString(7, descrp);
				psmt.setString(8, bounty);
				psmt.setString(9, lname);
				psmt.setString(10, rating);
				psmt.setString(11, id);
				int i = psmt.executeUpdate();

				if (i == 1) {
					isRegistered = true;
					

					messageDetail = "Criminal's Information successfully updated!";
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

}
