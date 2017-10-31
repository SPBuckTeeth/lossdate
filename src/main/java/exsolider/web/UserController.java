package exsolider.web;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import exsolider.entity.User;
import exsolider.service.UserExistException;
import exsolider.service.UserService;
import exsolider.util.JsonResult;
import exsolider.util.VerifyCodeUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * User Controller
 * @author  xsyzx
 * 2017/10/24.
 */
@Controller
@RequestMapping("/user")
public class UserController extends BaseController {
    @Resource
    private UserService userService;

    /**
     * 进入注册页面
     * 10/27/2017 PM
     * @return regist.jsp
     */
    @RequestMapping("/showRegist")
    public String toIndex() {
        return "regist";
    }

    /**
     * 注册
     * 10/30/2017 PM
     * @param data 注册信息
     * @param request request
     * @return JsonResult<User>
     */
    @RequestMapping("/regist.do")
    @ResponseBody
    public JsonResult<User> regist(@RequestParam("data") String data,HttpServletRequest request) {
        JSONObject paramMap = JSON.parseObject(data);
        String userName = paramMap.getString("userName");
        String nickName = paramMap.getString("nickName");
        String password = paramMap.getString("password");
        //确认密码
        String confirm = paramMap.getString("confirm");
        //验证码
        String vertification = paramMap.getString("vertification");
        String mailAddress = paramMap.getString("mailAddress");
        HttpSession session = request.getSession();
        String correctCode = (String) session.getAttribute("verifyCode");

        if("".equals(correctCode) || correctCode == null) {
            throw new UserExistException("验证码请求超时，请刷新页面重试");
        } else if(!vertification.equals(correctCode)) {
            throw new UserExistException("验证码错误");
        }
        User user = userService.regist(userName, nickName, password, confirm,mailAddress);
        return new JsonResult<User>(user);
    }

    /**
     * 生成验证码
     * 10/30/2017 PM
     * @param req request
     * @param resp response
     * @throws IOException 抛出异常
     */
    @RequestMapping("/vertification.do")
    public void vertificationGenetation(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setHeader("Pragma", "No-cache");
        resp.setHeader("Cache-Control", "no-cache");
        resp.setDateHeader("Expires", 0);
        resp.setContentType("image/jpeg");

        //生成随机字串
        String verifyCode = VerifyCodeUtils.generateVerifyCode(4);
        //存入会话session
        HttpSession session = req.getSession(true);
        session.setAttribute("verifyCode", verifyCode.toLowerCase());
        //生成图片
        int w = 200, h = 80;
        VerifyCodeUtils.outputImage(w, h, resp.getOutputStream(), verifyCode);
    }

    /**
     * 验证码检验
     * 10/30/2017 PM
     * @param data 验证码
     * @param request request
     * @param out 验证结果
     */
    @RequestMapping("/checkVertification")
    public void checkVertificationCode(@RequestParam("data") String data, HttpServletRequest request, java.io.PrintWriter out) {
        JSONObject jsonMap = JSON.parseObject(data);
        String code = jsonMap.getString("code").toLowerCase();
        HttpSession session = request.getSession();
        String correctCode = (String) session.getAttribute("verifyCode");
        if(correctCode.equals(code)) {
            out.print("True");
        } else {
            out.print("False");
        }
    }

}
