package imag.dac4.servlet;

import imag.dac4.Constants;
import imag.dac4.Tools;
import imag.dac4.model.item.Item;
import imag.dac4.model.item.ItemDao;
import imag.dac4.model.loan.Loan;
import imag.dac4.model.loan.LoanDao;
import imag.dac4.model.user.User;
import imag.dac4.model.user.UserDao;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@WebServlet(name = "ItemServlet", urlPatterns = {
        "/item",
        "/item/register",
        "/item/awaiting-approval",
        "/item/borrow",
        "/item/return",
        "/items",
})
@MultipartConfig
public class ItemServlet extends HttpServlet {

    private static final String UPLOAD_DIRECTORY = "/static/img";

    @EJB
    ItemDao itemDao;
    @EJB
    LoanDao loanDao;
    @EJB
    UserDao userDao;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final User user = Tools.getUser(req);
        final boolean isAdmin = Tools.isAdmin(req);

        final String[] split = req.getRequestURI().split("/");
        final String action = split[split.length - 1];
        switch (action.toLowerCase()) {
            case "item":
                final int id;
                try {
                    id = Integer.parseInt(req.getParameter("id"));
                } catch (final NumberFormatException e) {
                    req.getSession().setAttribute("error", 400);
                    req.getSession().setAttribute("error_msg", "Bad Request: " + req.getRequestURI() + " (Unknown or missing id)");
                    req.getRequestDispatcher(Constants.JSP_ITEM).forward(req, resp);
                    return;
                }
                final Item item = this.itemDao.read(id);
                if (item == null || !item.isApproved() && !isAdmin && item.getOwnerId() != user.getId()) {
                    req.getSession().setAttribute("error", 400);
                    req.getSession().setAttribute("error_msg", "Bad Request: " + req.getRequestURI() + " (Unknown or missing id)");
                } else {
                    req.setAttribute("item", item);
                }
                final User owner = this.userDao.read(item.getOwnerId());
                if (user == null) {
                    req.getSession().setAttribute("error", 400);
                    req.getSession().setAttribute("error_msg", "Bad Request: " + req.getRequestURI() + " (Unknown or missing id)");
                } else {
                    req.setAttribute("owner", owner);
                }
                req.getRequestDispatcher(Constants.JSP_ITEM).forward(req, resp);
                break;
            case "register":
                req.setAttribute("lockers", this.itemDao.getFreeLockers());
                req.getRequestDispatcher(Constants.JSP_ITEM_REGISTER).forward(req, resp);
                break;
            case "awaiting-approval":
                req.getRequestDispatcher(Constants.JSP_ITEM_AWAITING_APPROVAL).forward(req, resp);
                break;
            case "items":
                req.setAttribute("isAdmin", isAdmin);
                req.setAttribute("items", this.itemDao.getItems());
                req.getRequestDispatcher(Constants.JSP_ITEMS).forward(req, resp);
                break;
            default:
                req.getSession().setAttribute("error", 400);
                req.getSession().setAttribute("error_msg", "Bad Request: " + req.getRequestURI());
                resp.sendRedirect("/");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String[] split = req.getRequestURI().split("/");
        final String action = split[split.length - 1];
        switch (action.toLowerCase()) {
            case "borrow":
                this.onItemBorrowRequest(req, resp);
                break;
            case "register":
                this.onItemRegistrationRequest(req, resp);
                break;
            case "return":
                this.onItemReturnRequest(req, resp);
                break;
            default:
                req.getSession().setAttribute("error", 400);
                req.getSession().setAttribute("error_msg", "Bad Request: " + req.getRequestURI());
                resp.sendRedirect("/");
                break;
        }
    }

    private void onItemReturnRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String idString = req.getParameter("id");
        if (idString == null) {
            req.getSession().setAttribute("error", 400);
            req.getSession().setAttribute("error_msg", "Bad Request: Missing parameter");
            resp.sendRedirect("/user/loans");
            return;
        }

        final int id;
        try {
            id = Integer.parseInt(idString);
        } catch (final NumberFormatException e) {
            req.getSession().setAttribute("error", 400);
            req.getSession().setAttribute("error_msg", "Bad Request: Invalid id");
            resp.sendRedirect("/user/loans");
            return;
        }

        final Loan loan = this.loanDao.read(id);
        if (loan == null) {
            // loan doesn't exist
            req.getSession().setAttribute("error", 404);
            req.getSession().setAttribute("error_msg", "Not Found: Invalid id");
            resp.sendRedirect("/user/loans");
        } else {
            final User user = Tools.getUser(req);
            if (loan.getUserId() != user.getId()) {
                // user making the request isn't the borrower
                req.getSession().setAttribute("error", 400);
                req.getSession().setAttribute("error_msg", "Bad request: Not your loan");
                resp.sendRedirect("/user/loans");
            } else {
                final Item item = this.itemDao.read(loan.getItemId());
                if (item == null) {
                    req.getSession().setAttribute("error", 400);
                    req.getSession().setAttribute("error_msg", "Bad request: Item not found (wtf)");
                    resp.sendRedirect("/user/loans");
                } else {
                    /*ARDUINO : ArduinoInterface.insertProduct(item.getLockerNum()); */
                    item.setAvailable(true);
                    this.itemDao.update(item);
                    user.setCredits(user.getCredits() + 1);
                    this.userDao.update(user);
                    loan.setEndDate(new Date(System.currentTimeMillis()));
                    this.loanDao.update(loan);
                    resp.sendRedirect("/user/loans");
                }
            }
        }
    }

    private void onItemBorrowRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String idString = req.getParameter("id");
        if (idString == null) {
            req.getSession().setAttribute("error", 400);
            req.getSession().setAttribute("error_msg", "Bad Request: Missing parameter");
            resp.sendRedirect("/");
            return;
        }

        final int id;
        try {
            id = Integer.parseInt(idString);
        } catch (final NumberFormatException e) {
            req.getSession().setAttribute("error", 400);
            req.getSession().setAttribute("error_msg", "Bad Request: " + req.getRequestURI() + " (Unknown or missing id)");
            resp.sendRedirect("/");
            return;
        }

        final Item item = this.itemDao.read(id);
        if (item == null || !item.isApproved()) {
            // Item doesn't exist
            req.getSession().setAttribute("error", 404);
            req.getSession().setAttribute("error_msg", "Not Found: Invalid id");
            resp.sendRedirect("/items");
        } else if (!item.isAvailable()) {
            // Item not available
            req.getSession().setAttribute("error", 400);
            req.getSession().setAttribute("error_msg", "Bad Request: Item already borrowed");
            resp.sendRedirect("/items");
        } else {
            final User user = Tools.getUser(req);
            if (user.getCredits() <= 0) {
                // Not enough credits
                req.getSession().setAttribute("error", 403);
                req.getSession().setAttribute("error_msg", "Forbidden: Not enough credits");
                resp.sendRedirect("/items");
            } else if (!this.userDao.canUserBorrow(user)) {
                // Late on another loan
                req.getSession().setAttribute("error", 403);
                req.getSession().setAttribute("error_msg", "Forbidden: Please return late loans before borrowing anything else");
                resp.sendRedirect("/items");
            } else {
                 /*ARDUINO : ArduinoInterface.removeProduct(item.getLockerNum()); */
                // set item not available
                item.setAvailable(false);
                this.itemDao.update(item);
                // user spends 1 credit
                user.setCredits(user.getCredits() - 1);
                this.userDao.update(user);
                this.loanDao.create(new Loan(user.getId(), item.getId()));
                req.getSession().setAttribute("success_msg", "Successfully borrowed item \"" + item.getName() + '"');
                resp.sendRedirect("/user/loans");
            }
        }
    }

    private void onItemRegistrationRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!ServletFileUpload.isMultipartContent(req)) {
            req.getSession().setAttribute("error", 400);
            req.getSession().setAttribute("error_msg", "Bad Request: Awaiting multipart content");
            resp.sendRedirect("/");
            return;
        }
        final FileItemFactory fileItemFactory = new DiskFileItemFactory();
        final ServletFileUpload servletFileUpload = new ServletFileUpload(fileItemFactory);
        servletFileUpload.setFileSizeMax(5000000);
        final List<FileItem> fileItems;
        try {
            fileItems = servletFileUpload.parseRequest(req);
        } catch (FileUploadException e) {
            req.getSession().setAttribute("error", 500);
            req.getSession().setAttribute("error_msg", "Internal Server Error: " + e.getMessage());
            e.printStackTrace();
            resp.sendRedirect("/");
            return;
        }
        final Map<String, String> parameters = new HashMap<>();
        FileItem imageFile = null;
        for (FileItem fileItem : fileItems) {
            if (fileItem.isFormField()) {
                parameters.put(fileItem.getFieldName(), fileItem.getString("UTF-8"));
            } else {
                imageFile = fileItem;
            }
        }

        final String name = parameters.get("name");
        final String description = parameters.get("description");
        final String lockerNumString = parameters.get("lockerNum");
        final String maxLoanDurationString = parameters.get("maxLoanDuration");

        final User user = Tools.getUser(req);

        if (name == null || description == null || lockerNumString == null || maxLoanDurationString == null) {
            // Missing parameter
            req.getSession().setAttribute("error", 400);
            req.getSession().setAttribute("error_msg", "Bad Request: Missing parameter");
            resp.sendRedirect("/item/register");
        } else {
            final int lockerNum, maxLoanDuration;
            try {
                lockerNum = Integer.parseInt(lockerNumString);
                maxLoanDuration = Integer.parseInt(maxLoanDurationString);
                if (lockerNum < Constants.LOCKER_NUM_MIN ||
                        lockerNum > Constants.LOCKER_NUM_MAX ||
                        maxLoanDuration < Constants.MAX_LOAN_DURATION_MIN) {
                    throw new IllegalArgumentException();
                }
            } catch (final IllegalArgumentException e) {
                // Invalid parameter type
                req.getSession().setAttribute("error", 400);
                req.getSession().setAttribute("error_msg", "Bad Request: Invalid parameter type");
                resp.sendRedirect("/item/register");
                return;
            }
            String filePathString = null;
            if (imageFile != null) {
                final String imageFileName = imageFile.getName();
                final String[] imageFileNameSplit = imageFileName.split("\\.");
                final String imageFileType = imageFileNameSplit[imageFileNameSplit.length - 1];
                switch (imageFileType.toLowerCase()) {
                    case "png":
                    case "jpg":
                    case "jpeg":
                    case "gif":
                        break;
                    default:
                        // Invalid parameter type
                        req.getSession().setAttribute("error", 400);
                        req.getSession().setAttribute("error_msg", "Bad Request: Invalid file type");
                        resp.sendRedirect("/item/register");
                        return;
                }
                filePathString = UPLOAD_DIRECTORY + File.separatorChar + UUID.randomUUID().toString().replace("-", "") + '.' + imageFileType;
                try {
                    imageFile.write(Paths.get(getServletContext().getRealPath(File.separator), filePathString).toFile());
                } catch (Exception e) {
                    req.getSession().setAttribute("error", 500);
                    req.getSession().setAttribute("error_msg", "Internal Server Error: Failed to write file: " + e.getMessage());
                    e.printStackTrace();
                    resp.sendRedirect("/item/register");
                    return;
                }
            }

            final Item item = new Item(user.getId(), name, filePathString, description, lockerNum, maxLoanDuration);
            /*ARDUINO : ArduinoInterface.insertProduct(item.getLockerNum()); */
            this.itemDao.create(item);
            req.getSession().setAttribute("success_msg", "Successfully registered new item \"" + item.getName() + '"');
            resp.sendRedirect("/item/awaiting-approval");
        }
    }
}
