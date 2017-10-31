package exsolider.service.impl;

import exsolider.dao.UserDao;
import exsolider.entity.User;
import exsolider.service.NameException;
import exsolider.service.PasswordException;
import exsolider.service.UserExistException;
import exsolider.service.UserService;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.UUID;

/**
 * UserServiceImpl
 * Created by xsyzx on 2017/10/24.
 */
@Service("userService")
public class UserServiceImpl implements UserService {
    @Resource
    private UserDao userDao;

    /**
     * 注册
     * 10/30/2017 PM
     * @param userName 用户输入的用户名
     * @param nickName nickName
     * @param password 用户输入的密码
     * @param confirm 确认密码
     * @param mailAddress 邮箱地址
     * @return User
     * @throws UserExistException UserExistException
     * @throws NameException NameException
     * @throws PasswordException PasswordException
     */
    public User regist(String userName, String nickName, String password, String confirm, String mailAddress) throws UserExistException, NameException, PasswordException {
        if(! password.equals(confirm)){
            throw new PasswordException("确认密码不一致");
        }
        //检查用户是否已经注册
        User user = userDao.findUserByName(userName);
        if(user!=null){
            throw new UserExistException("用户已存在");
        }

        if(nickName==null||"".equals(nickName.trim())) {
            nickName = userName;
        }
        //检查所有参数后,保存数据
        String id = UUID.randomUUID().toString();
        String token = "";
        String md5 = DigestUtils.md5Hex(password+"@lossdate");
        user = new User(id, userName, nickName, md5, token, mailAddress);
        int i = userDao.saveUser(user);
        if(i!=1){
            throw new RuntimeException("保存失败");
        }
        return user;
    }
}
