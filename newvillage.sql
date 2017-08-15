/*
MySQL Data Transfer
Source Host: localhost
Source Database: newvillage
Target Host: localhost
Target Database: newvillage
Date: 2017/7/12 13:50:07
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for cmf_ad
-- ----------------------------
DROP TABLE IF EXISTS `cmf_ad`;
CREATE TABLE `cmf_ad` (
  `ad_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '广告id',
  `ad_name` varchar(255) NOT NULL COMMENT '广告名称',
  `ad_content` text COMMENT '广告内容',
  `status` int(2) NOT NULL DEFAULT '1' COMMENT '状态，1显示，0不显示',
  PRIMARY KEY (`ad_id`),
  KEY `ad_name` (`ad_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cmf_asset
-- ----------------------------
DROP TABLE IF EXISTS `cmf_asset`;
CREATE TABLE `cmf_asset` (
  `aid` bigint(20) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户 id',
  `key` varchar(50) NOT NULL COMMENT '资源 key',
  `filename` varchar(50) DEFAULT NULL COMMENT '文件名',
  `filesize` int(11) DEFAULT NULL COMMENT '文件大小,单位Byte',
  `filepath` varchar(200) NOT NULL COMMENT '文件路径，相对于 upload 目录，可以为 url',
  `uploadtime` int(11) NOT NULL COMMENT '上传时间',
  `status` int(2) NOT NULL DEFAULT '1' COMMENT '状态，1：可用，0：删除，不可用',
  `meta` text COMMENT '其它详细信息，JSON格式',
  `suffix` varchar(50) DEFAULT NULL COMMENT '文件后缀名，不包括点',
  `download_times` int(11) NOT NULL DEFAULT '0' COMMENT '下载次数',
  PRIMARY KEY (`aid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='资源表';

-- ----------------------------
-- Table structure for cmf_auth_access
-- ----------------------------
DROP TABLE IF EXISTS `cmf_auth_access`;
CREATE TABLE `cmf_auth_access` (
  `role_id` mediumint(8) unsigned NOT NULL COMMENT '角色',
  `rule_name` varchar(255) NOT NULL COMMENT '规则唯一英文标识,全小写',
  `type` varchar(30) DEFAULT NULL COMMENT '权限规则分类，请加应用前缀,如admin_',
  KEY `role_id` (`role_id`),
  KEY `rule_name` (`rule_name`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='权限授权表';

-- ----------------------------
-- Table structure for cmf_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `cmf_auth_rule`;
CREATE TABLE `cmf_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '规则id,自增主键',
  `module` varchar(20) NOT NULL COMMENT '规则所属module',
  `type` varchar(30) NOT NULL DEFAULT '1' COMMENT '权限规则分类，请加应用前缀,如admin_',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识,全小写',
  `param` varchar(255) DEFAULT NULL COMMENT '额外url参数',
  `title` varchar(20) NOT NULL DEFAULT '' COMMENT '规则中文描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效(0:无效,1:有效)',
  `condition` varchar(300) NOT NULL DEFAULT '' COMMENT '规则附加条件',
  PRIMARY KEY (`id`),
  KEY `module` (`module`,`status`,`type`)
) ENGINE=MyISAM AUTO_INCREMENT=185 DEFAULT CHARSET=utf8 COMMENT='权限规则表';

-- ----------------------------
-- Table structure for cmf_comments
-- ----------------------------
DROP TABLE IF EXISTS `cmf_comments`;
CREATE TABLE `cmf_comments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_table` varchar(100) NOT NULL COMMENT '评论内容所在表，不带表前缀',
  `post_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '评论内容 id',
  `url` varchar(255) DEFAULT NULL COMMENT '原文地址',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '发表评论的用户id',
  `to_uid` int(11) NOT NULL DEFAULT '0' COMMENT '被评论的用户id',
  `full_name` varchar(50) DEFAULT NULL COMMENT '评论者昵称',
  `email` varchar(255) DEFAULT NULL COMMENT '评论者邮箱',
  `createtime` datetime NOT NULL DEFAULT '2000-01-01 00:00:00' COMMENT '评论时间',
  `content` text NOT NULL COMMENT '评论内容',
  `type` smallint(1) NOT NULL DEFAULT '1' COMMENT '评论类型；1实名评论',
  `parentid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '被回复的评论id',
  `path` varchar(500) DEFAULT NULL,
  `status` smallint(1) NOT NULL DEFAULT '1' COMMENT '状态，1已审核，0未审核',
  PRIMARY KEY (`id`),
  KEY `comment_post_ID` (`post_id`),
  KEY `comment_approved_date_gmt` (`status`),
  KEY `comment_parent` (`parentid`),
  KEY `table_id_status` (`post_table`,`post_id`,`status`),
  KEY `createtime` (`createtime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='评论表';

-- ----------------------------
-- Table structure for cmf_common_action_log
-- ----------------------------
DROP TABLE IF EXISTS `cmf_common_action_log`;
CREATE TABLE `cmf_common_action_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` bigint(20) DEFAULT '0' COMMENT '用户id',
  `object` varchar(100) DEFAULT NULL COMMENT '访问对象的id,格式：不带前缀的表名+id;如posts1表示xx_posts表里id为1的记录',
  `action` varchar(50) DEFAULT NULL COMMENT '操作名称；格式规定为：应用名+控制器+操作名；也可自己定义格式只要不发生冲突且惟一；',
  `count` int(11) DEFAULT '0' COMMENT '访问次数',
  `last_time` int(11) DEFAULT '0' COMMENT '最后访问的时间戳',
  `ip` varchar(15) DEFAULT NULL COMMENT '访问者最后访问ip',
  PRIMARY KEY (`id`),
  KEY `user_object_action` (`user`,`object`,`action`),
  KEY `user_object_action_ip` (`user`,`object`,`action`,`ip`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='访问记录表';

-- ----------------------------
-- Table structure for cmf_goods
-- ----------------------------
DROP TABLE IF EXISTS `cmf_goods`;
CREATE TABLE `cmf_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品id',
  `name` varchar(255) NOT NULL COMMENT '商品名称',
  `norms` varchar(255) CHARACTER SET utf8 COLLATE utf8_estonian_ci NOT NULL COMMENT '商品规格',
  `barcode` varchar(255) NOT NULL COMMENT '条形码',
  `p_price` decimal(16,2) DEFAULT NULL COMMENT '商品进价',
  `s_price` decimal(16,2) DEFAULT NULL COMMENT '商品售价',
  `content` longtext COMMENT '商品详情',
  `goods_pic` text COMMENT '商品图片',
  `modify_time` datetime DEFAULT '2000-01-01 00:00:00' COMMENT '更新时间',
  `status` int(2) NOT NULL DEFAULT '0' COMMENT '标识符',
  `listorder` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4382 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cmf_guestbook
-- ----------------------------
DROP TABLE IF EXISTS `cmf_guestbook`;
CREATE TABLE `cmf_guestbook` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `full_name` varchar(50) NOT NULL COMMENT '留言者姓名',
  `email` varchar(100) NOT NULL COMMENT '留言者邮箱',
  `title` varchar(255) DEFAULT NULL COMMENT '留言标题',
  `msg` text NOT NULL COMMENT '留言内容',
  `createtime` datetime NOT NULL COMMENT '留言时间',
  `status` smallint(2) NOT NULL DEFAULT '1' COMMENT '留言状态，1：正常，0：删除',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='留言表';

-- ----------------------------
-- Table structure for cmf_links
-- ----------------------------
DROP TABLE IF EXISTS `cmf_links`;
CREATE TABLE `cmf_links` (
  `link_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `link_url` varchar(255) NOT NULL COMMENT '友情链接地址',
  `link_name` varchar(255) NOT NULL COMMENT '友情链接名称',
  `link_image` varchar(255) DEFAULT NULL COMMENT '友情链接图标',
  `link_target` varchar(25) NOT NULL DEFAULT '_blank' COMMENT '友情链接打开方式',
  `link_description` text NOT NULL COMMENT '友情链接描述',
  `link_status` int(2) NOT NULL DEFAULT '1' COMMENT '状态，1显示，0不显示',
  `link_rating` int(11) NOT NULL DEFAULT '0' COMMENT '友情链接评级',
  `link_rel` varchar(255) DEFAULT NULL COMMENT '链接与网站的关系',
  `listorder` int(10) NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`link_id`),
  KEY `link_visible` (`link_status`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='友情链接表';

-- ----------------------------
-- Table structure for cmf_menu
-- ----------------------------
DROP TABLE IF EXISTS `cmf_menu`;
CREATE TABLE `cmf_menu` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `parentid` smallint(6) unsigned NOT NULL DEFAULT '0',
  `app` varchar(30) NOT NULL DEFAULT '' COMMENT '应用名称app',
  `model` varchar(30) NOT NULL DEFAULT '' COMMENT '控制器',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT '操作名称',
  `data` varchar(50) NOT NULL DEFAULT '' COMMENT '额外参数',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '菜单类型  1：权限认证+菜单；0：只作为菜单',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态，1显示，0不显示',
  `name` varchar(50) NOT NULL COMMENT '菜单名称',
  `icon` varchar(50) DEFAULT NULL COMMENT '菜单图标',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `listorder` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '排序ID',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `parentid` (`parentid`),
  KEY `model` (`model`)
) ENGINE=MyISAM AUTO_INCREMENT=198 DEFAULT CHARSET=utf8 COMMENT='后台菜单表';

-- ----------------------------
-- Table structure for cmf_nav
-- ----------------------------
DROP TABLE IF EXISTS `cmf_nav`;
CREATE TABLE `cmf_nav` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL COMMENT '导航分类 id',
  `parentid` int(11) NOT NULL COMMENT '导航父 id',
  `label` varchar(255) NOT NULL COMMENT '导航标题',
  `target` varchar(50) DEFAULT NULL COMMENT '打开方式',
  `href` varchar(255) NOT NULL COMMENT '导航链接',
  `icon` varchar(255) NOT NULL COMMENT '导航图标',
  `status` int(2) NOT NULL DEFAULT '1' COMMENT '状态，1显示，0不显示',
  `listorder` int(6) DEFAULT '0' COMMENT '排序',
  `path` varchar(255) NOT NULL DEFAULT '0' COMMENT '层级关系',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='前台导航表';

-- ----------------------------
-- Table structure for cmf_nav_cat
-- ----------------------------
DROP TABLE IF EXISTS `cmf_nav_cat`;
CREATE TABLE `cmf_nav_cat` (
  `navcid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '导航分类名',
  `active` int(1) NOT NULL DEFAULT '1' COMMENT '是否为主菜单，1是，0不是',
  `remark` text COMMENT '备注',
  PRIMARY KEY (`navcid`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='前台导航分类表';

-- ----------------------------
-- Table structure for cmf_oauth_user
-- ----------------------------
DROP TABLE IF EXISTS `cmf_oauth_user`;
CREATE TABLE `cmf_oauth_user` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `from` varchar(20) NOT NULL COMMENT '用户来源key',
  `name` varchar(30) NOT NULL COMMENT '第三方昵称',
  `head_img` varchar(200) NOT NULL COMMENT '头像',
  `uid` int(20) NOT NULL COMMENT '关联的本站用户id',
  `create_time` datetime NOT NULL COMMENT '绑定时间',
  `last_login_time` datetime NOT NULL COMMENT '最后登录时间',
  `last_login_ip` varchar(16) NOT NULL COMMENT '最后登录ip',
  `login_times` int(6) NOT NULL COMMENT '登录次数',
  `status` tinyint(2) NOT NULL,
  `access_token` varchar(512) NOT NULL,
  `expires_date` int(11) NOT NULL COMMENT 'access_token过期时间',
  `openid` varchar(40) NOT NULL COMMENT '第三方用户id',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='第三方用户表';

-- ----------------------------
-- Table structure for cmf_options
-- ----------------------------
DROP TABLE IF EXISTS `cmf_options`;
CREATE TABLE `cmf_options` (
  `option_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `option_name` varchar(64) NOT NULL COMMENT '配置名',
  `option_value` longtext NOT NULL COMMENT '配置值',
  `autoload` int(2) NOT NULL DEFAULT '1' COMMENT '是否自动加载',
  PRIMARY KEY (`option_id`),
  UNIQUE KEY `option_name` (`option_name`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='全站配置表';

-- ----------------------------
-- Table structure for cmf_plugins
-- ----------------------------
DROP TABLE IF EXISTS `cmf_plugins`;
CREATE TABLE `cmf_plugins` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `name` varchar(50) NOT NULL COMMENT '插件名，英文',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '插件名称',
  `description` text COMMENT '插件描述',
  `type` tinyint(2) DEFAULT '0' COMMENT '插件类型, 1:网站；8;微信',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态；1开启；',
  `config` text COMMENT '插件配置',
  `hooks` varchar(255) DEFAULT NULL COMMENT '实现的钩子;以“，”分隔',
  `has_admin` tinyint(2) DEFAULT '0' COMMENT '插件是否有后台管理界面',
  `author` varchar(50) DEFAULT '' COMMENT '插件作者',
  `version` varchar(20) DEFAULT '' COMMENT '插件版本号',
  `createtime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '插件安装时间',
  `listorder` smallint(6) NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='插件表';

-- ----------------------------
-- Table structure for cmf_posts
-- ----------------------------
DROP TABLE IF EXISTS `cmf_posts`;
CREATE TABLE `cmf_posts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_author` bigint(20) unsigned DEFAULT '0' COMMENT '发表者id',
  `post_keywords` varchar(150) NOT NULL COMMENT 'seo keywords',
  `post_source` varchar(150) DEFAULT NULL COMMENT '转载文章的来源',
  `post_date` datetime DEFAULT '2000-01-01 00:00:00' COMMENT 'post发布日期',
  `post_content` longtext COMMENT 'post内容',
  `post_title` text COMMENT 'post标题',
  `post_excerpt` text COMMENT 'post摘要',
  `post_status` int(2) DEFAULT '1' COMMENT 'post状态，1已审核，0未审核,3删除',
  `comment_status` int(2) DEFAULT '1' COMMENT '评论状态，1允许，0不允许',
  `post_modified` datetime DEFAULT '2000-01-01 00:00:00' COMMENT 'post更新时间，可在前台修改，显示给用户',
  `post_content_filtered` longtext,
  `post_parent` bigint(20) unsigned DEFAULT '0' COMMENT 'post的父级post id,表示post层级关系',
  `post_type` int(2) DEFAULT '1' COMMENT 'post类型，1文章,2页面',
  `post_mime_type` varchar(100) DEFAULT '',
  `comment_count` bigint(20) DEFAULT '0',
  `smeta` text COMMENT 'post的扩展字段，保存相关扩展属性，如缩略图；格式为json',
  `post_hits` int(11) DEFAULT '0' COMMENT 'post点击数，查看数',
  `post_like` int(11) DEFAULT '0' COMMENT 'post赞数',
  `istop` tinyint(1) NOT NULL DEFAULT '0' COMMENT '置顶 1置顶； 0不置顶',
  `recommended` tinyint(1) NOT NULL DEFAULT '0' COMMENT '推荐 1推荐 0不推荐',
  PRIMARY KEY (`id`),
  KEY `type_status_date` (`post_type`,`post_status`,`post_date`,`id`),
  KEY `post_parent` (`post_parent`),
  KEY `post_author` (`post_author`),
  KEY `post_date` (`post_date`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Portal文章表';

-- ----------------------------
-- Table structure for cmf_role
-- ----------------------------
DROP TABLE IF EXISTS `cmf_role`;
CREATE TABLE `cmf_role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL COMMENT '角色名称',
  `pid` smallint(6) DEFAULT NULL COMMENT '父角色ID',
  `status` tinyint(1) unsigned DEFAULT NULL COMMENT '状态',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `listorder` int(3) NOT NULL DEFAULT '0' COMMENT '排序字段',
  PRIMARY KEY (`id`),
  KEY `parentId` (`pid`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Table structure for cmf_role_user
-- ----------------------------
DROP TABLE IF EXISTS `cmf_role_user`;
CREATE TABLE `cmf_role_user` (
  `role_id` int(11) unsigned DEFAULT '0' COMMENT '角色 id',
  `user_id` int(11) DEFAULT '0' COMMENT '用户id',
  KEY `group_id` (`role_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户角色对应表';

-- ----------------------------
-- Table structure for cmf_route
-- ----------------------------
DROP TABLE IF EXISTS `cmf_route`;
CREATE TABLE `cmf_route` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '路由id',
  `full_url` varchar(255) DEFAULT NULL COMMENT '完整url， 如：portal/list/index?id=1',
  `url` varchar(255) DEFAULT NULL COMMENT '实际显示的url',
  `listorder` int(5) DEFAULT '0' COMMENT '排序，优先级，越小优先级越高',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态，1：启用 ;0：不启用',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='url路由表';

-- ----------------------------
-- Table structure for cmf_slide
-- ----------------------------
DROP TABLE IF EXISTS `cmf_slide`;
CREATE TABLE `cmf_slide` (
  `slide_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `slide_cid` int(11) NOT NULL COMMENT '幻灯片分类 id',
  `slide_name` varchar(255) NOT NULL COMMENT '幻灯片名称',
  `slide_pic` varchar(255) DEFAULT NULL COMMENT '幻灯片图片',
  `slide_url` varchar(255) DEFAULT NULL COMMENT '幻灯片链接',
  `slide_des` varchar(255) DEFAULT NULL COMMENT '幻灯片描述',
  `slide_content` text COMMENT '幻灯片内容',
  `slide_status` int(2) NOT NULL DEFAULT '1' COMMENT '状态，1显示，0不显示',
  `listorder` int(10) DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`slide_id`),
  KEY `slide_cid` (`slide_cid`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='幻灯片表';

-- ----------------------------
-- Table structure for cmf_slide_cat
-- ----------------------------
DROP TABLE IF EXISTS `cmf_slide_cat`;
CREATE TABLE `cmf_slide_cat` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `cat_name` varchar(255) NOT NULL COMMENT '幻灯片分类',
  `cat_idname` varchar(255) NOT NULL COMMENT '幻灯片分类标识',
  `cat_remark` text COMMENT '分类备注',
  `cat_status` int(2) NOT NULL DEFAULT '1' COMMENT '状态，1显示，0不显示',
  PRIMARY KEY (`cid`),
  KEY `cat_idname` (`cat_idname`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='幻灯片分类表';

-- ----------------------------
-- Table structure for cmf_term_relationships
-- ----------------------------
DROP TABLE IF EXISTS `cmf_term_relationships`;
CREATE TABLE `cmf_term_relationships` (
  `tid` bigint(20) NOT NULL AUTO_INCREMENT,
  `object_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'posts表里文章id',
  `term_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '分类id',
  `listorder` int(10) NOT NULL DEFAULT '0' COMMENT '排序',
  `status` int(2) NOT NULL DEFAULT '1' COMMENT '状态，1发布，0不发布',
  PRIMARY KEY (`tid`),
  KEY `term_taxonomy_id` (`term_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Portal 文章分类对应表';

-- ----------------------------
-- Table structure for cmf_terms
-- ----------------------------
DROP TABLE IF EXISTS `cmf_terms`;
CREATE TABLE `cmf_terms` (
  `term_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `name` varchar(200) DEFAULT NULL COMMENT '分类名称',
  `slug` varchar(200) DEFAULT '',
  `taxonomy` varchar(32) DEFAULT NULL COMMENT '分类类型',
  `description` longtext COMMENT '分类描述',
  `parent` bigint(20) unsigned DEFAULT '0' COMMENT '分类父id',
  `count` bigint(20) DEFAULT '0' COMMENT '分类文章数',
  `path` varchar(500) DEFAULT NULL COMMENT '分类层级关系路径',
  `seo_title` varchar(500) DEFAULT NULL,
  `seo_keywords` varchar(500) DEFAULT NULL,
  `seo_description` varchar(500) DEFAULT NULL,
  `list_tpl` varchar(50) DEFAULT NULL COMMENT '分类列表模板',
  `one_tpl` varchar(50) DEFAULT NULL COMMENT '分类文章页模板',
  `listorder` int(5) NOT NULL DEFAULT '0' COMMENT '排序',
  `status` int(2) NOT NULL DEFAULT '1' COMMENT '状态，1发布，0不发布',
  PRIMARY KEY (`term_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Portal 文章分类表';

-- ----------------------------
-- Table structure for cmf_user_favorites
-- ----------------------------
DROP TABLE IF EXISTS `cmf_user_favorites`;
CREATE TABLE `cmf_user_favorites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` bigint(20) DEFAULT NULL COMMENT '用户 id',
  `title` varchar(255) DEFAULT NULL COMMENT '收藏内容的标题',
  `url` varchar(255) DEFAULT NULL COMMENT '收藏内容的原文地址，不带域名',
  `description` varchar(500) DEFAULT NULL COMMENT '收藏内容的描述',
  `table` varchar(50) DEFAULT NULL COMMENT '收藏实体以前所在表，不带前缀',
  `object_id` int(11) DEFAULT NULL COMMENT '收藏内容原来的主键id',
  `createtime` int(11) DEFAULT NULL COMMENT '收藏时间',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户收藏表';

-- ----------------------------
-- Table structure for cmf_users
-- ----------------------------
DROP TABLE IF EXISTS `cmf_users`;
CREATE TABLE `cmf_users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_login` varchar(60) NOT NULL DEFAULT '' COMMENT '用户名',
  `user_pass` varchar(64) NOT NULL DEFAULT '' COMMENT '登录密码；sp_password加密',
  `user_nicename` varchar(50) NOT NULL DEFAULT '' COMMENT '用户美名',
  `user_email` varchar(100) NOT NULL DEFAULT '' COMMENT '登录邮箱',
  `user_url` varchar(100) NOT NULL DEFAULT '' COMMENT '用户个人网站',
  `avatar` varchar(255) DEFAULT NULL COMMENT '用户头像，相对于upload/avatar目录',
  `sex` smallint(1) DEFAULT '0' COMMENT '性别；0：保密，1：男；2：女',
  `birthday` date DEFAULT '2000-01-01' COMMENT '生日',
  `signature` varchar(255) DEFAULT NULL COMMENT '个性签名',
  `last_login_ip` varchar(16) DEFAULT NULL COMMENT '最后登录ip',
  `last_login_time` datetime NOT NULL DEFAULT '2000-01-01 00:00:00' COMMENT '最后登录时间',
  `create_time` datetime NOT NULL DEFAULT '2000-01-01 00:00:00' COMMENT '注册时间',
  `user_activation_key` varchar(60) NOT NULL DEFAULT '' COMMENT '激活码',
  `user_status` int(11) NOT NULL DEFAULT '1' COMMENT '用户状态 0：禁用； 1：正常 ；2：未验证',
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '用户积分',
  `user_type` smallint(1) DEFAULT '1' COMMENT '用户类型，1:admin ;2:会员',
  `coin` int(11) NOT NULL DEFAULT '0' COMMENT '金币',
  `mobile` varchar(20) NOT NULL DEFAULT '' COMMENT '手机号',
  PRIMARY KEY (`id`),
  KEY `user_login_key` (`user_login`),
  KEY `user_nicename` (`user_nicename`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `cmf_auth_access` VALUES ('2', 'user/indexadmin/index', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'user/indexadmin/default1', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'user/indexadmin/default', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'admin/setting/upload_post', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'admin/setting/upload', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'admin/storage/setting_post', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'admin/storage/index', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'admin/setting/clearcache', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'admin/mailer/active_post', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'admin/mailer/active', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'admin/mailer/test', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'admin/mailer/index_post', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'admin/mailer/index', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'admin/mailer/default', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'admin/route/listorders', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'admin/route/open', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'admin/route/ban', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'admin/route/delete', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'admin/route/edit_post', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'admin/route/edit', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'admin/route/add_post', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'admin/route/add', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'admin/route/index', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'admin/setting/site_post', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'admin/setting/site', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'admin/setting/password_post', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'admin/setting/password', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'admin/user/userinfo_post', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'admin/user/userinfo', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'admin/setting/userdefault', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'admin/setting/default', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'admin/goods/ban', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'admin/goods/cancelban', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'admin/goods/delete', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'admin/goods/toggle', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'admin/goods/listorders', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'admin/goods/account', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'admin/goods/edit', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'admin/goods/goods_upload', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'admin/goods/add', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'admin/goods/index', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'admin/content/default', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'user/indexadmin/ban', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'user/indexadmin/cancelban', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'user/oauthadmin/index', 'admin_url');
INSERT INTO `cmf_auth_access` VALUES ('2', 'user/oauthadmin/delete', 'admin_url');
INSERT INTO `cmf_auth_rule` VALUES ('1', 'Admin', 'admin_url', 'admin/content/default', null, '内容管理', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('2', 'Api', 'admin_url', 'api/guestbookadmin/index', null, '所有留言', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('3', 'Api', 'admin_url', 'api/guestbookadmin/delete', null, '删除网站留言', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('4', 'Comment', 'admin_url', 'comment/commentadmin/index', null, '评论管理', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('5', 'Comment', 'admin_url', 'comment/commentadmin/delete', null, '删除评论', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('6', 'Comment', 'admin_url', 'comment/commentadmin/check', null, '评论审核', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('7', 'Portal', 'admin_url', 'portal/adminpost/index', null, '文章管理', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('8', 'Portal', 'admin_url', 'portal/adminpost/listorders', null, '文章排序', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('9', 'Portal', 'admin_url', 'portal/adminpost/top', null, '文章置顶', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('10', 'Portal', 'admin_url', 'portal/adminpost/recommend', null, '文章推荐', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('11', 'Portal', 'admin_url', 'portal/adminpost/move', null, '批量移动', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('12', 'Portal', 'admin_url', 'portal/adminpost/check', null, '文章审核', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('13', 'Portal', 'admin_url', 'portal/adminpost/delete', null, '删除文章', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('14', 'Portal', 'admin_url', 'portal/adminpost/edit', null, '编辑文章', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('15', 'Portal', 'admin_url', 'portal/adminpost/edit_post', null, '提交编辑', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('16', 'Portal', 'admin_url', 'portal/adminpost/add', null, '添加文章', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('17', 'Portal', 'admin_url', 'portal/adminpost/add_post', null, '提交添加', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('18', 'Portal', 'admin_url', 'portal/adminterm/index', null, '分类管理', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('19', 'Portal', 'admin_url', 'portal/adminterm/listorders', null, '文章分类排序', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('20', 'Portal', 'admin_url', 'portal/adminterm/delete', null, '删除分类', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('21', 'Portal', 'admin_url', 'portal/adminterm/edit', null, '编辑分类', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('22', 'Portal', 'admin_url', 'portal/adminterm/edit_post', null, '提交编辑', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('23', 'Portal', 'admin_url', 'portal/adminterm/add', null, '添加分类', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('24', 'Portal', 'admin_url', 'portal/adminterm/add_post', null, '提交添加', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('25', 'Portal', 'admin_url', 'portal/adminpage/index', null, '页面管理', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('26', 'Portal', 'admin_url', 'portal/adminpage/listorders', null, '页面排序', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('27', 'Portal', 'admin_url', 'portal/adminpage/delete', null, '删除页面', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('28', 'Portal', 'admin_url', 'portal/adminpage/edit', null, '编辑页面', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('29', 'Portal', 'admin_url', 'portal/adminpage/edit_post', null, '提交编辑', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('30', 'Portal', 'admin_url', 'portal/adminpage/add', null, '添加页面', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('31', 'Portal', 'admin_url', 'portal/adminpage/add_post', null, '提交添加', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('32', 'Admin', 'admin_url', 'admin/recycle/default', null, '回收站', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('33', 'Portal', 'admin_url', 'portal/adminpost/recyclebin', null, '文章回收', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('34', 'Portal', 'admin_url', 'portal/adminpost/restore', null, '文章还原', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('35', 'Portal', 'admin_url', 'portal/adminpost/clean', null, '彻底删除', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('36', 'Portal', 'admin_url', 'portal/adminpage/recyclebin', null, '页面回收', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('37', 'Portal', 'admin_url', 'portal/adminpage/clean', null, '彻底删除', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('38', 'Portal', 'admin_url', 'portal/adminpage/restore', null, '页面还原', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('39', 'Admin', 'admin_url', 'admin/extension/default', null, '扩展工具', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('40', 'Admin', 'admin_url', 'admin/backup/default', null, '备份管理', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('41', 'Admin', 'admin_url', 'admin/backup/restore', null, '数据还原', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('42', 'Admin', 'admin_url', 'admin/backup/index', null, '数据备份', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('43', 'Admin', 'admin_url', 'admin/backup/index_post', null, '提交数据备份', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('44', 'Admin', 'admin_url', 'admin/backup/download', null, '下载备份', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('45', 'Admin', 'admin_url', 'admin/backup/del_backup', null, '删除备份', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('46', 'Admin', 'admin_url', 'admin/backup/import', null, '数据备份导入', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('47', 'Admin', 'admin_url', 'admin/plugin/index', null, '插件管理', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('48', 'Admin', 'admin_url', 'admin/plugin/toggle', null, '插件启用切换', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('49', 'Admin', 'admin_url', 'admin/plugin/setting', null, '插件设置', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('50', 'Admin', 'admin_url', 'admin/plugin/setting_post', null, '插件设置提交', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('51', 'Admin', 'admin_url', 'admin/plugin/install', null, '插件安装', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('52', 'Admin', 'admin_url', 'admin/plugin/uninstall', null, '插件卸载', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('53', 'Admin', 'admin_url', 'admin/slide/default', null, '幻灯片', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('54', 'Admin', 'admin_url', 'admin/slide/index', null, '幻灯片管理', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('55', 'Admin', 'admin_url', 'admin/slide/listorders', null, '幻灯片排序', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('56', 'Admin', 'admin_url', 'admin/slide/toggle', null, '幻灯片显示切换', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('57', 'Admin', 'admin_url', 'admin/slide/delete', null, '删除幻灯片', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('58', 'Admin', 'admin_url', 'admin/slide/edit', null, '编辑幻灯片', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('59', 'Admin', 'admin_url', 'admin/slide/edit_post', null, '提交编辑', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('60', 'Admin', 'admin_url', 'admin/slide/add', null, '添加幻灯片', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('61', 'Admin', 'admin_url', 'admin/slide/add_post', null, '提交添加', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('62', 'Admin', 'admin_url', 'admin/slidecat/index', null, '幻灯片分类', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('63', 'Admin', 'admin_url', 'admin/slidecat/delete', null, '删除分类', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('64', 'Admin', 'admin_url', 'admin/slidecat/edit', null, '编辑分类', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('65', 'Admin', 'admin_url', 'admin/slidecat/edit_post', null, '提交编辑', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('66', 'Admin', 'admin_url', 'admin/slidecat/add', null, '添加分类', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('67', 'Admin', 'admin_url', 'admin/slidecat/add_post', null, '提交添加', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('68', 'Admin', 'admin_url', 'admin/ad/index', null, '网站广告', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('69', 'Admin', 'admin_url', 'admin/ad/toggle', null, '广告显示切换', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('70', 'Admin', 'admin_url', 'admin/ad/delete', null, '删除广告', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('71', 'Admin', 'admin_url', 'admin/ad/edit', null, '编辑广告', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('72', 'Admin', 'admin_url', 'admin/ad/edit_post', null, '提交编辑', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('73', 'Admin', 'admin_url', 'admin/ad/add', null, '添加广告', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('74', 'Admin', 'admin_url', 'admin/ad/add_post', null, '提交添加', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('75', 'Admin', 'admin_url', 'admin/link/index', null, '友情链接', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('76', 'Admin', 'admin_url', 'admin/link/listorders', null, '友情链接排序', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('77', 'Admin', 'admin_url', 'admin/link/toggle', null, '友链显示切换', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('78', 'Admin', 'admin_url', 'admin/link/delete', null, '删除友情链接', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('79', 'Admin', 'admin_url', 'admin/link/edit', null, '编辑友情链接', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('80', 'Admin', 'admin_url', 'admin/link/edit_post', null, '提交编辑', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('81', 'Admin', 'admin_url', 'admin/link/add', null, '添加友情链接', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('82', 'Admin', 'admin_url', 'admin/link/add_post', null, '提交添加', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('83', 'Api', 'admin_url', 'api/oauthadmin/setting', null, '第三方登陆', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('84', 'Api', 'admin_url', 'api/oauthadmin/setting_post', null, '提交设置', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('85', 'Admin', 'admin_url', 'admin/menu/default', null, '菜单管理', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('86', 'Admin', 'admin_url', 'admin/navcat/default1', null, '前台菜单', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('87', 'Admin', 'admin_url', 'admin/nav/index', null, '菜单管理', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('88', 'Admin', 'admin_url', 'admin/nav/listorders', null, '前台导航排序', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('89', 'Admin', 'admin_url', 'admin/nav/delete', null, '删除菜单', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('90', 'Admin', 'admin_url', 'admin/nav/edit', null, '编辑菜单', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('91', 'Admin', 'admin_url', 'admin/nav/edit_post', null, '提交编辑', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('92', 'Admin', 'admin_url', 'admin/nav/add', null, '添加菜单', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('93', 'Admin', 'admin_url', 'admin/nav/add_post', null, '提交添加', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('94', 'Admin', 'admin_url', 'admin/navcat/index', null, '菜单分类', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('95', 'Admin', 'admin_url', 'admin/navcat/delete', null, '删除分类', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('96', 'Admin', 'admin_url', 'admin/navcat/edit', null, '编辑分类', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('97', 'Admin', 'admin_url', 'admin/navcat/edit_post', null, '提交编辑', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('98', 'Admin', 'admin_url', 'admin/navcat/add', null, '添加分类', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('99', 'Admin', 'admin_url', 'admin/navcat/add_post', null, '提交添加', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('100', 'Admin', 'admin_url', 'admin/menu/index', null, '后台菜单', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('101', 'Admin', 'admin_url', 'admin/menu/add', null, '添加菜单', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('102', 'Admin', 'admin_url', 'admin/menu/add_post', null, '提交添加', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('103', 'Admin', 'admin_url', 'admin/menu/listorders', null, '后台菜单排序', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('104', 'Admin', 'admin_url', 'admin/menu/export_menu', null, '菜单备份', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('105', 'Admin', 'admin_url', 'admin/menu/edit', null, '编辑菜单', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('106', 'Admin', 'admin_url', 'admin/menu/edit_post', null, '提交编辑', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('107', 'Admin', 'admin_url', 'admin/menu/delete', null, '删除菜单', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('108', 'Admin', 'admin_url', 'admin/menu/lists', null, '所有菜单', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('109', 'Admin', 'admin_url', 'admin/setting/default', null, '设置', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('110', 'Admin', 'admin_url', 'admin/setting/userdefault', null, '个人信息', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('111', 'Admin', 'admin_url', 'admin/user/userinfo', null, '修改信息', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('112', 'Admin', 'admin_url', 'admin/user/userinfo_post', null, '修改信息提交', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('113', 'Admin', 'admin_url', 'admin/setting/password', null, '修改密码', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('114', 'Admin', 'admin_url', 'admin/setting/password_post', null, '提交修改', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('115', 'Admin', 'admin_url', 'admin/setting/site', null, '网站信息', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('116', 'Admin', 'admin_url', 'admin/setting/site_post', null, '提交修改', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('117', 'Admin', 'admin_url', 'admin/route/index', null, '路由列表', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('118', 'Admin', 'admin_url', 'admin/route/add', null, '路由添加', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('119', 'Admin', 'admin_url', 'admin/route/add_post', null, '路由添加提交', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('120', 'Admin', 'admin_url', 'admin/route/edit', null, '路由编辑', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('121', 'Admin', 'admin_url', 'admin/route/edit_post', null, '路由编辑提交', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('122', 'Admin', 'admin_url', 'admin/route/delete', null, '路由删除', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('123', 'Admin', 'admin_url', 'admin/route/ban', null, '路由禁止', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('124', 'Admin', 'admin_url', 'admin/route/open', null, '路由启用', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('125', 'Admin', 'admin_url', 'admin/route/listorders', null, '路由排序', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('126', 'Admin', 'admin_url', 'admin/mailer/default', null, '邮箱配置', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('127', 'Admin', 'admin_url', 'admin/mailer/index', null, 'SMTP配置', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('128', 'Admin', 'admin_url', 'admin/mailer/index_post', null, '提交配置', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('129', 'Admin', 'admin_url', 'admin/mailer/active', null, '注册邮件模板', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('130', 'Admin', 'admin_url', 'admin/mailer/active_post', null, '提交模板', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('131', 'Admin', 'admin_url', 'admin/setting/clearcache', null, '清除缓存', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('132', 'User', 'admin_url', 'user/indexadmin/default', null, '用户管理', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('133', 'User', 'admin_url', 'user/indexadmin/default1', null, '用户组', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('134', 'User', 'admin_url', 'user/indexadmin/index', null, '本站用户', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('135', 'User', 'admin_url', 'user/indexadmin/ban', null, '拉黑会员', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('136', 'User', 'admin_url', 'user/indexadmin/cancelban', null, '启用会员', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('137', 'User', 'admin_url', 'user/oauthadmin/index', null, '第三方用户', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('138', 'User', 'admin_url', 'user/oauthadmin/delete', null, '第三方用户解绑', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('139', 'User', 'admin_url', 'user/indexadmin/default3', null, '管理组', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('140', 'Admin', 'admin_url', 'admin/rbac/index', null, '角色管理', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('141', 'Admin', 'admin_url', 'admin/rbac/member', null, '成员管理', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('142', 'Admin', 'admin_url', 'admin/rbac/authorize', null, '权限设置', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('143', 'Admin', 'admin_url', 'admin/rbac/authorize_post', null, '提交设置', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('144', 'Admin', 'admin_url', 'admin/rbac/roleedit', null, '编辑角色', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('145', 'Admin', 'admin_url', 'admin/rbac/roleedit_post', null, '提交编辑', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('146', 'Admin', 'admin_url', 'admin/rbac/roledelete', null, '删除角色', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('147', 'Admin', 'admin_url', 'admin/rbac/roleadd', null, '添加角色', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('148', 'Admin', 'admin_url', 'admin/rbac/roleadd_post', null, '提交添加', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('149', 'Admin', 'admin_url', 'admin/user/index', null, '管理员', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('150', 'Admin', 'admin_url', 'admin/user/delete', null, '删除管理员', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('151', 'Admin', 'admin_url', 'admin/user/edit', null, '管理员编辑', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('152', 'Admin', 'admin_url', 'admin/user/edit_post', null, '编辑提交', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('153', 'Admin', 'admin_url', 'admin/user/add', null, '管理员添加', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('154', 'Admin', 'admin_url', 'admin/user/add_post', null, '添加提交', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('155', 'Admin', 'admin_url', 'admin/plugin/update', null, '插件更新', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('156', 'Admin', 'admin_url', 'admin/storage/index', null, '文件存储', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('157', 'Admin', 'admin_url', 'admin/storage/setting_post', null, '文件存储设置提交', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('158', 'Admin', 'admin_url', 'admin/slide/ban', null, '禁用幻灯片', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('159', 'Admin', 'admin_url', 'admin/slide/cancelban', null, '启用幻灯片', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('160', 'Admin', 'admin_url', 'admin/user/ban', null, '禁用管理员', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('161', 'Admin', 'admin_url', 'admin/user/cancelban', null, '启用管理员', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('162', 'Demo', 'admin_url', 'demo/adminindex/index', null, '', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('163', 'Demo', 'admin_url', 'demo/adminindex/last', null, '', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('166', 'Admin', 'admin_url', 'admin/mailer/test', null, '测试邮件', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('167', 'Admin', 'admin_url', 'admin/setting/upload', null, '上传设置', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('168', 'Admin', 'admin_url', 'admin/setting/upload_post', null, '上传设置提交', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('169', 'Portal', 'admin_url', 'portal/adminpost/copy', null, '文章批量复制', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('170', 'Admin', 'admin_url', 'admin/menu/backup_menu', null, '备份菜单', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('171', 'Admin', 'admin_url', 'admin/menu/export_menu_lang', null, '导出后台菜单多语言包', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('172', 'Admin', 'admin_url', 'admin/menu/restore_menu', null, '还原菜单', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('173', 'Admin', 'admin_url', 'admin/menu/getactions', null, '导入新菜单', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('174', 'Admin', 'admin_url', 'admin/goods/index', null, '商品管理', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('175', 'Admin', 'admin_url', 'admin/goods/add', null, '添加商品', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('176', 'Admin', 'admin_url', 'admin/goods/goods_upload', null, '批量导入', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('177', 'Admin', 'admin_url', 'admin/goods/edit', null, '编辑商品', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('178', 'Admin', 'admin_url', 'admin/goods/account', null, '结账', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('179', 'Admin', 'admin_url', 'admin/goods/listorders', null, '商品排序', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('180', 'Admin', 'admin_url', 'admin/goods/toggle', null, '商品显示和隐藏', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('181', 'Admin', 'admin_url', 'admin/goods/delete', null, '删除商品', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('182', 'Admin', 'admin_url', 'admin/goods/cancelban', null, '显示商品', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('183', 'Admin', 'admin_url', 'admin/goods/ban', null, '隐藏商品', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('184', 'Admin', 'admin_url', 'admin/goods/getgoods', null, '扫码显示', '1', '');
INSERT INTO `cmf_goods` VALUES ('2922', '可口可乐', '1.25L', '6908512108211', '6.00', '8.00', '<p style=\"text-align: center;\"><img src=\"/newvillage/data/upload/ueditor/20170712/5965a1f12d723.jpg\" title=\"rBEQWFFtBnYIAAAAAADYqlCKpHsAAEOwwI6Kr0AANjC701.jpg\" alt=\"rBEQWFFtBnYIAAAAAADYqlCKpHsAAEOwwI6Kr0AANjC701.jpg\"/></p>', 'admin/20170712/5965a1fd49709.jpg', '2017-07-12 12:14:00', '1', '0');
INSERT INTO `cmf_goods` VALUES ('2923', '雪碧', '1.25L', '6908512109218', '6.50', '8.50', '<p style=\"text-align: center;\"><img src=\"/newvillage/data/upload/ueditor/20170712/5965a2588c491.JPG\" title=\"564359_3_pic500_7448.JPG\" alt=\"564359_3_pic500_7448.JPG\"/></p>', 'admin/20170712/5965a2791ae8a.JPG', '2017-07-12 12:15:55', '1', '0');
INSERT INTO `cmf_goods` VALUES ('2924', 'A雪碧汽水600ml', '600ml', '6908512109423', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2925', 'A可口可乐汽水600ml', '600ml', '6908512108426', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2926', 'A芬达橙味汽水', '600ml', '6908512110429', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2927', 'A百事可乐（听）355ml', '355ml', '6942404210019', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2928', 'A百事可乐600ml', '600ml', '6942404210026', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2929', 'A百事可乐1.25L', '1.25L', '6942404210033', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2930', 'A百事可乐2.5L', '2.5L', '6942404210057', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2931', 'A雪碧听装330ml', '330ml', '6908512208720', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2932', 'A可口可乐听装330ml', '330ml', '6908512208645', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2933', 'A雪碧汽水2.3L', '2.3L', '6908512109737', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2934', 'A酷儿橙汁1.5L', '1.5L', '6920927181818', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2935', 'A酷儿QOO橙汁饮料310ml', '310ml', '6920927181320', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2936', 'A美汁源果粒橙橙汁饮料1.25L', '1.25L', '6920927181894', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2937', 'A酷儿维生素C+钙香橙汁450ml', '450ML', '6920927181245', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2938', 'A美汁源果粒橙450ml', '450ml', '6920927181221', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2939', 'A康师傅橙汁饮品', '2L', '6920459998939', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2940', 'A水晶活力橙粒爽饮料', '1.5L', '6906670200549', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2941', 'A椰树牌天然椰子汁', '245ML', '6901347800053', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2942', 'A椰树天然椰子汁纸盒', '245ML', '6901347880017', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2943', 'A农夫果园芒果/菠萝/蕃石榴汁', '500ml', '6921168532025', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2944', 'A农夫果园(橙+芒果+苹果)汁', '1.5l', '6921168591510', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2945', 'A康师傅水蜜桃汁饮品', '500ml', '6920459905104', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2946', 'A康师傅水晶葡萄饮品', '500ml', '6920459908181', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2947', 'A健桑桑果汁30%500ml', '500ml', '6927729918185', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2948', 'A水溶C100柠檬汁饮料445ml', '445ml', '6921168500956', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2949', 'A美汁源热带果粒复合果汁饮料450ml', '450ml', '6920927182228', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2950', 'A美汁源爽粒葡萄汁饮料', '450ml', '6920927182235', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2951', 'A酷儿Qoo苹果汁饮料', '450ml', '6920927181252', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2952', 'A美汁源C粒柠檬450ml', '450ml', '6920927182266', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2953', 'A汇源100%果汁（苹果汁）200ml', '200ml', '6923555212800', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2954', 'A汇源100%果汁（鲜橙汁）200ml', '200ml', '6923555212794', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2955', 'A悦活超级100黑加仑葡萄混合果汁', '280ml', '6944396764129', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2956', 'A果缤纷沁甜梅莓美味果汁饮料', '450ml', '6934024515001', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2957', 'A酷儿QOO葡萄汁饮料450ml', '450ml', '6920927182273', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2958', 'A纯果乐鲜果粒橙汁饮料420ml', '420ml', '6934024515605', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2959', 'A午时金银花露饮料', '250ML', '6911011516883', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2960', 'A红牛维生素功能饮料', '250ml', '6920202888883', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2961', 'A泰山牌仙草蜜饮料', '250克', '6921567099105', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2962', 'A娃哈哈激活（柑桔）', '600ml', '6902083886363', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2963', 'A农夫山泉尖叫纤维饮料', '550ml', '6921168504022', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2964', 'A泰山牌仙草蜜颗粒饮料', '330g', '6921567028884', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2965', 'A雀巢丝滑拿铁咖啡饮料268ml', '268ml', '6917878030623', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2966', 'A红牛维生素营养液500ml', '500ml', '6943827600036', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2967', 'A康师傅冰红茶', '490ml', '6920459905012', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2968', 'A康师傅绿茶', '500ML', '6920459905166', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2969', 'A惠尔康燕窝冬瓜茶', '250ML', '6903254688076', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2970', 'A绿力冬瓜茶', '245ml', '6911474741082', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2971', 'A康师傅冰绿茶', '490ml', '6920459923009', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2972', 'A娃哈哈冰红茶', '500ML', '6902083883089', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2973', 'A绿力冬瓜茶', '500ml', '6911474500344', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2974', 'A惠尔康蜂蜜菊花茶', '560ML', '6903254300763', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2975', 'A惠尔康菊花茶饮料', '250ml', '6903254000045', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2976', 'A王老吉凉茶利乐包', '250ml', '6901424333948', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2977', 'A王老吉凉茶310ml', '310ml', '4891599338898', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2978', 'A呦呦奶味茶（原味）', '500ml', '6942980800048', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2979', 'A娃哈哈蓝莓冰红茶', '500ml', '6902083894092', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2980', 'A农夫山泉饮用天然水', '4L', '6921168509270', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2981', 'A农夫山泉饮用天然水（奥运装）', '550ml', '6921168509256', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2982', 'A娃哈哈饮用纯净水', '596ML', '6902083881405', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2983', 'A农夫山泉饮用天然水', '1.5L', '6921168520015', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2984', 'A娃哈哈饮用纯净水', '1.25升', '6902083882099', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2985', 'A娃哈哈饮用纯净水', '350ML', '6902083880675', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2986', 'A农夫山泉饮用天然水', '380ml', '6921168511280', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2987', 'A娃哈哈纯真年代纯净水', '596ML', '6902083884178', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2988', 'A康师傅矿物质纯净水', '550ml', '6920459905036', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2989', 'A水森活饮用纯净水', '550ML', '6908198100011', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2990', 'A白鸽我滴橙滴水果饮料', '500克', '6900157527785', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2991', 'A正点酷青苹果醋365ml', '365ml', '6942994800102', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2992', 'A青岛啤酒(金装8度)', '600ml', '6901035603515', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2993', 'A石梁啤酒', '590ml', '6936020661072', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2994', 'A青岛听装啤酒', '330ml', '6901035608824', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2995', 'A红石粱7度啤酒听装350ml', '350ml', '6943736201096', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2996', 'A雪花8度清爽啤酒330ml', '330ml', '6901109889081', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2997', 'A王朝干红750ML', '750ML', '6901025100406', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2998', 'A王朝98年份干红葡萄酒', '750ML', '6901025100826', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('2999', 'A王朝干红葡萄酒2001年份', '750ML', '6901025400230', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3000', 'A王朝干白葡萄酒2001年份', '750ML', '6901025400247', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3001', 'A威龙赤霞珠橡木桶干红葡萄酒', '750ml', '6905596003456', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3002', 'A威龙92蛇龙珠干红葡萄酒', '750ml', '6905596004132', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3003', 'A华东庄园薏丝琳干白葡萄酒　', '750ml', '6901008720010', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3004', 'A威龙至樽干红葡萄酒', '750ml', '6905596000738', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3005', 'A长城解百纳干红750ml', '750ml', '6901009912216', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3006', 'A张裕2001精品干红葡萄酒', '750ml', '6901584060562', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3007', 'A张裕特选级解百纳干红', '750ml', '6901584061231', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3008', 'A张裕窖藏三年至尊干红葡萄酒', '750ml', '6901584064935', null, null, null, null, '2017-07-12 12:12:18', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3009', 'A古越龙山陈年5年花雕', '500ML', '6903290190298', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3010', 'A仙不走三年陈花雕', '500ML', '6926345650011', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3011', 'A仙不走五年陈花雕', '500ML', '6926345620052', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3012', 'A北高峰糯米黄酒400ML', '400ML', '6910768918377', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3013', 'A越景陈年花雕酒', '600ml', '6939037400115', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3014', 'A越景花雕酒（桶装）', '2.5L', '6939037400016', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3015', 'A古越龙山绍兴加饭酒', '500ml', '6903290190045', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3016', 'A古越龙山状元红八年陈酿', '372ml', '6902944901587', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3017', 'A会稽山三年陈酿黄酒', '500ml', '6905321879875', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3018', 'A会稽山五年陈酿黄酒', '500ml', '6905321879899', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3019', 'A古越龙山状元红营养黄酒', '370ml', '6902944910046', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3020', 'A米婆婆甜香酒酿', '400克', '6937491301788', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3021', 'A古越龙山清醇三年黄酒500ml', '500ml', '6902944880059', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3022', 'A同康袋装黄酒350ml', '350ml', '6928190700040', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3023', 'A俏阿婆佬米酒400g', '400g', '6947402100027', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3024', 'A越景特醇三年陈绍兴花雕', '2.5L', '6939037400054', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3025', 'A茅台醇白浓香型酒（38度佳品）', '425ml', '6931699810264', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3026', 'A43度贵州茅台酒（带杯）', '500ml', '6902952884308', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3027', 'A52度泸州老窖特曲', '500ml', '6901798810137', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3028', 'A52度五粮液(新)', '500ml', '6901382103355', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3029', 'A茅台醇浓香型白酒（52度佳品）', '425ml', '6931699810301', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3030', 'A京乐牌北京二锅头(55度清香型)', '500ml', '6927772300463', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3031', 'A京乐牌北京二锅头(运', '475ml', '6927772300319', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3032', 'A泸州老酒坊白酒(52度喜字坛)', '500ml', '6901798117243', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3033', 'A泸州老酒坊白酒（38度地字坛）', '500ml', '6901798117120', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3034', 'A茅台醇45度小酒', '125ml', '6931699818192', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3035', 'A皇妃中华玉液（38度白酒）', '500ml', '6938875518983', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3036', 'A洋河精制特曲（42度）', '500ml', '6902135342175', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3037', 'A古井金纯粮白酒（39度）', '500ml', '6902018995528', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3038', 'A五粮液1618（52度）', '500ml', '6901382023677', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3039', 'A金六福福星50度白酒475ml', '475ml', '6937660961997', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3040', 'A泸州老窖头曲52度白酒500ml', '500ml', '6901798120854', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3041', 'A汾湖45度特制糟烧', '4.5L', '6902550302914', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3042', 'A红星52度二锅头酒100ml', '100ml', '6906785010910', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3043', 'A红星45度窖藏二锅头酒', '248ml', '6906785012174', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3044', 'A泸州五年陈52度窖酒', '500ml', '6901798113320', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3045', 'A金山陵50度瓶装糟烧500ml', '500ml', '6928393700076', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3046', 'A京乐50度红高粱酒4L', '4L', '6927772302580', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3047', 'A38度致中和牌五加皮酒（精制）', '500ml', '6922306500029', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3048', 'A35度中国劲酒', '125ml', '6909131169201', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3049', 'A中国劲酒258ml', '258ml', '6909131181234', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3050', 'A椰岛鹿龟酒单瓶装', '500ml', '6901160007073', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3051', 'A光明纯牛奶', '250ml', '6901209302220', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3052', 'A伊利纯牛奶', '250ML', '6907992100272', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3053', 'A蒙牛纯牛奶', '250ML', '6923644223458', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3054', 'A蒙牛高钙纯奶', '250ML', '6923644251123', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3055', 'A伊利高钙奶', '250ML', '6907992500379', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3056', 'A蒙牛高钙低脂牛奶', '250ML', '6923644240318', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3057', 'A旺仔牛奶(小罐)', '145ml', '6920584471215', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3058', 'A旺仔牛奶', '245ML', '6920584471017', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3059', 'A伊利甜牛奶', '250ml', '6907992501154', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3060', 'A伊利AD钙奶', '250ML', '6907992100043', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3061', 'A旺仔牛奶(纸盒)', '125ml', '69021824', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3062', 'A蒙牛早餐奶核桃味', '250ML', '6923644264116', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3063', 'A蒙牛特仑苏纯牛奶', '12*250ml', '6923644266318', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3064', 'A娃哈哈营养快线菠萝味饮料', '500ML', '6902083886417', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3065', 'A娃哈哈营养快线原味饮料', '500ML', '6902083886455', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3066', 'A伊利优酸乳原味', '250ML', '6907992500010', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3067', 'A光明酸牛奶饮品(原味)', '190ML', '6901209309298', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3068', 'A蒙牛酸酸乳（原味）', '250ml', '6923644242923', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3069', 'A蒙牛未来星活力成长奶（原味）', '125ml', '6923644265946', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3070', 'A蒙牛未来星优智成长奶（原味）', '125ml', '6923644265953', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3071', 'A蒙牛妙妙儿童营养乳酸饮品180ml', '180ml', '6923644265922', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3072', 'A伊利QQ星原味儿童乳饮料', '125ml', '6907992506623', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3073', 'A伊利优酸乳（草莓味', '250ML', '6907992100012', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3074', 'A伊利优酸乳蓝莓味', '250ML', '6907992502588', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3075', 'A蒙牛酸酸乳（草莓味）', '250ml', '6923644242930', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3076', 'A蒙牛酸酸乳蓝莓味', '250ML', '6923644242947', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3077', 'A蒙牛酸酸乳芒果味', '250ML', '6923644242954', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3078', 'A蒙牛芦荟味酸酸乳乳饮料', '250ml', '6923644264901', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3079', 'A蒙牛AD钙酸酸乳乳饮料', '250ml', '6923644264895', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3080', 'A椰树豆奶', '242ML', '6901347880543', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3081', 'A蒙牛未来星活力成长奶原味', '190ml', '6923644265960', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3082', 'A蒙牛未来星优智成长奶原味', '190ml', '6923644265977', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3083', 'A蒙牛特仑苏低脂奶', '250ml*12', '6923644269586', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3084', 'A蒙牛真果粒牛奶饮品黄桃味', '250ml', '6923644268510', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3085', 'A蒙牛真果粒牛奶饮品芦荟味', '250ml', '6923644268497', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3086', 'A蒙牛真果粒牛奶饮品椰果味', '250ml', '6923644268480', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3087', 'A蒙牛真果粒牛奶饮品草莓味', '250ml', '6923644268503', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3088', 'A伊利营养舒化奶全脂型', '250ml', '6907992507064', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3089', 'A伊利营养舒化奶低脂型', '250ml', '6907992507088', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3090', 'A蒙牛妙妙儿童营养乳酸饮品', '125ml', '6923644270780', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3091', 'A蒙牛酸酸乳猕猴桃味250ml', '250ml', '6923644270247', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3092', 'A银鹭花生牛奶蛋白饮料', '250ml', '6926892522052', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3093', 'A伊利QQ星健骨型儿童成长牛奶190ml', '190ml', '6907992510439', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3094', 'A伊利QQ星益智型儿童成长牛奶125ml', '125ml', '6907992510446', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3095', 'A伊利QQ星健骨型儿童成长奶125ml', '125ml', '6907992510422', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3096', 'A伊利QQ星益智型儿童成长奶190ml', '190ml', '6907992510453', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3097', 'A蒙牛草莓果蔬酸酸乳', '250ml', '6923644271985', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3098', 'A蒙牛菠萝果蔬酸酸乳', '250ml', '6923644271961', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3099', 'A蒙牛妙妙儿童营养乳酸饮品草莓味', '125ml', '6923644271886', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3100', 'A伊利果之优酸乳原味250ml', '250ml', '6907992509389', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3101', 'A伊利果之优酸乳草莓味250ml', '250ml', '6907992508856', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3102', 'A娃哈哈大AD钙奶（组）', '220ml*4', '6902083881085', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3103', 'A娃哈哈乳娃娃营养酸奶（组）', '100ml*5', '6902083881245', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3104', 'A娃哈哈爽歪歪酸奶饮品（组）', '200ml*4', '6902083890636', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3105', 'A娃哈哈爽歪歪酸奶饮品（组）', '125ml*4', '6902083890261', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3106', 'A美汁源果粒奶优芒果风味450ml', '450ml', '6920927184215', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3107', 'A美汁源果粒奶优菠萝风味450ml', '450ml', '6920927184239', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3108', 'A美汁源果粒奶优蜜桃风味450ml', '450ml', '6920927184222', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3109', 'A娃哈哈营养快线椰子味果汁酸奶', '500ml', '6902083893842', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3110', 'A喜羊羊与灰太狼乳酸菌饮料原味200ml', '200ml', '6949487700116', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3111', 'A伊利谷粒多红谷牛奶250ml', '250ml', '6907992511139', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3112', 'A伊利谷粒多黑谷牛奶250ml', '250ml', '6907992511146', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3113', 'A李子园花生牛奶蛋白饮料', '250ml*16', '6916196410704', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3114', 'A万士发淮盐克力架饼干', '250克', '6901533121658', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3115', 'A达能牛奶香脆饼干', '1KG', '6904682161049', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3116', 'A达能牛奶香脆饼干', '125克', '6904682161018', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3117', 'A明治欣欣杯(牛奶味)', '50克', '6908312000869', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3118', 'A明治欣欣杯(牛奶味)', '25克', '6908312000852', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3119', 'A乐天可可+鲜奶油小熊饼', '49克', '6916296990076', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3120', 'A立洲纯之蛋蛋黄饼', '170克', '6919863000789', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3121', 'A盼盼奶酪小馒头片', '75g', '6920912342910', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3122', 'A旺旺小馒头（五连包）', '18g', '6935041525066', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3123', 'A金得利草莓巧克力手挽杯', '35克', '6908004000382', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3124', 'A溢东广东早茶饼', '800克', '6902031312883', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3125', 'A精益珍小丸煎饼芝麻味', '120克', '6920902912024', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3126', 'A万士发巧克力通心酥', '200克', '6901533122198', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3127', 'A万士发芝麻通心酥', '200克', '6901533121474', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3128', 'A达利园好吃点香脆核桃饼', '108g', '6911988009784', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3129', 'A达利园好吃点香脆腰果饼', '108g', '6911988009777', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3130', 'A达利好吃点杏仁酥', '800g', '6911988000385', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3131', 'A达利好吃点核桃酥', '800g', '6911988000378', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3132', 'A达利好吃点杏仁酥', '146g', '6911988000293', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3133', 'A达利好吃点核桃酥', '146g', '6911988000286', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3134', 'A万士发风梨果酱夹心饼', '100克', '6901533121443', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3135', 'A乐天小熊饼巧克力夹心', '49g', '6916296970030', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3136', 'A乐天小熊饼草莓奶油夹心', '49克', '6916296970047', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3137', 'A达能王子夹心饼干草莓味', '120克', '6904682124013', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3138', 'A奥利奥夹心巧克力饼干', '150克', '6901668053015', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3139', 'A奥利奥饼干', '450克', '6901668053039', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3140', 'A达能王子夹心巧克力味', '120克', '6904682123016', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3141', 'A达能王子夹心饼干牛奶巧克力', '120克', '6904682124204', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3142', 'A达能牛奶特浓夹心饼干', '130克', '6904682162206', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3143', 'A奥利奥巧克力夹心', '150ｇ', '6901668053206', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3144', 'A奥利奥巧克力夹心饼干', '450克', '6901668053213', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3145', 'A格力高百奇(牛奶)', '60克', '6901845010176', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3146', 'A格力高百奇(巧克力)', '60克', '6901845010169', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3147', 'A奥利奥美味双心（花生巧克力味）', '137克', '6901668053251', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3148', 'A格力高百醇巧克力味夹心饼干　', '48克', '6901845040685', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3149', 'A格力高百醇牛奶味夹心饼干', '48克', '6901845040692', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3150', 'A卡夫奥利奥轻舔夹心饼干', '150g', '6901668053312', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3151', 'A达能王子曲奇星饼干', '85克', '6904682123207', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3152', 'A达能牛奶香脆饼干香橙味', '125克', '6920262316821', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3153', 'A欣欣杯朱古力', '50克', '6908312000784', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3154', 'A达能甜趣清甜饼干', '1kg', '6904682152146', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3155', 'A达能甜趣清甜饼干', '100克', '6904682151118', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3156', 'A欣欣杯（朱古力+香蕉）', '50克', '6908312000821', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3157', 'A欣欣杯草莓味', '50克', '6908312000760', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3158', 'A欣欣杯(朱古力+香蕉)', '25克', '6908312000814', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3159', 'A欣欣杯（草莓酱）', '25克', '6908312000753', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3160', 'A四洲小欣欣杯  （香橙）', '50g', '6908312001347', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3161', 'A旺仔小馒头', '250g', '6935041525103', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3162', 'A达能王子曲奇星饼干醇香奶油味', '85g', '6920262312304', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3163', 'A格力高百醇抹茶慕斯味', '48g', '6901845040968', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3164', 'A米老头蛋黄煎饼（原味）', '150g', '6934364801123', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3165', 'A滨崎小熊灌心饼奶油味', '45g', '6924762398615', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3166', 'A滨崎小熊灌心饼草莓味', '45g', '6924762397618', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3167', 'A旺旺妈妈罐小馒头', '250g', '6935041525455', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3168', 'A旺旺小馒头', '50g', '6935041525059', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3169', 'A好丽友蘑古力巧克力味', '48克', '6920907808018', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3170', 'A格力高百醇红酒巧克力味夹心饼干', '48克', '6901845041248', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3171', 'A好丽友蘑古力红豆巧克力味小饼干', '48克', '6920907808070', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3172', 'A格力高慕思百奇涂层饼干浓郁抹茶味', '48g', '6901845041330', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3173', 'A格力高粒粒百奇饼干（牛奶草莓）', '45g', '6901845041538', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3174', 'A格力高粒粒百奇饼干（蓝莓）', '45g', '6901845041552', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3175', 'A格力高百奇饼干（草莓）', '55g', '6901845041606', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3176', 'A奥利奥草莓夹心饼干', '450g', '6901668053701', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3177', 'A奥利奥草莓夹心饼干', '150g', '6901668053695', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3178', 'A米老头时尚法式薄饼', '150g', '6925332603054', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3179', 'A米老头蛋黄煎饼', '150g', '6934364801390', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3180', 'A明治欣欣杯（草莓酸奶）饼干条', '50g', '6908312001897', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3181', 'A格力高百醇饼干（草莓 香草）', '48g', '6901845041705', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3182', 'A格力高百奇（抹茶味）', '50g', '6901845041804', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3183', 'A奥利奥冰淇淋夹心饼干（香草）', '118g', '6901668053848', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3184', 'A奥利奥冰淇淋夹心巧克力饼干（抹茶）', '118g', '6901668053824', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3185', 'A旺旺仙贝', '240g', '6909995101140', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3186', 'A旺旺仙贝经济包', '500克', '6909995101089', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3187', 'A旺旺雪饼', '84g', '6909995102093', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3188', 'A旺旺煎饼', '130克', '6909410202025', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3189', 'A旺旺经济装雪饼', '500g', '6909995102079', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3190', 'A蛋黄长鼻王（蛋黄口味）', '48g', '6906978938663', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3191', 'A旺旺仙贝', '52克', '6909995101119', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3192', 'A蛋黄长鼻王', '160克', '6906978941212', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3193', 'A小王子中聪明棒', '150克', '6905418005101', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3194', 'A长鼻王蛋黄口味膨化夹心卷', '420克', '6906978938687', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3195', 'A60克小小酥(鸡肉味)', '60克', '6909995103687', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3196', 'A米老头农夫小舍花生味米通', '150克', '6925332600411', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3197', 'A米老头农夫小舍芝麻味米通', '150克', '6925332600404', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3198', 'A小王子香雪饼', '84g', '6905418003688', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3199', 'A小王子鲜米饼（经济包）', '500g', '6905418003060', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3200', 'A小王子香雪饼', '500g', '6905418003077', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3201', 'A长富花梨糖(牛奶味)', '128g', '6921127001012', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3202', 'A长富花梨糖牛奶味', '50g', '6921127001098', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3203', 'A达能高钙三层苏打饼干（奶盐味）', '100克', '6904682111105', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3204', 'A达能三层高钙苏打香葱', '100克', '6904682121104', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3205', 'A康师傅3+2苏打饼干柠檬口味', '125克', '6919892633309', null, null, null, null, '2017-07-12 12:12:19', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3206', 'A康师傅3+2苏打饼干蓝莓口味', '125克', '6919892633606', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3207', 'A康师傅3+2苏打饼干奶油味', '125克', '6919892633101', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3208', 'A达能3层高钙梳打海苔味', '100g', '6904682114205', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3209', 'A达能芝麻闲趣咸味饼干', '100克', '6904682154010', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3210', 'A达能闲趣TLC咸味饼干', '100克', '6904682151019', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3211', 'A达能闲趣咸饼干TLC', '1KG', '6904682152047', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3212', 'A达能海苔闲趣饼干', '100G', '6904682152207', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3213', 'A达能闲趣田园香葱味咸饼干', '100克', '6904682153204', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3214', 'A吉利小火星微波爆米花奶油味', '118g', '6923487500020', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3215', 'A麦吉士一口吃山核桃小酥', '320g', '6940517512044', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3216', 'A麦吉士一口吃芝麻仁小酥', '320g', '6940517512020', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3217', 'A麦吉士一口吃南瓜子小酥', '320g', '6940517512037', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3218', 'A麦吉士一口吃花生小酥　', '320g', '6940517512013', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3219', 'A旺旺小小酥原味', '60g', '6909995103670', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3220', 'A风顺米老大香脆米棒', '208g', '6928885701413', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3221', 'A旺旺大米饼', '135克', '6920616313186', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3222', 'A小鱼果海苔味', '15克', '6921068700104', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3223', 'A小鱼果海苔味', '60克', '6921068700067', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3224', 'A米老头农夫小舍米通花生味', '500g', '6925332604051', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3225', 'A添乐卡通王长棒饼新奥尔良烤鸡翅味', '50克', '6936891520515', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3226', 'A添乐卡通王长棒饼意式番茄味', '50克', '6936891520508', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3227', 'A旺旺大雪饼', '118g', '6920766211608', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3228', 'A旺旺仙贝', '105g', '6920766211028', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3229', 'A正宗咪咪油炸虾条', '180克', '6921682816663', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3230', 'A妙脆角香脆玉米角香浓辣鸡', '40克', '6923721201430', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3231', 'A贝蒂妙厨妙脆角美式茄汁', '16克', '6923721201232', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3232', 'A妙脆角美式茄汁', '40克', '6923721201225', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3233', 'A妙脆角魔力炭烧', '40克', '6923721201331', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3234', 'A上好佳荷兰豆', '60克', '6909409012031', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3235', 'A上好佳汉堡球', '18克', '6926265302038', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3236', 'A上好佳牛奶小饼', '28克', '6926265312549', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3237', 'A好丽友好多鱼脆香烧烤味', '34克', '6920907808179', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3238', 'A好丽友好多鱼鲜香海苔味', '34克', '6920907808032', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3239', 'A好丽友好多鱼浓香茄汁味', '34克', '6920907808117', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3240', 'A奇多干杯脆日式牛排味', '25克', '6924743913387', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3241', 'A上好佳日本鱼果海苔味', '12g', '6926265339133', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3242', 'A上好佳薯条番茄味', '12g', '6926265339409', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3243', 'A上好佳鲜虾片', '12g', '6926265339386', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3244', 'A上好佳洋葱圈', '12g', '6926265339515', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3245', 'A精益珍蛋沙琪玛', '200G', '6920902960094', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3246', 'A精益珍芝麻沙琪玛', '200G', '6920902961688', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3247', 'A精益珍蛋酥沙琪玛', '368', '6920902967017', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3248', 'A精益珍芝麻沙琪玛', '368', '6920902967024', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3249', 'A精益珍黑糖沙琪玛', '200g', '6920902968083', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3250', 'A乐事忠于原味薯片', '110克', '6924743914551', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3251', 'A乐事原味天然薯片', '50g', '6924743910355', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3252', 'A上好佳洋葱圈', '45克', '6909409040799', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3253', 'A上好佳鲜虾片', '45g', '6909409012024', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3254', 'A上好佳天然薯片(烤肉味)', '60g', '6909409040898', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3255', 'A上好佳天然薯片(番茄口味)', '60克', '6909409040775', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3256', 'A上好佳玉米花（果仁奶油）', '50克', '6909409012321', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3257', 'A上好佳天然薯片（烤肉口味）', '18g', '6909409039892', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3258', 'A上好佳鲜虾片', '18克', '6909409023020', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3259', 'A上好佳玉米卷', '18克', '6909409023099', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3260', 'A上好佳洋葱圈', '18克', '6909409039793', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3261', 'A上好佳天然薯片(番茄)', '18g', '6909409039779', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3262', 'A上好佳日本海苔味', '18g', '6926265302137', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3263', 'A乐事天然薯片红烩味', '80g', '6924743910447', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3264', 'A乐事无限滋滋烤肉薯', '110克', '6924743914568', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3265', 'A乖乖脆果草莓炼乳味薯片', '22克', '6921290410437', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3266', 'A乖乖脆果炼乳超浓味薯片', '22克', '6921290410413', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3267', 'A乖乖脆果炼乳超浓味薯片', '70克', '6921290410420', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3268', 'A乐事得克萨斯烧烤味', '50g', '6924743910393', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3269', 'A乐事天然薯片脆香鸡翅味', '50g', '6924743910478', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3270', 'A乐事天然薯片意大利香浓红烩味', '50g', '6924743910430', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3271', 'A乐事天然薯片清怡黄瓜味', '50g', '6924743910621', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3272', 'A乐事天然薯片清怡黄瓜味', '80g', '6924743910638', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3273', 'A乐事天然薯片墨西哥鸡汁番茄味', '50g', '6924743910508', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3274', 'A乐事无限鲜浓番茄薯片', '110克', '6924743914599', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3275', 'A乐事无限吮指红烧肉薯片', '110克', '6924743914575', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3276', 'A奇多粟米棒日式牛排味', '60克', '6924743911659', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3277', 'A乐事世界风意大利香浓红烩味', '18g', '6924743912441', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3278', 'A乐事世界风墨西哥鸡汁番茄味', '18g', '6924743912526', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3279', 'A上好佳薯条(番茄)', '18克', '6909409023242', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3280', 'A上好佳草莓粟米条', '18克', '6909409023808', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3281', 'A上好佳鲜虾条', '18克', '6909409023013', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3282', 'A上好佳芝士条', '18g', '6926265302052', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3283', 'A上好佳草莓粟米条', '45克', '6909409012802', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3284', 'A盼盼摇摇乐薯条番茄味', '45g', '6920912341173', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3285', 'A乐事薯片美国经典原味', '18g', '6924743912434', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3286', 'A乐事薯片得克萨斯烧烤味', '18g', '6924743912533', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3287', 'A乐事无限薯片翡翠黄瓜味', '110g', '6924743914629', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3288', 'A乐事薯片小番茄味', '50g', '6924743912496', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3289', 'A可比克薯片番茄味', '60g', '6911988006455', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3290', 'A可比克薯片烧烤味', '60g', '6911988006448', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3291', 'A可比克薯片香辣味', '60g', '6911988006462', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3292', 'A可比克薯片原味', '45g', '6911988006554', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3293', 'A可比克薯片烧烤味', '45g', '6911988006547', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3294', 'A可比克薯片番茄味', '45g', '6911988006523', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3295', 'A可比克薯片烧烤味', '110g', '6911988006585', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3296', 'A可比克薯片番茄味', '110g', '6911988006561', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3297', 'A可比克薯片原味', '60g', '6911988006479', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3298', 'A乐事自然清爽青柠味薯片', '50克', '6924743913189', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3299', 'A乐事薯片蓝莓味', '50克', '6924743913608', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3300', 'A好丽友呀土豆番茄味薯片', '40g', '6920907808513', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3301', 'A好丽友呀土豆里脊牛排味薯条', '40g', '6920907808551', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3302', 'A好丽友呀土豆里脊牛排味薯条', '70克', '6920907808575', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3303', 'A好丽友呀土豆番茄薯条', '70克', '6920907808537', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3304', 'A乐事秘制酸汤鱼味薯片', '50克', '6924743914452', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3305', 'A好吃点草莓夹心金牌蛋卷', '120克', '6911988000934', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3306', 'A小神童蛋黄夹心卷', '150g', '6936474100066', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3307', 'A可兹巧克力味休闲夹心卷', '60g', '6900731886178', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3308', 'A达利瑞士卷草莓味', '176克', '6911988013538', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3309', 'A奥利奥巧克力威化', '18克', '6901668053343', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3310', 'A奥利奥双心脆巧克力威化饼', '87g', '6901668053718', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3311', 'A奥利奥双心脆威化饼干（草莓）', '87g', '6901668053787', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3312', 'A奥利奥巧克力威化饼干（摩卡咖啡）', '324g', '6901668053763', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3313', 'A奥利奥巧脆卷（巧克力味）', '55g', '6901668053527', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3314', 'A奥利奥巧脆卷（香草味）', '55g', '6901668053510', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3315', 'A奥利奥双心脆威化饼干（花生）', '87g', '6901668053817', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3316', 'A奥利奥双心脆威化饼干（香草）', '14.5g', '6901668053671', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3317', 'A达利蛋黄注心派', '1000G', '6911988005472', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3318', 'A康师傅妙芙欧式蛋糕奶油味', '96克', '6920731701103', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3319', 'A乐天草莓派', '165g', '6916296000225', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3320', 'A好丽友蛋黄派', '23g*6', '6920907800210', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3321', 'A乐天蛋黄派', '150g', '6916296980022', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3322', 'A乐天巧克力派', '30g*6', '6916296960031', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3323', 'A乐天蓝莓派', '27.5克*6个', '6916296000072', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3324', 'A福马蛋黄派', '450克', '6921682815390', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3325', 'A三辉麦风法式香奶面包', '200g', '6922734883886', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3326', 'A三辉麦风法式香奶面包', '450g', '6922734898996', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3327', 'A佳迪澳芙欧式香面包', '420g', '6924194416925', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3328', 'A嘉伦欧派蛋糕蛋黄味', '800g', '6902031313170', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3329', 'A乐天蛋黄派', '144克', '8801062140398', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3330', 'A好丽友蛋黄派', '276克', '6920907800302', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3331', 'A福马爱尚非蛋糕椰香味', '160克', '6921682823616', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3332', 'A福马爱尚非蛋糕椰香味', '80克', '6921682823579', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3333', 'A福马爱尚非蛋糕草莓味', '80克', '6921682823562', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3334', 'A福马爱尚非蛋糕香蕉味', '160克', '6921682823593', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3335', 'A福马爱尚非蛋糕草莓味', '160克', '6921682823609', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3336', 'A实在香和风草饼黑芝麻味', '150克', '6921644302630', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3337', 'A实在香和风草饼绿豆味', '150克', '6921644302678', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3338', 'A盼昐法式面包', '320克', '6920912349391', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3339', 'A丹夫华夫饼（奶油）', '168克', '6942813800030', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3340', 'A丹夫华夫饼原味', '168克', '6942813800023', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3341', 'A好丽友Q蒂巧克力蛋糕', '168g', '6920907803020', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3342', 'A好丽友提拉米苏派', '138g', '6920907801323', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3343', 'A达利园法式香奶面包', '400克', '6911988011619', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3344', 'A达利园法式奶香面包', '200克', '6911988011602', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3345', 'A福马巧克力派', '450克', '6921682826914', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3346', 'A福马巧克力派', '350克', '6921682826891', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3347', 'A好丽友Q蒂榛子巧克力蛋糕', '168克', '6920907803129', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3348', 'A达利法式软面包香奶味', '600克', '6911988014870', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3349', 'A达利法式软面包香橙味', '600克', '6911988014399', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3350', 'A达利法式软面包香橙味', '360克', '6911988014887', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3351', 'A达利法式软面包香奶味', '360克', '6911988014825', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3352', 'A达利法式软面包香奶味', '200克', '6911988014832', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3353', 'A达利法式软面包香橙味', '200克', '6911988014894', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3354', 'A三辉烧贝壳蛋糕', '150克', '6922734801392', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3355', 'A三辉烧贝壳蛋糕', '300克', '6922734801385', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3356', 'A达利园瑞士卷（草莓）', '800g', '6911988013835', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3357', 'A达利园瑞士卷（香蕉）', '800g', '6911988013866', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3358', 'A盼盼法式面包奶香味', '300g', '6920912353688', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3359', 'A盼盼法式面包香橙味', '300g', '6920912353695', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3360', 'A盼盼法式面包香橙味', '200g', '6920912353664', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3361', 'A盼盼法式面包香橙味', '400g', '6920912353725', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3362', 'A盼盼法式面包奶香味', '400g', '6920912353718', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3363', 'A雪丽糍日式麻糬（香芋）', '200g', '6914253434755', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3364', 'A雪丽糍日式麻糬（芝麻）', '200g', '6914253434731', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3365', 'A泡吧拉丝面包', '50g', '6948965900048', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3366', 'A众望小麻花（芝麻）', '130克', '6922895498301', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3367', 'A好丽友巧克力派（6个装）', '34g*6', '6920907800944', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3368', 'A好丽友巧克力派（12个装）', '34g*12', '6920907800968', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3369', 'A绿盛精装牛肉颗粒', '100克', '6907149808280', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3370', 'A绿盛沙嗲牛肉颗粒', '75克', '6907149707040', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3371', 'A绿盛五香牛肉颗粒', '75克', '6907149707033', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3372', 'A绿盛牛肉粒', '18g', '6907149707415', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3373', 'A溢佳香牛肉粒(五香)', '70克', '6922065711339', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3374', 'A溢佳香牛肉粒（五香）', '45g', '6922065733881', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3375', 'A溢佳香牛肉粒（低糖）', '45克', '6922065700067', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3376', 'A溢佳香牛肉粒', '105克', '6922065704119', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3377', 'A绿盛卤味牛筋（红烧味）', '120g', '6907149200305', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3378', 'A绿盛红烧卤味牛筋', '68g', '6907149300036', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3379', 'A厨师沙嗲牛肉片', '50克', '6920072423030', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3380', 'A溢佳香卤半鲜红烧牛肉粒', '80克', '6922065701958', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3381', 'A溢佳香卤半鲜红烧牛肉粒', '150克', '6922065722205', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3382', 'A溢佳香沙嗲牛肉干', '70g', '6922065733454', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3383', 'A绿盛农夫与海鱼柳夹心牛肉粒', '100g', '6907149808334', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3384', 'A厨师金丝猪肉松', '100克', '6920072498403', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3385', 'A厨师猪肉干', '20克', '6920072498335', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3386', 'A厨师儿童营养肉松塑盒', '120克', '6920072498458', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3387', 'A厨师儿童营养猪肉松', '250克', '6920072422279', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3388', 'A台洲湾熟鱼片', '100g', '6931981708286', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3389', 'A台洲湾鱿鱼丝', '50g', '6931981708088', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3390', 'A台洲湾鱿鱼丝', '100g', '6931981708095', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3391', 'A台洲湾鱼片', '50g', '6931981708187', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3392', 'A4.5克波力原味海苔', '4.5g', '6918598028013', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3393', 'A波力海苔原味', '6克', '6918598028198', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3394', 'A喜之郎美好时光原味海苔', '4.5g', '6926475202074', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3395', 'A喜之郎美好时光辣味海苔', '12g', '6926475202098', null, null, null, null, '2017-07-12 12:12:20', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3396', 'A喜之郎美好时光原味海苔', '7.5克', '6926475202357', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3397', 'A喜之郎美好时光原味海苔', '3克', '6926475202340', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3398', 'A绿盛卤味鸭肫干（红烧味）', '120g', '6907149200329', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3399', 'A绿盛红烧卤味鸭肫干', '68g', '6907149300012', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3400', 'A喜之郎美好时光海苔', '18g', '6926475202685', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3401', 'A唯新儿童营养肉酥', '115g', '6905587061014', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3402', 'A贝因美酥可儿宝宝原味酥', '115g', '6904591005359', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3403', 'A贝因美酥可儿宝宝胡萝卜酥', '115g', '6904591005366', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3404', 'A喜之郎美好时光海苔韩式岩烧味', '6g', '6926475203071', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3405', 'A厨师儿童营养猪肉松', '120克', '6920072424334', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3406', 'A渔家小镇烤鱼片', '65克', '6944314860094', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3407', 'A渔家小镇香鱼派', '42克', '6944314860070', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3408', 'A渔家小镇烤鱼片', '35克', '6944314860032', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3409', 'A渔家小镇鱿鱼仔', '96克', '6944314860124', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3410', 'A渔家小镇炭烤鱿鱼丝', '60克', '6944314860162', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3411', 'A渔家小镇鱿鱼丝', '60克', '6944314860131', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3412', 'A喜之郎美好时光海苔（番茄味）', '4.5克', '6926475203439', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3413', 'A厨师儿童营养猪肉酥', '225g', '6920072425782', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3414', 'A台州湾手撕鱿鱼片', '100g', '6931981700013', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3415', 'A台州湾鱿鱼仔', '225g', '6931981700037', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3416', 'A星卓新疆葡萄干', '228克', '6923248920081', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3417', 'A华味亨新疆葡萄干', '96克', '6930044164915', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3418', 'A得力味皇杨梅', '120克', '6923435233123', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3419', 'A得力冰糖杨梅', '160克', '6923435222011', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3420', 'A华味亨超级话梅皇', '200克', '6918894564246', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3421', 'A华味亨特级话梅皇', '150克', '6918894564567', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3422', 'A华味亨珍珠梅', '180g', '6930044165097', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3423', 'A凯旋溜溜梅', '60克', '6923976113137', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3424', 'A凯旋溜溜雪梅', '60克', '6923976111171', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3425', 'A华味亨话梅肉', '150克', '6918894564574', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3426', 'A得力山楂片', '120克', '6923435245461', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3427', 'A得力鲜山楂', '200g', '6923435258195', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3428', 'A嘉得力山楂卷', '120g', '6923435212548', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3429', 'A智神金丝红-阿胶蜜枣', '227克', '6906312000162', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3430', 'A智神金丝红阿胶蜜枣', '138克', '6906312000582', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3431', 'A智神无核阿胶蜜枣', '50G', '6906312001879', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3432', 'A嘉得力冰糖杨梅', '180g', '6923435262130', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3433', 'A佳宝加应子', '60g', '6901097750110', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3434', 'A凯旋溜溜话梅', '40g', '6923976181228', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3435', 'A嘉得力盐津葡萄', '180g', '6923435261379', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3436', 'A雅士利蜜蜂加应子', '230g', '6939805400156', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3437', 'A雅士利加应子', '360g', '6939805400019', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3438', 'A雅士利加应子', '180g', '6939805400026', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3439', 'A雅士利加应子', '60g', '6939805400033', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3440', 'A茂发西梅', '150克', '6920733430957', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3441', 'A枣花香阿胶蜜枣', '227克', '6924100406200', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3442', 'A枣花香阿胶蜜枣', '130克', '6924100406217', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3443', 'A嘉盈山楂羹', '180克', '6933710700431', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3444', 'A嘉盈果丹皮', '200克', '6933710700479', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3445', 'A嘉盈山楂片', '168克', '6933710700455', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3446', 'A嘉盈果丹皮', '120克', '6933710700486', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3447', 'A春桂山桂饼草莓味', '118克', '6925461200308', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3448', 'A好日子九制椰榄', '250克', '6938395600090', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3449', 'A枣花香大红枣', '454g', '6924100420107', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3450', 'A华味亨猕猴桃干', '160g', '6930044168333', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3451', 'A妙缘阿胶蜜枣', '252g', '6938436900196', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3452', 'A妙缘阿胶蜜枣', '120g', '6938436900592', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3453', 'A大好大甘草瓜子', '110克', '6926858900344', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3454', 'A大好大奶油香瓜籽', '138克', '6926858900078', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3455', 'A大好大奶油香瓜子', '80克', '6926858900085', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3456', 'A大好大葵花籽', '155克', '6926858900023', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3457', 'A大好大葵花籽', '225克', '6926858900016', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3458', 'A洽洽香瓜子', '160克', '6924187820067', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3459', 'A恒康五香瓜子', '90克', '6920771610786', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3460', 'A恒康椰香瓜子', '160克', '6920771612636', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3461', 'A洽洽香瓜子（原香）', '150g', '6924187828759', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3462', 'A姚生记原味瓜子', '130g', '6933568001094', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3463', 'A洽洽茶瓜子', '112克', '6924187825079', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3464', 'A洽洽小而香西瓜子奶油味', '12g*15袋', '6924187822337', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3465', 'A恒康原味瓜子', '120g', '6920771613688', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3466', 'A恒康手剥西瓜子', '128g', '6920771611783', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3467', 'A恒康五香瓜子', '155g', '6920771610236', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3468', 'A真心香瓜子', '130g', '6926396160408', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3469', 'A恒康椒盐瓜子', '120克', '6920771614548', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3470', 'A恒康小金生花生', '100克', '6920771610106', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3471', 'A恒康老奶奶花生米', '155克', '6920771610090', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3472', 'A恒康老奶奶花生米', '70g', '6920771611073', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3473', 'A大好大香酥花生', '120克', '6926858900214', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3474', 'A绿野之香酱油花生', '180g', '6909327106683', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3475', 'A绿野香浓奶油花生', '180g', '6909327106676', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3476', 'A旺旺回味蚕豆', '45克', '6925861557071', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3477', 'A旺旺随手包(碗豆)', '50克', '6906839502248', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3478', 'A恒康开心果', '65g', '6920771611363', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3479', 'A恒康开心果', '160克', '6920771611165', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3480', 'A星卓美国开心果', '228克', '6923248920111', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3481', 'A恒康山核桃仁', '120克', '6920771611219', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3482', 'A恒康琥珀核桃仁', '125克', '6920771610380', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3483', 'A恒康手剥山核桃', '155克', '6920771611608', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3484', 'A恒康手剥山核桃（椒盐）', '155克', '6920771611714', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3485', 'A恒康芝麻桃仁', '125g', '6920771612674', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3486', 'A恒康蜂蜜桃仁', '125g', '6920771612667', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3487', 'A恒康美国杏仁', '75克', '6920771611332', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3488', 'A恒康美国杏仁', '160g', '6920771611141', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3489', 'A大好大水煮花生五香味', '150g', '6926858901365', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3490', 'A上口心酒鬼花生', '70g', '6925337091566', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3491', 'A恒康香酥腰果', '155g', '6920771613107', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3492', 'A潘大哥思乡蚕豆', '130g', '6933090900056', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3493', 'A蒙努酒鬼花生', '70克', '6931365616640', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3494', 'A大好大水煮花生五香味', '255克', '6926858901457', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3495', 'A洽洽怪味豆（五香味）', '20克', '6924187836792', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3496', 'A洽洽怪味豆（五香）', '40克', '6924187835566', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3497', 'A恒康美国山核桃', '75克', '6920771614104', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3498', 'A恒康美国山核桃', '238克', '6920771613718', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3499', 'A恒康美国山核桃', '138克', '6920771613701', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3500', 'A恒康美国山核桃仁', '108g', '6920771614111', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3501', 'A恒康开口杏仁', '120g', '6920771614159', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3502', 'A恒康香酥腰果', '150g', '6920771613367', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3503', 'A姚生记山核桃仁', '108g', '6933568001179', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3504', 'A口水娃香脆兰花豆（烤肉）', '130g', '6935768921127', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3505', 'A恒康蒜香青豆', '138克', '6920771614388', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3506', 'A姚生记原香青豆', '160克', '6933568002596', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3507', 'A上好佳八宝果糖', '120g', '6926265329400', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3508', 'A阿尔卑斯牛奶糖', '35克', '6911316400016', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3509', 'A上好佳薄荷糖', '120g', '6926265306807', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3510', 'A旺旺QQ糖水蜜桃味', '25克', '6920952762044', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3511', 'A旺仔QQ糖凤梨味', '25克', '6920952762037', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3512', 'A旺仔QQ糖橘子味', '25克', '6920952762013', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3513', 'A森和园开心仔棉花糖', '40克', '6914253420093', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3514', 'A旺仔QQ糖（草莓味）', '25克', '6920952767117', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3515', 'A旺仔QQ糖（荔枝味）', '25克', '6920952762839', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3516', 'A金丝猴圆柱奶糖', '108克', '6921681107564', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3517', 'A孺牛鲜奶糖', '250克', '6920837088085', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3518', 'A串屋棉花糖', '100克', '6914253468187', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3519', 'A旺仔QQ糖青苹果味', '25克', '6920952767315', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3520', 'A旺仔ＱＱ糖蓝莓味', '25克', '6920952767124', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3521', 'A黑妞吸吸糖炼乳味', '30g', '6920658212263', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3522', 'A黑妞吸吸糖巧克力味', '30g', '6920658212270', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3523', 'A旺仔牛奶糖', '18克', '6936003512414', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3524', 'A果然多CC卷玉露蜜桃味', '19g', '6938810900323', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3525', 'A果然多CC卷活力草莓味', '19g', '6938810900088', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3526', 'A清嘴柠檬含片', '6.9克', '6924960961116', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3527', 'A比巴卜三支装（超能）', '75克', '6911316100190', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3528', 'A绿箭口香糖', '15克', '69019388', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3529', 'A比巴卜三支魔幻组合', '75克', '6911316100299', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3530', 'A益达蓝莓味', '13.5g', '69021343', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3531', 'A绿箭口香糖(分享包)', '45克', '69021220', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3532', 'A清嘴含片草莓味（单盒装）', '6.9G', '6924960961185', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3533', 'A乐天木糖醇(青柠)', '66克', '69023576', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3534', 'A乐天木糖醇(蓝莓)', '66克', '69023569', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3535', 'A益达木糖醇冰凉薄荷味', '56克', '6923450656181', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3536', 'A益达木糖醇清爽草莓味', '56克', '6923450656150', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3537', 'A乐天无糖木糖醇柠檬味', '61.5g', '6916296027093', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3538', 'A彩虹果汁糖原果味', '45g', '6923450603550', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3539', 'A伊利干吃鲜奶片', '36克', '6907992400037', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3540', 'A彩虹果汁糖酸劲味', '40克', '6923450603567', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3541', 'A明治橡皮糖朱古力（青提味）', '50g', '6908312001552', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3542', 'A明治橡皮糖朱古力（草莓味）', '50g', '6908312001569', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3543', 'A绿箭粒装口香糖', '64g', '6923450601549', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3544', 'A益达木糖醇无糖口香糖香浓蜜瓜味', '56g', '69025143', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3545', 'A旺仔牛奶糖', '58g', '6936003512421', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3546', 'A不二家棒棒糖', '50g', '6937451831249', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3547', 'A大大卷切切乐泡泡糖可乐青柠味', '30克', '6923450681145', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3548', 'A艾兰得VC含片草莓味', '6.5克', '6922286135884', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3549', 'A悠哈特浓牛奶糖', '120克', '6930639267687', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3550', 'A益达草本精华木糖醇口香糖', '56克', '6923450657713', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3551', 'A益达无糖口香糖（西瓜味）', '13.5克', '69027086', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3552', 'A好丽友木糖醇柠檬薄荷味', '110克', '6920907805086', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3553', 'A好丽友木糖醇水果味混合装', '110克', '6920907805161', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3554', 'A不二家牛奶棒棒糖8支装', '46克', '6937451811418', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3555', 'A王老吉润喉糖', '28克', '6901424286213', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3556', 'A润喉糖', '56克', '6901424286206', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3557', 'A绿箭薄荷口香糖', '64克', '6923450601822', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3558', 'A肯的乐自动售货机玩具糖', '22克', '6937281140603', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3559', 'A肯的乐灌篮高手玩具糖', '25克', '6937281137900', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3560', 'A益达木糖醇香橙薄荷味', '56克', '6923450656860', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3561', 'A伊利干吃鲜奶片', '18克', '6907992400754', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3562', 'A伊利牛初乳片', '16克', '6907992400761', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3563', 'A伊利牛奶片草莓味', '16克', '6907992631240', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3564', 'A肯的汽水糖', '7克', '6937281102601', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3565', 'A好丽友木糖醇（柠檬味）', '61g', '6920907806960', null, null, null, null, '2017-07-12 12:12:21', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3566', 'A好丽友木糖醇水蜜桃味', '61克', '6920907805369', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3567', 'A果然多CC果卷（葡萄）', '19g', '6938810901115', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3568', 'A酷莎清口含片草莓', '9克', '6931925800991', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3569', 'A珍宝珠惊喜蛋硬糖（草莓）', '24g', '84194107', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3570', 'A益达至尊无糖口香糖', '56g', '6923450657188', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3571', 'A益达无糖口香糖（12片装热带水果味）', '32g', '69029110', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3572', 'A果然多特浓奶卷（香醇原味）', '16g', '6938810901368', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3573', 'A绿箭口香糖（金装）', '32g', '6923450605288', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3574', 'A益达木糖醇口香糖（西瓜）', '56克', '6923450657638', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3575', 'A阿尔卑斯双享棒棒糖', '16.8克', '6911316375161', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3576', 'A滨崎唇膏水果软糖（混合）', '10克', '6924762311010', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3577', 'A真知棒果汁什锦棒棒糖', '12克', '6923450682104', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3578', 'A德芙黑巧克力', '90克', '6914973200418', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3579', 'A德芙丝滑牛奶巧克力', '43g', '6914973600010', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3580', 'A德芙牛奶巧克力', '90克', '6914973200401', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3581', 'A德芙奶香白巧克力', '43克', '6914973600164', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3582', 'Am&m\'S迷你纯牛奶巧克力', '30.6克', '6914973600997', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3583', 'A德芙榛仁葡萄干巧克力', '43克', '6914973600102', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3584', 'A德芙榛子巧克力', '43g', '6914973600072', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3585', 'A德芙丝滑牛奶巧克力（碗装）', '294g', '6914973600225', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3586', 'A德芙什锦装（牛奶榛仁葡萄干黑巧克力）', '290.5g', '6914973600324', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3587', 'A德芙脆香米分享装', '120克', '6914973200685', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3588', 'A脆香米牛奶巧克力', '22g', '6914973105584', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3589', 'A德芙醇香黑巧克力', '43g', '6914973106956', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3590', 'A彩虹迷你糖', '30克', '6923450603574', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3591', 'A德芙心随丝滑牛奶巧克力', '40g', '69028403', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3592', 'A喜之郎乳酸钙果冻', '495克', '6902934990164', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3593', 'A喜之郎乳酸钙提袋拼装', '15克*40粒', '6902934982138', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3594', 'A喜之郎果肉果冻小袋高钙', '30克*8杯', '6902934976298', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3595', 'A喜之郎果肉果冻(高钙)', '30克*15粒', '6902934961256', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3596', 'A喜之郎维C果冻爽荔枝味', '150克', '6902934987171', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3597', 'A喜之郎果肉果冻', '200克', '6902934990362', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3598', 'A喜之郎果肉果冻(高钙', '33克*30', '6902934967012', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3599', 'A喜之郎芦荟果冻爽', '200ML', '6926475200759', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3600', 'A喜之郎葡萄果肉果冻', '200克', '6926475200995', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3601', 'A喜之郎蜜桃果肉果冻', '200克', '6926475201008', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3602', 'A喜之郎维C果冻爽葡萄味', '150克', '6926475201367', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3603', 'A喜之郎维C果冻爽香橙味', '150克', '6926475201350', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3604', 'A喜之郎维C果冻爽苹果味', '150克', '6926475201312', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3605', 'A喜之郎维C果冻爽菠萝味', '150克', '6926475201343', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3606', 'A喜之郎果汁果冻爽香橙味', '200g', '6926475202029', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3607', 'A致中和龟苓膏', '200克', '6927671100010', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3608', 'A晨光即食凉粉', '255g', '6924686550083', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3609', 'A致中和龟苓膏', '100克*4', '6938124405521', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3610', 'A旺旺果肉果冻什锦味', '178克', '6920658215837', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3611', 'A喜之郎蜜桔果肉', '200克', '6926475203392', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3612', 'A鸭司令松花皮蛋', '330克', '6920336897232', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3613', 'A光阳松花皮蛋', '360克', '6920336897959', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3614', 'A山哩珍鹌鹑蛋', '45克', '6922273425356', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3615', 'A山哩珍鹌鹑蛋', '100克', '6922273425363', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3616', 'A老李五香蛋', '45克', '6920433826388', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3617', 'A老爸豆腐干（卤辣味）', '100克', '6909442201157', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3618', 'A老爸肉汁豆腐干', '100克', '6909442201133', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3619', 'A老爸豆腐干（卤味）', '100克', '6909442201119', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3620', 'A老李五香干', '70克', '6920433816389', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3621', 'A老爸豆腐干(五香)', '100克', '6909442201188', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3622', 'A想一想鸡爪', '15g', '6945101200529', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3623', 'A沪光乡吧佬双翅', '60克', '6922574316865', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3624', 'A老李五香翅', '75克', '6920433816327', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3625', 'A老李五香腿', '85克', '6920433816518', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3626', 'A萨啦咪即食香肠', '25克', '6921799888010', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3627', 'A萨啦咪啃德佬小鸡腿', '28克', '6921799888348', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3628', 'A萨啦咪德佬鸡翅', '38克', '6921799888362', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3629', 'A胖大佬红香吧佬', '65g', '6935922700087', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3630', 'A胖大佬白玉乡吧佬', '65g', '6935922700131', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3631', 'A乡吧佬鸡翅', '65克', '6935922700124', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3632', 'A萨啦咪德佬鸡翅尖', '33克', '6921799888461', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3633', 'A福佬王单翅(绿色)', '30克', '6922574388879', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3634', 'A胖大佬鸡翅(绿色)', '65克', '6935922700155', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3635', 'A福佬乡吧佬鸡翅（绿）', '60克', '6922574388886', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3636', 'A虹一鲜汁鸡爪', '121克', '6923789022138', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3637', 'A胖大佬原味翅', '65克', '6935922700094', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3638', 'A萨啦咪1+1小鸡腿', '28克', '6921799888263', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3639', 'A好棒美烤鸭脖', '30克', '6934242966265', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3640', 'A好棒美小鸡腿', '30克', '6934242965893', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3641', 'A福佬盐水鸡腿', '100g', '6922574316889', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3642', 'A50克双汇王中王火腿肠', '50克', '6902890022183', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3643', 'A40克双汇王中王火腿肠', '40克', '6902890022473', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3644', 'A45克双汇王中王火腿肠', '45克', '6902890110330', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3645', 'A60克双汇王中王火腿肠', '60克', '6902890012016', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3646', 'A双汇王中王', '40克*5', '6902890218623', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3647', 'A双汇王中王火腿肠', '600g', '6902890022558', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3648', 'A金锣鲜肉王中王火腿肠', '40克*10*10', '6927462200875', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3649', 'A双汇王中王火腿肠', '30g*10', '6902890220138', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3650', 'A50g金锣王中王火腿肠', '50g', '6927462204392', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3651', 'A38g金锣王中王火腿肠', '38g', '6927462201704', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3652', 'A双汇甜玉米香肠', '40克', '6902890224792', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3653', 'A皂李湖感鸭蛋', '63克', '6928946600198', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3654', 'A味他行山椒凤爪', '100克', '6922737200819', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3655', 'A吉百年无铅松花皮蛋（6枚）', '372克', '6927061500130', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3656', 'A鸭司令松花皮蛋', '480克', '6920336897768', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3657', 'A多味斋贡丸', '67克', '6934722400166', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3658', 'A味他行山椒脆节', '100g', '6922737200840', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3659', 'A味他行鸭掌', '75g', '6922737200857', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3660', 'A祖名豆腐卷卤汁味', '100g', '6922163402443', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3661', 'A祖名豆腐干（肉汁）', '100g', '6927541700050', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3662', 'A萨啦咪手造鸭舌', '13g', '6946866088063', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3663', 'A渝味缘野山椒凤爪', '100g', '6949219300041', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3664', 'A绿盛酱鸭舌', '60g', '6907149201661', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3665', 'A乡下香鸡爪（长）', '38g', '6928458900472', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3666', 'A溢佳香酱鸭舌（原汁）', '56g', '6949671800608', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3667', 'A雀巢纯咖啡盒装', '1.8克*20', '6917878008691', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3668', 'A雀巢1+2咖啡42杯', '42*13g', '6917878002446', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3669', 'A雀巢1+2咖啡11杯条装', '13克*11', '6917878007441', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3670', 'A雀巢鹰唛炼奶370克', '370克', '6900975010018', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3671', 'A金味原味麦片', '600克', '6920118519567', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3672', 'A金味强化钙营养麦片', '600克', '6920118532450', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3673', 'A金味原味麦片低糖', '600克', '6920118532443', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3674', 'A金麦买一送一原味营养麦片', '480g', '6933968102636', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3675', 'A洪太老姜汤', '216克', '6925187910031', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3676', 'A智仁早餐燕麦片', '700克', '6921431288802', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3677', 'A洪太红枣姜汤', '216克', '6925187909417', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3678', 'A洪太原味姜汤', '216克', '6925187909448', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3679', 'A卡夫果珍(柠檬味)', '250克', '6904724019734', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3680', 'A卡夫袋装果珍(美国甜橙味)', '500克', '6904724019680', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3681', 'A卡夫果珍(甜橙)袋装', '250克', '6904724018669', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3682', 'A冰泉豆腐花', '256克', '6901432048285', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3683', 'A碧雪豆腐花', '256克', '6924747800287', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3684', 'A伊利多维型豆奶粉', '640克', '6907992610405', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3685', 'A南方黑芝麻糊', '480g', '6901333100518', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3686', 'A南方黑芝麻糊', '240克', '6901333100914', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3687', 'A南方AD钙黑芝麻糊', '480克', '6901333980196', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3688', 'A香飘飘原味奶茶', '80g', '6938888888837', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3689', 'A香飘飘香芋奶茶', '80g', '6938888888813', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3690', 'A香飘飘麦香奶茶', '80g', '6938888888844', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3691', 'A贝因美胡萝卜蔬菜营养米粉', '225g', '6904591515162', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3692', 'A贝因美铁锌钙米粉', '225克', '6904591590121', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3693', 'A维恩铁锌钙葡萄糖', '700克', '6933968101578', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3694', 'A贝因美奶伴葡萄糖', '360克', '6904591000316', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3695', 'A华精牌加钙核桃粉', '600克', '6920259682410', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3696', 'A700克荔波中老年高钙核桃粉', '700克', '6903056001646', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3697', 'A香飘飘草莓奶茶', '80g', '6938888888868', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3698', 'A喜之郎奶茶香芋味', '80g', '6926475203170', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3699', 'A喜之郎奶茶原味', '80g', '6926475203149', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3700', 'A喜之郎奶茶麦香味', '80g', '6926475203156', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3701', 'A喜之郎奶茶草莓味', '80g', '6926475203187', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3702', 'A永和多维低糖豆浆粉', '350克', '6931500340805', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3703', 'A永和豆浆甜豆浆粉', '350克', '6931500340904', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3704', 'A永和无添加蔗糖豆浆粉', '350克', '6931500341000', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3705', 'A维维维他豆奶粉', '360克', '6904432800358', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3706', 'A天怡红枣莲子藕粉', '560克', '6923513618774', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3707', 'A维维维他豆奶粉', '560g', '6904432800198', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3708', 'A优乐美草莓连包奶茶', '22克', '6926475204276', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3709', 'A优乐美麦香连包奶茶', '22克', '6926475204283', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3710', 'A卡夫果珍甜橙蜜桃混合味', '500克', '6904724022277', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3711', 'A康师傅辣系列香辣牛肉', '105克', '6920152403990', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3712', 'A康师傅香菇炖鸡袋面', '101克', '6920152415993', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3713', 'A康师傅上汤鲜虾大袋面', '119克', '6920152424049', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3714', 'A康师傅椒香牛肉大袋面', '128克', '6920152424025', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3715', 'A康师傅精装红烧牛肉袋面', '103克', '6920152401798', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3716', 'A康师傅鲜虾鱼板面', '99克', '6920152407998', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3717', 'A康师傅珍品红烧牛肉大袋面', '124克', '6920152424018', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3718', 'A康师傅红烧牛肉面（五连包）', '103克*5', '6920152405178', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3719', 'A康师傅香菇炖鸡面', '101克*5', '6920152471623', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3720', 'A康师傅鲜虾鱼板面(精袋五连包)', '99克*5', '6920152471562', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3721', 'A康师傅红烧牛肉五连包', '124克*5', '6920152471517', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3722', 'A康师傅袋面(东坡红烧肉)', '106克', '6920152432907', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3723', 'A康师傅袋面(笋干老鸭煲)', '103克', '6920152432006', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3724', 'A康师傅康袋五入香辣牛肉面', '105克*5', '6920152471548', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3725', 'A康师傅红烧牛肉面', '54克', '6920152400029', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3726', 'A康师傅鲜虾鱼板面', '49克', '6920152400623', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3727', 'A康师傅精装红烧牛肉碗面', '90克', '6920152400715', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3728', 'A康师傅红烧牛肉桶面', '113克', '6920152414019', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3729', 'A日清葱油肉丝炒面大王', '103克', '6917536006021', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3730', 'A康师傅鲜虾鱼板面', '109克', '6920152414040', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3731', 'A日清铁板牛肉炒面', '122克', '6917536003068', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3732', 'A日清点心杯鲜鲜虾仁面', '52克', '6917536001026', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3733', 'A开杯乐五香牛肉杯面', '83克', '6917536004010', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3734', 'A康师傅香菇炖鸡面', '111克', '6920152442715', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3735', 'A康师傅红烧牛肉半干面', '105克', '6920152484012', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3736', 'A日清炒面大王糖醋排骨风味', '108克', '6917536006038', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3737', 'A康师傅辣旋风香辣牛肉面（桶）', '118克', '6920152414170', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3738', 'A统一100老坛酸菜五莲包', '116克*5', '6925303773908', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3739', 'A统一100老坛酸菜牛肉袋面', '116克', '6925303773915', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3740', 'A统一来一桶老坛酸菜牛肉味', '125克', '6925303773106', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3741', 'A康师傅袋面酸菜牛肉味', '118克', '6920152439005', null, null, null, null, '2017-07-12 12:12:22', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3742', 'A康师傅五连包酸菜牛肉味', '118克*5', '6920152439203', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3743', 'A康师傅桶面酸菜牛肉味', '132克', '6920152414071', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3744', 'A皇品宫廷菜泡饭', '73g', '6911474704032', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3745', 'A皇品梅菜扣肉菜泡饭', '75克', '6911474501013', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3746', 'A宏祥精制兰州拉面', '300克', '6925301466956', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3747', 'A白家正宗酸辣方便粉丝（碗）', '108克', '6926410320023', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3748', 'A白家正宗酸辣味方便粉丝', '108克', '6926410320047', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3749', 'A白家酸菜鱼味方便粉丝', '105克', '6926410321396', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3750', 'A稻花香酸菜鱼过桥米线（袋）', '108克', '6926997200893', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3751', 'A稻花香过桥米线（红烧牛肉桶）', '110克', '6926997200671', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3752', 'A稻花香过桥米线上汤排骨桶', '108克', '6926997200619', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3753', 'A稻花香过桥米线（香辣牛肉桶）', '109克', '6926997200633', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3754', 'A稻花香过桥米线（酸辣牛肉桶）', '110克', '6926997200664', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3755', 'A稻花香酸辣牛肉过桥米线（袋）', '108克', '6926997200862', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3756', 'A巨能龙须面', '600g', '6920793820859', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3757', 'A巨能家常拉面', '600g', '6920793820842', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3758', 'A屹立儿童蝴蝶面（蔬菜）', '160g', '6923372309035', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3759', 'A百乐麦儿童营养面', '300克', '6920595901909', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3760', 'A陈克明强力香菇面', '1000克', '6922507800218', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3761', 'A陈克明强力玉米面', '1000克', '6922507804247', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3762', 'A贝因美蛋黄营养面条', '208克', '6904591003829', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3763', 'A贝因美果蔬营养面条', '208克', '6904591003836', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3764', 'A厨香园味佳鸡蛋挂面', '200克', '6932326226519', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3765', 'A赞成牌加碘精制盐', '1*350克', '6923381100050', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3766', 'A低碘营养日晒盐', '300g', '6937063700353', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3767', 'A正北半方糖', '450克', '6905558114114', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3768', 'A甘汁园无糖糖', '125g', '6928002374117', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3769', 'A汇强满意白砂糖', '454克', '6923731201123', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3770', 'A甘汁园益母红糖', '350g', '6928002374193', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3771', 'A汇强满意红糖', '450克', '6923731200379', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3772', 'A青青单晶冰糖', '350克', '6927171611726', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3773', 'A汇强满意单晶冰糖', '450克', '6923731200362', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3774', 'A蜜蜂牌纯味精', '400克', '6904934091179', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3775', 'A味华牌无盐味精', '380克', '6921999303870', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3776', 'A蜜蜂牌纯味精', '1000克', '6904934096105', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3777', 'A太太乐加鲜味精', '500克', '6922130103014', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3778', 'A太太乐味精', '1000g', '6922130105247', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3779', 'A味华无盐味精', '1000克', '6921915000081', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3780', 'A太太乐鸡精', '100克', '6922130101034', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3781', 'A太太乐鸡精', '250克', '6922130101010', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3782', 'A太太乐鸡精', '227g', '6922130101126', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3783', 'A味好美椒盐', '52g', '6901844507219', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3784', 'A味好美黑胡椒粉', '30g', '6901844307215', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3785', 'A珍津白胡椒调味素', '36克', '6921168484454', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3786', 'A海天上等蚝油', '700g', '6902265360018', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3787', 'A海天芝麻油', '150ML', '6902265690153', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3788', 'A王守义十三香', '45克', '6906303002410', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3789', 'A镇江恒顺白醋', '520ml', '6902007010249', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3790', 'A恒顺酿造白醋', '500ml', '6902882050774', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3791', 'A马大嫂玫瑰醋', '450ML', '6916159158858', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3792', 'A马大嫂玫瑰醋', '460ML', '6916159158865', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3793', 'A恒顺出口香醋', '550ml', '6902007115050', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3794', 'A恒顺镇江陈醋', '500ML', '6902007010928', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3795', 'A恒顺香醋(袋装)', '340ML', '6902007030087', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3796', 'A北固山镇江香醋', '800ml', '6902882020739', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3797', 'A恒顺镇江香醋', '500ml', '6902007010911', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3798', 'A北固山镇江米醋', '800ml', '6902882020760', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3799', 'A宝鼎康乐醋', '500ML', '6932107253185', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3800', 'A恒顺镇江香醋（新B）', '500ml', '6902007115180', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3801', 'A月桂温岭米醋', '350ml', '6927875200080', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3802', 'A马大嫂黄豆酱', '220克', '6916159888939', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3803', 'A海天金标生抽王', '500ML', '6902265120506', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3804', 'A海天草菇老抽', '500ML', '6902265210504', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3805', 'A海天金标生抽王桶装', '1.9L', '6902265120193', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3806', 'A海天老抽王', '500ML', '6902265240501', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3807', 'A海天红烧酱油', '500ML', '6902265107057', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3808', 'A海天鲜味生抽', '500ML', '6902265170501', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3809', 'A海天味极鲜特级酱油', '380ml', '6902265150008', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3810', 'A海天特级草菇老抽', '500ml', '6902265114369', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3811', 'A海天牌特级一品酱油', '500ml', '6902265114345', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3812', 'A太太乐宴会酱油（特鲜）', '623ML', '6922130111088', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3813', 'A海天儿童酱油', '200ML', '6902265100263', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3814', 'A海天海鲜酱油', '500ML', '6902265160502', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3815', 'A湖羊美味鲜酱油', '380ml', '6909210002603', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3816', 'A湖羊美味鲜酱油', '1.58L', '6909210002634', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3817', 'A海天味极鲜特级酱油', '750ml', '6902265150015', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3818', 'A味事达味极鲜酱油', '380ml', '6921480218287', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3819', 'A爱之味番茄沙司', '360g', '6921401720318', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3820', 'A爱之味蕃茄沙司', '160克', '6921401720219', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3821', 'A陶华碧风味豆豉油制辣椒', '280克', '6921804700757', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3822', 'A陶华碧老干妈油辣椒', '210克', '6921804700054', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3823', 'A陶华碧老干妈香辣酱', '200克', '6921804700108', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3824', 'A陶华碧香辣脆油辣椒', '210G', '6921804700269', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3825', 'A陶华碧精制牛肉末豆豉油辣椒', '210克', '6921804700306', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3826', 'A海天黄豆酱', '230g', '6902265470236', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3827', 'A陶华碧干煸肉丝油辣椒', '260G', '6921804700559', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3828', 'A海天黄豆酱', '340克', '6902265470267', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3829', 'A海天黄豆酱', '800克', '6902265908012', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3830', 'A阿一波苔湾紫菜', '100克', '6921168483228', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3831', 'A金丰味野生紫菜（圆盘）', '100克', '6921229300891', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3832', 'A金丰味野生紫菜（圆盘）', '70克', '6921229300662', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3833', 'A福临门高级大豆烹调油', '5L', '6919839108150', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3834', 'A金龙鱼大豆色拉油', '5L', '6935694410887', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3835', 'A金龙鱼大豆色拉油', '2.5L', '6935694410252', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3836', 'A金龙鱼第二代调和油', '5L', '6935694411884', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3837', 'A金龙鱼第二代调和油', '1.8L', '6935694411181', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3838', 'A鲁花纯正花生油', '5升', '6916168616554', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3839', 'A多力葵花籽油', '5L', '6909931010055', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3840', 'A金龙鱼玉米胚芽油', '5L', '6935694409508', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3841', 'A金龙鱼菜籽油', '5L', '6935694406507', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3842', 'A多力橄榄葵花油', '2.5L', '6909931371118', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3843', 'A金龙鱼花生油（新）', '5L', '6935694405500', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3844', 'A福临门天然谷物调和油', '5L', '6941499100618', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3845', 'A福临门一级大豆油', '5L', '6941499100335', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3846', 'A福临门菜籽油', '5L', '6941499100533', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3847', 'A金龙鱼食用调和油', '4L', '6935694411402', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3848', 'A金象精制大豆油', '5L', '6920881750112', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3849', 'A幸运花花生调和油（定牌）', '5L', '6946635601035', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3850', 'A菱花牌红薯淀粉', '330克', '6905028200170', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3851', 'A小彩娃奶香味蛋糕粉', '200克', '6930761700021', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3852', 'A金健牌桃花香米（籼米）', '5kg', '6923557958058', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3853', 'A金健牌桃花香米（籼米）', '10kg', '6923557958041', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3854', 'A福临门东北优质大米', '10KG', '6919839601101', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3855', 'A星卓红枣', '300克', '6923248920043', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3856', 'A星卓枸杞王', '158克', '6923248922030', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3857', 'A汇强满意绿豆', '450克', '6923731200065', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3858', 'A星卓好口味绿豆', '450克', '6923248922306', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3859', 'A星卓原味黄花菜', '500g', '6923248922641', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3860', 'A枣花香金丝小枣', '660克', '6924100406286', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3861', 'A青青红枣', '400克', '6927171612815', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3862', 'A青青有机核桃仁', '220克', '6933556810196', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3863', 'A星卓黑木耳', '200克', '6923248923068', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3864', 'A星卓庆元香菇', '250克', '6923248922177', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3865', 'A冠珠纯绿豆龙口粉丝', '300克', '6902482001350', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3866', 'A冠珠纯绿豆龙口粉丝', '180克', '6902482001268', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3867', 'A冠珠纯绿豆龙口粉丝', '500克', '6902482001367', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3868', 'A娃哈哈桂圆莲子八宝粥', '360克', '6902083880781', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3869', 'A泰山牛奶花生八宝粥', '370克', '6921567020888', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3870', 'A娃哈哈木糖醇八宝粥', '360克', '6902083881559', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3871', 'A银鹭桂圆莲子八宝粥', '360克', '6926892521086', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3872', 'A泰山莲子八宝粥', '360克', '6921567068842', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3873', 'A喜多多牛奶花生', '370克', '6923523900050', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3874', 'A喜多多绿豆汤', '370g', '6923523900944', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3875', 'A银鹭牛奶花生', '370g', '6926892516082', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3876', 'A津味笋丝咸菜', '200克', '6927200421210', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3877', 'A梅花牌去皮榨菜', '138克', '6921120521302', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3878', 'A莲丰麻油白腐乳', '300克', '6920673709168', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3879', 'A新中糟方乳腐', '500克', '6903588881358', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3880', 'A咸亨玫瑰腐乳', '380克', '6903775143801', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3881', 'A咸亨糟方', '500g', '6903775876549', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3882', 'A三和四美扬州糟方', '500克', '6902445032216', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3883', 'A三和四美麻油红方腐乳', '500克', '6902445032223', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3884', 'A龙之味梅菜笋丝', '80克', '6921741288387', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3885', 'A阿一波香味脆笋梅菜', '80克', '6921168484560', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3886', 'A潮盛香港橄榄菜', '170克', '6915249313238', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3887', 'A潮盛香港橄榄菜', '450克', '6920516402140', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3888', 'A川南爽口下饭菜', '330克', '6915993300768', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3889', 'A乌江鲜爽榨菜丝', '50克', '6901754050218', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3890', 'A粤花牌金装豆鼓鲮鱼', '227克', '6902150888214', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3891', 'A粤花牌豆豉带鱼', '184克', '6902150921133', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3892', 'A成吉菠萝(罐头)', '480克', '6923339669028', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3893', 'A成吉什锦珍果', '822克', '6923339667901', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3894', 'A成吉糖水蜜桔', '480克', '6923339669066', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3895', 'A成吉什锦珍果', '480克', '6923339669059', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3896', 'A成吉蜜桔罐头', '248克', '6923339670734', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3897', 'A紫山糖水黄桃罐头', '485g', '6943244500025', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3898', 'A紫山糖水黄桃罐头', '1055g', '6943244500049', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3899', 'A心之源女人蜂露', '456克', '6925270512036', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3900', 'A心之源蜂蜜', '236g', '6925270508015', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3901', 'A四季宝颗粒花生酱', '340克+100克', '6922601200020', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3902', 'A心之源学生蜂宝', '456克', '6925270533512', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3903', 'A心之源枇杷蜜　', '1500克', '6925270514085', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3904', 'A心之源野菊蜜　', '1500克', '6925270519080', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3905', 'A白猫玻璃清洗剂', '500克', '6901894128211', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3906', 'A蓝月亮地板清洁剂', '600ml', '6902022130243', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3907', 'A蓝月亮厕清', '500ML', '6902022130229', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3908', 'A蓝月亮Q厕清', '500ML', '6902022130410', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3909', 'A爱特福84消毒液', '468ML', '6905339060913', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3910', 'A威猛油烟机油污净', '500克', '6901586200362', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3911', 'A蓝月亮油污克星', '500ml', '6902022130519', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3912', 'A威猛先生厨房重油污净（柠檬）', '500g', '6901586103557', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3913', 'A威猛先生厕浴清洁剂（洁净清香）', '450克', '6901586103816', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3914', 'A蓝月亮强力厕清优惠装', '500g*2', '6902022133596', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3915', 'A蓝月亮Q厕宝', '50g', '6902022130601', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3916', 'A爱家固体清香剂(柠檬)', '88g', '6911348430135', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3917', 'A高洁固体清香剂', '100g', '6918101020251', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3918', 'A佳丽空气清新剂（桂花）', '320ML', '6901586102130', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3919', 'A可娜斯国际型清新剂', '280ml', '6901063204050', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3920', 'A好迪空气清新剂桂花', '320ml', '6907435666563', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3921', 'A高洁固体清香剂（茉莉）', '100g', '6918101020220', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3922', 'A健士霸苹果型竹炭除味包', '1', '6921810126503', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3923', 'A富士防霉防蛀片剂（薰衣草）', '80g', '6920408011313', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3924', 'A富士防霉防蛀片剂（透气片）', '150g', '6920408011283', null, null, null, null, '2017-07-12 12:12:23', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3925', 'A红鸟高级鞋油(黑色)', '30ml', '6901586200300', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3926', 'A红鸟高级鞋油(自然色)', '30ml', '6901586200324', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3927', 'A红鸟高级鞋油(棕色)', '30ml', '6901586200317', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3928', 'A蓝月亮丝毛净', '500g', '6902022132131', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3929', 'A白猫喷洁净', '350ML', '6901894129010', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3930', 'A船牌半透明皂', '300克', '6901326000825', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3931', 'A船牌透明皂', '240+20克', '6901326002126', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3932', 'A诗洁内衣清洗剂', '400ml', '6921007086917', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3933', 'A超能天然皂粉', '680g', '6910019005344', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3934', 'A威露士卫新衣物洗衣液', '2L', '6925911510421', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3935', 'A汰渍三重功效洗衣皂', '238克', '6903148070925', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3936', 'A雕牌高级洗衣皂', '222克', '6910019006358', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3937', 'A雕牌高级洗衣皂', '252克', '6910019006365', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3938', 'A雕牌高级洗衣皂', '252克*2', '6910019006372', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3939', 'A雕牌增白皂', '252克', '6910019006488', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3940', 'A雕牌超能皂', '226克', '6910019006518', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3941', 'A汰渍三重功效柠檬清新洗衣皂', '238克', '6903148070840', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3942', 'A蓝月亮香薰立袋柔顺剂（薰衣草）', '500ml', '6902022132797', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3943', 'A金纺怡神薰衣草衣物柔顺护理剂', '1L', '6902088701098', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3944', 'A奥妙净蓝全效洗衣粉', '300克', '6902088702828', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3945', 'A奥妙超效洗衣皂（二块装）', '226克*2', '6902088701753', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3946', 'A奥妙超效洗衣皂', '226克', '6902088701746', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3947', 'A雕牌超效加酶洗衣粉', '318克', '6910019007584', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3948', 'A雕牌超效加酶洗衣粉', '560克', '6910019007553', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3949', 'A雕牌超效加酶洗衣粉', '818克', '6910019007577', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3950', 'A雕牌超效加酶洗衣粉', '1638克', '6910019007638', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3951', 'A汰渍净白去渍柠檬清香洗衣粉', '508克', '6903148078938', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3952', 'A汰渍净白去渍自然清新洗衣粉', '1360克', '6903148078907', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3953', 'A汰渍净白去渍柠檬清香洗衣粉', '1360克', '6903148078945', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3954', 'A奥妙99全自动洗衣粉', '560克', '6902088702347', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3955', 'A汰渍净白去渍无磷洗衣粉', '1.55kg', '6903148095799', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3956', 'A奥妙净蓝全效洗衣粉', '500g', '6902088702835', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3957', 'A蓝月亮深层洁净薰衣草洗衣液', '2kg', '6902022134357', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3958', 'A蓝月亮深层洁净薰衣草洗衣液', '1kg', '6902022134333', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3959', 'A奥妙超效洗衣皂', '160+16g', '6902088703528', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3960', 'A蓝月亮洁净洗衣液（薰衣草）', '3kg', '6902022135514', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3961', 'A蓝月亮洁净洗衣液（自然清香）', '3kg', '6902022135316', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3962', 'A蓝月亮洁净袋装洗衣液（薰衣草）', '500g*3', '6902022135590', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3963', 'A奥妙全自动洗衣粉', '1700g+170g', '6902088704068', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3964', 'A立白漂渍液', '600克', '6920174723649', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3965', 'A蓝月亮彩漂', '600ML', '6902022132537', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3966', 'A蓝月亮漂渍液', '600ml', '6902022132513', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3967', 'A雕牌洗洁精', '500克', '6910019405007', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3968', 'A白猫洗洁精柠檬香味', '2000克', '6901894121205', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3969', 'A雕牌洗洁精', '900g', '6910019409005', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3970', 'A立白洗洁精', '500g', '6920174783490', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3971', 'A雕牌洗洁精', '2000g', '6910019420000', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3972', 'A立白洗洁精', '2000克', '6920174797053', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3973', 'A台州华联洗洁精（柠檬）', '2kg', '6918101020886', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3974', 'A立白金桔洗洁精', '500g', '6920174764116', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3975', 'A白猫经典配方洗洁精', '2kg', '6901894121212', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3976', 'A雕牌洗洁精', '1618g', '6910019008253', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3977', 'A蜜蜜花竹叶兰发梳', '1', '6925670988806', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3978', 'A蜜蜜花百子莲发梳', '1', '6925670988790', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3979', 'A蜜蜜花发梳505', '1', '6925670985058', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3980', 'A六神清凉皂(冰片)', '125克', '6901294171756', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3981', 'A六神清凉香皂(绿茶)', '90克', '6901294171305', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3982', 'A纳爱斯硫磺香皂', '90克', '6910019000561', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3983', 'A玉兰油全身护理香皂（椰油滋养）', '125g', '6903148051696', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3984', 'A舒肤佳纯白清香型香皂', '125g', '6903148091654', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3985', 'A舒肤佳柠檬去味型香皂', '125g', '6903148091661', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3986', 'A舒肤佳芦荟护肤型香皂', '125g', '6903148091678', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3987', 'A舒肤佳薄荷舒爽型香皂', '125g', '6903148091685', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3988', 'A舒肤佳金银花菊花型香皂', '125g', '6903148092224', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3989', 'A舒肤佳维生素E养肤型香皂', '125g', '6903148091739', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3990', 'A舒肤佳人参精华活肤型香皂', '125g', '6903148091746', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3991', 'A玉兰油乳液嫩白洁面乳', '100G', '6903148026076', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3992', 'A旁氏清透净白洁面乳', '75克', '6902088407457', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3993', 'A六神清凉爽肤沐浴露', '1000ml', '6901294171954', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3994', 'A六神清凉爽肤沐浴露', '200ml', '6901294171206', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3995', 'A六神清凉爽肤沐浴露', '450ML', '6901294171213', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3996', 'A强生婴儿牛奶沐浴露', '300ml', '6907376500056', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3997', 'A六神清凉润肤沐浴露', '200ml', '6901294171657', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3998', 'A六神冰凉超爽浴霸', '1000ml', '6901294172173', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('3999', 'A六神冰凉超爽浴霸', '200ml', '6901294172159', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4000', 'A舒肤佳经典净护柠檬清香沐浴露', '200ml', '6903148047804', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4001', 'A力士白皙焕采沐浴露', '750ml', '6902088302158', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4002', 'A力士闪亮冰爽沐浴露', '1000ml', '6902088302349', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4003', 'A蓝月亮洗手液', '500ML', '6902022130861', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4004', 'A蓝月亮洗手液补充装', '500ml', '6902022130885', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4005', 'A诗洁女土护理液', '100ml', '6921007086887', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4006', 'A台州华联洗手液（清爽型）', '500ml', '6918101020893', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4007', 'A妇炎洁洗液', '200ml', '6923601900569', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4008', 'A蓝月亮芦荟洗手液', '500+500ml', '6902022130496', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4009', 'A旁氏亮采净白粉润洁面乳', '75克', '6902088404913', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4010', 'A强生婴儿洗发沐浴露', '100ｍｌ', '6907376211044', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4011', 'A飘柔家庭绿茶长效清爽洗发露（去油型）', '200ml', '6903148030462', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4012', 'A飘柔家庭兰花长效清爽洗发露（去屑型）', '200ml', '6903148030356', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4013', 'A海飞丝强根护发型去屑洗发露', '200ml', '6903148104743', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4014', 'A海飞丝丝质柔滑型去屑洗发露', '200ml', '6903148044971', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4015', 'A海飞丝怡神冰凉型去屑洗发露', '200ml', '6903148045015', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4016', 'A海飞丝清爽去油型去屑洗发露', '200ml', '6903148045053', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4017', 'A海飞丝乌黑强韧型去屑洗发露', '200ml', '6903148045091', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4018', 'A海飞丝海洋活力型去屑洗发露', '200ml', '6903148045121', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4019', 'A飘柔滋润去屑洗发露', '200ml', '6903148048979', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4020', 'A飘柔家庭绿茶长效清爽洗发露（去油型）', '400ml', '6903148030479', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4021', 'A飘柔家庭兰花长效洁顺洗发露（水润型）', '400ml', '6903148030455', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4022', 'A飘柔家庭兰花长效清爽洗发露（去屑型）', '400ml', '6903148030363', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4023', 'A海飞丝丝质柔滑去屑洗发露', '500ml', '6903148115107', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4024', 'A海飞丝丝质柔滑型去屑洗发露', '400ml', '6903148044964', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4025', 'A海飞丝怡神冰凉型去屑洗发露', '400ml', '6903148045008', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4026', 'A海飞丝清爽去油型去屑洗发露', '400ml', '6903148045046', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4027', 'A海飞丝深层洁净型去屑洗发露', '400ml', '6903148045060', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4028', 'A海飞丝乌黑强韧型去屑洗发露', '400ml', '6903148045084', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4029', 'A飘柔滋润去屑洗发露', '400ml', '6903148048986', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4030', 'A海飞丝丝质柔滑型去屑洗发露', '750ml', '6903148044957', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4031', 'A海飞丝清爽去油型去屑洗发露', '750ml', '6903148045039', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4032', 'A飘柔滋润去屑洗发露', '750ml', '6903148049006', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4033', 'A潘婷丝质顺滑去屑洗发露', '200ml', '6903148093627', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4034', 'A潘婷丝质顺滑去屑洗发露', '400ml', '6903148093610', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4035', 'A潘婷乳液修复去屑洗发露', '200ml', '6903148093719', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4036', 'A潘婷乳液修复去屑洗发露', '400ml', '6903148093702', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4037', 'A潘婷乳液修复去屑洗发露', '750ml', '6903148093696', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4038', 'A潘婷乳液修复洗发露', '200ml', '6903148091425', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4039', 'A好迪啫喱水(红)', '140克', '6907435666983', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4040', 'A好迪啫喱水(绿)', '140克', '6907435667003', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4041', 'A好迪啫喱水(兰)', '140克', '6907435666990', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4042', 'A温雅染发焗油(自然黑)', '60ML', '6920619120514', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4043', 'A蜂花滋润护发素', '450G', '6904915631561', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4044', 'A蜂花护发素(黄)', '450G', '6904915612652', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4045', 'A蜂花营养护发素（蓝）', '400g', '6904915694016', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4046', 'A飘柔高纯度焗油精华润发精华素', '200ml', '6903148049082', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4047', 'A光明一洗黑洗染香波', '17克', '6920765800049', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4048', 'A高露洁草本牙膏', '90g', '6920354802331', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4049', 'A黑人全功能氟化物牙膏', '225g', '4891338000918', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4050', 'A黑人牙膏轻便装', '18g', '4891338004282', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4051', 'A佳洁士草本水晶牙膏', '90g', '6903148015834', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4052', 'A佳洁士防蛀牙膏（清新）', '140g', '6903148017241', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4053', 'A佳洁士防蛀牙膏(薄荷)', '200克', '6903148017272', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4054', 'A黑人牙膏', '90g', '4891338005692', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4055', 'A佳洁士盐白牙膏', '90G', '6903148018194', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4056', 'A佳洁士草本水晶牙膏', '140g', '6903148028155', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4057', 'A佳洁士盐白牙膏', '140g', '6903148034149', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4058', 'A中华健齿白牙膏(清新薄荷)', '155克', '6902088601077', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4059', 'A中华全效+亮白牙膏(清新薄荷)', '130克', '6902088601039', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4060', 'A纳爱斯牙膏（恋齿维C）', '160g', '6910019003692', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4061', 'A黑人茶保健牙膏', '190g', '4891338010542', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4062', 'A黑人超白牙膏', '190g', '4891338010528', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4063', 'A黑人弹力洁齿牙刷（软毛）', '单支', '4891338002974', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4064', 'A黑人弹力洁齿牙刷（中毛）', '单支', '4891338002950', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4065', 'A高露洁三重功效波浪型牙刷（中毛）', '单支', '6903388620003', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4066', 'A佳洁士全能健齿牙刷（摩指护龈）', '单支', '5000174142716', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4067', 'A黑人俊朗型牙刷（软毛）', '单支', '4891338007191', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4068', 'A小青蛙柔丝软毛儿童牙刷', '单支', '6908011923216', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4069', 'A纳爱斯固齿之脉牙刷', '单支装', '6910019005504', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4070', 'A纳爱斯纤丝爽洁型牙刷', '单支装', '6910019005283', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4071', 'A纳爱斯伢伢乐儿童牙膏（草莓）', '40克', '6910019004408', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4072', 'A佳洁士三重护理牙刷', '单支装', '6903148072233', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4073', 'A佳洁士五彩水晶牙刷（软毛）', '单支装', '6903148072257', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4074', 'A佳洁士五彩水晶牙刷（中毛）', '单支装', '6903148072271', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4075', 'A今晨2110柔丝软毛牙刷', '单支装', '6921458603534', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4076', 'A今晨1111中毛牙刷', '单支装', '6921458603848', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4077', 'A黑人柔丝洁牙刷（软毛）', '单支装', '4891338011419', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4078', 'A今晨2118动力炫齿型软毛牙刷', '单支装', '6921458603374', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4079', 'A高露洁亮洁晶莹牙刷（中毛）', '单支装', '6903388100369', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4080', 'A吉列双面刀架', '刀架+1片', '6900068000216', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4081', 'A吉列威锋旋转双层刀架及刮胡泡组合装', '刀架+1片+50克', '6900068005020', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4082', 'A吉列威锋旋转双层刀架', '刀架+1片', '6900068900035', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4083', 'A吉列超级不锈钢双面刀片（挂卡装）', '5片', '6900068204997', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4084', 'A吉列威锋旋转双层刀片', '5片', '6900068802636', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4085', 'A吉列威锋旋转双层刀片', '3片', '6900068802711', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4086', 'A大宝SOD蜜', '100g', '6920999701730', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4087', 'A六神花露水', '195ML', '6901294177017', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4088', 'A六神花露水', '95ML', '6901294177024', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4089', 'A六神驱蚊花露水', '195ML', '6901294179158', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4090', 'A邦迪牌弹性创可贴4片装', '4片装', '6916999320088', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4091', 'A维达V4028卷筒纸', '10卷', '6901236390610', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4092', 'A心相印BT910特柔3层卷筒卫生纸', '140G*10', '6922868283118', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4093', 'A维达V4073卷纸', '200克*10只', '6901236373996', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4094', 'A纯点2层卫生卷纸', '110g*10', '6933615300835', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4095', 'A纯点3层卫生卷纸', '180g *10', '6933615300514', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4096', 'A纯点2层卫生卷纸', '500节*10', '6933615300477', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4097', 'A维达V4078卷纸', '10只装', '6901236375075', null, null, null, null, '2017-07-12 12:12:24', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4098', '清风B22AT4三层卷筒纸', '10卷', '6922266434860', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4099', 'A纸音三层特柔卷筒纸', '180g*10', '6935661780067', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4100', 'A维达V4081卷筒纸', '180g*10', '6901236376768', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4101', 'A华联皱纹卫生纸', '500克', '6920326206174', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4102', 'A三合牌特白皱纹卫生纸', '500克', '6939074200044', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4103', 'A双熊猫S8185高级卫生纸', '350克', '6921594888185', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4104', 'A双灯高效平板卫生纸', '400张', '6920005771795', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4105', 'A贝柔长条实蕊卷纸A1049', '140克*10', '6923407912926', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4106', 'A清风无芯长卷卫生纸B01B', '10卷', '6922266438868', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4107', 'A心相印三层无芯长卷纸LR110', '100g*10', '6922868286959', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4108', 'A纸音8014妇婴无芯卷纸', '100g*10', '6935661780142', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4109', 'A金丝猫抽取式面纸', '400张', '6925044603687', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4110', 'A金丝猫三层无心卷纸1*8', '1000g', '6925044603762', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4111', 'A唯尔福三层无芯卷纸', '850g', '6935661780197', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4112', 'A贝柔面巾纸C1301盒装纸', '130抽', '6923407930029', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4113', 'A清风盒装面巾纸B338S', '200抽', '6922266434075', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4114', 'A心相印盒装面巾纸C130', '130抽', '6922868282326', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4115', 'A清风B334盒装面纸', '120抽', '6922266438622', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4116', 'A美琦抽取', '210抽', '6926673103722', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4117', 'A波斯猫迷你抽取纸', '200抽', '6926673100080', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4118', 'A南阳之星六月情抽纸', '180抽', '6931767068016', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4119', 'A贝柔宝宝面巾纸', '700张', '6923407920242', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4120', 'A南阳之星面巾纸', '340张', '6931767011234', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4121', 'A南阳之星特惠压花方巾纸', '330张', '6931767011593', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4122', 'A贝柔蓝色魅力面巾纸', '350g', '6923407921478', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4123', 'A贝柔家乐压花方巾', '420张', '6923407920402', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4124', 'A清风迷你包纸手帕清香型B66AS', '10包装', '6922266434020', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4125', 'A心相印面巾纸T2125', '50张', '6903244981255', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4126', 'A心相印薰衣草二层夹纸W412', '6小包', '6922868281343', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4127', 'A心相印迷你型三层手帕纸C1210', '10小包', '6922868284023', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4128', 'A清风B66ADF手帕纸', '10小包', '6922266437649', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4129', 'A纸音二层迷你手帕纸', '10小包', '6935661781088', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4130', 'A清风软抽面纸B338RCM', '200抽', '6922266438844', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4131', 'A心相印H200盒装面巾纸', '200抽', '6922868285747', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4132', 'A维达V1040满天星面巾纸', '350克', '6901236377802', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4133', 'A心相印C2010优选系列二层手帕纸', '10小包', '6922868286850', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4134', 'A清风BR38MC软抽纸', '200抽', '6922266440090', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4135', 'A欧帕玲珑系列长巾面纸', '40抽', '6926673107560', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4136', 'A波斯猫A169袖珍抽取式面巾纸', '188抽', '6926673105627', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4137', 'A金丝猫迷你抽取式面纸', '200抽', '6925044603519', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4138', 'A金丝猫压花方巾', '360张', '6925044603540', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4139', 'A双熊猫面巾纸', '300g', '6921594888017', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4140', 'A情花方巾Y09', '1000张', '6925044603601', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4141', 'A宝贝方巾Y10', '1000张', '6925044603618', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4142', 'A金惠猫C19迷你抽取面巾纸', '400张', '6925044603748', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4143', 'A悠好D019抽取式面巾纸', '200抽', '6928073100929', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4144', 'A金丝猫金装软抽面巾纸Y05', '200抽', '6925044603502', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4145', 'A唯尔福纸音软抽', '200抽', '6935661782146', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4146', 'A贝柔软抽面纸C5001', '400张', '6923407922130', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4147', 'A心相印消毒湿巾', '10包', '6922868284283', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4148', 'A依依天使清肤爽组合湿巾', '10片', '6931750100112', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4149', 'A强生婴儿护肤柔湿巾', '10片', '6907376500032', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4150', 'A唯尔福清爽柔湿巾', '10片', '6917902086077', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4151', 'A维达VW1001单片冰爽柔湿巾', '10片', '6901236300022', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4152', 'A安儿乐婴儿纸尿片M518', '18片', '6903244957205', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4153', 'A安儿乐婴儿纸尿片S520', '20片', '6903244957106', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4154', 'A安尔乐尿片L516', '16片', '6903244540131', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4155', 'A帮宝适超薄干爽纸尿裤（大号）', '24片', '6903148040829', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4156', 'A帮宝适超薄干爽纸尿裤（中号）', '28片', '6903148040812', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4157', 'A帮宝适超薄干爽纸尿裤（初生型）', '40片', '6903148043196', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4158', 'A贝柔婴儿中号纸尿片', '26片', '6923407947287', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4159', 'A帮宝适干爽健康小包装大号纸尿裤', '10片', '6903148071472', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4160', 'A帮宝适干爽健康中包装大号纸尿裤', '20片', '6903148076088', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4161', 'A帮宝适超薄干爽大包装纸尿裤（大号）', '56片', '6903148088302', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4162', 'A满好智能护围棉质丝薄日用卫生巾', '10片', '6924950616149', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4163', 'A唯尔福柔棉日用丝薄推广装3110', '5片', '6905756031107', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4164', 'A七度空间绢爽超薄日用卫生巾A99510', '10片', '6903244371018', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4165', 'A护舒宝瞬洁丝薄日用护翼卫生巾', '10+2片', '6903148031957', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4166', 'A护舒宝瞬洁丝薄日用护翼卫生巾', '5+1片', '6903148031940', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4167', 'A七度空间纯棉超薄日用卫生巾A6510', '10片', '6903244370950', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4168', 'A满好爽洁倍吸棉质丝薄日用卫生巾', '20片', '6924950616453', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4169', 'A满好智能护围棉质纤巧日用卫生巾', '10片', '6924950616446', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4170', 'A满好爽洁倍吸干爽丝薄超长夜用卫生巾', '8片', '6924950616484', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4171', 'A七度空间绢爽超薄夜用卫生巾A9908', '8片', '6903244371056', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4172', 'A护舒宝瞬洁贴身夜用护翼卫生巾', '10+2片', '6903148032053', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4173', 'A护舒宝瞬洁丝薄超长夜用护翼卫生巾', '4片', '6903148032008', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4174', 'A护舒宝瞬洁丝薄夜用护翼卫生巾', '5+1片', '6903148031988', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4175', 'A七度空间纯棉超薄夜用卫生巾A6610', '10片', '6903244370974', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4176', 'A七度空间特长纯棉夜用卫生巾A68908', '8片', '6903244370998', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4177', 'A满好爽洁倍吸棉质丝薄超长夜用卫生巾', '8片', '6924950616392', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4178', 'A满好智能棉质丝薄超长夜用卫生巾', '8片', '6924950616675', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4179', 'A安尔乐抗菌卫生护垫A8720', '20片', '6903244361200', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4180', 'A满好粉色轻盈棉质迷你卫生巾', '20片', '6924950616187', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4181', 'A安尔乐卫生护垫B9020', '20片', '6903244911207', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4182', 'A安尔乐Ｂ6020高级纯棉护垫', '20片', '6903244370356', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4183', 'A唯尔福1173阳光型护垫推广装', '10片', '6905756011734', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4184', 'A七度空间冰感护垫BQ8928', '28片', '6903244370929', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4185', 'A七度空间冰感护垫BQ8918', '18片', '6903244370912', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4186', 'A七度空间女生护垫BQ6028', '28片', '6903244370905', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4187', 'A满好透气型护垫PL-B30', '30片', '6924950616606', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4188', 'A苏菲立体护围超长夜用卫生巾40.5cm', '4片', '6934660519715', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4189', 'A护舒宝超值棉柔贴身日用卫生巾', '5片', '6903148091067', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4190', 'A护舒宝超值棉柔贴身日用卫生巾', '10片', '6903148091074', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4191', 'A护舒宝超值棉柔贴身夜用卫生巾', '5片', '6903148091098', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4192', 'A护舒宝超值棉柔贴身夜用卫生巾', '10片', '6903148091104', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4193', 'A娅洁舒柔棉感全程护理装卫生巾B046', '30片', '6925044601881', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4194', 'A护舒宝隐形净洁超薄无香护垫', '18片', '6903148096901', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4195', 'A娅洁舒熟睡天使日夜组合超长卫生巾', '20片', '6925044602055', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4196', 'A娅洁舒熟睡天使日夜组合丝薄卫生巾', '5片', '6925044602086', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4197', 'A护舒宝瞬洁丝薄卫生巾日用12片', '12片', '6903148117521', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4198', 'A7＃碱双鹿电池', '2粒装', '6911334442319', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4199', 'A7＃塑吊双鹿电池', '4粒装', '6911334434017', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4200', 'A5＃碱双鹿电池', '2粒装', '6911334342312', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4201', 'A5＃精双鹿电池', '4粒装', '6911334344415', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4202', 'A5＃铁双鹿电池', '4粒装', '6911334324318', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4203', 'A2＃铁吊双鹿电池', '2粒装', '6911334222416', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4204', 'A1＃铁双鹿双池', '2粒装', '6911334122310', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4205', 'A9V吊双鹿电池', '1粒装', '6911334521410', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4206', 'A南孚五号碱性4粒挂卡装', '1', '6901826888039', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4207', 'A博客电筒SLT-P016', '1', '6940675700161', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4208', 'A公牛牌转换器1.8米GN-102', '102', '6922646100026', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4209', 'A公牛牌转换器GN-610（3m）', '610', '6922646101757', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4210', 'A幸工3寸螺丝批2PCXFC-24', '1', '6930228700328', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4211', 'A健士霸防滑磨砂杯A-369', '1', '6921810100046', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4212', 'A小号印花果汁杯L-362', '1', '6922286983621', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4213', 'A大号印花果汁杯L-363', '1', '6922286983638', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4214', 'A汇丰有盖口杯30430', '1', '6926053304305', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4215', 'A健士霸大号密封口杯', '1', '6921810126077', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4216', 'A健士霸丽人时尚中号杯', '1', '6921810128088', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4217', 'A健士霸喜洋洋漱口杯', '1', '6921810128118', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4218', 'A健士霸色彩人生系列杯A-30', '1', '6921810129467', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4219', 'A吉康密封杯500ml-3030', '1', '6924624530306', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4220', 'A吉康葫芦饮水吸水壶3155', '1', '6924624531556', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4221', 'A吉康双色饮水太空杯700ml-3102', '1', '6924624531020', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4222', 'A冠福直身马克杯', '1', '6921390389947', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4223', 'A冠福向阳花1#老板杯2001', '1', '6921390389824', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4224', 'A冠福“卡通”系列水杯（瓷）物价', '1', '6921390377234', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4225', 'A玻璃强化杯N2408W', 'N2408W', '6911614100229', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4226', 'A贴花单杯玻璃N4010T', 'N4010T', '6911614102940', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4227', 'A玻璃干红酒杯R31', 'R31', '6901351200429', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4228', 'A青苹果小酒杯Y5003(玻璃)', '1', '6933890310819', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4229', 'A弓箭伊斯朗直身杯FH33', '12832', '0026102952832', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4230', 'A青苹果ZB01-300啤酒杯', '1', '6933890310741', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4231', 'A运隆小碗YL374045', '1', '6944656203252', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4232', 'A运隆饭铲YL585085', '1', '6944656200954', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4233', 'A冠福快乐猪6.5”面碗', '1', '6921390378071', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4234', 'A冠福快乐猪5”碗', '1', '6921390378095', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4235', 'A冠福快乐猪4.5寸碗', '1', '6921390378101', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4236', 'A冠福快乐猪7寸汤盘', '1', '6921390378040', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4237', 'A冠福快乐猪7.5寸饭盘', '1', '6921390378026', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4238', 'A彩梅11.5尔康碗1*10（带磁）', '1', '6934058500646', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4239', 'A夏氏中叉', '30003', '6920109705429', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4240', 'A夏氏中匙', '30004', '6920109705436', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4241', 'A希尔调味匙117（密胺）（1*96）', '1', '6935718811713', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4242', 'A味老大小园筷HLXJ-50(10双装)', '1', '6922971633343', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4243', 'A鑫峰金装水果刀4723', '1', '6920690114723', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4244', 'A冠福快乐猪二号条更', '1', '6921390377951', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4245', 'A味老大聚福堂竹筷30双装', '1把', '6922971634104', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4246', 'A竹天下6.0简装天然光板（十双装）', '1', '6935336722859', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4247', 'A青苹果烟缸1004', '1', '6933890310598', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4248', 'A汇丰打火机', '1', '2830317149011', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4249', 'A17cm圆形隔热垫', '1', '6922286987179', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4250', 'A味老大竹制锅垫HLGD-16(16cm)', '1', '6922971633909', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4251', 'A福达时尚提篮', '1', '6925951505494', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4252', 'A中南一次性航旅杯ZL－9020', '200G*50只', '6924378089020', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4253', 'A台州华联纸杯051', '100只装', '6934584230512', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4254', 'A台州华联纸杯050', '50只装', '6934584230505', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4255', 'A希艺欧竖纹胶杯100只', '1', '6933932603435', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4256', 'A健士霸大号台布', '180cm*180cm', '6921810101029', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4257', 'A天竹袋装牙签TZ5002', '1', '6925116105002', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4258', 'A健士霸饮料吸管F-218', '80根/包', '6921810102811', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4259', 'A健士霸特级竹牙签', '1', '6921810126312', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4260', 'A健士霸棉花棒GD-4303', '100支装', '6921810104303', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4261', 'A健士霸S形罐装棉花棒GD-4305', '100支装', '6921810120389', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4262', 'A健士霸一次性卫生手套', '1*30', '6921810116313', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4263', 'A健士霸12只装一次性鞋套', '1*12', '6921810119871', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4264', 'A健士霸微波圆形三件套2728', '1', '6921810111417', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4265', 'A龙士达大号方型保鲜微波盒L-1105', '1', '6922286911051', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4266', 'A550ml小圆保鲜盒LK-2003', '1', '6922286920039', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4267', 'A健士霸中号双层饭盒', '1', '6921810115699', null, null, null, null, '2017-07-12 12:12:25', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4268', 'A健士霸550ml玻璃油壶', '1', '6921810117235', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4269', 'A阳光5磅注塑平盖保温瓶500-G', '1', '6940446200043', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4270', 'A阳光5磅注塑鸭嘴保温瓶500-C', '1', '6940446200036', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4271', 'A健士霸咪咪钢化杯（含盖）', '1', '6921810126268', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4272', 'A妙洁M100PE保鲜膜(经济装)', '30CM*30M', '6917751410405', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4273', 'A妙洁M100PE保鲜膜(盒装)', '30CM*30米', '6917751410108', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4274', 'A七彩家园保鲜膜20cm*20cm', '1盒', '6944768266091', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4275', 'A健士霸点断式PE保鲜袋20*30', '1', '6921810128422', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4276', 'A健士霸30CM宽PE保鲜膜（50CM）', '1', '6921810128460', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4277', 'A健士霸背心型PE保鲜袋', '1', '6921810128958', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4278', 'A龙士达小号圆筛L-1200', '1', '6922286912003', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4279', 'A夏氏皇朝开瓶器911', '911', '6920109720446', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4280', 'A味老大精品筷笼HLL', '1', '6922971633756', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4281', 'A鑫峰不锈钢民用剪4549', '1', '6920690114549', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4282', 'A阳江十八子厨房多用刨W-280P', '1', '6920264505575', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4283', 'A金威龙厨宝调味盒', '1', '6927034998551', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4284', 'A美家美户工艺砧板CB1234', '1', '6943402912349', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4285', 'A新田不锈钢锅铲', '1', '6922744200031', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4286', 'A健士霸混装强力吸盘挂钩', '1', '6921810125360', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4287', 'A健士霸粘钩（混装）', '1', '6921810113800', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4288', 'A健士霸小号垃圾袋V-13', '30只装', '6921810101074', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4289', 'A健士霸中号垃圾袋V-12', '15只装', '6921810101067', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4290', 'A妙洁点断式垃圾袋M号30只装', '1', '6917751430151', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4291', 'A七彩家园垃圾袋45cm*55cm', '1袋', '6944768268347', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4292', 'A健士霸背心式垃圾袋', '1', '6921810128934', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4293', 'A大号印花垃圾桶30125', '1', '6926053301250', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4294', 'A38cm脸盆L-139', '1', '6922286981399', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4295', 'A健士霸中号磨砂水桶', '1', '6921810126961', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4296', 'A健士霸34cm双色盆', '1', '6921810117440', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4297', 'A健士霸不绣钢清洁球XE-8301', '1', '6921810115965', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4298', 'A健士霸多用组合刷', '1*2', '6921810127586', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4299', 'A妙洁MGCL弹性型手套(', '1', '6917751420169', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4300', 'A庭扫组合G-046', '1', '6921810116771', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4301', 'A捷力特组合扫把627', '1', '6933000186273', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4302', 'A好媳妇胶棉拖把3190', '1', '6935978031906', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4303', 'A妙洁MTA2+1神奇抹布2+1', '30CM*30CM', '6917751451019', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4304', 'A健士霸柔棉洗洁巾G-938', '3', '6921810128576', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4305', 'A健士霸竹纤维宜擦巾18*33*1', '1', '6921810128538', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4306', 'A明正牌竹晾衣架991-8＃', '1', '6923789758969', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4307', 'A龙士达套塑衣架LE-1691', '十只装', '6922286916919', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4308', 'A利玻时尚衣架LB-7101', '4只装', '6926402571013', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4309', 'A健士霸水晶衣架', '1*4', '6921810128217', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4310', 'A健士霸水晶韩式衣架', '1*3', '6921810128224', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4311', 'A英利美式裤架3472', '1', '6933831334720', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4312', 'A英利18头梅花晒架3215', '1', '6933831332153', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4313', 'A商港20头椭圆形晒衣架7808', '1', '6920662278088', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4314', 'A大圆球马桶刷J-122', '1', '6921810122659', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4315', 'A健士霸双层皂盒B-175', '1', '6921810110991', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4316', 'A清清美洗澡巾1703', '1', '6927594617039', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4317', 'A健士霸沐浴球花8308', '1', '6921810119543', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4318', 'A健士霸复合浴擦XE-8011', '1', '6921810120105', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4319', 'A健士霸洗刷刷牙具盒', '1', '6921810129030', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4320', 'A圣强桌椅保护垫（4正方）', '1*60', '6935606407059', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4321', 'A金万年荧光笔K-0508', '6支装', '6931190708824', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4322', 'A听雨轩中性笔G-568', '6', '6927975307368', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4323', 'A金万年KA-2216自动铅笔+2277笔芯', '1', '6931190710254', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4324', 'A天乐文具盒TE881234', '1', '6949896600083', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4325', 'A得力30246封箱胶带', '1', '6935205302465', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4326', 'A松鹤YE-609万能胶', '1', '6927345960278', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4327', 'A玛丽36K田字簿', '1', '6911989011601', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4328', 'A玛丽24K练习簿', '1', '6911989011557', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4329', 'A日康有柄小圆弧自动奶瓶3002', '1', '6923298430028', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4330', 'A日康有柄大指握自动奶瓶3021', '1', '6923298430219', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4331', 'A日康盒装十字孔奶嘴3302', '1', '6923298433029', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4332', 'A日康双粒装十字孔奶嘴RK-3305', '1', '6923298433050', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4333', 'A日康标准口径自动吸管刷组3650', '1', '6923298436501', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4334', 'A洪剑搪瓷电热快', '1', '6934614002041', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4335', 'A光明电吹风RCT322', '1', '6925979783225', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4336', 'A光明电吹风RCT807', '1', '6925979788077', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4337', 'A飞科剃须刀FS812', '1', '6949123308126', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4338', 'A来月亮童巾3396', '50g/50*25cm', '6932517831997', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4339', 'A来月亮素织纯白毛巾3306', '74*33cm', '6932517830297', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4340', 'A永亮素色提花毛巾0352', '70*32', '6940695903528', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4341', 'A洁玉女士美容巾MR-3B', '30*50', '6922424898145', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4342', 'A洁丽雅日本小方巾0062', '1', '6925954400062', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4343', 'A海狮素色弱捻纱面巾1527', '76*34cm', '6930433611969', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4344', 'A海狮提缎方巾937', '22*22cm', '6930433690025', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4345', 'A海狮素色无捻童巾1542', '50*25cm', '6930433612201', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4346', 'A海狮回字缎面巾1584', '76*34cm', '6930433612232', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4347', 'A海狮面巾1647', '76*34cm', '6930433612669', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4348', 'A金号割绒童巾T1110', '52*26cm', '6925704410389', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4349', 'A金号无捻提缎割绒毛巾G1416W', '78*35cm', '6925704410518', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4350', 'A金号提缎毛巾G1354', '78*35cm', '6925704408928', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4351', 'A永亮朦胧窗格毛巾8269', '33*75', '6940695982691', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4352', 'A永亮无捻绣花毛巾8276', '33*74', '6940695982769', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4353', 'A永亮割绒提花童巾5408', '50*26', '6940695954087', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4354', 'A永亮祥云毛巾8268', '33*75', '6940695982684', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4355', 'A永亮绣花断档童巾5409', '50*26', '6940695954094', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4356', 'A洁玉情迷伊甸园毛巾JY-7057F', '33*72', '6922424844869', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4357', 'A洁玉半无捻勾边刺绣童巾THT-007', '25*50', '6922424834211', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4358', 'A洁玉忘忧草毛巾JY-8070F', '33*72', '6922424893508', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4359', 'A莎奴亚女木代尔平脚裤SL9308', 'L', '6928906593089', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4360', 'A莎奴亚女全棉印花牙边三角裤SL9313', 'L', '6928906593133', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4361', 'A莎奴亚女木代尔花边平脚裤9325', 'L', '6928906593256', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4362', 'A莎奴亚女三角裤9301', 'L', '6928906593010', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4363', 'A洁丽雅女士印花三角裤（单条装）24037', 'L', '6934925905581', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4364', 'A洁丽雅女士蕾丝花边小平脚裤（单条装25028', 'L', '6934925905567', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4365', 'A洁丽雅女士无缝印花平脚裤（单条装）25031', 'L', '6934925905642', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4366', 'A莎奴亚男弹力棉明根色织三角裤9846', 'XL', '2831108036022', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4367', 'A莎奴亚男弹力棉明根色织三角裤9846', '2XL', '2831108037029', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4368', 'A莎奴亚男弹力明根木代尔拼图三角裤SL9819', 'XL', '2831108042023', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4369', 'A莎奴亚男弹力明根木代尔拼图三角裤SL9819', '2XL', '2831108043020', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4370', 'A莎奴亚男木代尔包根平脚裤SL9903', '2XL', '2831108388022', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4371', 'A莎奴亚男平脚裤9953', 'XL', '2831108399028', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4372', 'A莎奴亚男全面印花平脚裤SL9913', 'XL', '2831108408027', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4373', 'A洁丽雅男士全棉印花平脚裤15013', 'XL', '2831108435023', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4374', 'A洁丽雅男士全棉印花平脚裤15029', '2XL', '2831108438024', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4375', 'A莎奴亚男全面印花平脚裤SL9913', 'L', '6928906599135', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4376', 'A红叶三折+K银胶雨伞', '324', '6926991103244', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4377', 'A红叶三折银胶雨伞', '319', '6926991103190', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4378', 'A天堂雨披N120', 'N120', '6912003006047', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4379', 'A神荣鞋垫', '40#', '6928222800106', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4380', 'A神荣鞋垫', '39#', '6928222800090', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_goods` VALUES ('4381', 'A神荣鞋垫', '36#', '6928222800069', null, null, null, null, '2017-07-12 12:12:26', '0', '0');
INSERT INTO `cmf_links` VALUES ('1', '#', 'NewVillage', '', '_self', '', '1', '0', '', '0');
INSERT INTO `cmf_menu` VALUES ('1', '0', 'Admin', 'Content', 'default', '', '0', '1', '内容管理', 'th', '', '30');
INSERT INTO `cmf_menu` VALUES ('2', '1', 'Api', 'Guestbookadmin', 'index', '', '1', '1', '所有留言', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('3', '2', 'Api', 'Guestbookadmin', 'delete', '', '1', '0', '删除网站留言', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('4', '1', 'Comment', 'Commentadmin', 'index', '', '1', '1', '评论管理', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('5', '4', 'Comment', 'Commentadmin', 'delete', '', '1', '0', '删除评论', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('6', '4', 'Comment', 'Commentadmin', 'check', '', '1', '0', '评论审核', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('7', '1', 'Portal', 'AdminPost', 'index', '', '1', '1', '文章管理', '', '', '10');
INSERT INTO `cmf_menu` VALUES ('8', '7', 'Portal', 'AdminPost', 'listorders', '', '1', '0', '文章排序', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('9', '7', 'Portal', 'AdminPost', 'top', '', '1', '0', '文章置顶', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('10', '7', 'Portal', 'AdminPost', 'recommend', '', '1', '0', '文章推荐', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('11', '7', 'Portal', 'AdminPost', 'move', '', '1', '0', '批量移动', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('12', '7', 'Portal', 'AdminPost', 'check', '', '1', '0', '文章审核', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('13', '7', 'Portal', 'AdminPost', 'delete', '', '1', '0', '删除文章', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('14', '7', 'Portal', 'AdminPost', 'edit', '', '1', '0', '编辑文章', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('15', '14', 'Portal', 'AdminPost', 'edit_post', '', '1', '0', '提交编辑', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('16', '7', 'Portal', 'AdminPost', 'add', '', '1', '0', '添加文章', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('17', '16', 'Portal', 'AdminPost', 'add_post', '', '1', '0', '提交添加', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('18', '1', 'Portal', 'AdminTerm', 'index', '', '0', '1', '分类管理', '', '', '20');
INSERT INTO `cmf_menu` VALUES ('19', '18', 'Portal', 'AdminTerm', 'listorders', '', '1', '0', '文章分类排序', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('20', '18', 'Portal', 'AdminTerm', 'delete', '', '1', '0', '删除分类', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('21', '18', 'Portal', 'AdminTerm', 'edit', '', '1', '0', '编辑分类', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('22', '21', 'Portal', 'AdminTerm', 'edit_post', '', '1', '0', '提交编辑', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('23', '18', 'Portal', 'AdminTerm', 'add', '', '1', '0', '添加分类', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('24', '23', 'Portal', 'AdminTerm', 'add_post', '', '1', '0', '提交添加', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('25', '1', 'Portal', 'AdminPage', 'index', '', '1', '1', '页面管理', '', '', '30');
INSERT INTO `cmf_menu` VALUES ('26', '25', 'Portal', 'AdminPage', 'listorders', '', '1', '0', '页面排序', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('27', '25', 'Portal', 'AdminPage', 'delete', '', '1', '0', '删除页面', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('28', '25', 'Portal', 'AdminPage', 'edit', '', '1', '0', '编辑页面', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('29', '28', 'Portal', 'AdminPage', 'edit_post', '', '1', '0', '提交编辑', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('30', '25', 'Portal', 'AdminPage', 'add', '', '1', '0', '添加页面', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('31', '30', 'Portal', 'AdminPage', 'add_post', '', '1', '0', '提交添加', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('32', '1', 'Admin', 'Recycle', 'default', '', '1', '1', '回收站', '', '', '50');
INSERT INTO `cmf_menu` VALUES ('33', '32', 'Portal', 'AdminPost', 'recyclebin', '', '1', '1', '文章回收', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('34', '33', 'Portal', 'AdminPost', 'restore', '', '1', '0', '文章还原', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('35', '33', 'Portal', 'AdminPost', 'clean', '', '1', '0', '彻底删除', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('36', '32', 'Portal', 'AdminPage', 'recyclebin', '', '1', '1', '页面回收', '', '', '1');
INSERT INTO `cmf_menu` VALUES ('37', '36', 'Portal', 'AdminPage', 'clean', '', '1', '0', '彻底删除', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('38', '36', 'Portal', 'AdminPage', 'restore', '', '1', '0', '页面还原', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('39', '0', 'Admin', 'Extension', 'default', '', '0', '1', '扩展工具', 'cloud', '', '40');
INSERT INTO `cmf_menu` VALUES ('40', '39', 'Admin', 'Backup', 'default', '', '1', '0', '备份管理', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('41', '40', 'Admin', 'Backup', 'restore', '', '1', '1', '数据还原', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('42', '40', 'Admin', 'Backup', 'index', '', '1', '1', '数据备份', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('43', '42', 'Admin', 'Backup', 'index_post', '', '1', '0', '提交数据备份', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('44', '40', 'Admin', 'Backup', 'download', '', '1', '0', '下载备份', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('45', '40', 'Admin', 'Backup', 'del_backup', '', '1', '0', '删除备份', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('46', '40', 'Admin', 'Backup', 'import', '', '1', '0', '数据备份导入', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('47', '39', 'Admin', 'Plugin', 'index', '', '1', '1', '插件管理', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('48', '47', 'Admin', 'Plugin', 'toggle', '', '1', '0', '插件启用切换', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('49', '47', 'Admin', 'Plugin', 'setting', '', '1', '0', '插件设置', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('50', '49', 'Admin', 'Plugin', 'setting_post', '', '1', '0', '插件设置提交', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('51', '47', 'Admin', 'Plugin', 'install', '', '1', '0', '插件安装', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('52', '47', 'Admin', 'Plugin', 'uninstall', '', '1', '0', '插件卸载', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('53', '39', 'Admin', 'Slide', 'default', '', '1', '1', '幻灯片', '', '', '1');
INSERT INTO `cmf_menu` VALUES ('54', '53', 'Admin', 'Slide', 'index', '', '1', '1', '幻灯片管理', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('55', '54', 'Admin', 'Slide', 'listorders', '', '1', '0', '幻灯片排序', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('56', '54', 'Admin', 'Slide', 'toggle', '', '1', '0', '幻灯片显示切换', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('57', '54', 'Admin', 'Slide', 'delete', '', '1', '0', '删除幻灯片', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('58', '54', 'Admin', 'Slide', 'edit', '', '1', '0', '编辑幻灯片', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('59', '58', 'Admin', 'Slide', 'edit_post', '', '1', '0', '提交编辑', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('60', '54', 'Admin', 'Slide', 'add', '', '1', '0', '添加幻灯片', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('61', '60', 'Admin', 'Slide', 'add_post', '', '1', '0', '提交添加', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('62', '53', 'Admin', 'Slidecat', 'index', '', '1', '1', '幻灯片分类', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('63', '62', 'Admin', 'Slidecat', 'delete', '', '1', '0', '删除分类', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('64', '62', 'Admin', 'Slidecat', 'edit', '', '1', '0', '编辑分类', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('65', '64', 'Admin', 'Slidecat', 'edit_post', '', '1', '0', '提交编辑', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('66', '62', 'Admin', 'Slidecat', 'add', '', '1', '0', '添加分类', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('67', '66', 'Admin', 'Slidecat', 'add_post', '', '1', '0', '提交添加', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('68', '39', 'Admin', 'Ad', 'index', '', '1', '1', '网站广告', '', '', '2');
INSERT INTO `cmf_menu` VALUES ('69', '68', 'Admin', 'Ad', 'toggle', '', '1', '0', '广告显示切换', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('70', '68', 'Admin', 'Ad', 'delete', '', '1', '0', '删除广告', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('71', '68', 'Admin', 'Ad', 'edit', '', '1', '0', '编辑广告', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('72', '71', 'Admin', 'Ad', 'edit_post', '', '1', '0', '提交编辑', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('73', '68', 'Admin', 'Ad', 'add', '', '1', '0', '添加广告', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('74', '73', 'Admin', 'Ad', 'add_post', '', '1', '0', '提交添加', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('75', '39', 'Admin', 'Link', 'index', '', '0', '1', '友情链接', '', '', '3');
INSERT INTO `cmf_menu` VALUES ('76', '75', 'Admin', 'Link', 'listorders', '', '1', '0', '友情链接排序', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('77', '75', 'Admin', 'Link', 'toggle', '', '1', '0', '友链显示切换', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('78', '75', 'Admin', 'Link', 'delete', '', '1', '0', '删除友情链接', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('79', '75', 'Admin', 'Link', 'edit', '', '1', '0', '编辑友情链接', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('80', '79', 'Admin', 'Link', 'edit_post', '', '1', '0', '提交编辑', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('81', '75', 'Admin', 'Link', 'add', '', '1', '0', '添加友情链接', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('82', '81', 'Admin', 'Link', 'add_post', '', '1', '0', '提交添加', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('83', '39', 'Api', 'Oauthadmin', 'setting', '', '1', '1', '第三方登陆', 'leaf', '', '4');
INSERT INTO `cmf_menu` VALUES ('84', '83', 'Api', 'Oauthadmin', 'setting_post', '', '1', '0', '提交设置', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('85', '0', 'Admin', 'Menu', 'default', '', '1', '1', '菜单管理', 'list', '', '20');
INSERT INTO `cmf_menu` VALUES ('86', '85', 'Admin', 'Navcat', 'default1', '', '1', '1', '前台菜单', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('87', '86', 'Admin', 'Nav', 'index', '', '1', '1', '菜单管理', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('88', '87', 'Admin', 'Nav', 'listorders', '', '1', '0', '前台导航排序', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('89', '87', 'Admin', 'Nav', 'delete', '', '1', '0', '删除菜单', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('90', '87', 'Admin', 'Nav', 'edit', '', '1', '0', '编辑菜单', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('91', '90', 'Admin', 'Nav', 'edit_post', '', '1', '0', '提交编辑', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('92', '87', 'Admin', 'Nav', 'add', '', '1', '0', '添加菜单', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('93', '92', 'Admin', 'Nav', 'add_post', '', '1', '0', '提交添加', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('94', '86', 'Admin', 'Navcat', 'index', '', '1', '1', '菜单分类', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('95', '94', 'Admin', 'Navcat', 'delete', '', '1', '0', '删除分类', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('96', '94', 'Admin', 'Navcat', 'edit', '', '1', '0', '编辑分类', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('97', '96', 'Admin', 'Navcat', 'edit_post', '', '1', '0', '提交编辑', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('98', '94', 'Admin', 'Navcat', 'add', '', '1', '0', '添加分类', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('99', '98', 'Admin', 'Navcat', 'add_post', '', '1', '0', '提交添加', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('100', '85', 'Admin', 'Menu', 'index', '', '1', '1', '后台菜单', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('101', '100', 'Admin', 'Menu', 'add', '', '1', '0', '添加菜单', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('102', '101', 'Admin', 'Menu', 'add_post', '', '1', '0', '提交添加', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('103', '100', 'Admin', 'Menu', 'listorders', '', '1', '0', '后台菜单排序', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('104', '100', 'Admin', 'Menu', 'export_menu', '', '1', '0', '菜单备份', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('105', '100', 'Admin', 'Menu', 'edit', '', '1', '0', '编辑菜单', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('106', '105', 'Admin', 'Menu', 'edit_post', '', '1', '0', '提交编辑', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('107', '100', 'Admin', 'Menu', 'delete', '', '1', '0', '删除菜单', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('108', '100', 'Admin', 'Menu', 'lists', '', '1', '0', '所有菜单', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('109', '0', 'Admin', 'Setting', 'default', '', '0', '1', '设置', 'cogs', '', '0');
INSERT INTO `cmf_menu` VALUES ('110', '109', 'Admin', 'Setting', 'userdefault', '', '0', '1', '个人信息', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('111', '110', 'Admin', 'User', 'userinfo', '', '1', '1', '修改信息', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('112', '111', 'Admin', 'User', 'userinfo_post', '', '1', '0', '修改信息提交', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('113', '110', 'Admin', 'Setting', 'password', '', '1', '1', '修改密码', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('114', '113', 'Admin', 'Setting', 'password_post', '', '1', '0', '提交修改', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('115', '109', 'Admin', 'Setting', 'site', '', '1', '1', '网站信息', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('116', '115', 'Admin', 'Setting', 'site_post', '', '1', '0', '提交修改', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('117', '115', 'Admin', 'Route', 'index', '', '1', '0', '路由列表', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('118', '115', 'Admin', 'Route', 'add', '', '1', '0', '路由添加', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('119', '118', 'Admin', 'Route', 'add_post', '', '1', '0', '路由添加提交', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('120', '115', 'Admin', 'Route', 'edit', '', '1', '0', '路由编辑', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('121', '120', 'Admin', 'Route', 'edit_post', '', '1', '0', '路由编辑提交', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('122', '115', 'Admin', 'Route', 'delete', '', '1', '0', '路由删除', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('123', '115', 'Admin', 'Route', 'ban', '', '1', '0', '路由禁止', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('124', '115', 'Admin', 'Route', 'open', '', '1', '0', '路由启用', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('125', '115', 'Admin', 'Route', 'listorders', '', '1', '0', '路由排序', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('126', '109', 'Admin', 'Mailer', 'default', '', '1', '1', '邮箱配置', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('127', '126', 'Admin', 'Mailer', 'index', '', '1', '1', 'SMTP配置', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('128', '127', 'Admin', 'Mailer', 'index_post', '', '1', '0', '提交配置', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('129', '126', 'Admin', 'Mailer', 'active', '', '1', '1', '注册邮件模板', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('130', '129', 'Admin', 'Mailer', 'active_post', '', '1', '0', '提交模板', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('131', '109', 'Admin', 'Setting', 'clearcache', '', '1', '1', '清除缓存', '', '', '1');
INSERT INTO `cmf_menu` VALUES ('132', '0', 'User', 'Indexadmin', 'default', '', '1', '1', '用户管理', 'group', '', '10');
INSERT INTO `cmf_menu` VALUES ('133', '132', 'User', 'Indexadmin', 'default1', '', '1', '1', '用户组', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('134', '133', 'User', 'Indexadmin', 'index', '', '1', '1', '本站用户', 'leaf', '', '0');
INSERT INTO `cmf_menu` VALUES ('135', '134', 'User', 'Indexadmin', 'ban', '', '1', '0', '拉黑会员', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('136', '134', 'User', 'Indexadmin', 'cancelban', '', '1', '0', '启用会员', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('137', '133', 'User', 'Oauthadmin', 'index', '', '1', '1', '第三方用户', 'leaf', '', '0');
INSERT INTO `cmf_menu` VALUES ('138', '137', 'User', 'Oauthadmin', 'delete', '', '1', '0', '第三方用户解绑', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('139', '132', 'User', 'Indexadmin', 'default3', '', '1', '1', '管理组', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('140', '139', 'Admin', 'Rbac', 'index', '', '1', '1', '角色管理', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('141', '140', 'Admin', 'Rbac', 'member', '', '1', '0', '成员管理', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('142', '140', 'Admin', 'Rbac', 'authorize', '', '1', '0', '权限设置', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('143', '142', 'Admin', 'Rbac', 'authorize_post', '', '1', '0', '提交设置', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('144', '140', 'Admin', 'Rbac', 'roleedit', '', '1', '0', '编辑角色', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('145', '144', 'Admin', 'Rbac', 'roleedit_post', '', '1', '0', '提交编辑', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('146', '140', 'Admin', 'Rbac', 'roledelete', '', '1', '1', '删除角色', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('147', '140', 'Admin', 'Rbac', 'roleadd', '', '1', '1', '添加角色', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('148', '147', 'Admin', 'Rbac', 'roleadd_post', '', '1', '0', '提交添加', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('149', '139', 'Admin', 'User', 'index', '', '1', '1', '管理员', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('150', '149', 'Admin', 'User', 'delete', '', '1', '0', '删除管理员', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('151', '149', 'Admin', 'User', 'edit', '', '1', '0', '管理员编辑', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('152', '151', 'Admin', 'User', 'edit_post', '', '1', '0', '编辑提交', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('153', '149', 'Admin', 'User', 'add', '', '1', '0', '管理员添加', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('154', '153', 'Admin', 'User', 'add_post', '', '1', '0', '添加提交', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('155', '47', 'Admin', 'Plugin', 'update', '', '1', '0', '插件更新', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('156', '109', 'Admin', 'Storage', 'index', '', '1', '1', '文件存储', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('157', '156', 'Admin', 'Storage', 'setting_post', '', '1', '0', '文件存储设置提交', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('158', '54', 'Admin', 'Slide', 'ban', '', '1', '0', '禁用幻灯片', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('159', '54', 'Admin', 'Slide', 'cancelban', '', '1', '0', '启用幻灯片', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('160', '149', 'Admin', 'User', 'ban', '', '1', '0', '禁用管理员', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('161', '149', 'Admin', 'User', 'cancelban', '', '1', '0', '启用管理员', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('166', '127', 'Admin', 'Mailer', 'test', '', '1', '0', '测试邮件', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('167', '109', 'Admin', 'Setting', 'upload', '', '1', '1', '上传设置', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('168', '167', 'Admin', 'Setting', 'upload_post', '', '1', '0', '上传设置提交', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('169', '7', 'Portal', 'AdminPost', 'copy', '', '1', '0', '文章批量复制', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('174', '100', 'Admin', 'Menu', 'backup_menu', '', '1', '0', '备份菜单', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('175', '100', 'Admin', 'Menu', 'export_menu_lang', '', '1', '0', '导出后台菜单多语言包', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('176', '100', 'Admin', 'Menu', 'restore_menu', '', '1', '0', '还原菜单', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('177', '100', 'Admin', 'Menu', 'getactions', '', '1', '0', '导入新菜单', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('187', '1', 'Admin', 'Goods', 'index', '', '1', '1', '商品管理', '', '', '40');
INSERT INTO `cmf_menu` VALUES ('188', '187', 'Admin', 'Goods', 'add', '', '1', '0', '添加商品', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('189', '187', 'Admin', 'Goods', 'goods_upload', '', '1', '0', '批量导入', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('190', '187', 'Admin', 'Goods', 'edit', '', '1', '0', '编辑商品', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('191', '187', 'Admin', 'Goods', 'account', '', '1', '0', '结账', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('192', '187', 'Admin', 'Goods', 'listorders', '', '1', '0', '商品排序', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('193', '187', 'Admin', 'Goods', 'toggle', '', '1', '0', '商品显示和隐藏', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('194', '187', 'Admin', 'Goods', 'delete', '', '1', '0', '删除商品', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('195', '187', 'Admin', 'Goods', 'cancelban', '', '1', '0', '显示商品', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('196', '187', 'Admin', 'Goods', 'ban', '', '1', '0', '隐藏商品', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('197', '187', 'Admin', 'Goods', 'getGoods', '', '1', '0', '扫码显示', '', '', '0');
INSERT INTO `cmf_nav` VALUES ('1', '1', '0', '首页', '', 'home', '', '1', '0', '0-1');
INSERT INTO `cmf_nav` VALUES ('2', '1', '0', '列表演示', '', 'a:2:{s:6:\"action\";s:17:\"Portal/List/index\";s:5:\"param\";a:1:{s:2:\"id\";s:1:\"1\";}}', '', '0', '0', '0-2');
INSERT INTO `cmf_nav` VALUES ('3', '1', '0', '瀑布流', '', 'a:2:{s:6:\"action\";s:17:\"Portal/List/index\";s:5:\"param\";a:1:{s:2:\"id\";s:1:\"2\";}}', '', '0', '0', '0-3');
INSERT INTO `cmf_nav_cat` VALUES ('1', '主导航', '1', '主导航');
INSERT INTO `cmf_options` VALUES ('1', 'member_email_active', '{\"title\":\"ThinkCMF\\u90ae\\u4ef6\\u6fc0\\u6d3b\\u901a\\u77e5.\",\"template\":\"<p>\\u672c\\u90ae\\u4ef6\\u6765\\u81ea<a href=\\\"http:\\/\\/www.thinkcmf.com\\\">ThinkCMF<\\/a><br\\/><br\\/>&nbsp; &nbsp;<strong>---------------<strong style=\\\"white-space: normal;\\\">---<\\/strong><\\/strong><br\\/>&nbsp; &nbsp;<strong>\\u5e10\\u53f7\\u6fc0\\u6d3b\\u8bf4\\u660e<\\/strong><br\\/>&nbsp; &nbsp;<strong>---------------<strong style=\\\"white-space: normal;\\\">---<\\/strong><\\/strong><br\\/><br\\/>&nbsp; &nbsp; \\u5c0a\\u656c\\u7684<span style=\\\"FONT-SIZE: 16px; FONT-FAMILY: Arial; COLOR: rgb(51,51,51); LINE-HEIGHT: 18px; BACKGROUND-COLOR: rgb(255,255,255)\\\">#username#\\uff0c\\u60a8\\u597d\\u3002<\\/span>\\u5982\\u679c\\u60a8\\u662fThinkCMF\\u7684\\u65b0\\u7528\\u6237\\uff0c\\u6216\\u5728\\u4fee\\u6539\\u60a8\\u7684\\u6ce8\\u518cEmail\\u65f6\\u4f7f\\u7528\\u4e86\\u672c\\u5730\\u5740\\uff0c\\u6211\\u4eec\\u9700\\u8981\\u5bf9\\u60a8\\u7684\\u5730\\u5740\\u6709\\u6548\\u6027\\u8fdb\\u884c\\u9a8c\\u8bc1\\u4ee5\\u907f\\u514d\\u5783\\u573e\\u90ae\\u4ef6\\u6216\\u5730\\u5740\\u88ab\\u6ee5\\u7528\\u3002<br\\/>&nbsp; &nbsp; \\u60a8\\u53ea\\u9700\\u70b9\\u51fb\\u4e0b\\u9762\\u7684\\u94fe\\u63a5\\u5373\\u53ef\\u6fc0\\u6d3b\\u60a8\\u7684\\u5e10\\u53f7\\uff1a<br\\/>&nbsp; &nbsp; <a title=\\\"\\\" href=\\\"http:\\/\\/#link#\\\" target=\\\"_self\\\">http:\\/\\/#link#<\\/a><br\\/>&nbsp; &nbsp; (\\u5982\\u679c\\u4e0a\\u9762\\u4e0d\\u662f\\u94fe\\u63a5\\u5f62\\u5f0f\\uff0c\\u8bf7\\u5c06\\u8be5\\u5730\\u5740\\u624b\\u5de5\\u7c98\\u8d34\\u5230\\u6d4f\\u89c8\\u5668\\u5730\\u5740\\u680f\\u518d\\u8bbf\\u95ee)<br\\/>&nbsp; &nbsp; \\u611f\\u8c22\\u60a8\\u7684\\u8bbf\\u95ee\\uff0c\\u795d\\u60a8\\u4f7f\\u7528\\u6109\\u5feb\\uff01<br\\/><br\\/>&nbsp; &nbsp; \\u6b64\\u81f4<br\\/>&nbsp; &nbsp; ThinkCMF \\u7ba1\\u7406\\u56e2\\u961f.<\\/p>\"}', '1');
INSERT INTO `cmf_options` VALUES ('6', 'site_options', '{\"site_name\":\"\\u65b0\\u519c\\u8d85\\u5e02\",\"site_admin_url_password\":\"\",\"site_tpl\":\"nv\",\"site_adminstyle\":\"flat\",\"site_icp\":\"\",\"site_admin_email\":\"likun_19911227@163.com\",\"site_tongji\":\"&lt;script&gt;\\nvar _hmt = _hmt || [];\\n(function() {\\n  var hm = document.createElement(&quot;script&quot;);\\n  hm.src = &quot;\\/\\/hm.baidu.com\\/hm.js?8ad55e8fec10bc822435b50eb3d7fe43&quot;;\\n  var s = document.getElementsByTagName(&quot;script&quot;)[0]; \\n  s.parentNode.insertBefore(hm, s);\\n})();\\n&lt;\\/script&gt;\",\"site_copyright\":\"\",\"site_seo_title\":\"\\u65b0\\u519c\\u8d85\\u5e02\",\"site_seo_keywords\":\"\\u65b0\\u519c\\u8d85\\u5e02,\\u65b0\\u519c\\u6751\",\"site_seo_description\":\"\\u65b0\\u519c\\u8d85\\u5e02\\u662f\\u65b0\\u519c\\u6751\\u8d2d\\u7269\\u7f51\\u7ad9\",\"urlmode\":\"0\",\"html_suffix\":\"\",\"comment_time_interval\":\"60\"}', '1');
INSERT INTO `cmf_options` VALUES ('7', 'cmf_settings', '{\"banned_usernames\":\"\"}', '1');
INSERT INTO `cmf_options` VALUES ('8', 'cdn_settings', '{\"cdn_static_root\":\"\"}', '1');
INSERT INTO `cmf_posts` VALUES ('1', '1', '', '', '2017-07-05 20:33:57', '', '发斯蒂芬是', '', '3', '1', '2017-07-05 20:34:21', null, '0', '1', '', '0', '{\"thumb\":\"portal\\/20170705\\/595cdcc449661.jpg\",\"template\":\"\"}', '0', '0', '0', '0');
INSERT INTO `cmf_role` VALUES ('1', '超级管理员', '0', '1', '拥有网站最高管理员权限！', '1329633709', '1329633709', '0');
INSERT INTO `cmf_slide` VALUES ('1', '1', '新农超市banner1', 'admin/20170712/5965a92a96211.jpg', '', '', '', '1', '0');
INSERT INTO `cmf_slide` VALUES ('2', '1', '新农超市banner2', 'admin/20170712/5965a94e668aa.jpg', '', '', '', '1', '0');
INSERT INTO `cmf_slide_cat` VALUES ('1', '首页Banner图（1920x600）', 'home_banner', '', '1');
INSERT INTO `cmf_term_relationships` VALUES ('1', '1', '1', '0', '1');
INSERT INTO `cmf_terms` VALUES ('1', '列表演示', '', 'article', '', '0', '0', '0-1', '', '', '', 'list', 'article', '0', '1');
INSERT INTO `cmf_terms` VALUES ('2', '瀑布流', '', 'article', '', '0', '0', '0-2', '', '', '', 'list_masonry', 'article', '0', '1');
INSERT INTO `cmf_users` VALUES ('1', 'llk', '###4a989b5f5c1b6f90508e492bf5ea16eb', '李利坤', 'likun_19911227@163.com', '', null, '0', '1991-12-27', '我有一个梦想', '0.0.0.0', '2017-07-12 09:37:37', '2017-07-04 03:06:49', '', '1', '0', '1', '0', '');
