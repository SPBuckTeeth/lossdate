package exsolider.service;

import exsolider.entity.User;

/**
 * User Service
 * Created by xsyzx on 2017/10/24.
 */
public interface UserService {
    /**
     * 登入功能
     * @param userName 用户输入的用户名
     * @param password 用户输入的密码
     * @return 如果登入成功返回用户信息
     * @throws NameException 用户名错误
     * @throws PasswordException 密码错误
     */
    User regist(String userName, String nickName, String password, String confirm,String mailAddress) throws UserExistException,NameException,PasswordException;
}
