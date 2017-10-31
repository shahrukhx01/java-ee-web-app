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
 * Servlet implementation class Police_Controller
 */
@WebServlet("/Police_Controller")
public class Police_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Map<String, String> actionMap = new HashMap<>();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Police_Controller() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		actionMap.put("home", "/police_home.jsp");
		actionMap.put("comp_progress", "/police_view_case.jsp"); 
		actionMap.put("update_progress", "/update_progress.jsp");
		actionMap.put("current", "/current_cases.jsp");
		actionMap.put("closed", "/closed_cases.jsp");
		actionMap.put("pending", "/pending_cases.jsp");
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
