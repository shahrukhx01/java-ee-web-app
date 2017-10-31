package controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Controller
 */
@WebServlet("/Controller")
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private Map<String, String> actionMap = new HashMap<>();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Controller() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		actionMap.put("about", "/about-us.jsp");
		actionMap.put("home", "/index.jsp");
		actionMap.put("criminal", "/criminal.jsp");
		actionMap.put("contact", "/contact.jsp");
		actionMap.put("complaint", "/complaint_register.jsp");
		actionMap.put("wanted", "/wanted_criminals.jsp");
		actionMap.put("filed", "/filed_complaints.jsp");
		actionMap.put("progress", "/filed_complaints.jsp");
		actionMap.put("missing", "/missing_persons.jsp");
		actionMap.put("comp_progress", "/complaint_progress.jsp");
		actionMap.put("stats", "/crime_statistics.jsp");
		actionMap.put("login", "/login_signUp.jsp");
		// Get the action parameter
		String action = request.getParameter("action");

		// If the action parameter is null or the map doesn't contain
		// a page for this action, set the action to the home page
		if (action == null || !actionMap.containsKey(action))
			action = "home";
		// Forward to the requested page.
request.getRequestDispatcher(actionMap.get(action)).forward(request,
				response);


	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

	
	}

}
