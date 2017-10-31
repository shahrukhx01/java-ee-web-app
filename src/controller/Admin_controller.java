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
 * Servlet implementation class Admin_controller
 */
@WebServlet("/Admin_controller")
public class Admin_controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Map<String, String> actionMap = new HashMap<>();   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Admin_controller() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		actionMap.put("addCriminal", "/add_criminal.jsp");
		actionMap.put("addMissing", "/add_missing_person.jsp");
		actionMap.put("home", "/admin_home.jsp");
		actionMap.put("missing", "/add_missing_person.jsp");
		actionMap.put("update_criminal", "/update_criminal.jsp");
		actionMap.put("update_missing", "/update_missing_person.jsp");
		actionMap.put("updateMissing", "/select_update_missing_person.jsp");
		actionMap.put("updateCriminal", "/select_update_criminal.jsp");
		actionMap.put("deleteCriminal", "/delete_criminal.jsp");
		actionMap.put("deleteMissing", "/delete_missing_person.jsp");
		actionMap.put("addStats", "/add_statistics.jsp");
		actionMap.put("wanted", "/admin_view_wanted_criminals.jsp");
		actionMap.put("missing", "/admin_view_missing_persons.jsp");
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
