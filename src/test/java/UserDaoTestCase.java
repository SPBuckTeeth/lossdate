import org.apache.commons.codec.digest.DigestUtils;
import org.junit.Before;
import org.junit.Test;
import exsolider.dao.UserDao;
import exsolider.entity.User;

public class UserDaoTestCase extends BaseTestCase{
	
	UserDao dao;
	@Before
	public void initDao(){
		dao = ctx.getBean("userDao",UserDao.class);
	}
	
	@Test
	public void testFindUserByName(){
		String name = "zhoujia";
		User user = dao.findUserByName(name);
		System.out.println(user);
	}
	
	@Test
	public void testSaveUser(){
		String psw = "123";
		String salt = "need not to know";
		String md5 = DigestUtils.md5Hex(psw+salt);
		User user = new User("009", "Jerry", "Mouse", md5, "", "");
		int i = dao.saveUser(user);
		System.out.println(i);
	}
}
