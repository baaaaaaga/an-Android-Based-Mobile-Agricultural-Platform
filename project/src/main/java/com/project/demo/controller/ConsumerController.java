package com.project.demo.controller;

import com.project.demo.entity.Consumer;
import com.project.demo.service.ConsumerService;
import com.project.demo.controller.base.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import javax.persistence.Query;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.*;


/**
 * 消费者：(Consumer)表控制层
 *
 */
@RestController
@RequestMapping("/consumer")
public class ConsumerController extends BaseController<Consumer, ConsumerService> {

    /**
     * 消费者对象
     */
    @Autowired
    public ConsumerController(ConsumerService service) {
        setService(service);
    }



    @PostMapping("/add")
    @Transactional
    public Map<String, Object> add(HttpServletRequest request) throws IOException {
        Map<String,Object> paramMap = service.readBody(request.getReader());
        this.addMap(paramMap);
        return success(1);
    }


}
