package helpers;
import java.util.Calendar;
import java.util.Date;
import java.util.Scanner;
import java.util.regex.*;

public class EmailValidator {
    boolean result = false;
        private Pattern pattern;
    private Matcher matcher;
    private static final String EMAIL_PATTERN = "^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";

    public EmailValidator() {
        pattern = Pattern.compile(EMAIL_PATTERN);
    }

    /**
     * Validate hex with regular expression
     *
     * @param hex hex for validation
     * @return true valid hex, false invalid hex
     */
    public boolean validate(final String hex) {

        matcher = pattern.matcher(hex);
        return matcher.matches();

    }

    
    public static void main(String arg[]){
        EmailValidator valid = new EmailValidator();
//        System.out.print("Gimme an email to validate "+new java.util.Date());
        Date date = new Date(); // your date
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        int year = cal.get(Calendar.YEAR);
        int month = cal.get(Calendar.MONTH);
        int day = cal.get(Calendar.DAY_OF_MONTH);
        
        System.out.println(year+"-"+month+"-"+day);

        @SuppressWarnings("resource")
		Scanner sc = new Scanner(System.in);
        String email = sc.next();
        boolean b = valid.validate(email);
        System.out.println("email is "+ b);
    }
}
