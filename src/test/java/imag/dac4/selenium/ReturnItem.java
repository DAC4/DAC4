package imag.dac4.selenium;

import java.util.regex.Pattern;
import java.util.concurrent.TimeUnit;
import org.junit.*;
import static org.junit.Assert.*;
import static org.hamcrest.CoreMatchers.*;
import org.openqa.selenium.*;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.support.ui.Select;

public class ReturnItem {

  public void testReturnItem() throws Exception {

    final WebDriver driver = TestSuiteSelenium.getDriver();
    final String login = "user1";
    final String password = "user1";

    System.out.println("\t\tEventually logging out...");

    try {
      driver.findElement(By.linkText("Logout")).click();
    } catch (final NoSuchElementException ignored) {
    }

    System.out.println("\t\tlogin in as user1 ...");

    driver.findElement(By.id("login")).clear();
    driver.findElement(By.id("login")).sendKeys(login);
    driver.findElement(By.id("password")).clear();
    driver.findElement(By.id("password")).sendKeys(password);
    driver.findElement(By.xpath("//input[@value='Login']")).click();

    System.out.println("\t\tBrowsing to Loans page...");

    driver.findElement(By.xpath("//div[@id='header']/a[@data-menu='my-loans']/div")).click();

    System.out.println("\t\tReturn an item...");

    driver.findElement(By.xpath("//input[@value='Return']")).click();
    //driver.findElement(By.xpath("//div[@id='header']/a[2]/div/span")).click();

    System.out.println("\t\tLogging out...");

    driver.findElement(By.linkText("Logout")).click();


  }
}
