package imag.dac4;

import java.util.regex.Pattern;

public final class Constants {

    // ############### //
    // ## JSP Paths ## //
    // ############### //

    public static final String JSP_HEADER = "/jsp/header.jsp";
    public static final String JSP_INDEX  = "/jsp/index.jsp";

    public static final String JSP_AUTH_REGISTER            = "/jsp/auth/register.jsp";
    public static final String JSP_AUTH_AWAITING_VALIDATION = "/jsp/auth/awaitingApproval.jsp";

    public static final String JSP_ADMIN_HOME  = "/jsp/admin/home.jsp";
    public static final String JSP_ADMIN_USERS = "/jsp/admin/users.jsp";
    public static final String JSP_ADMIN_ITEMS = "/jsp/admin/items.jsp";

    public static final String JSP_USER_HOME = "/jsp/user/home.jsp";

    public static final String JSP_ITEMS                    = "/jsp/item/items.jsp";
    public static final String JSP_ITEM                     = "/jsp/item/item.jsp";
    public static final String JSP_ITEM_REGISTER            = "/jsp/item/register.jsp";
    public static final String JSP_ITEM_AWAITING_VALIDATION = "/jsp/item/awaitingApproval.jsp";

    public static final String JSP_DEBUG = "/jsp/debug/db.jsp";

    // ########## //
    // ## Misc ## //
    // ########## //

    // TODO Make those 3 values configurable somehow
    public static final int LOCKER_NUM_MIN        = 1;
    public static final int LOCKER_NUM_MAX        = 9;
    public static final int MAX_LOAN_DURATION_MIN = 1;

    public static final Pattern EMAIL_PATTERN = Pattern.compile("\\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}\\b", Pattern.CASE_INSENSITIVE);

    private Constants() {
    }
}
