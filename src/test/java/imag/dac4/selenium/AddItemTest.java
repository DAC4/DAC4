package imag.dac4.selenium;

import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.math.BigInteger;
import java.util.Random;

public class AddItemTest {

    @Test
    public void testAddItem() throws Exception {
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

        System.out.println("\t\tBrowsing to Item Registration page...");

        driver.findElement(By.linkText("Add an Item")).click();

        System.out.println("\t\tRegistering a new Item...");

        driver.findElement(By.id("name")).clear();
        driver.findElement(By.id("name")).sendKeys(randomString);
        driver.findElement(By.id("description")).clear();
        driver.findElement(By.id("description")).sendKeys(randomString);
        // driver.findElement(By.id("image")).sendKeys("src/test/resources/dog.jpg"); // Selenium problem or something
        final WebElement selectorDiv = driver.findElement(By.cssSelector(".ui.dropdown.selection"));
        selectorDiv.click();
        final WebElement option = selectorDiv.findElements(By.className("item")).get(0);
        new WebDriverWait(driver, 5).until(ExpectedConditions.visibilityOf(option));
        option.click();
        driver.findElement(By.id("maxLoanDuration")).clear();
        driver.findElement(By.id("maxLoanDuration")).sendKeys("10");
        driver.findElement(By.xpath("//input[@value='Register Item']")).click();

        try {
            final WebElement e = driver.findElement(By.id("error"));
            System.out.println(e.findElement(By.tagName("h2")).getText() + ": " + e.findElement(By.tagName("p")).getText());
        } catch (final NoSuchElementException ignored) {
        }

        System.out.println("\t\tBrowsing to Items page...");

        driver.findElement(By.xpath("//div[@id='header']/a[@data-menu='items']/div")).click();

        System.out.println("\t\tBrowsing to My Items page...");

        driver.findElement(By.xpath("//div[@id='header']/a[@data-menu='my-items']/div")).click();

        System.out.println("\t\tLogging out...");

        driver.findElement(By.linkText("Logout")).click();

        System.out.println("\t\tLogging in as admin...");

        driver.findElement(By.id("login")).clear();
        driver.findElement(By.id("login")).sendKeys("admin");
        driver.findElement(By.id("password")).clear();
        driver.findElement(By.id("password")).sendKeys("admin");
        driver.findElement(By.xpath("//input[@value='Login']")).click();

        System.out.println("\t\tBrowsing to Admin Items page...");

        driver.findElement(By.xpath("//div[@id='header']/a[@data-menu='admin-items']/div")).click();

        System.out.println("\t\tApproving our new Item...");

        driver.findElement(By.xpath("//tr[@data-item-name='" + randomString + "']//input[@value='Approve']")).click();

        System.out.println("\t\tLogging out...");

        driver.findElement(By.linkText("Logout")).click();

        System.out.println("\t\tLogging in as user1...");

        driver.findElement(By.id("login")).clear();
        driver.findElement(By.id("login")).sendKeys("user1");
        driver.findElement(By.id("password")).clear();
        driver.findElement(By.id("password")).sendKeys("user1");
        driver.findElement(By.xpath("//input[@value='Login']")).click();

        System.out.println("\t\tBrowsing to Items page...");

        driver.findElement(By.xpath("//div[@id='header']/a[@data-menu='items']/div")).click();

        System.out.println("\tEnding Add Item Test");
    }
}
