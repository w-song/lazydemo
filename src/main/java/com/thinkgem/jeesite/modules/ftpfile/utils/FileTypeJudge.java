/**
 * <p>Copyright ® 2002 东软  软件开发事业部版权所有。</p>
 */
package com.thinkgem.jeesite.modules.ftpfile.utils;

import java.io.IOException;
import java.io.InputStream;

/**
 * 文件类型判断类
 */
public final class FileTypeJudge {

    /**
     * 此常量值放置Font-Awesome 图标，作为类型判断
     */
    // 图片
    public final static String IMAGE = "file-image-o";

    // 视频
    public final static String VIDEO = "file-video-o";

    // 压缩包
    public final static String PACKAGE = "file-archive-o";

    // 文档
    public final static String DOCUMENT = "file-text-o";

    // 未知
    public final static String UNKNOWN = "file-o";

    /**
     * Constructor
     */
    private FileTypeJudge() {
    }

    /**
     * 将文件头转换成16进制字符串
     * 
     * @param 原生byte
     * @return 16进制字符串
     */
    private static String bytesToHexString(byte[] src) {

        StringBuilder stringBuilder = new StringBuilder();
        if (src == null || src.length <= 0) {
            return null;
        }
        for (int i = 0; i < src.length; i++) {
            int v = src[i] & 0xFF;
            String hv = Integer.toHexString(v);
            if (hv.length() < 2) {
                stringBuilder.append(0);
            }
            stringBuilder.append(hv);
        }
        return stringBuilder.toString();
    }

    /**
     * 得到文件头
     * 
     * @param filePath
     *            文件路径
     * @return 文件头
     * @throws IOException
     */
    private static String getFileContent(InputStream inputStream) throws IOException {

        byte[] b = new byte[28];

        try {
            inputStream.read(b, 0, 28);
        } catch (IOException e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (inputStream != null) {
                try {
                    inputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                    throw e;
                }
            }
        }
        return bytesToHexString(b);
    }

    /**
     * 判断文件类型
     * 
     * @param filePath
     *            文件路径
     * @return 文件类型
     */
    public static FileType getType(InputStream inputStream) throws IOException {

        String fileHead = getFileContent(inputStream);

        if (fileHead == null || fileHead.length() == 0) {
            return null;
        }

        fileHead = fileHead.toUpperCase();

        FileType[] fileTypes = FileType.values();

        for (FileType type : fileTypes) {
            if (fileHead.startsWith(type.getValue())) {
                return type;
            }
        }

        return null;
    }

    /**
     * 判断文件类型
     * 
     * @return 文件图标
     */
    public static String getFileCategory(InputStream inputStream) throws IOException {
        String fileType = String.valueOf(getType(inputStream));
        if (isImage(fileType)) {
            return IMAGE;
        } else if (isVideo(fileType)) {
            return VIDEO;
        } else if (isDocument(fileType)) {
            return DOCUMENT;
        } else if (isPackage(fileType)) {
            return PACKAGE;
        } else {
            return UNKNOWN;
        }
    }

    /**
     * 是否为图片
     */
    public static Boolean isImage(String fileType) {
        return FileType.JPEG.name().equals(fileType) || FileType.GIF.name().equals(fileType)
                || FileType.PNG.name().equals(fileType) || FileType.BMP.name().equals(fileType);
    }

    /**
     * 是否为视频
     */
    public static Boolean isVideo(String fileType) {
        return FileType.MP4.name().equals(fileType) || FileType.AVI.name().equals(fileType)
                || FileType.ASF.name().equals(fileType) || FileType.MPG.name().equals(fileType)
                || FileType.WAV.name().equals(fileType);
    }

    /**
     * 是否为文档
     */
    public static Boolean isDocument(String fileType) {
        return FileType.XLS_DOC.name().equals(fileType) || FileType.XLSX_DOCX.name().equals(fileType)
                || FileType.PDF.name().equals(fileType);
    }

    /**
     * 是否为压缩包
     */
    public static Boolean isPackage(String fileType) {
        return FileType.ZIP.name().equals(fileType) || FileType.RAR.name().equals(fileType);
    }

}
