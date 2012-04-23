public class MySiteHomeController {
    public PageReference doRedirect() {
        // Redirect to portal home page
        return new PageReference('/home/home.jsp');
    }
}