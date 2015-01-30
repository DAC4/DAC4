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

public class DeletItemTest {


  @Test
  public void testDeletItem() throws Exception {

    System.out.println("\tStarting Add Item Test");

    final WebDriver driver = TestSuiteSelenium.getDriver();
    final String randomString = new BigInteger(130, new Random()).toString(32);
    driver.get(TestSuiteSelenium.BASE_URL);

    System.out.println("\t\tEventually logging out...");

    try {
      driver.findElement(By.linkText("Logout")).click();
    } catch (final NoSuchElementException ignored) {
    }

    System.out.println("\t\tLogging in as user1...");

    driver.findElement(By.id("login")).clear();
    driver.findElement(By.id("login")).sendKeys("user1");
    driver.findElement(By.id("password")).clear();
    driver.findElement(By.id("password")).sendKeys("user1");
    driver.findElement(By.xpath("//input[@value='Login']")).click();

    System.out.println("\t\tBrowsing to Items page...");

    driver.findElement(By.xpath("//div[@id='header']/a[@data-menu='my-items']/div")).click();

    System.out.println("\t\tDeleting an object...");
    driver.findElement(By.xpath("//input[@value='Delete']")).click();

    System.out.println("\t\tVerifying the object is deleted...");

    try {
      final WebElement e = driver.findElement(By.linkText("Success!"));
    } catch (final NoSuchElementException ignored) {
    }

    System.out.println("\t\tLogging out...");

    driver.findElement(By.linkText("Logout")).click();

  }
}
