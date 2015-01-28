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
@Suite.SuiteClasses({
                      TestCompleteRegistration.class
                    })
public class SeleniumTestSuite {

    public static final String BASE_URL = "http://dac.ribesg.fr/";

    private static WebDriver driver;

    public static WebDriver getDriver() {
        return SeleniumTestSuite.driver;
    }

    @BeforeClass
    public static void setUp() {
        final FirefoxBinary bin = new FirefoxBinary();
        bin.setEnvironmentProperty("DISPLAY", ":20");
        driver = new FirefoxDriver(bin, null);
        driver.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
        driver.manage().timeouts().pageLoadTimeout(30, TimeUnit.SECONDS);
        driver.manage().window().setSize(new Dimension(1920, 1080));
    }

    @Before
    public static void setUpSingleTest() {
        driver.manage().deleteAllCookies();
    }

    @AfterClass
    public static void tearDown() {
        driver.quit();
    }
}
