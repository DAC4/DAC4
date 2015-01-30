package imag.dac4;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;

import java.util.Arrays;
import java.util.Collection;

@RunWith(Parameterized.class)
public class TestEmailRegex {

    @Parameterized.Parameters
    public static Collection<Object[]> data() {
        return Arrays.asList(new Object[][]{
            {"test@test.test", true},
            {"TEST@TEST.TEST", true},
            {"test", false},
            {"test@test", false},
            {"test@", false},
            {"test@.", false},
            {"test@.test", false},
            {"&test@test.test", false},
            {"test@test.", false},
        });
    }

    private final String  email;
    private final boolean isValid;

    public TestEmailRegex(String email, boolean isValid) {
        this.email = email;
        this.isValid = isValid;
    }

    @Test
    public void testEmailRegex() {
        Assert.assertTrue(Constants.EMAIL_PATTERN.matcher(this.email).matches() == this.isValid);
    }
}
