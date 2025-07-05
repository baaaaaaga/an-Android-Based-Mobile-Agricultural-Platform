package com.project.demo.controller;

import com.project.demo.controller.base.BaseController;
import com.project.demo.entity.LogisticsDelivery;
import com.project.demo.service.LogisticsDeliveryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 物流
 *
 */
@RestController
@RequestMapping("logistics_delivery")
public class LogisticsDeliveryController extends BaseController<LogisticsDelivery, LogisticsDeliveryService> {
    /**
     * 服务对象
     */
    @Autowired
    public LogisticsDeliveryController(LogisticsDeliveryService service) {
        setService(service);
    }

}


