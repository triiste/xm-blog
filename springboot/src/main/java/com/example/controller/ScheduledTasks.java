package com.example.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;

/**
 * @BelongsProject: demo
 * @BelongsPackage: com.example.demo.common
 * @Author: wcf
 * @CreateTime: 2024年2月19日
 * @Description:
 * @Version:1.0
 */
@Component
public class ScheduledTasks {
    private static final Logger log = LoggerFactory.getLogger(ScheduledTasks.class);
    private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmssSS");
    @Autowired
    private BackupController backupController;
    // 每二十秒执行一次
    @Scheduled(cron = "0 0 8 * * ?")
    public void reportCurrentTime() {
        String format = dateFormat.format(System.currentTimeMillis());
        log.info("The time is now {}", format);
        backupController.backup();
    }
}

