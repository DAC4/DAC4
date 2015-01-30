package imag.dac4.selenium;

import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebDriver;

public class ReturnItemTest {

    @Test
    public void testReturnItem() throws Exception {
        System.out.println("\tStarting Return Item Test");

        final WebDriver driver = TestSuiteSelenium.getDriver();
        driver.get(TestSuiteSelenium.BASE_URL);

        System.out.println("\t\tEventually logging out...");

        try {
            driver.findElement(By.linkText("Logout")).click();
        } catch (final NoSuchElementException ignored) {
        }

        System.out.println("\t\tLogging in as user1...");

        driver.findElement(By.id("login")).clear();
        driver.findElement(By.id("login")).sendKeys("user2");
        driver.findElement(By.id("password")).clear();
        driver.findElement(By.id("password")).sendKeys("user2");
        driver.findElement(By.xpath("//input[@value='Login']")).click();

        System.out.println("\t\tBrowsing to Loans page...");

        driver.findElement(By.xpath("//div[@id='header']/a[@data-menu='my-loans']/div")).click();

        System.out.println("\t\tReturning an item...");

        driver.findElement(By.xpath("//input[@value='Return']")).click();

        System.out.println("\t\tVerifying success...");

        driver.findElement(By.id("success"));

        System.out.println("\tEnding Return Item Test");
    }
}
