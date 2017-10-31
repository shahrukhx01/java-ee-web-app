package loginRegister;

import helpers.*;
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
 * Servlet implementation class RegisterUser
 */
@WebServlet("/RegisterUser")
public class RegisterUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private DataSource ds;
	private Connection conn = null;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterUser() {
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
        String firstname,lastname,address,email, pass, passAgain,cnic,mobile;
        
        
        boolean isRegistered = false;

        String messageUrl = "/login_signUp.jsp";
        RequestDispatcher dispatchMessage =request.getServletContext().getRequestDispatcher(messageUrl);
        request.setAttribute("signup","signup");
        mobile = request.getParameter("mobile");
        cnic = request.getParameter("cnic");
        firstname = request.getParameter("fname");
        lastname = request.getParameter("lname");
        address = request.getParameter("address");
        email = request.getParameter("email");
        pass = request.getParameter("password");
        passAgain = request.getParameter("passwordRepeat");
        EmailValidator validator = new EmailValidator();
        boolean isEmailValid = validator.validate(email);
 
       
        try {
            
           
            if ((request.getParameter("email") != null) || (request.getParameter("email") != null)){
                if (isEmailValid) {
                    if (pass.length() > 7 && cnic.length()==13 && mobile.length()==11) {
                        if (pass.equals(passAgain)) {
                       
                        	
                    
                        	

                            String sql = "INSERT INTO  `e_crime`.`users` "
                                    + "(`email` ,`password` ,`registeredOn`, `user_firstname` ,`user_lastname` ,`cnic_number`,`mobile_number` ,`present_address`) "
                                    + "VALUES (?, SHA1(  ? ) , NOW( ),?,?, SHA1(  ? ), SHA1(  ? ) ,?); ";
                            	
                            PreparedStatement psmt = conn.prepareStatement(sql);

                            psmt.setString(1, email);

                            psmt.setString(2, pass);
                            	

                            psmt.setString(3, firstname);
                            psmt.setString(4, lastname);
                            psmt.setString(5, cnic);
                            psmt.setString(6, mobile);
                            psmt.setString(7, address);

                            int i = psmt.executeUpdate();
 
                            
                           
                            

                            if (i == 1) {
                                isRegistered = true;
                                out.println("You are registered ");
                                
                                 messageDetail="Account successfully created.";
                                 request.setAttribute("success", "success");
                                 request.setAttribute("messageDetail", messageDetail);
                                 dispatchMessage.forward(request, response);
                            } else {
                                isRegistered = false;
                                out.println("You are not registered");
                            }

                        } //Else both passwords do not match
                        else {
                            isRegistered = false;
                            message = "Passwords do not match";
                            messageDetail = "Please provide a matching passwords";
                            out.print(" nOT Success!  both passwords do not match!");

                        }
                    } //or the paasword length is less than 7
                    else {
                        isRegistered = false;
                        if(pass.length()<=7){
                       
                        messageDetail = "Please provide a passwords that has password length of minimum of eight alphanumeric characters";
                        }
                        else if(cnic.length()!=13){
                        	
                            messageDetail = "Please provide a valid 13 digit cnic card number";
                            	
                        }
                        else if(mobile.length()!=11){
                        	messageDetail = "Please provide a valid 11 digit mobile number";
                        }
                        
                    }
                } //or email is wrong
                else {
                    isRegistered = false;
                    message = "No email address typed";
                    messageDetail = "Please provide a valid email address";
                    out.print(" nOT Success!! email is wrong");
                }
            }
            else {
                isRegistered = false;
                message = "Please enter values";
                messageDetail = "Please provide an email address. Your account currently is not registered";
            }
            
            if (isRegistered == false) {
            	request.setAttribute("fname", firstname);
                request.setAttribute("lname", lastname);
                request.setAttribute("cnic", cnic);
                request.setAttribute("mobile", mobile);
                request.setAttribute("address", address);
                request.setAttribute("email", email);
                
            	request.setAttribute("message", message);
                request.setAttribute("messageDetail", messageDetail);
                dispatchMessage.forward(request, response);
            }

            //try ends here
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
            request.setAttribute("email", email);
            request.setAttribute("message", message);
            if(messageDetail.contains("email"))
            {
            	messageDetail="Email already registered.";
            }
            else if(messageDetail.contains("mobile_number"))
            {
            	messageDetail="Mobile number already registered.";
            }
            else if(messageDetail.contains("cnic_number"))
            {
            	messageDetail="CNIC number already registered.";
            }
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
            request.setAttribute("email", email);
            request.setAttribute("message", message);
            
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
