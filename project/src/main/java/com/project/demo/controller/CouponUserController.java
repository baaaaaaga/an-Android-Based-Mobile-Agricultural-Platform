package com.project.demo.controller;

import com.project.demo.controller.base.BaseController;
import com.project.demo.entity.CouponUser;
import com.project.demo.service.CouponUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 优惠券用户：(CouponUser)表控制层
 *
 */
@RestController
@RequestMapping("coupon_user")
public class CouponUserController extends BaseController<CouponUser, CouponUserService> {
    /**
     * 服务对象
     */
    @Autowired
    public CouponUserController(CouponUserService service) {
        setService(service);
    }

}


