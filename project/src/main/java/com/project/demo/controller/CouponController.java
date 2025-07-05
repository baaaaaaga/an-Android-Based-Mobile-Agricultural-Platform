package com.project.demo.controller;

import com.project.demo.controller.base.BaseController;
import com.project.demo.entity.Coupon;
import com.project.demo.service.CouponService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 优惠券：(Coupon)表控制层
 *
 */
@RestController
@RequestMapping("coupon")
public class CouponController extends BaseController<Coupon, CouponService> {
    /**
     * 服务对象
     */
    @Autowired
    public CouponController(CouponService service) {
        setService(service);
    }

}


