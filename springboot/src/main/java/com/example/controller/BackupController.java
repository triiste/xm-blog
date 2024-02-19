package com.example.controller;


import com.example.common.Result;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

@RestController
@RequestMapping("back")
public class BackupController {
    //服务器的 62.234.62.75
    public String host = "62.234.62.75";
    public String port = "3308";
    public String database = "xm_blog";
    public String username = "root";
    public String password = "926424qq!";
//  public String password = "123456";

    String backupPath = System.getProperty("user.dir") + "/sql/" + "backup"+".sql";
//    String backupPath = "C:/backup.sql";
    //备份成功
    @GetMapping("/backup")
    public Result backup(){
        try {
            ProcessBuilder processBuilder = new ProcessBuilder(
                    "mysqldump",
                    "--host=" + host,
                    "--port=" + port,
                    "--user=" + username,
                    "--password=" + password,
                    "--databases",
                    database,
                    "--result-file=" + backupPath
            );
            Process process = processBuilder.start();
            int exitCode = process.waitFor();
            if (exitCode == 0) {
                //备份一次写入数据库
                return Result.success();
            } else {
                System.out.println("备份失败");
                return  Result.error("-1","备份失败");
            }
        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
        }
        return Result.success();
    }
    //执行备份的sql文件
    @GetMapping("excute")
    public Result excute() throws IOException, InterruptedException {
        String command = "mysql";
        try {
            // 定义命令和参数
            // 创建ProcessBuilder对象
            ProcessBuilder processBuilder = new ProcessBuilder(
                    command,
                    "-u" + username,
                    "-p" + password,
                    database,
                    "-e",
                    "source " + backupPath
            );

            // 启动进程
            Process process = processBuilder.start();
            System.out.println("有什么问题");

            // 读取错误输出流
            try (BufferedReader br = new BufferedReader(new InputStreamReader(process.getErrorStream()))) {
                String line;
                while ((line = br.readLine()) != null) {
                    System.out.println(line);
                }
            }

            // 等待进程执行完成
            int exitCode = process.waitFor();
            System.out.println(exitCode);
            if (exitCode == 0) {
                return Result.success();
            } else {
                return Result.error("-1","导入文件出错");
            }
        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
        }
        return Result.success();
    }
}
