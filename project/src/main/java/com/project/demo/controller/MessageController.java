package com.project.demo.controller;

import com.project.demo.entity.Message;
import com.project.demo.service.MessageService;

import com.project.demo.controller.base.BaseController;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.web.bind.annotation.*;

/**
 * 留言板：(Message)表控制层
 *
 */
@RestController
@RequestMapping("message")
public class MessageController extends BaseController<Message, MessageService> {
    /**
     * 服务对象
     */
    @Autowired
    public MessageController(MessageService service) {
        setService(service);
    }

}


