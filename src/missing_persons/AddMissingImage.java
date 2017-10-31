package missing_persons;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import javax.sql.DataSource;

/**
 * Servlet implementation class AddCriminalImage
 */
@MultipartConfig
@WebServlet("/AddMissingImage")
public class AddMissingImage extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DataSource ds;
	private Connection conn = null;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddMissingImage() {
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

		String message, messageDetail;
		String messageUrl = "/admin_view_missing_persons.jsp";
		RequestDispatcher dispatchMessage = request.getServletContext().getRequestDispatcher(messageUrl);
		String id, img_id;
		message="";
		messageDetail="";
		img_id = request.getParameter("img_id");
		id = request.getParameter("c_hidden_id");
		String img_name="";
		response.setContentType("text/html;charset=UTF-8");
		String path = request.getParameter("destination");
		Part filePart = request.getPart("file");
		String fileName = getFileName(filePart);
		boolean isRegistered = false;
		boolean invalidImage = false;
		int index = fileName.lastIndexOf(".");
		index++;
		String extension = (fileName.substring(index, fileName.length()))
				.toLowerCase();
		if (extension.equals("jpg") || extension.equals("jpeg")
				|| extension.equals("png")) {

			OutputStream out = null;
			InputStream filecontent = null;
			PrintWriter writer = response.getWriter();
		
			writer.println("cid " + id);

			try {
				img_name="missing" + id + "0" + img_id + "." + extension;
				out = new FileOutputStream(new File(path + File.separator
						+ img_name));
				filecontent = filePart.getInputStream();
				int read = 0;
				final byte[] bytes = new byte[1024];
				while ((read = filecontent.read(bytes)) != -1) {
					out.write(bytes, 0, read);
				}
				writer.println(fileName + " created at " + path);
				
			} catch (FileNotFoundException fne) {
				request.setAttribute("error", "error");
				request.setAttribute("message", "");
				request.setAttribute("messageDetail",
						"Error in file upload ERROR");
				invalidImage=true;
//				dispatchMessage.forward(request, response);

			} 
		} else {

			request.setAttribute("error", "error");
			request.setAttribute("message", "");
			request.setAttribute("messageDetail",
					"Error! Only .jpg and .png extension files can be uploaded.");
			invalidImage=true;
			//		dispatchMessage.forward(request, response);	
			//return;
		}
		// use connection
		 PrintWriter out1 = response.getWriter();
		out1.println("hola1");


		// PrintWriter out = response.getWriter();

		try {
			conn = ds.getConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return;
		}

		
		try {
			if(!invalidImage){

			String sql = " INSERT INTO `images`(`person_id`, `image_name`, `category`) VALUES (?,?,?)";

			PreparedStatement psmt = conn.prepareStatement(sql);

			psmt.setString(1, id);
			psmt.setString(2, img_name);
			psmt.setString(3, "missing");
			int i = psmt.executeUpdate();

			if (i == 1) {
				isRegistered = true;

				messageDetail = "Missing Person's image successfull added!";
				request.setAttribute("success", "success");
				request.setAttribute("messageDetail", messageDetail);
				
				PrintWriter wr=response.getWriter();
				wr.println(messageDetail);
				dispatchMessage.forward(request, response);
			} else {

				isRegistered = false;
			}

			if (isRegistered == false) {
				request.setAttribute("error", "error");
				request.setAttribute("message", message);
				request.setAttribute("messageDetail", messageDetail);
				dispatchMessage.forward(request, response);
			}
			}else{
				
				dispatchMessage.forward(request, response);
			}

			// try ends here
		} catch (SQLIntegrityConstraintViolationException ex) {
			// user exsts but wrong password ask to CHANGE THE PASSWORD
			messageDetail = ex.getMessage();
			// out.print(" nOT Success!!" + ex);
			request.setAttribute("error", "error");
			request.setAttribute("message", message);
			request.setAttribute("messageDetail", messageDetail);
			dispatchMessage.forward(request, response);
		} catch (Exception ex) {
			messageDetail = ex.getMessage();
			message = "There was a problem in registering your account please do retry again later...";
			// out.print(" nOT Success!!" + ex);
			request.setAttribute("error", "error");
			request.setAttribute("message", message);
			request.setAttribute("messageDetail", messageDetail);
			dispatchMessage.forward(request, response);
			// response.sendError(404);
		}

		try {
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	private String getFileName(final Part part) {
		// final String partHeader = part.getHeader("content-disposition");
		for (String content : part.getHeader("content-disposition").split(";")) {
			if (content.trim().startsWith("filename")) {
				return content.substring(content.indexOf('=') + 1).trim()
						.replace("\"", "");
			}
		}
		return null;

	}
}
