import org.junit.Test;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.SQLException;

/**
 * test for jdbc connection
 * Created by xsyzx on 2017/10/24.
 */
public class JDBCTestCase extends BaseTestCase {
    @Test
    public void Test() throws SQLException {
        DataSource ds = ctx.getBean("dataSource",DataSource.class);
        Connection conn = ds.getConnection();
        DatabaseMetaData dmd = conn.getMetaData();
        System.out.print(dmd);
        String n = dmd.getDatabaseProductName();
        String v = dmd.getDatabaseProductVersion();
        System.out.print(n + ":" + v);
        conn.close();
    }
}
