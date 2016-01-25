/**
 * <p>Copyright ® 2002 东软  软件开发事业部版权所有。</p>
 */
package com.thinkgem.jeesite.modules.ftpfile.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.ConnectException;
import java.net.SocketException;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.utils.CommonsException;
import com.thinkgem.jeesite.common.utils.ResourceUtil;
import com.thinkgem.jeesite.common.utils.StringUtils;

/**
 * FTP工具类
 * 
 * @author MingYi
 * @date 2015-8-10
 */
public class FTPUtil {

    /**
     * 默认端口
     */
    private final static int DEFAULT_PORT = 21;

    /**
     * ftpClient
     */
    private FTPClient ftpClient;

    /**
     * 服务端保存的文件名
     */
    private String fileName;

    /**
     * 服务端保存的路径
     */
    private String remotePath;

    /**
     * 本地文件
     */
    private File local;

    /**
     * 主机地址
     */
    private String host;

    /**
     * 端口
     */
    private int port = DEFAULT_PORT;

    /**
     * 登录名
     */
    private String userName;

    /**
     * 登录密码
     */
    private String password;

    public FTPUtil() {
        this.init(Global.getConfig("ftp.host"), Integer.parseInt(Global.getConfig("ftp.port")),
                Global.getConfig("ftp.userName"), Global.getConfig("ftp.password"));
    }

    /**
     * 初始化
     * 
     * @param host
     * @param port
     * @param userName
     * @param password
     * @author MingYi
     * @date 2015-8-10
     */
    private void init(String host, int port, String userName, String password) {
        this.host = host;
        this.port = port;
        this.userName = userName;
        this.password = password;
    }

    private static final Map<String, String> replyCodeMap;

    static {
        replyCodeMap = new HashMap<String, String>();
        replyCodeMap.put("530", "登录错误");
        replyCodeMap.put("550", "权限不足");
    }

    public interface FTPAction {
        boolean action(FTPClient ftpClient) throws Exception;
    }

    public void execute(FTPAction ftpAction) {
        try {
            boolean success = ftpAction.action(ftpClient);
            if (!success) {
                int replyCode = ftpClient.getReplyCode();
                String reply = ftpClient.getReplyString();
                if (!FTPReply.isPositiveCompletion(replyCode)) {
                    throw new CommonsException(reply);
                }
            }
        } catch (ConnectException e) {
            throw new CommonsException("连接到服务器" + host + ":" + port + "失败," + e.getMessage());
        } catch (Exception e) {
            throw new CommonsException(e);
        }
    }

    /**
     * 连接FTP
     * 
     * @param ftpClient
     * @author MingYi
     * @date 2015-8-10
     */
    private void ftpConnect() {
        execute(new FTPAction() {
            @Override
            public boolean action(FTPClient ftpClient) throws Exception {
                ftpClient.connect(host, port);
                return true;
            }
        });
    }

    /**
     * 登录
     * 
     * @param ftpClient
     * @author MingYi
     * @date 2015-8-10
     */
    private void ftpLogin() {
        execute(new FTPAction() {
            @Override
            public boolean action(FTPClient ftpClient) throws Exception {
                return ftpClient.login(userName, password);
            }
        });
    }

    private void ftpSetFileType() {
        execute(new FTPAction() {
            @Override
            public boolean action(FTPClient ftpClient) throws Exception {
                return ftpClient.setFileType(FTPClient.BINARY_FILE_TYPE);
            }
        });
    }

    /**
     * 变更当前操作目录
     * 
     * @author MingYi
     * @date 2015-8-23
     */
    private void ftpChangeWorkingDirectory() {
        execute(new FTPAction() {
            @Override
            public boolean action(FTPClient ftpClient) throws Exception {
                // 如果目录不存在，则创建目录
                if (ftpClient.changeWorkingDirectory(remotePath)) {
                    return true;
                } else {
                    return createDirectory(remotePath);
                }
            }
        });
    }

    /**
     * 拉取文件
     * 
     * @author MingYi
     * @date 2015-8-23
     */
    private void ftpRetrieveFile(final FileOutputStream output) {
        execute(new FTPAction() {
            @Override
            public boolean action(FTPClient ftpClient) throws Exception {
                // 缓冲区
                ftpClient.setBufferSize(1024 * 1024);
                return ftpClient.retrieveFile(fileName, output);
            }
        });
    }

    /**
     * 存储文件
     * 
     * @author MingYi
     * @date 2015-8-23
     */
    private void ftpStoreFile(final InputStream is) {
        execute(new FTPAction() {
            @Override
            public boolean action(FTPClient ftpClient) throws Exception {
                // 缓冲区
                ftpClient.setBufferSize(1024 * 1024);
                return ftpClient.storeFile(fileName, is);
            }
        });
    }

    /**
     * 删除文件
     * 
     * @author MingYi
     * @date 2015-8-23
     */
    private void ftpDeleteFile() {
        execute(new FTPAction() {
            @Override
            public boolean action(FTPClient ftpClient) throws Exception {
                if (ftpClient.changeWorkingDirectory(remotePath)) {
                    return ftpClient.deleteFile(remotePath + fileName);
                }
                return false;
            }
        });
    }

    /**
     * 创建及进入FTP目录
     * 
     * @param remotePath
     *            格式如 "/1991/11/03/" 不允许存在中文
     * @author MingYi
     * @date 2015-8-10
     */
    private Boolean createDirectory(String remotePath) throws Exception {
        // 远程目录不存在，递归创建远程服务器目录
        if (!remotePath.equalsIgnoreCase("/") && !ftpClient.changeWorkingDirectory(remotePath)) {
            // 开始标识
            int start = 1;
            // 如果不以“/”开始路径
            if (!remotePath.startsWith("/")) {
                start = 0;
            }
            // 结束标识
            int end = remotePath.indexOf("/", start);
            while (true) {
                String subDir = remotePath.substring(start, end);
                if (!ftpClient.changeWorkingDirectory(subDir)) {
                    if (ftpClient.makeDirectory(subDir)) {
                        ftpClient.changeWorkingDirectory(subDir);
                    } else {
                        throw new CommonsException("创建目录" + remotePath + "失败");
                    }
                }
                // 子目录标识
                start = end + 1;
                end = remotePath.indexOf("/", start);
                // 检查所有目录是否创建完毕
                if (end <= start) {
                    break;
                }
            }
        }
        return true;
    }

    /**
     * 连接FTP服务器
     * 
     * @param host
     *            主机IP或域名
     * @param port
     *            端口
     * @param username
     *            登录用户名
     * @param password
     *            登录密码
     * @throws Exception
     * @author MingYi
     * @throws IOException
     * @throws SocketException
     * @date 2015-8-10
     */
    private void connect() throws SocketException, IOException {
        validateConnectInfo();
        ftpClient = new FTPClient();
        ftpConnect();
        ftpLogin();
        ftpSetFileType();
    }

    /**
     * 验证连接信息
     * 
     * @author MingYi
     * @date 2015-8-23
     */
    private void validateConnectInfo() {
        if (StringUtils.isEmpty(host)) {
            throw new CommonsException("host不能为空");
        }
        if (StringUtils.isEmpty(userName)) {
            throw new CommonsException("userName不能为空");
        }
        if (StringUtils.isEmpty(password)) {
            throw new CommonsException("password不能为空");
        }
    }

    /**
     * 断开连接
     * 
     * @author MingYi
     * @date 2015-8-23
     */
    private void disconnect() {
        try {
            ftpClient.disconnect();
        } catch (Exception e) {
            throw new CommonsException(e);
        }
    }

    /**
     * 下载文件
     * 
     * @author MingYi
     * @date 2015-8-23
     */
    public synchronized void download() {
        FileOutputStream output = null;
        try {
            this.connect();
            if (StringUtils.isNotEmpty(remotePath)) {
                ftpChangeWorkingDirectory();
            }
            output = new FileOutputStream(local);
            ftpRetrieveFile(output);
            output.flush();
        } catch (Exception e) {
            throw new CommonsException(e);
        } finally {
            ResourceUtil.close(output);
            this.disconnect();
        }
    }

    /**
     * 上传文件
     * 
     * @author MingYi
     * @date 2015-8-10
     */
    public void upload() {
        FileInputStream fis = null;
        try {
            fis = new FileInputStream(local);
        } catch (Exception e) {
            throw new CommonsException(e);
        }
        upload(fis);
    }

    /**
     * 上传文件
     * 
     * @param fis
     *            文件流
     * @author MingYi
     * @date 2015-8-10
     */
    public synchronized void upload(InputStream is) {
        try {
            this.connect();
            if (StringUtils.isNotEmpty(remotePath)) {
                ftpChangeWorkingDirectory();
            }
            if (StringUtils.isEmpty(fileName)) {
                fileName = local.getName();
            }
            ftpStoreFile(is);
        } catch (Exception e) {
            throw new CommonsException(e);
        } finally {
            this.disconnect();
            ResourceUtil.close(is);
        }
    }

    /**
     * 删除文件
     * 
     * @author MingYi
     * @date 2015-8-14
     */
    public synchronized void delete() {
        try {
            this.connect();
            ftpDeleteFile();
        } catch (Exception e) {
            throw new CommonsException(e);
        } finally {
            this.disconnect();
        }
    }

    /**
     * 服务端保存的路径 如果不设置此值，将会默认为用户登录之后的路径
     * 
     * @param remotePath
     * @author MingYi
     * @date 2015-8-23
     */
    public void setRemotePath(String remotePath) {
        this.remotePath = remotePath;
    }

    public String getRemotePath() {
        return remotePath;
    }

    /**
     * 服务端保存的文件名 如果不设置此值，将会默认为本地文件的文件名
     * 
     * @param fileName
     * @author MingYi
     * @date 2015-8-23
     */
    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    /**
     * 本地文件
     * 
     * @param local
     * @author MingYi
     * @date 2015-8-23
     */
    public void setLocal(File local) {
        this.local = local;
    }

    public File getLocal() {
        return local;
    }

}
