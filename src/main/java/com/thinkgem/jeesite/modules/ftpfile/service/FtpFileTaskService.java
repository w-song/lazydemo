/**
 * <p>Copyright ® 2002 东软  软件开发事业部版权所有。</p>
 */
package com.thinkgem.jeesite.modules.ftpfile.service;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.context.annotation.Lazy;

/**
 * 定时处理文件Service
 * 
 * @author MingYi
 * @version 2015-09-10
 */
@Service
@Lazy(false)
public class FtpFileTaskService {

    @Scheduled(cron = "0 0 2 * * ?")
    public void doSomthing() {

    }
}
