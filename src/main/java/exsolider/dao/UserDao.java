package exsolider.dao;

import exsolider.entity.User;

/**
 * UserDao
 * Created by xsyzx on 2017/10/24.
 */
public interface UserDao {
    /**
     * 根据用户名查找用户信息
     * @param name 用户名
     * @return 如果找到返回用户信息,否则返回null
     */
    User findUserByName(String name);

    /**
     * 将用户信息保存到数据库中
     * @param user 被保存的用户信息
     * @return 更新数据行数,返回1表示更新成功
     */
    int saveUser(User user);

    /**
     * 通过id查询用户
     * @param userId 用户
     * @returnid 用户信息
     */
    User findUserById(String userId);
}
