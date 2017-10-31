package loginRegister;

import helpers.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
import police.Police;

/**
 * Servlet implementation class PoliceLogin
 */
@WebServlet("/PoliceLogin")
public class PoliceLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DataSource ds;
	private Connection conn = null;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public PoliceLogin() {
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
		

        String station, pass;
        String db_station, db_pass;
        boolean isLoggedIn = false;
        HttpSession userSession = request.getSession();
        
        station = request.getParameter("station");
        pass = request.getParameter("password");
        String message, messageDetail;
        message = "";
        messageDetail = "";
        
        String messageUrl = "/police_login.jsp";
        RequestDispatcher dispatchMessage =
                 request.getServletContext().getRequestDispatcher(messageUrl);
        
        try {
            
            pass = SecureSHA1.getSHA1(pass);
           // out.println("email " + email + " pass " + pass);
        
            
            String sqlGetUsers = "SELECT  * FROM  `police_officer` join `police_stations` on `police_officer`.station_id=`police_stations`.police_station_id and `police_officer`.station_id="+station+" ; ";

            PreparedStatement st = conn.prepareStatement(sqlGetUsers);

            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                db_station = rs.getString("station_name");
                db_pass = rs.getString("password");
                String db_station_id=rs.getString("station_id"); 
                    if (pass.equals(db_pass)) {
                        isLoggedIn = true;
                        //user exists and password is matching
                        out.print("You are logged in");
                  Police police = new Police();
                      police.setStation_name(db_station);
                      police.setStation_id(db_station_id);
                    userSession.setAttribute("police", police);
                    response.sendRedirect(request.getContextPath()+"/police_home.jsp");
                      }
                    else {
                        isLoggedIn = false;
                        // user exsts but wrong passwotd ask to CHANGE THE PASSWORD
                        message = "Wrong Password...!";
                        messageDetail = "Password does not match with the password during registeration... Please re-login with correct password";
                      
                    }
                
                
            }
            else{
                isLoggedIn = false;
                // user doesn't exsts 
                message = "Wrong Login...!";
                messageDetail = "You're not registered as a police officer...";
              
            }
            
            if (isLoggedIn == false){
                request.setAttribute("message", message);
                request.setAttribute("messageDetail", messageDetail);
                request.setAttribute("error", "error");
                dispatchMessage.forward(request, response);
            }
        } catch (SQLException e) {
            out.println(" Problem in the process execution...");
            //response.sendError(404);
            message = "An Error occoured during the process of login";
            messageDetail = "We are extremely sorry to have this but we had an error during your process of login please do try after some time,";
            request.setAttribute("error", "error");       
            request.setAttribute("message", message);
            request.setAttribute("messageDetail", messageDetail);
            dispatchMessage.forward(request, response);
        
        } catch (Exception e) {
            out.println(" Problem in the process execution...");
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
