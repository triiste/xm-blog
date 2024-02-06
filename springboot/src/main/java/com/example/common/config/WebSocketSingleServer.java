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
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

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
    public void onOpen(Session session, @PathParam("id") String id) {
        try {
            if (id != null && !id.isEmpty()) {
                sessionMap.put(session.getId(), session);
                userMap.put(session.getId(),id);
                long timestamp = System.currentTimeMillis();
                String value = "存在" + timestamp;
                stringRedisTemplate.opsForValue().set(id, value, 1, TimeUnit.HOURS);
                log.info("[onOpen] 新建连接，session={}, 当前在线人数为：{}", session.getId(), userMap.size());
                this.sendAllMessage(JSONUtil.toJsonStr(Dict.create().set("users", userMap.values())));
            } else {
                log.warn("[onOpen] 连接建立失败，ID为空");
            }
        } catch (Exception e) {
            log.error("[onOpen] 连接建立时发生异常", e);
        }
    }


    /**
     * 连接关闭调用的方法
     */
    @OnClose
    public void onClose(Session session) {
        try {
            //离线先删除 Redis 数据库中元素
            String userId = userMap.get(session.getId());
            if (userId != null) {
                stringRedisTemplate.delete(userId);
                userMap.remove(session.getId());
                sessionMap.remove(session.getId());
            }
        } catch (Exception e) {
            log.error("Exception during onClose:", e);
        }
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
        //先看收到的是什么消息
        log.info("服务端收到消息:{}", message);
        ImSingle imSingle = JSONUtil.toBean(message, ImSingle.class);
        imSingle.setTime(DateUtil.now());
        // 存储数据到数据库
        staticImSingleService.add(imSingle);
        String jsonStr = JSONUtil.toJsonStr(imSingle);  // 处理后的消息体
        this.sendAllMessage(jsonStr);
        log.info("[onMessage] 发送消息：{}", jsonStr);
    }


//
//    private final ScheduledExecutorService executorService = Executors.newSingleThreadScheduledExecutor();
//
//    public WebSocketSingleServer () {
//        // 每隔一段时间检查一次连接状态
//        executorService.scheduleAtFixedRate(this::checkConnectionStatus, 0, 1, TimeUnit.MINUTES);
//    }
//    private void checkConnectionStatus() {
//        System.out.println("心脏跳动"+DateUtil.now());
//        // 遍历所有连接，检查连接状态
//        for (Session session : sessionMap.values()) {
//            if (!session.isOpen()) {
//                // 连接已关闭，执行清理操作
//                log.info("连接已关闭，执行清理操作");
//                onClose(session);
//            }
//        }
//    }




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
            for (Session session : new ArrayList<>(sessionMap.values())) {
                try {
                    if (session.isOpen()) {
                        log.info("服务端给客户端[{}]发送消息{}", session.getId(), message);
                        session.getBasicRemote().sendText(message);
                    }
                } catch (IOException e) {
                    log.error("向客户端[{}]发送消息失败", session.getId(), e);
                }
            }
        } catch (ConcurrentModificationException e) {
            log.error("遍历时发生 ConcurrentModificationException", e);
        }
    }



    @Override
    public void afterPropertiesSet() {
        staticImSingleService = imSingleService;
    }
}
