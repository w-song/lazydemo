/**
 * <p>Copyright ® 2002 东软  软件开发事业部版权所有。</p>
 */
package com.thinkgem.jeesite.modules.ftpfile.web;

import java.util.List;

import org.apache.shiro.authz.annotation.RequiresUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.ftpfile.entity.FtpFile;
import com.thinkgem.jeesite.modules.ftpfile.service.FtpFileService;

/**
 * FTP管理Controller
 * 
 * @author MingYi
 * @version 2015-08-13
 */
@Controller
@RequestMapping(value = "${adminPath}/ftpFile")
public class FtpFileController extends BaseController {

    @Autowired
    private FtpFileService ftpFileService;

    /**
     * 上传文件
     * 
     * @param request
     * @param batchId
     *            批量编号
     * @return
     * @author MingYi
     * @date 2015年8月17日
     * @throws
     */
    @RequiresUser
    @ResponseBody
    @RequestMapping(value = "upload", method = RequestMethod.POST)
    public List<FtpFile> upload(MultipartHttpServletRequest request, String batchId) {
        List<FtpFile> list = null;
        try {
            list = ftpFileService.upload(request, batchId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * 删除文件
     * 
     * @param ftpFile
     */
    @RequiresUser
    @ResponseBody
    @RequestMapping(value = "delete", method = RequestMethod.POST)
    public void delete(FtpFile ftpFile) {
        ftpFileService.delete(ftpFile);
    }

}