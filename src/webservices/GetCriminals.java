package webservices;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import org.json.simple.JSONValue;

/**
 * Servlet implementation class GetCriminals
 */
@WebServlet("/GetCriminals")
public class GetCriminals extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DataSource ds;
	private Connection conn = null;
	List<Map<String, String>> criminalData = new ArrayList<Map<String, String>>();
	Map<String, String> criminals = new HashMap<String, String>();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GetCriminals() {
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
		try {
			processRequest(request, response);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	private void processRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException,
			SQLException {

		String callBackJavaScripMethodName = request.getParameter("callback");
		criminals.clear();
		try {
			conn = ds.getConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return;
		}
		String getCriminals = "select * from most_wanted";

		PreparedStatement st = conn.prepareStatement(getCriminals);
		List<Map<String, String>> criminalsData=new ArrayList<Map<String, String>>();
		ResultSet rs = st.executeQuery();

		while (rs.next()) {

			//List<String> row = new ArrayList<>(columnsNumber); // new list per row
			Map<String, String> row = new HashMap<String, String>();
		   row.put("criminal_fname",rs.getString("criminal_fname"));
		   row.put("criminal_age",rs.getString("criminal_age")); 
		   row.put("criminal_last_name",rs.getString("criminal_last_name"));
		   row.put("criminal_last_address",rs.getString("criminal_last_address"));
		    criminalsData.add(row); 
		    }
		
		
		
		
		String jsonText = JSONValue.toJSONString(criminalsData);
		jsonText = callBackJavaScripMethodName + "(" + jsonText + ");";
		PrintWriter pw = response.getWriter();
		pw.println(jsonText);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
