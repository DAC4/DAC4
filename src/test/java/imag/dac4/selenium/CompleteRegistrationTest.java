package imag.dac4.selenium;

import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import java.math.BigInteger;
import java.util.Random;

public class CompleteRegistrationTest {

    @Test
    public void testRegistration() throws Exception {
        System.out.println("Starting Complete Registration Test");

        final WebDriver driver = TestSuiteSelenium.getDriver();
        final String randomString = new BigInteger(130, new Random()).toString(32);
        driver.get(TestSuiteSelenium.BASE_URL);
        driver.findElement(By.linkText("Register")).click();
        driver.findElement(By.cssSelector("div.field > #login")).clear();
        driver.findElement(By.cssSelector("div.field > #login")).sendKeys(randomString);
        driver.findElement(By.cssSelector("div.field > #password")).clear();
        driver.findElement(By.cssSelector("div.field > #password")).sendKeys(randomString);
        driver.findElement(By.id("passwordConfirm")).clear();
        driver.findElement(By.id("passwordConfirm")).sendKeys(randomString);
        driver.findElement(By.id("name")).clear();
        driver.findElement(By.id("name")).sendKeys(randomString);
        driver.findElement(By.id("email")).clear();
        driver.findElement(By.id("email")).sendKeys(randomString);
        driver.findElement(By.xpath("//input[@value='Register']")).click();
        driver.findElement(By.id("email")).clear();
        driver.findElement(By.id("email")).sendKeys(randomString + "@example.com");
        driver.findElement(By.xpath("//input[@value='Register']")).click();
        driver.findElement(By.id("login")).clear();
        driver.findElement(By.id("login")).sendKeys("admin");
        driver.findElement(By.id("password")).clear();
        driver.findElement(By.id("password")).sendKeys("admin");
        driver.findElement(By.xpath("//input[@value='Login']")).click();
        driver.findElement(By.xpath("//div[@id='header']/a[@data-menu='admin-users']/div")).click();
        driver.findElement(By.xpath("//tr[@data-login='" + randomString + "']/input[@value='Approve']")).click();
        driver.findElement(By.linkText("Logout")).click();
        driver.findElement(By.id("login")).clear();
        driver.findElement(By.id("login")).sendKeys("chat");
        driver.findElement(By.id("password")).clear();
        driver.findElement(By.id("password")).sendKeys("chat");
        driver.findElement(By.xpath("//input[@value='Login']")).click();
        driver.findElement(By.xpath("//div[@id='header']/a[2]/div/span")).click();

        System.out.println("Ending Complete Registration Test");
    }
}
