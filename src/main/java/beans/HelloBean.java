package beans;

import javax.inject.Named;

@Named
public class HelloBean {
    public String getMessage() {
        return "Hello World!";
    }
}
