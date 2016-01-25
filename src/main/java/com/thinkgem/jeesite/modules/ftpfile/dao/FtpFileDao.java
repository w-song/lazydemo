/**
 * <p>Copyright ® 2002 东软  软件开发事业部版权所有。</p>
 */
package com.thinkgem.jeesite.modules.ftpfile.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.ftpfile.entity.FtpFile;

/**
 * FTP管理DAO接口
 * 
 * @author MingYi
 * @version 2015-08-13
 */
@MyBatisDao
public interface FtpFileDao extends CrudDao<FtpFile> {

}