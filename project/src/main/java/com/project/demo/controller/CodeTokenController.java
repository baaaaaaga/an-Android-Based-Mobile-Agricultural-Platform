package com.project.demo.controller;

import com.project.demo.controller.base.BaseController;
import com.project.demo.entity.CodeToken;
import com.project.demo.service.CodeTokenService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 邮箱验证码：(Ad)表控制层
 */
@RestController
@RequestMapping("code_token")
public class CodeTokenController extends BaseController<CodeToken, CodeTokenService> {
    /**
     * 服务对象
     */
    @Autowired
    public CodeTokenController(CodeTokenService service) {
        setService(service);
    }

    @Autowired
    private JavaMailSender mailSender;

    /**
     * 发送验证码到邮箱API
     *
     * @param email
     * @return
     */
    @GetMapping("send_email")
    public Map<String, Object> sendEmail(String email) {
        //判断邮箱号是否为空
        if (StringUtils.isEmpty(email)) {
            return error(30000, "参数错误");
        }
        try {
            //随机生成 6位数的验证码
            int code = (int) (Math.floor(Math.random() * 900000) + 100000);

            // 创建MimeMessage对象
            MimeMessage mimeMessage = mailSender.createMimeMessage();

            // 使用MimeMessageHelper辅助类构建邮件
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);

            // 设置收件人、发件人、主题和内容
            helper.setFrom("3216252476@qq.com");  // 替换为你的QQ邮箱地址
            helper.setTo(email);
            helper.setSubject("找回密码");
            helper.setText("<h1>验证码为："+code+"</h1>", true);

            // 发送邮件
            mailSender.send(mimeMessage);
            Calendar cal = Calendar.getInstance();
            cal.add(Calendar.MINUTE,10);
            String token = service.encryption(code + "_" + cal.getTime());
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Map<String, Object> map = new HashMap<>();
            map.put("token",token);
            map.put("code",code);
            map.put("expire_time",format.format(cal.getTime()));
            this.addMap(map);
            Map<String, Object> result = new HashMap<>();
            result.put("result",1);
            result.put("token",token);
            return result;
        }catch (MessagingException e){
            e.printStackTrace();
            return error(30000, e.getMessage());
        }
    }

    @GetMapping("verify_email_code")
    public Map<String, Object> verifyEmailCode(String token,String code) {
        if (StringUtils.isEmpty(token) || StringUtils.isEmpty(code)) {
            return error(30000, "参数错误");
        }else {
            Map<String,String> queryMap = new HashMap<>();
            queryMap.put("token",token);
            Map<String,String> configMap = new HashMap<>();
            configMap.put("like","false");
            List resultList = service.selectBaseList(service.select(queryMap, configMap));
            if (resultList.size() > 0) {
                CodeToken obj = (CodeToken) resultList.get(0);
                Date now = new Date();
                if (obj.getExpire_time().after(now)){
                    if (code.equals(obj.getCode())){
                        return success(1);
                    }else {
                        return error(30000, "验证码错误");
                    }
                }else {
                    return error(30000, "验证码已失效");
                }
            }else {
                return error(30000, "token请求错误");
            }
        }
    }

}


