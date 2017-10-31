import org.junit.Before;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * init jdbc
 * Created by xsyzx on 2017/10/24.
 */
public class BaseTestCase {
    protected ClassPathXmlApplicationContext ctx;

    @Before
    public void init() {
        ctx = new ClassPathXmlApplicationContext(
                "conf/spring-mybatis.xml",
                "conf/spring-service.xml",
                "conf/spring-web.xml"
        );

    }
}
