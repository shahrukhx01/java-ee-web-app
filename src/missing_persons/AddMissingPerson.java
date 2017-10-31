package missing_persons;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.Calendar;
import java.util.Date;

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
 * Servlet implementation class AddMissingPerson
 */
@WebServlet("/AddMissingPerson")
public class AddMissingPerson extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DataSource ds;
	private Connection conn = null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddMissingPerson() {
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
		String fname,lname,sex,age,psycho,marital,address,last_seen;

		boolean isRegistered = false;

		String messageUrl = "/admin_view_missing_persons.jsp";
		RequestDispatcher dispatchMessage = request.getServletContext().getRequestDispatcher(messageUrl);
		fname = request.getParameter("fname");
		lname = request.getParameter("lname");
		sex = request.getParameter("sex");
		age = request.getParameter("age");
		psycho = request.getParameter("psycho");
		marital = request.getParameter("marital");
		address = request.getParameter("address");
		last_seen = request.getParameter("last_seen");
		
		//out.println(bounty);
			
		try {
				String sql = "INSERT INTO `missing_person`( `first_name`, `last_name`, `age`, `sex`, `date`, `address`, `marital_status`, `psycological_status`, `last_seen`) VALUES (?,?,?,?,?,?,?,?,?)";

				PreparedStatement psmt = conn.prepareStatement(sql);
				String today="";
				Date date = new Date(); // your date
		        Calendar cal = Calendar.getInstance();
		        cal.setTime(date);
		        int year = cal.get(Calendar.YEAR);
		        int month = cal.get(Calendar.MONTH);
		        int day = cal.get(Calendar.DAY_OF_MONTH);
		        today=year+"-"+month+"-"+day;
				psmt.setString(1, fname);
				psmt.setString(2, lname);
				psmt.setString(3, age);
				psmt.setString(4, sex);
				psmt.setString(5, today);
				psmt.setString(6, address);
				psmt.setString(7, marital);
				psmt.setString(8, psycho);
				psmt.setString(9, last_seen);
				int i = psmt.executeUpdate();

				if (i == 1) {
					isRegistered = true;
					String getMissing = "select * from missing_person ORDER BY missing_person_id DESC LIMIT 1";

					PreparedStatement st = conn.prepareStatement(getMissing);
					ResultSet rs = st.executeQuery();
					String id="";
					if(rs.next()){
					id=rs.getString("missing_person_id");
					}
					String notification="INSERT INTO `e_crime`.`notifications` ( `category`, `person_id`, `time`) VALUES ('missing', ?, now())";
					PreparedStatement psmt2 = conn.prepareStatement(notification);
					psmt2.setString(1, id);
					psmt2.executeUpdate();

					messageDetail = "Missing Person successfully added!";
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
