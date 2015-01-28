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
import java.util.logging.Logger;

@RunWith(Suite.class)
@Suite.SuiteClasses({
                      CompleteRegistrationTest.class
                    })
public class TestSuiteSelenium {

    public static final String BASE_URL = "http://dac.ribesg.fr/";

    private static final Logger LOGGER = Logger.getLogger(TestSuiteSelenium.class.getName());

    private static WebDriver driver;

    public static WebDriver getDriver() {
        return TestSuiteSelenium.driver;
    }

    @BeforeClass
    public static void setUp() {
        LOGGER.info("Initializing Selenium Test Suite. Creating Firefox Driver...");
        final FirefoxBinary bin = new FirefoxBinary();
        bin.setEnvironmentProperty("DISPLAY", ":20");
        driver = new FirefoxDriver(bin, null);
        driver.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
        driver.manage().timeouts().pageLoadTimeout(30, TimeUnit.SECONDS);
        driver.manage().window().setSize(new Dimension(1920, 1080));
        LOGGER.info("Firefox Driver ready, launching test suite");
    }

    @Before
    public static void setUpSingleTest() {
        LOGGER.info("Cleaning cookies for next test");
        driver.manage().deleteAllCookies();
    }

    @AfterClass
    public static void tearDown() {
        LOGGER.info("End of test suite, stopping Firefox Driver");
        driver.quit();
        LOGGER.info("Terminated Selenium Test Suite.");
    }
}
