package imag.dac4.selenium;

import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.runner.RunWith;
import org.junit.runners.Suite;
import org.openqa.selenium.Dimension;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxBinary;
import org.openqa.selenium.firefox.FirefoxDriver;

import java.util.concurrent.TimeUnit;

@RunWith(Suite.class)
@Suite.SuiteClasses(
    {
        CompleteRegistrationTest.class,
        AddItemTest.class,
        BorrowItemTest.class,
        ReturnItemTest.class,
        DeleteItemTest.class
    }
)
public class TestSuiteSelenium {

    public static final  String BASE_URL;
    private static final String DISPLAY;

    static {
        final String url = System.getProperty("trocbox.test.instanceUrl");
        // Use provided URL or fallback to default Glassfish port on localhost
        BASE_URL = url == null ? "http://localhost:8080" : url;

        final String display = System.getProperty("trocbox.test.display");
        // Use provided display or fallback to default :0 value
        DISPLAY = display == null ? ":0" : display;
    }

    private static WebDriver driver;

    public static WebDriver getDriver() {
        return TestSuiteSelenium.driver;
    }

    @BeforeClass
    public static void setUp() {
        System.out.println("Initializing Selenium Test Suite. Creating Firefox Driver...");

        final FirefoxBinary bin = new FirefoxBinary();
        bin.setEnvironmentProperty("DISPLAY", DISPLAY);
        driver = new FirefoxDriver(bin, null);
        driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
        driver.manage().timeouts().pageLoadTimeout(30, TimeUnit.SECONDS);
        driver.manage().window().setSize(new Dimension(1280, 720));

        System.out.println("Firefox Driver ready, launching test suite");
    }

    @Before
    public static void setUpSingleTest() {
        System.out.println("Cleaning cookies for next test");

        driver.manage().deleteAllCookies();
    }

    @AfterClass
    public static void tearDown() {
        System.out.println("End of test suite, stopping Firefox Driver");

        driver.quit();

        System.out.println("Terminated Selenium Test Suite.");
    }
}
