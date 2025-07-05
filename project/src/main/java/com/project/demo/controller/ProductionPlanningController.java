package com.project.demo.controller;

import com.project.demo.entity.ProductionPlanning;
import com.project.demo.service.ProductionPlanningService;
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
 * 生产计划：(ProductionPlanning)表控制层
 *
 */
@RestController
@RequestMapping("/production_planning")
public class ProductionPlanningController extends BaseController<ProductionPlanning, ProductionPlanningService> {

    /**
     * 生产计划对象
     */
    @Autowired
    public ProductionPlanningController(ProductionPlanningService service) {
        setService(service);
    }



    @PostMapping("/add")
    @Transactional
    public Map<String, Object> add(HttpServletRequest request) throws IOException {
        Map<String,Object> paramMap = service.readBody(request.getReader());
        Map<String, String> mapplan_no = new HashMap<>();
        mapplan_no.put("plan_no",String.valueOf(paramMap.get("plan_no")));
        List listplan_no = service.selectBaseList(service.select(mapplan_no, new HashMap<>()));
        if (listplan_no.size()>0){
            return error(30000, "字段计划编号内容不能重复");
        }
        this.addMap(paramMap);
        return success(1);
    }


}
