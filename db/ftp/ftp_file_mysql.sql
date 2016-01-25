
SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for ftp_file
-- ----------------------------
DROP TABLE IF EXISTS `ftp_file`;
CREATE TABLE `ftp_file` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `batch_id` varchar(64) DEFAULT NULL COMMENT '批量编号',
  `file_name` varchar(255) NOT NULL DEFAULT '' COMMENT '文件名',
  `file_type` varchar(64) NOT NULL DEFAULT '' COMMENT '文件类型',
  `remote_path` varchar(255) NOT NULL DEFAULT '' COMMENT '远程路径',
  `icon` varchar(64) DEFAULT NULL COMMENT '文件图标',
  `thumbnail` varchar(255) DEFAULT NULL COMMENT '缩略图',
  `status` char(1) NOT NULL DEFAULT '' COMMENT '状态',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='FTP文件信息表';
