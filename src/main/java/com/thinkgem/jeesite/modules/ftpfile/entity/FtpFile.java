/**
 * <p>Copyright ® 2002 东软  软件开发事业部版权所有。</p>
 */
package com.thinkgem.jeesite.modules.ftpfile.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * FTP管理Entity
 * 
 * @author MingYi
 * @version 2015-08-13
 */
public class FtpFile extends DataEntity<FtpFile> {

    private static final long serialVersionUID = 1L;
    private String batchId; // 批量编号
    private String fileName; // 文件名
    private String fileType; // 文件类型
    private String remotePath; // 远程路径
    private String icon; // 文件图标
    private String thumbnail; // 缩略图
    private String status; // 状态

    // 成功
    public final static String UPLOAD_SUCCESS = "1";
    // 失败
    public final static String UPLOAD_FAILD = "2";

    // 缩略图后缀
    public final static String THUMBNAIL_NAME = "-thumbnail";
    // 缩略图大小（PX）
    public final static Integer THUMBNAIL_SIZE = 250;

    public FtpFile() {
        super();
    }

    public FtpFile(String id) {
        super(id);
    }

    @Length(min = 0, max = 64, message = "批量编号长度必须介于 0 和 64 之间")
    public String getBatchId() {
        return batchId;
    }

    public void setBatchId(String batchId) {
        this.batchId = batchId;
    }

    @Length(min = 1, max = 255, message = "文件名长度必须介于 1 和 255 之间")
    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    @Length(min = 1, max = 64, message = "文件类型长度必须介于 1 和 64 之间")
    public String getFileType() {
        return fileType;
    }

    public void setFileType(String fileType) {
        this.fileType = fileType;
    }

    @Length(min = 1, max = 255, message = "远程路径长度必须介于 1 和 255 之间")
    public String getRemotePath() {
        return remotePath;
    }

    public void setRemotePath(String remotePath) {
        this.remotePath = remotePath;
    }

    @Length(min = 0, max = 64, message = "文件图标长度必须介于 0 和 64 之间")
    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    @Length(min = 0, max = 255, message = "缩略图长度必须介于 0 和 255 之间")
    public String getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }

    @Length(min = 1, max = 1, message = "状态长度必须介于 1 和 1 之间")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}