package messages;

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
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import user.user;

/**
 * Servlet implementation class PoliceMessages
 */
@WebServlet("/PoliceMessages")
public class PoliceMessages extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DataSource ds;
	private Connection conn = null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PoliceMessages() {
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
		String complain_id,status, cont_message;

		boolean isRegistered = false;

		String messageUrl = "/contact.jsp";
		RequestDispatcher dispatchMessage = request.getServletContext()
				.getRequestDispatcher(messageUrl);
		complain_id = request.getParameter("complain_id");
		cont_message = request.getParameter("c_message");
		status=request.getParameter("status");
		HttpSession userSession = request.getSession();

		user User1 = (user) userSession.getAttribute("user");
		
		try {

			if (cont_message.length()>0) {

				String sql = "INSERT INTO `police_messages`( `msg`, `user_id`, `complaint_id`, `date`, `status`) VALUES (?,?,?,?,?) ";

				PreparedStatement psmt = conn.prepareStatement(sql);
				String user_id;
				if(User1==null){
					user_id=request.getParameter("id");
				}	else{
				 user_id = "" + User1.getUserId();}
				psmt.setString(1, cont_message);
				psmt.setString(2, user_id);
				psmt.setString(3, complain_id);
				psmt.setString(4, new java.util.Date().toString());
				psmt.setString(5, status);
				
				int i = psmt.executeUpdate();

				if (i == 1) {
					isRegistered = true;
					

					messageDetail = "Message successfully sent. You'll soon receive a response from us.";
					request.setAttribute("success", "success");
					request.setAttribute("messageDetail", messageDetail);
					dispatchMessage.forward(request, response);
				}
				else{
					
					isRegistered=false;
				}

			} else {
				isRegistered = false;

					messageDetail = "Message must not be empty!";


			}

			if (isRegistered == false) {
				request.setAttribute("subject", complain_id);
				request.setAttribute("con_message", cont_message);
				request.setAttribute("error", "error");
				request.setAttribute("message", message);
				request.setAttribute("messageDetail", messageDetail);
				 dispatchMessage.forward(request, response);
			}

			// try ends here
		} catch (SQLIntegrityConstraintViolationException ex) {
			// user exsts but wrong password ask to CHANGE THE PASSWORD
			messageDetail = ex.getMessage();
			out.print(" nOT Success!!" + ex);
			request.setAttribute("subject", complain_id);
			request.setAttribute("con_message", cont_message);
			request.setAttribute("error", "error");
			request.setAttribute("message", message);
			request.setAttribute("messageDetail", messageDetail);
			dispatchMessage.forward(request, response);
		} catch (Exception ex) {
			messageDetail = ex.getMessage();
			message = "There was a problem in registering your account please do retry again later...";
			out.print(" nOT Success!!" + ex);
			request.setAttribute("subject", complain_id);
			request.setAttribute("con_message", cont_message);
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
