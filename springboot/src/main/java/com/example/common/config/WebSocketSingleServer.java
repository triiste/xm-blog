package com.example.common.config;


import cn.hutool.core.date.DateUtil;
import cn.hutool.core.lang.Dict;

import cn.hutool.json.JSONUtil;
import com.example.entity.ImSingle;
import com.example.mapper.UserMapper;
import com.example.service.ImSingleService;
import com.example.service.UserService;
import com.example.utils.SpringUtils;
import io.lettuce.core.RedisClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;


import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/**
 * websocket服务 - 单聊
 */
@ServerEndpoint(value = "/imserverSingle/{id}")
@Component
public class WebSocketSingleServer implements InitializingBean {



    private static final Logger log = LoggerFactory.getLogger(WebSocketSingleServer.class);
    /**
     * 记录当前在线连接数
     */

    public static final Map<String, String> userMap = new ConcurrentHashMap<>();
    public static final Map<String, Session> sessionMap = new ConcurrentHashMap<>();
//
//    @Autowired
//    private StringRedisTemplate stringRedisTemplate;

    @Resource
    private UserService userService;

    @Resource
    ImSingleService imSingleService;
    static ImSingleService staticImSingleService;

    @Resource
    private StringRedisTemplate stringRedisTemplate= SpringUtils.getBean(StringRedisTemplate.class);


    /**
     * 连接建立成功调用的方法
     */
    @OnOpen
    public void onOpen(Session session,@PathParam("id") String id) {
        sessionMap.put(session.getId(), session);
        userMap.put(session.getId(),id);
        //使用Redis先缓存到数据库
//        System.out.println(id);
        long timestamp = System.currentTimeMillis();
        stringRedisTemplate.opsForValue().set(id,"存在"+timestamp);
        log.info("[onOpen] 新建连接，session={}, 当前在线人数为：{}", session.getId(), userMap.size());
        this.sendAllMessage(JSONUtil.toJsonStr(Dict.create().set("users", userMap.values())));//广播所有加入的用户
    }

    /**
     * 连接关闭调用的方法
     */
    @OnClose
    public void onClose(Session session) {
        //离线先删除redis数据库中元素
        stringRedisTemplate.delete(userMap.get(session.getId()));
        //因为我关闭了也就是下线了不能送message  退出有一点点延迟
        userMap.remove(session.getId());//删除当前用户
        sessionMap.remove(session.getId());
        log.info("[onClose] 有一连接关闭，session={}, 当前在线人数为：{}", session.getId(), userMap.size());
    }

    /**
     * 收到客户端消息后调用的方法
     * 后台收到客户端发送过来的消息
     * onMessage 是一个消息的中转站
     * 接受 浏览器端 socket.send 发送过来的 json数据
     *
     * @param message 客户端发送过来的消息
     */
    @OnMessage
    public void onMessage(String message, Session fromSession) {
        log.info("服务端收到消息:{}", message);
        ImSingle imSingle = JSONUtil.toBean(message, ImSingle.class);
        imSingle.setTime(DateUtil.now());
        // 存储数据到数据库
        staticImSingleService.add(imSingle);
        String jsonStr = JSONUtil.toJsonStr(imSingle);  // 处理后的消息体
        this.sendAllMessage(jsonStr);
        log.info("[onMessage] 发送消息：{}", jsonStr);
    }


    @OnError
    public void onError(Session session, Throwable error) {
        log.error("[onError] 发生错误", error);
    }

    /**
     * 服务端发送消息给除了自己的其他客户端
     */
    private void sendMessage(Session fromSession, String message) {
        sessionMap.values().forEach(session -> {
            if (fromSession != session) {
                log.info("服务端给客户端[{}]发送消息{}", session.getId(), message);
                try {
                    session.getBasicRemote().sendText(message);
                } catch (IOException e) {
                    log.error("服务端发送消息给客户端异常", e);
                }
            }
        });
    }

    /**
     * 服务端发送消息给所有客户端
     */
    private void sendAllMessage(String message) {
        try {
            for (Session session : sessionMap.values()) {
                log.info("服务端给客户端[{}]发送消息{}", session.getId(), message);
                session.getBasicRemote().sendText(message);
            }
        } catch (Exception e) {
            log.error("服务端发送消息给客户端失败", e);
        }
    }

    @Override
    public void afterPropertiesSet() {
        staticImSingleService = imSingleService;
    }
}
