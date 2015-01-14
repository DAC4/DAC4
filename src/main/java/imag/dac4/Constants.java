package imag.dac4;

import java.util.regex.Pattern;

public final class Constants {

    // ############### //
    // ## JSP Paths ## //
    // ############### //

    public static final String JSP_INDEX = "/index.jsp";

    public static final String JSP_AUTH_REGISTER            = "/auth/register.jsp";
    public static final String JSP_AUTH_AWAITING_VALIDATION = "/auth/awaitingValidation.jsp";

    public static final String JSP_ADMIN_HOME = "/admin/home.jsp";

    public static final String JSP_USER_HOME = "/user/home.jsp";

    // ########## //
    // ## Misc ## //
    // ########## //

    public static final Pattern EMAIL_PATTERN = Pattern.compile("\\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}\\b", Pattern.CASE_INSENSITIVE);

    private Constants() {
    }
}
