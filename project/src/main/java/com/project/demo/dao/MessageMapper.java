package com.project.demo.dao;

import com.project.demo.dao.base.BaseMapper;
import com.project.demo.entity.Message;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 留言板：Mapper接口
 *
 */
@Mapper
public interface MessageMapper extends BaseMapper<Message>
{
    /**
     * 查询留言板：
     *
     * @param messageId 留言板：ID
     * @return 留言板：
     */
    Message selectMessageById(Integer messageId);

    /**
     * 查询留言板：列表
     *
     * @param message 留言板：
     * @return 留言板：集合
     */
    List<Message> selectMessageList(Message message);

    /**
     * 新增留言板：
     *
     * @param message 留言板：
     * @return 结果
     */
    int insertMessage(Message message);

    /**
     * 修改留言板：
     *
     * @param message 留言板：
     * @return 结果
     */
    int updateMessage(Message message);

    /**
     * 删除留言板：
     *
     * @param messageId 留言板：ID
     * @return 结果
     */
    int deleteMessageById(Integer messageId);

    /**
     * 批量删除留言板：
     *
     * @param messageIds 需要删除的数据ID
     * @return 结果
     */
    int deleteMessageByIds(Integer[] messageIds);
}
