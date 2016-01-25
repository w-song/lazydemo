/**
 * <p>Copyright ® 2002 东软  软件开发事业部版权所有。</p>
 */
package com.thinkgem.jeesite.modules.ftpfile.service;

import java.awt.image.BufferedImage;
import java.awt.image.ImagingOpException;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Iterator;
import java.util.List;

import javax.imageio.ImageIO;

import org.apache.commons.lang3.StringUtils;
import org.imgscalr.Scalr;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.FileUtils;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.modules.ftpfile.entity.FtpFile;
import com.thinkgem.jeesite.modules.ftpfile.utils.FTPUtil;
import com.thinkgem.jeesite.modules.ftpfile.utils.FileTypeJudge;
import com.thinkgem.jeesite.modules.ftpfile.dao.FtpFileDao;

/**
 * FTP文件处理Service
 * 
 * @author MingYi
 * @version 2015-08-13
 */
@Service
@Transactional(readOnly = true)
public class FtpFileService extends CrudService<FtpFileDao, FtpFile> {

    /**
     * 获取单个实体
     */
    public FtpFile get(String id) {
        return super.get(id);
    }

    /**
     * 通过实体查询列表
     */
    public List<FtpFile> findList(FtpFile ftpFile) {
        return super.findList(ftpFile);
    }

    /**
     * 通过批量编号查询列表
     * 
     * @param batchId
     * @return
     * @author MingYi
     * @date 2015年8月19日
     * @throws
     */
    public List<FtpFile> findList(String batchId) {
        FtpFile ftpFile = new FtpFile();
        ftpFile.setBatchId(batchId);
        return super.findList(ftpFile);
    }

    /**
     * 上传文件
     * 
     * @param request
     * @param batchId
     *            批量编号
     * @return
     * @throws Exception
     * @author MingYi
     * @date 2015年8月17日
     * @throws
     */
    @Transactional(readOnly = false)
    public List<FtpFile> upload(MultipartHttpServletRequest request, String batchId) throws Exception {
        List<FtpFile> list = Lists.newArrayList();
        // 获得文件名
        Iterator<String> names = request.getFileNames();
        // 批量编号
        if (StringUtils.isEmpty(batchId)) {
            batchId = IdGen.uuid();
        }
        while (names.hasNext()) {
            // 获得单个文件
            MultipartFile file = request.getFile(names.next());
            // 上传文件
            FtpFile ftpFile = new FtpFile();
            // 设置编号
            ftpFile.setBatchId(batchId);
            ftpFile = uploadFtpFile(file, ftpFile);
            list.add(ftpFile);
        }
        return list;
    }

    /**
     * 上传文件单个文件
     * 
     * @param file
     * @param ftpFile
     * @return
     * @throws Exception
     * @author MingYi
     * @date 2015年8月17日
     * @throws
     */
    @Transactional(readOnly = false)
    private FtpFile uploadFtpFile(MultipartFile file, FtpFile ftpFile) throws Exception {
        // 文件类型归类
        String fileCategory = FileTypeJudge.getFileCategory(file.getInputStream());
        // 远程路径
        String remotePath = FileUtils.getTodayPath();
        // 后缀名
        String fileType = FileUtils.getfileType(file.getOriginalFilename());
        // FTP文件名
        String fileName = FileUtils.getRandomFileName();
        // 设置路径
        ftpFile.setRemotePath(remotePath);
        ftpFile.setFileName(fileName);
        ftpFile.setFileType(fileType);
        ftpFile.setIcon(fileCategory);
        // 上传及保存
        saveFtpFile(file, ftpFile);
        return ftpFile;
    }

    /**
     * 上传至FTP服务器，保存实体
     * 
     * @param file
     * @param ftpFile
     * @throws Exception
     */
    @Transactional(readOnly = false)
    private void saveFtpFile(MultipartFile file, FtpFile ftpFile) throws Exception {
        FTPUtil ftpUtil = new FTPUtil();
        // FTP文件路径
        ftpUtil.setRemotePath(ftpFile.getRemotePath());
        // 文件名
        ftpUtil.setFileName(ftpFile.getFileName() + ftpFile.getFileType());
        // 上传
        ftpUtil.upload(file.getInputStream());
        // 上传缩略图
        if (FileTypeJudge.IMAGE.equals(ftpFile.getIcon())) {
            String thumbnail = uploadThumbnail(file, ftpFile);
            ftpFile.setThumbnail(thumbnail);
        }
        // 设置状态
        ftpFile.setStatus(FtpFile.UPLOAD_SUCCESS);
        // 保存路径
        super.save(ftpFile);
    }

    /**
     * 上传缩略图
     * 
     * @param file
     * @param ftpFile
     * @throws IOException
     */
    private String uploadThumbnail(MultipartFile file, FtpFile ftpFile) throws IOException {
        FTPUtil ftpUtil = new FTPUtil();
        ftpUtil.setRemotePath(ftpFile.getRemotePath());
        String tbName = ftpFile.getFileName() + FtpFile.THUMBNAIL_NAME;
        ftpUtil.setFileName(tbName + ftpFile.getFileType());
        // 上传缩略图
        ftpUtil.upload(getThumbnail(file.getInputStream(), ftpFile.getFileType()));
        return tbName;
    }

    /**
     * 生成缩略图
     * 
     * @param inputStream
     * @param fileType
     *            文件类型
     * @return InputStream
     */
    private InputStream getThumbnail(InputStream inputStream, String fileType) {
        try {
            // 以 “.” 开头，截取名称
            if (fileType.startsWith(".")) {
                fileType = fileType.substring(1);
            }
            // 生成缩略图，返回文件流
            BufferedImage thumbnail = Scalr.resize(ImageIO.read(inputStream), FtpFile.THUMBNAIL_SIZE);
            ByteArrayOutputStream os = new ByteArrayOutputStream();
            ImageIO.write(thumbnail, fileType, os);
            InputStream is = new ByteArrayInputStream(os.toByteArray());
            return is;
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
        } catch (ImagingOpException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 删除文件
     * 
     * @param ftpFile
     */
    @Transactional(readOnly = false)
    public void delete(FtpFile ftpFile) {
        ftpFile = super.get(ftpFile);
        FTPUtil ftpUtil = new FTPUtil();
        ftpUtil.setRemotePath(ftpFile.getRemotePath());
        ftpUtil.setFileName(ftpFile.getFileName() + ftpFile.getFileType());
        ftpUtil.delete();
        // 删除缩略图
        if (FileTypeJudge.IMAGE.equals(ftpFile.getIcon())) {
            deleteThumbnail(ftpUtil, ftpFile);
        }
        super.delete(ftpFile);
    }

    /**
     * 删除缩略图
     * 
     * @param ftpUtil
     * @param ftpFile
     */
    private void deleteThumbnail(FTPUtil ftpUtil, FtpFile ftpFile) {
        ftpUtil.setRemotePath(ftpFile.getRemotePath());
        ftpUtil.setFileName(ftpFile.getFileName() + FtpFile.THUMBNAIL_NAME + ftpFile.getFileType());
        ftpUtil.delete();
    }

}