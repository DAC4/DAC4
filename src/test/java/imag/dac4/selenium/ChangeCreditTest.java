package imag.dac4.selenium;

import org.junit.Assert;
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebDriver;

import java.math.BigInteger;
import java.util.Random;

public class ChangeCreditTest {

    @Test
    public void testChangeCredit() throws Exception {
        System.out.println("\tStarting Change Credit Test");

        final WebDriver driver = TestSuiteSelenium.getDriver();
        final String randomString = new BigInteger(130, new Random()).toString(32);
        driver.get(TestSuiteSelenium.BASE_URL);

        System.out.println("\t\tEventually logging out...");

        try {
            driver.findElement(By.linkText("Logout")).click();
        } catch (final NoSuchElementException ignored) {
        }

        driver.findElement(By.id("login")).clear();
        driver.findElement(By.id("login")).sendKeys("admin");
        driver.findElement(By.id("password")).clear();
        driver.findElement(By.id("password")).sendKeys("admin");
        driver.findElement(By.xpath("//input[@value='Login']")).click();

        System.out.println("\t\tBrowsing to Admin Users page...");

        driver.findElement(By.xpath("//div[@id='header']/a[@data-menu='admin-users']/div")).click();

        System.out.println("\t\tChanging credit...");

        driver.findElement(By.xpath("/html/body/div[2]/div/table/tbody/tr[1]/td[4]/form/div/input")).sendKeys("10");
        driver.findElement(By.xpath("/html/body/div[2]/div/table/tbody/tr[1]/td[4]/form/input[2]")).click();

        System.out.println("\t\tLogging out...");

        driver.findElement(By.linkText("Logout")).click();

        System.out.println("\t\tLogging in as user1...");

        driver.findElement(By.id("login")).clear();
        driver.findElement(By.id("login")).sendKeys("user1");
        driver.findElement(By.id("password")).clear();
        driver.findElement(By.id("password")).sendKeys("user1");
        driver.findElement(By.xpath("//input[@value='Login']")).click();

        Assert.assertTrue(driver.findElement(By.cssSelector("#footer .item.bar-text-medium span")).getText().trim().equals("Credits: 10"));

        System.out.println("\tEnding change credit Test");
    }
}
