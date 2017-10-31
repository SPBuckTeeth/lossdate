import exsolider.entity.User;
import exsolider.service.UserService;
import org.junit.Before;
import org.junit.Test;

/**
 * Test UserService
 * Created by xsyzx on 2017/10/24.
 */
public class UserServiceTestCase extends BaseTestCase {
    UserService userService;
    @Before
    public void initService() {
        userService = ctx.getBean("userService",UserService.class);
    }

    @Test
    public void testUserServiceRegist() {
        String name = "aiai";
        String nick = "ii";
        String password = "123456";
        String confirm = "123456";
        User user = userService.regist(name, nick, password, confirm,"");
        System.out.println(user);
    }

}
