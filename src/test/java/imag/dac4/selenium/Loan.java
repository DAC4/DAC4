package imag.dac4.selenium;

import java.math.BigInteger;
import java.util.Random;
import java.util.regex.Pattern;
import java.util.concurrent.TimeUnit;
import org.junit.*;
import static org.junit.Assert.*;
import static org.hamcrest.CoreMatchers.*;
import org.openqa.selenium.*;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.support.ui.Select;

public class Loan {
  private WebDriver driver;
  private String baseUrl;
  private boolean acceptNextAlert = true;
  private StringBuffer verificationErrors = new StringBuffer();


  @Test
  public void testLoan() throws Exception {

    System.out.println("\tStarting Complete Registration Test");

    final WebDriver driver = TestSuiteSelenium.getDriver();
    final String login = "user1";
    final String password = "user1";

    System.out.println("\t\tlogin in as user1 ...");

    driver.findElement(By.id("login")).clear();
    driver.findElement(By.id("login")).sendKeys("laforesy");
    driver.findElement(By.id("password")).clear();
    driver.findElement(By.id("password")).sendKeys("mdp");
    driver.findElement(By.xpath("//input[@value='Login']")).click();

    System.out.println("\t\tSwitching to browse item list...");

    driver.findElement(By.xpath("//div[@id='header']/a[@data-menu='items']/div")).click();

    System.out.println("\t\tBorrow the item 2...");

    driver.findElement(By.xpath("//div[@id='header']/a[2]/div/span")).click();
    driver.findElement(By.xpath("(//input[@value='Borrow'])[2]")).click();

    System.out.println("\t\tLogging out...");

    driver.findElement(By.linkText("Logout")).click();

  }
}
