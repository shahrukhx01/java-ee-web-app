package complaint;



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
 * Servlet implementation class UpdateCaseProgress
 */
@WebServlet("/UpdateCaseProgress")
public class UpdateCaseProgress extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DataSource ds;
	private Connection conn = null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateCaseProgress() {
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
		String id,witnesses,evidences,progress,arrests,warrants,law_sections;

		boolean isRegistered = false;

		String messageUrl = "/update_progress.jsp";
		RequestDispatcher dispatchMessage = request.getServletContext().getRequestDispatcher(messageUrl);
		id = request.getParameter("complaint_id");
		witnesses = request.getParameter("witnesses");
		evidences = request.getParameter("evidences");
		progress = request.getParameter("progress");
		warrants = request.getParameter("warrants");
		arrests = request.getParameter("arrests");
		law_sections = request.getParameter("law_sections");

		
				
	
			
		try {

			String sql = "UPDATE `case_progress` SET `witnesses`=?,`evidences`=?,`prgress`=?,`warrants`=?,`arrests`=?,`law_sections`=? WHERE complaint_id=?";

				PreparedStatement psmt = conn.prepareStatement(sql);
				
				psmt.setString(1, witnesses);
				psmt.setString(2, evidences);
				psmt.setString(3, progress);
				psmt.setString(4, warrants);
				psmt.setString(5, arrests);
				psmt.setString(6, law_sections);
				psmt.setString(7, id);
						int i = psmt.executeUpdate();

				if (i == 1) {
					isRegistered = true;
					

					messageDetail = "Case Progress successfully updated!";
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
