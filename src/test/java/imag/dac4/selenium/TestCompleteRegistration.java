package imag.dac4.selenium;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;

import java.util.concurrent.TimeUnit;

public class TestCompleteRegistration {

    private WebDriver driver;
    private String    baseUrl;

    @Before
    public void setUp() throws Exception {
        driver = new FirefoxDriver();
        baseUrl = "http://dac.ribesg.fr/";
        driver.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
    }

    @Test
    public void testRegistration() throws Exception {
        driver.get(baseUrl + "/");
        driver.findElement(By.linkText("Register")).click();
        driver.findElement(By.cssSelector("div.field > #login")).clear();
        driver.findElement(By.cssSelector("div.field > #login")).sendKeys("chat");
        driver.findElement(By.cssSelector("div.field > #password")).clear();
        driver.findElement(By.cssSelector("div.field > #password")).sendKeys("chat");
        driver.findElement(By.id("passwordConfirm")).clear();
        driver.findElement(By.id("passwordConfirm")).sendKeys("chat");
        driver.findElement(By.id("name")).clear();
        driver.findElement(By.id("name")).sendKeys("chat");
        driver.findElement(By.id("email")).clear();
        driver.findElement(By.id("email")).sendKeys("chat");
        driver.findElement(By.xpath("//input[@value='Register']")).click();
        driver.findElement(By.id("email")).clear();
        driver.findElement(By.id("email")).sendKeys("nouvc@gmail.com");
        driver.findElement(By.xpath("//input[@value='Register']")).click();
        driver.findElement(By.id("login")).clear();
        driver.findElement(By.id("login")).sendKeys("admin");
        driver.findElement(By.id("password")).clear();
        driver.findElement(By.id("password")).sendKeys("admin");
        driver.findElement(By.xpath("//input[@value='Login']")).click();
        driver.findElement(By.xpath("//div[@id='header']/a[2]/div")).click();
        driver.findElement(By.xpath("(//input[@value='Approve'])[2]")).click();
        driver.findElement(By.linkText("Logout")).click();
        driver.findElement(By.id("login")).clear();
        driver.findElement(By.id("login")).sendKeys("chat");
        driver.findElement(By.id("password")).clear();
        driver.findElement(By.id("password")).sendKeys("chat");
        driver.findElement(By.xpath("//input[@value='Login']")).click();
        driver.findElement(By.xpath("//div[@id='header']/a[2]/div/span")).click();
    }

    @After
    public void tearDown() throws Exception {
        driver.quit();
    }
}
