package imag.dac4.selenium;

import java.util.regex.Pattern;
import java.util.concurrent.TimeUnit;
import org.junit.*;
import static org.junit.Assert.*;
import static org.hamcrest.CoreMatchers.*;
import org.openqa.selenium.*;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.support.ui.Select;

public class AddItemTest {
  private WebDriver driver;
  private String baseUrl;
  private boolean acceptNextAlert = true;
  private StringBuffer verificationErrors = new StringBuffer();

  @Before
  public void setUp() throws Exception {
    driver = new FirefoxDriver();
    baseUrl = "http://dac.ribesg.fr/";
    driver.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
  }

  @Test
  public void testAddItem() throws Exception {
    driver.get(baseUrl + "/");
    driver.findElement(By.id("login")).clear();
    driver.findElement(By.id("login")).sendKeys("test");
    driver.findElement(By.id("password")).clear();
    driver.findElement(By.id("password")).sendKeys("test");
    driver.findElement(By.xpath("//input[@value='Login']")).click();
    driver.findElement(By.xpath("//div[@id='header']/a[2]/div/span")).click();
    driver.findElement(By.linkText("Add an Item")).click();
    driver.findElement(By.id("name")).clear();
    driver.findElement(By.id("name")).sendKeys("Test item");
    driver.findElement(By.id("description")).clear();
    driver.findElement(By.id("description")).sendKeys("Dog");
    driver.findElement(By.id("image")).clear();
    driver.findElement(By.id("image")).sendKeys("/home/ubuntu/Desktop/TESTS/test.jpeg");
// casier 9, MaxDuration 10j
    driver.findElement(By.id("lockerNum")).clear();
    driver.findElement(By.id("lockerNum")).sendKeys("9");
    driver.findElement(By.xpath("//input[@value='Register Item']")).click();
    driver.findElement(By.id("maxLoanDuration")).clear();
    driver.findElement(By.id("maxLoanDuration")).sendKeys("10");
    driver.findElement(By.xpath("//input[@value='Register Item']")).click();
    driver.findElement(By.xpath("//div[@id='header']/a[2]/div/span")).click();
    driver.findElement(By.xpath("//div[@id='header']/a[3]/div/span")).click();
    driver.findElement(By.linkText("Logout")).click();
// approving
    driver.findElement(By.id("login")).clear();
    driver.findElement(By.id("login")).sendKeys("admin");
    driver.findElement(By.id("password")).clear();
    driver.findElement(By.id("password")).sendKeys("admin");
    driver.findElement(By.xpath("//input[@value='Login']")).click();
    driver.findElement(By.xpath("//div[@id='header']/a[3]/div/span")).click();
    driver.findElement(By.xpath("(//input[@value='Approve'])[26]")).click();
    driver.findElement(By.linkText("Logout")).click();
// verification
    driver.findElement(By.id("login")).clear();
    driver.findElement(By.id("login")).sendKeys("test");
    driver.findElement(By.id("password")).clear();
    driver.findElement(By.id("password")).sendKeys("test");
    driver.findElement(By.xpath("//input[@value='Login']")).click();
    driver.findElement(By.xpath("//div[@id='header']/a[2]/div")).click();
  }

  @After
  public void tearDown() throws Exception {
    driver.quit();
    String verificationErrorString = verificationErrors.toString();
    if (!"".equals(verificationErrorString)) {
      fail(verificationErrorString);
    }
  }

  private boolean isElementPresent(By by) {
    try {
      driver.findElement(by);
      return true;
    } catch (NoSuchElementException e) {
      return false;
    }
  }

  private boolean isAlertPresent() {
    try {
      driver.switchTo().alert();
      return true;
    } catch (NoAlertPresentException e) {
      return false;
    }
  }

  private String closeAlertAndGetItsText() {
    try {
      Alert alert = driver.switchTo().alert();
      String alertText = alert.getText();
      if (acceptNextAlert) {
        alert.accept();
      } else {
        alert.dismiss();
      }
      return alertText;
    } finally {
      acceptNextAlert = true;
    }
  }
}
