package user;

import database.DB_Conn;
import java.sql.*;

public class user {
	public String userEmail = null;
	public int userId = 0;
	public String firstname;
	public String lastname;
	public String cnicNum;
	public String mobileNum;
	public String address;
	Connection c;

	public void setUserEmail(String userEmail) throws SQLException,
			ClassNotFoundException {
		this.userId = findUserId(userEmail);
		 fetchAllValues(getUserId());
		this.userEmail = userEmail;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getFirstname() {
		return firstname;
	}

	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}

	public String getLastname() {
		return lastname;
	}

	public void setLasttname(String lastname) {
		this.lastname = lastname;
	}

	public String getCnicNum() {
		return cnicNum;
	}

	public void setCnicNum(String cnicNum) {
		this.cnicNum = cnicNum;
	}

	public String getMobileNum() {
		return mobileNum;
	}

	public void setMobileNum(String mobileNum) {
		this.mobileNum = mobileNum;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public int findUserId(String email) throws SQLException,
			ClassNotFoundException {
		String sqlGetUserId = "SELECT  `user_id` FROM  `users` WHERE  `email` =  ?";
		c = new DB_Conn().getConnection();
		PreparedStatement psmt = c.prepareStatement(sqlGetUserId);
		psmt.setString(1, email);
		ResultSet executeQuery = psmt.executeQuery();
		executeQuery.next();
		userId = executeQuery.getInt("user_id");
		return userId;
	}

	public boolean fetchAllValues(int userId) throws SQLException,
			ClassNotFoundException {
		// GETS ALL THE VALUES FROM THE TABLE user-deails

		String fetchSql;
		boolean fetched;
		fetchSql = "SELECT * FROM  `users` WHERE  `user_id` =? ;";
		c = new DB_Conn().getConnection();

		PreparedStatement psmt = c.prepareStatement(fetchSql);
		psmt.setInt(1, userId);

		ResultSet executeQuery = psmt.executeQuery();
		boolean next = executeQuery.next();
		if (next) {
			firstname = executeQuery.getString("user_firstname");
			lastname = executeQuery.getString("user_lastname");
			cnicNum = executeQuery.getString("cnic_number");
			mobileNum = executeQuery.getString("mobile_number");
			address = executeQuery.getString("present_address");
			fetched = true;
		} else {
			firstname = null;
			lastname = null;
			cnicNum = null;
			mobileNum = null;
			address = null;

			fetched = false;
		}

		return fetched;
	}

	public static void main(String args[]) throws SQLException,
			ClassNotFoundException {
		System.out.println("Ok then gimme an email to give u an ID");
		//Scanner sc = new Scanner(System.in);
		//String next = sc.next();
		//user user = new user();
		//user.setUserEmail(next);
		//user.getUsername();
		//System.out.println("Dude u have a email of an id " + user.getFirstname()
			//	+ " Address of " + user.getAddress());
	}
}
