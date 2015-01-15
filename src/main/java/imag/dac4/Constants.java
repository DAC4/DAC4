package imag.dac4;

import java.util.regex.Pattern;

public final class Constants {

    // ############### //
    // ## JSP Paths ## //
    // ############### //

    public static final String JSP_HEADER = "/jsp/header.jsp";
    public static final String JSP_INDEX  = "/jsp/index.jsp";

    public static final String JSP_AUTH_REGISTER            = "/jsp/auth/register.jsp";
    public static final String JSP_AUTH_AWAITING_VALIDATION = "/jsp/auth/awaitingValidation.jsp";

    public static final String JSP_ADMIN_HOME  = "/jsp/admin/home.jsp";
    public static final String JSP_ADMIN_USERS = "/jsp/admin/users.jsp";
    public static final String JSP_ADMIN_ITEMS = "/jsp/admin/items.jsp";

    public static final String JSP_USER_HOME = "/jsp/user/home.jsp";

    public static final String JSP_ITEMS = "/jsp/item/items.jsp";
    public static final String JSP_ITEM  = "/jsp/item/item.jsp";

    // ########## //
    // ## Misc ## //
    // ########## //

    public static final Pattern EMAIL_PATTERN = Pattern.compile("\\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}\\b", Pattern.CASE_INSENSITIVE);

    private Constants() {
    }
}
