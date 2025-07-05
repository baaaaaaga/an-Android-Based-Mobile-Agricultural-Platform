package com.project.demo.controller;

import com.project.demo.entity.OriginDisplay;
import com.project.demo.service.OriginDisplayService;
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
 * 产地展示：(OriginDisplay)表控制层
 *
 */
@RestController
@RequestMapping("/origin_display")
public class OriginDisplayController extends BaseController<OriginDisplay, OriginDisplayService> {

    /**
     * 产地展示对象
     */
    @Autowired
    public OriginDisplayController(OriginDisplayService service) {
        setService(service);
    }



    @PostMapping("/add")
    @Transactional
    public Map<String, Object> add(HttpServletRequest request) throws IOException {
        Map<String,Object> paramMap = service.readBody(request.getReader());
        this.addMap(paramMap);
        return success(1);
    }
    /**
     * 协同过滤算法
     */
    @RequestMapping("/get_hits_list")
    public Map<String, Object> getHits(HttpServletRequest request) {
        Map<String,String> paramMap = service.readQuery(request);
        if (paramMap.get("user_id")==null||paramMap.get("user_id").equals("")){
			            return this.getList(request);
			        }else{
            try {
                if (paramMap.get("examine_state")!=null && !paramMap.get("examine_state").equals("")){
                    paramMap.put("examine_state", URLDecoder.decode(paramMap.get("examine_state"), "UTF-8"));
                }
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
						//查询该用户收藏
			String hitsSource = "SELECT COUNT( collect_id ) AS hits_count, source_id FROM collect WHERE source_table = 'origin_display' AND user_id = "+paramMap.get("user_id")+" GROUP BY source_id ORDER BY create_time desc";
						            List<Map<String,Object>> hitsSourceList = service.selectMapBaseList(hitsSource);
			            //判断是否为空,代表当前用户暂无点击数据，那么取其他用户的最常点击
            if (hitsSourceList==null || hitsSourceList.size()<=0){
								hitsSource = "SELECT COUNT( collect_id ) AS hits_count, source_id FROM collect WHERE source_table = 'origin_display' GROUP BY source_id ORDER BY create_time desc";
								                hitsSourceList = service.selectMapBaseList(hitsSource);
				            }
						String table_name = "origin_display";
			String table_id = "origin_display_id";
			String type_name = "type_of_place_of_origin";
			            //二次处理-如果依旧为空则取添加时间前12条数据
            if (hitsSourceList==null || hitsSourceList.size()<=0){
                String sql = "SELECT * FROM " + table_name;
                if (paramMap.get("examine_state")!=null && !paramMap.get("examine_state").equals("")){
                    sql = sql + " where examine_state = '"+paramMap.get("examine_state")+"'";
                }
                sql = sql + " ORDER BY create_time DESC LIMIT 0,12";
								List list = service.selectBaseList(sql);
				                Map<String, Object> map=new HashMap<>();
                map.put("list",list);
                map.put("count",list.size());
                return success(map);
            }else {
                //对用户点击量进行排序取得最大值
                int max = 0;
                int maxSourceId = 0;
                for (Map<String,Object> map:hitsSourceList) {
                    int hitsCount = Integer.parseInt(String.valueOf(map.get("hits_count")));
                    if (hitsCount > max){
                        max = hitsCount;
						                        maxSourceId = Integer.parseInt(String.valueOf(map.get("source_id")));
						                    }
                }
                //查询该用户点击最大值的种类
                String typeSql = "SELECT " + type_name + " FROM "  + table_name + " WHERE " + table_id + " = " + maxSourceId;
				                List<Map<String,Object>> typeList = service.selectMapBaseList(typeSql);
				                //如果为空则取添加时间前12条数据
                if (typeList==null || typeList.size()<=0){
                    String sql = "SELECT * FROM " + table_name;
                    if (paramMap.get("examine_state")!=null && !paramMap.get("examine_state").equals("")){
                        sql = sql + " where examine_state = '"+paramMap.get("examine_state")+"'";
                    }
                    sql = sql + " ORDER BY create_time DESC LIMIT 0,12";
					                    List list = service.selectBaseList(sql);
					                    Map<String, Object> map=new HashMap<>();
                    map.put("list",list);
                    map.put("count",list.size());
                    return success(map);
                }else {
                    String typeName = String.valueOf(typeList.get(0).get(type_name));
                    //查询该种类的数据
                    String sql = "SELECT * FROM "  + table_name + " WHERE " + type_name + " = '"+typeName+"'" ;
                    if (paramMap.get("examine_state")!=null && !paramMap.get("examine_state").equals("")){
                        sql = sql + " and examine_state = '"+paramMap.get("examine_state")+"' ORDER BY create_time DESC limit 0,12";
                    }else {
                        sql = sql + " ORDER BY create_time DESC limit 0,12";
                    }
					                    List resultList = service.selectBaseList(sql);
					                    //如果为空则取添加时间前12条数据
                    if (resultList==null || resultList.size()<=0){
                        sql = "SELECT * FROM " + table_name;
                        if (paramMap.get("examine_state")!=null && !paramMap.get("examine_state").equals("")){
                            sql = sql + " where examine_state = '"+paramMap.get("examine_state")+"'";
                        }
                        sql = sql + " ORDER BY create_time DESC LIMIT 0,12";
						                        List list = service.selectBaseList(sql);
						                        Map<String, Object> map=new HashMap<>();
                        map.put("list",list);
                        map.put("count",list.size());
                        return success(map);
                    }else {
                        //对结果排序-冒泡排序
                        for (int i = resultList.size() - 1; i > 0; i--) {
                            // 是否发生交换
                            boolean swapped = false;
                            for (int j = 0; j < i; j++) {
								                                OriginDisplay leftMap = (OriginDisplay) resultList.get(j);
                                OriginDisplay rightMap = (OriginDisplay) resultList.get(j + 1);
                                if (leftMap.getHits()<rightMap.getHits()){
                                    OriginDisplay temp = rightMap;
                                    rightMap = leftMap;
                                    leftMap = temp;
                                    swapped = true;
                                }
								                            }
                            if (!swapped) {
                                // 没有发生交换，则说明数组已有序,停止冒泡
                                break;
                            }
                        }
                        //判断是否有12条-如果不足则计算其他类型和用户当前点击最多的余弦相似度，依次往下取得数据
                        if (resultList.size()<12) {
                            String typeCosSql = "SELECT " + type_name + " FROM "  + table_name + " WHERE " + type_name + " <> '" + typeName + "' GROUP BY " + type_name;
							                            List<Map<String, Object>> typeCosList = service.selectMapBaseList(typeCosSql);
							                            if (typeCosList != null && typeCosList.size() > 0) {
                                for (Map<String, Object> typeCos : typeCosList) {
                                    typeCos.put("cosSim", calculateCosineSimilarity(typeName, String.valueOf(typeCos.get(type_name))));
                                }
                                //冒泡根据相似度排序
                                for (int i = typeCosList.size() - 1; i > 0; i--) {
                                    // 是否发生交换
                                    boolean swapped = false;
                                    for (int j = 0; j < i; j++) {
                                        Map<String, Object> leftMap = typeCosList.get(j);
                                        Map<String, Object> rightMap = typeCosList.get(j + 1);
                                        if (Double.parseDouble(String.valueOf(leftMap.get("cosSim" ))) < Double.parseDouble(String.valueOf(rightMap.get("cosSim" )))) {
                                            Map<String, Object> temp = rightMap;
                                            rightMap = leftMap;
                                            leftMap = temp;
                                            swapped = true;
                                        }
                                    }
                                    if (!swapped) {
                                        // 没有发生交换，则说明数组已有序,停止冒泡
                                        break;
                                    }
                                }
                                //逐条加入数据
                                for (Map<String, Object> typeCos : typeCosList) {
                                    sql = "SELECT * FROM "  + table_name + " WHERE " + type_name + " = '" + String.valueOf(typeCos.get(type_name)) + "'";
                                    if (paramMap.get("examine_state")!=null && !paramMap.get("examine_state").equals("")){
                                        sql = sql + " and examine_state = '"+paramMap.get("examine_state")+"'";
                                    }
                                    sql = sql + " ORDER BY create_time DESC LIMIT 0," + (12 - resultList.size());
									                                    List list = service.selectBaseList(sql);
									                                    if (list != null && list.size() > 0) {
                                        resultList.addAll(list);
                                    }
                                    if (resultList.size() >= 12) {
                                        break;
                                    }
                                }
                            }
                        }
                        Map<String, Object> map=new HashMap<>();
                        map.put("list",resultList);
                        map.put("count",resultList.size());
                        return success(map);
                    }
                }

            }
        }
    }

    /**
     * 计算余弦相似度
     */
    private double calculateCosineSimilarity(String text1, String text2) {
        // 将文本分词并转换为向量表示
        Map<Character, Integer> wordCount1 = getWordCount(text1);
        Map<Character, Integer> wordCount2 = getWordCount(text2);

        double dotProduct = 0.0;
        double magnitude1 = 0.0;
        double magnitude2 = 0.0;

        for (Character word : wordCount1.keySet()) {
            int count1 = wordCount1.get(word);
            int count2 = wordCount2.getOrDefault(word, 0);
            dotProduct += count1 * count2;
            magnitude1 += Math.pow(count1, 2);
        }

        for (Integer count : wordCount2.values()) {
            magnitude2 += Math.pow(count, 2);
        }

        magnitude1 = Math.sqrt(magnitude1);
        magnitude2 = Math.sqrt(magnitude2);

        if (magnitude1 == 0.0 || magnitude2 == 0.0) {
            return 0.0;
        }

        return dotProduct / (magnitude1 * magnitude2);
    }

    private static Map<Character, Integer> getWordCount(String text) {
        Map<Character, Integer> wordCount = new HashMap<>();
        for (char c : text.toCharArray()) {
            wordCount.put(c, wordCount.getOrDefault(c, 0) + 1);
        }
        return wordCount;
    }


}
