-- MySQL dump 10.13  Distrib 5.7.37, for Win64 (x86_64)
--
-- Host: 62.234.62.75    Database: xm_blog
-- ------------------------------------------------------
-- Server version	5.7.37

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `xm_blog`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `xm_blog` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;

USE `xm_blog`;

--
-- Table structure for table `activity`
--

DROP TABLE IF EXISTS `activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activity` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '活动名称',
  `descr` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '活动简介',
  `content` longtext COLLATE utf8mb4_unicode_ci COMMENT '活动内容',
  `start` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '开始时间',
  `end` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '结束时间',
  `form` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '活动形式',
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '活动地址',
  `host` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '主办方',
  `read_count` int(11) DEFAULT '0' COMMENT '浏览量',
  `cover` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '封面',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='活动';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity`
--

LOCK TABLES `activity` WRITE;
/*!40000 ALTER TABLE `activity` DISABLE KEYS */;
INSERT INTO `activity` VALUES (5,'西北大学计算机考研资料','西北大学计算机考研844笔记整理','<h2 id=\"epwbh\">2025版笔记特点</h2><ul><li><b>结构清晰、答案规范、图表清晰、纯键盘输入、格式优美、11万字(共249页)</b></li><li>真题全面、涉及数据结构、计算机网络、操作系统能找到的所有真题。归纳了网数院845的计算机网络真题、3年的西北大学计算机网络期末题。还有给<b>某机构出的两套844考研卷及详细解析</b></li><li><b>解析全面，力求准确，对真题答案不断进行优化</b>，已经过<b>百余名</b>学子的检验，感谢大家反馈的意见，已优化。</li><li>本笔记适用考研人群：&nbsp; &nbsp;&nbsp;</li></ul><p><span style=\"font-size: 14px;\">&nbsp; &nbsp;&nbsp;</span><span style=\"font-size: 14px;\">&nbsp; &nbsp;&nbsp;</span><b>西北大学-计算机科学与技术(学硕-081200)；&nbsp;</b></p><p><span style=\"font-size: 14px;\">&nbsp; &nbsp;&nbsp;</span><span style=\"font-size: 14px;\">&nbsp; &nbsp;&nbsp;</span><b>西北大学-软件工程(学硕-083500)；</b></p><p><span style=\"font-size: 14px;\">&nbsp; &nbsp;&nbsp;</span><span style=\"font-size: 14px;\">&nbsp; &nbsp;&nbsp;</span><b>西北大学-软件工程(专硕-085405)。</b></p><ol></ol><div><h2 id=\"xi0af\">个人认为本笔记的突出作用</h2><ul><li>帮助844考研学子获得更多844的相关信息，<b>打破自命题信息壁垒</b>。</li><li>对历年真题进行了详细解析，<b>格式优美，纯机打</b>，考研学生不必为各种错误答案烦恼，<b>节省大家搜索时间</b>。</li><li>对844初试涉及的所有知识点进行了整理，大家不用浪费时间再去自己整理，<b>节省大家总结时间以及降低试错成本</b>。</li></ul><div><h2 id=\"dwnjl\">2025级（第三版资料）优化内容</h2><div><img src=\"http://62.234.62.75:9090/files/1707320383414-image.png\" style=\"max-width:100%;\" contenteditable=\"false\"/></div><div><br/></div><div><br/></div><div><br/></div><div></div></div></div>','2024-01-04','2024-12-30','线上','https://m.tb.cn/h.5t2q6vI?tk=VZE2WkhXuj2','迟意',153,'http://62.234.62.75:9090/files/1707320037823-8d9052af96c93758e28fee90ec05a80.png');
/*!40000 ALTER TABLE `activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `activity_sign`
--

DROP TABLE IF EXISTS `activity_sign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activity_sign` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `activity_id` int(11) DEFAULT NULL COMMENT '活动ID',
  `user_id` int(11) DEFAULT NULL COMMENT '用户ID',
  `time` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '报名时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='活动报名表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_sign`
--

LOCK TABLES `activity_sign` WRITE;
/*!40000 ALTER TABLE `activity_sign` DISABLE KEYS */;
/*!40000 ALTER TABLE `activity_sign` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '密码',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '姓名',
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '头像',
  `role` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '角色标识',
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电话',
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='管理员';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'admin','926424qq','迟意','http://62.234.62.75:9090/files/1704683025336-头像.jpg','ADMIN','18392945246','1256933608@qq.com');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog`
--

DROP TABLE IF EXISTS `blog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  `content` longtext COLLATE utf8mb4_unicode_ci COMMENT '内容',
  `descr` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '简介',
  `cover` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '封面',
  `tags` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标签',
  `user_id` int(11) DEFAULT NULL COMMENT '发布人ID',
  `date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发布日期',
  `read_count` int(11) DEFAULT '0' COMMENT '浏览量',
  `category_id` int(11) DEFAULT NULL COMMENT '分类ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='博客信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog`
--

LOCK TABLES `blog` WRITE;
/*!40000 ALTER TABLE `blog` DISABLE KEYS */;
INSERT INTO `blog` VALUES (25,'力扣热题100题','@[TOC]\n## 哈希\n\n### 1.两数之和\n\n给定一个整数数组 `nums` 和一个整数目标值 `target`，请你在该数组中找出 **和为目标值** *`target`* 的那 **两个** 整数，并返回它们的数组下标。\n\n你可以假设每种输入只会对应一个答案。但是，数组中同一个元素在答案里不能重复出现。\n\n你可以按任意顺序返回答案。\n\n \n\n**示例 1：**\n\n```\n输入：nums = [2,7,11,15], target = 9\n输出：[0,1]\n解释：因为 nums[0] + nums[1] == 9 ，返回 [0, 1] 。\n```\n\n**示例 2：**\n\n```\n输入：nums = [3,2,4], target = 6\n输出：[1,2]\n```\n\n**示例 3：**\n\n```\n输入：nums = [3,3], target = 6\n输出：[0,1]\n```\n\n~~~cpp\n/*\n思路:\n采用哈希表:\n如果target-nums[i]有值，就输出i与target-nums[i]的下标\n如果target-nums[i]无值，就将nums[i]的下标i存到哈希表中\n*/\n~~~\n\n~~~cpp\nclass Solution {\npublic:\n    vector<int> twoSum(vector<int>& nums, int target) {\n        unordered_map<int,int> hash;\n        for(int i=0;i<nums.size();i++){\n            if(hash.count(target-nums[i])){\n                return {hash[target-nums[i]],i};\n            }else  hash[nums[i]] = i;\n        }\n        return {-1,-1};\n    }\n};\n~~~\n\n### 49.字母异位词分词\n\n给你一个字符串数组，请你将 **字母异位词** 组合在一起。可以按任意顺序返回结果列表。\n\n**字母异位词** 是由重新排列源单词的所有字母得到的一个新单词。\n\n**示例 1:**\n\n```\n输入: strs = [\"eat\", \"tea\", \"tan\", \"ate\", \"nat\", \"bat\"]\n输出: [[\"bat\"],[\"nat\",\"tan\"],[\"ate\",\"eat\",\"tea\"]]\n```\n\n**示例 2:**\n\n```\n输入: strs = [\"\"]\n输出: [[\"\"]]\n```\n\n**示例 3:**\n\n```\n输入: strs = [\"a\"]\n输出: [[\"a\"]]\n```\n\n~~~cpp\n/*\n思路 先对每个字符串进行排序，相同顺序的存到哈希表中\n最后将相同顺序的存到一个vector<string>中\n*/\n~~~\n\n~~~cpp\nclass Solution {\npublic:\n    vector<vector<string>> groupAnagrams(vector<string>& strs) {\n        unordered_map<string,vector<string>> hash;\n        string str;\n        for(int i=0;i<strs.size();i++){\n            str=strs[i];\n            sort(str.begin(),str.end());\n            hash[str].push_back(strs[i]);\n        }\n        vector<vector<string>> res;\n        for(auto [x,c]:hash){\n            res.push_back(c);\n        }\n        return res;\n    }\n};\n~~~\n\n### 128.最长连续序列\n\n给定一个未排序的整数数组 `nums` ，找出数字连续的最长序列（不要求序列元素在原数组中连续）的长度。\n\n请你设计并实现时间复杂度为 `O(n)` 的算法解决此问题。\n\n**示例 1：**\n\n```\n输入：nums = [100,4,200,1,3,2]\n输出：4\n解释：最长数字连续序列是 [1, 2, 3, 4]。它的长度为 4。\n```\n\n**示例 2：**\n\n```\n输入：nums = [0,3,7,2,5,8,4,6,0,1]\n输出：9\n```\n\n~~~cpp\n/* \n思路：\n采用一个无序集合，存储所有非重复的值\n遍历无序集合，如果x-1存在则跳过，找到最起始的位置进行遍历，计数。\n*/\n~~~\n\n~~~cpp\nclass Solution {\npublic:\n    int longestConsecutive(vector<int>& nums) {\n        unordered_set<int> un_set;\n        for(auto c:nums){\n            un_set.insert(c);        \n        }\n        int res = 0;\n        for(auto c:un_set){\n            if(!un_set.count(c-1)){\n                int curnum = c;\n                int curlength = 1;\n                while(un_set.count(curnum+1)){\n                    curnum+=1;\n                    curlength+=1;\n                }\n                res = max(curlength,res);\n            }\n            \n        }\n        return res;\n    }\n};\n~~~\n\n## 双指针\n\n### 283.移动零\n\n给定一个数组 `nums`，编写一个函数将所有 `0` 移动到数组的末尾，同时保持非零元素的相对顺序。\n\n**请注意** ，必须在不复制数组的情况下原地对数组进行操作。\n\n**示例 1:**\n\n```\n输入: nums = [0,1,0,3,12]\n输出: [1,3,12,0,0]\n```\n\n**示例 2:**\n\n```\n输入: nums = [0]\n输出: [0]\n```\n\n~~~cpp\n/*\n思路:双指针算法\n将不等于0的挪到前面，后面全部补为0\n*/\n~~~\n\n~~~cpp\nclass Solution {\npublic:\n    void moveZeroes(vector<int>& nums) {\n        int i=0,j=0;\n        for(auto c:nums){\n            if(c!=0){\n                nums[j++]=c;                \n            }\n        }\n        for(j;j<nums.size();j++) nums[j] = 0;\n    }\n};\n~~~\n\n### 11.盛最多水的容器\n\n给定一个长度为 `n` 的整数数组 `height` 。有 `n` 条垂线，第 `i` 条线的两个端点是 `(i, 0)` 和 `(i, height[i])` 。\n\n找出其中的两条线，使得它们与 `x` 轴共同构成的容器可以容纳最多的水。\n\n返回容器可以储存的最大水量。\n\n**说明：**你不能倾斜容器。\n\n**示例 1：**\n\n![img](https://aliyun-lc-upload.oss-cn-hangzhou.aliyuncs.com/aliyun-lc-upload/uploads/2018/07/25/question_11.jpg)\n\n```\n输入：[1,8,6,2,5,4,8,3,7]\n输出：49 \n解释：图中垂直线代表输入数组 [1,8,6,2,5,4,8,3,7]。在此情况下，容器能够容纳水（表示为蓝色部分）的最大值为 49。\n```\n\n**示例 2：**\n\n```\n输入：height = [1,1]\n输出：1\n```\n\n~~~c++\n/*\n思路 左右往里面夹着，每次以最低的为高，算个面积 一直算直到两者相等，求出最高即可\n//先将i往里挪 还是先将j往里挪呢？ 注意是先挪低的那一方\n在每个状态下，无论长板或短板向中间收窄一格，都会导致水槽 底边宽度 −1 变短：\n若向内 移动短板 ，水槽的短板 min(h[i],h[j]) 可能变大，因此下个水槽的面积 可能增大 。\n若向内 移动长板 ，水槽的短板 min(h[i],h[j]) 不变或变小，因此下个水槽的面积 一定变小 。\n\n作者：Krahets\n链接：https://leetcode.cn/problems/container-with-most-water/\n来源：力扣（LeetCode）\n著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。\n\n\n\n*/\n~~~\n\n~~~cpp\nclass Solution {\npublic:\n    int maxArea(vector<int>& height) {\n        int i=0,j=height.size()-1;\n        int res = 0;\n        while(i<j){\n            int min = height[i]<height[j]?height[i]:height[j];\n            //先将i往里挪 还是先将j往里挪呢？ 先挪低的\n            res = max(min*(j-i),res);  \n            if(height[i]<height[j]) i++;\n            else j--;            \n        }\n        return res;\n    }\n};\n~~~\n\n### 15.三数之和\n\n给你一个整数数组 `nums` ，判断是否存在三元组 `[nums[i], nums[j], nums[k]]` 满足 `i != j`、`i != k` 且 `j != k` ，同时还满足 `nums[i] + nums[j] + nums[k] == 0` 。请\n\n你返回所有和为 `0` 且不重复的三元组。\n\n**注意：**答案中不可以包含重复的三元组。\n\n**示例 1：**\n\n```\n输入：nums = [-1,0,1,2,-1,-4]\n输出：[[-1,-1,2],[-1,0,1]]\n解释：\nnums[0] + nums[1] + nums[2] = (-1) + 0 + 1 = 0 。\nnums[1] + nums[2] + nums[4] = 0 + 1 + (-1) = 0 。\nnums[0] + nums[3] + nums[4] = (-1) + 2 + (-1) = 0 。\n不同的三元组是 [-1,0,1] 和 [-1,-1,2] 。\n注意，输出的顺序和三元组的顺序并不重要。\n```\n\n**示例 2：**\n\n```\n输入：nums = [0,1,1]\n输出：[]\n解释：唯一可能的三元组和不为 0 。\n```\n\n**示例 3：**\n\n```\n输入：nums = [0,0,0]\n输出：[[0,0,0]]\n解释：唯一可能的三元组和为 0 。\n```\n\n~~~cpp\n/*\n思路：\n先对数组进行排序  三指针 i j k，固定i j往右增大 k往左缩小\n主要设置去除重复值，前面出现的不用去除 如 -1 -1 2， -2 1 1 遇到第一个重复的可能会用到后面的值不用去重，后面重复的需要去除\n*/\n~~~\n\n~~~cpp\nclass Solution {\npublic:\n    vector<vector<int>> threeSum(vector<int>& nums) {\n        sort(nums.begin(),nums.end());\n        vector<vector<int>>res;\n        for(int i=0;i<nums.size();i++){\n            //将i固定            \n            if(i&&nums[i] == nums[i-1]) continue;\n            for(int j=i+1,k=nums.size()-1;j<k;j++){\n                if(j>i+1 && nums[j] == nums[j-1]) continue;\n                while(j<k && nums[i]+nums[j]+nums[k]>0) k--;\n                if(j<k && nums[i]+nums[j]+nums[k] == 0) \n                res.push_back({nums[i],nums[j],nums[k]});\n            }\n        }\n        return res;\n\n    }\n};\n~~~\n\n### 42.接雨水\n\n给定 `n` 个非负整数表示每个宽度为 `1` 的柱子的高度图，计算按此排列的柱子，下雨之后能接多少雨水。\n\n**示例 1：**\n\n![img](https://assets.leetcode-cn.com/aliyun-lc-upload/uploads/2018/10/22/rainwatertrap.png)\n\n```\n输入：height = [0,1,0,2,1,0,1,3,2,1,2,1]\n输出：6\n解释：上面是由数组 [0,1,0,2,1,0,1,3,2,1,2,1] 表示的高度图，在这种情况下，可以接 6 个单位的雨水（蓝色部分表示雨水）。\n```\n\n**示例 2：**\n\n```\n输入：height = [4,2,0,3,2,5]\n输出：9\n```\n\n~~~cpp\n/*\n实现思路  //针对除第一个和最后一个柱子 找左边最大的右边最大的 的最小值(包括本身) -当前高度\n*/\n~~~\n\n~~~cpp\nclass Solution {\npublic:\n    int trap(vector<int>& height) {\n        //针对除第一个和最后一个柱子 找左边最大的右边最大的(包括本身)-当前高度\n        int n = height.size();\n        vector<int> left(n),right(n);\n        left[0]=height[0],right[n-1] = height[n-1];\n        for(int i=1;i<height.size();i++){\n            left[i] = max(left[i-1],height[i]);\n            right[n-i-1] = max(right[n-i],height[n-i-1]);\n        }\n        int res = 0;\n        for(int i=1;i<n-1;i++){\n            res += min(left[i],right[i]) - height[i];\n        }\n        return res;\n\n    }\n};\n~~~\n\n## 滑动窗口\n\n### 3.无重复字符的最长字串\n\n给定一个字符串 `s` ，请你找出其中不含有重复字符的 **最长子串** 的长度。\n\n**示例 1:**\n\n```\n输入: s = \"abcabcbb\"\n输出: 3 \n解释: 因为无重复字符的最长子串是 \"abc\"，所以其长度为 3。\n```\n\n**示例 2:**\n\n```\n输入: s = \"bbbbb\"\n输出: 1\n解释: 因为无重复字符的最长子串是 \"b\"，所以其长度为 1。\n```\n\n**示例 3:**\n\n```\n输入: s = \"pwwkew\"\n输出: 3\n解释: 因为无重复字符的最长子串是 \"wke\"，所以其长度为 3。\n     请注意，你的答案必须是 子串 的长度，\"pwke\" 是一个子序列，不是子串。\n```\n\n~~~cpp\n/*\n思路：滑动窗口\n用一个哈希表，i,j作为滑动窗口，当hash[i]==2时候，j++,直到去除重复的为止\n*/\n~~~\n\n~~~cpp\nclass Solution {\npublic:\n    int lengthOfLongestSubstring(string s) {\n        unordered_map<char,int>hash;\n        int res=0;\n        for(int i=0,j=0;i<s.size();i++){\n            hash[s[i]]++;\n            while(hash[s[i]]>1) hash[s[j++]]--;\n            res = max(res,i-j+1);\n        }\n        return res;\n\n    }\n};\n~~~\n\n### 438.找到字符串中所有字母异位词\n\n给定两个字符串 `s` 和 `p`，找到 `s` 中所有 `p` 的 **异位词** 的子串，返回这些子串的起始索引。不考虑答案输出的顺序。\n\n**异位词** 指由相同字母重排列形成的字符串（包括相同的字符串）。\n\n**示例 1:**\n\n```\n输入: s = \"cbaebabacd\", p = \"abc\"\n输出: [0,6]\n解释:\n起始索引等于 0 的子串是 \"cba\", 它是 \"abc\" 的异位词。\n起始索引等于 6 的子串是 \"bac\", 它是 \"abc\" 的异位词。\n```\n\n **示例 2:**\n\n```\n输入: s = \"abab\", p = \"ab\"\n输出: [0,1,2]\n解释:\n起始索引等于 0 的子串是 \"ab\", 它是 \"ab\" 的异位词。\n起始索引等于 1 的子串是 \"ba\", 它是 \"ab\" 的异位词。\n起始索引等于 2 的子串是 \"ab\", 它是 \"ab\" 的异位词。\n```\n\n~~~cpp\n//采用一个滑动窗口\n// i,j i为起始位置，j为终止位置，当i加一个位置，hash[s[i]]--.同时hash[s[j]]++,判断此时的哈希表是否相等即可\n~~~\n\n~~~cpp\nclass Solution {\npublic:\n    vector<int> findAnagrams(string s, string p) {\n        unordered_map<char,int> hs;\n        unordered_map<char,int> hp;\n        int slen = s.size(),plen=p.size();\n        if(slen < plen) return {};\n        for(int i=0;i<plen;i++){\n            hs[s[i]]++; hp[p[i]]++;\n        }\n        vector<int> res;\n        if(hs == hp) res.push_back(0);\n        for(int i=0;i+plen<slen;i++){\n            if(--hs[s[i]] == 0) hs.erase(s[i]);\n            hs[s[i+plen]]++;\n            if(hs == hp) res.push_back(i+1);\n        }\n        return res;\n    }\n};\n~~~\n\n## 子串\n\n### 560.和为K的子数组\n\n给你一个整数数组 `nums` 和一个整数 `k` ，请你统计并返回 *该数组中和为 `k` 的子数组的个数* 。\n\n子数组是数组中元素的连续非空序列。\n\n**示例 1：**\n\n```\n输入：nums = [1,1,1], k = 2\n输出：2\n```\n\n**示例 2：**\n\n```\n输入：nums = [1,2,3], k = 3\n输出：2\n```\n\n~~~cpp\n/**\n思路：采用前缀和＋哈希表解决\n前缀和求出来后存到哈希表中，每个试着减去k如果有值说明有连续字串和为K\n**/\n~~~\n\n~~~cpp\nclass Solution {\npublic:\n    int subarraySum(vector<int>& nums, int k) {\n        int n=nums.size();\n        vector<int> f(n);\n        f[0]=nums[0];\n        for(int i=1;i<n;i++){\n            f[i]=f[i-1]+nums[i];\n        }\n        unordered_map<int,int> hash;\n        hash[0]=1;\n        int res=0;\n        for(int i=0;i<n;i++){\n            res+=hash[f[i]-k];\n            hash[f[i]]++;\n        }\n        return res;\n\n    }\n};\n~~~\n\n### 239.滑动窗口最大值\n\n给你一个整数数组 `nums`，有一个大小为 `k` 的滑动窗口从数组的最左侧移动到数组的最右侧。你只可以看到在滑动窗口内的 `k` 个数字。滑动窗口每次只向右移动一位。\n\n返回 *滑动窗口中的最大值* 。\n\n**示例 1：**\n\n```\n输入：nums = [1,3,-1,-3,5,3,6,7], k = 3\n输出：[3,3,5,5,6,7]\n解释：\n滑动窗口的位置                最大值\n---------------               -----\n[1  3  -1] -3  5  3  6  7       3\n 1 [3  -1  -3] 5  3  6  7       3\n 1  3 [-1  -3  5] 3  6  7       5\n 1  3  -1 [-3  5  3] 6  7       5\n 1  3  -1  -3 [5  3  6] 7       6\n 1  3  -1  -3  5 [3  6  7]      7\n```\n\n~~~\n-1 3 \n~~~\n\n**示例 2：**\n\n```\n输入：nums = [1], k = 1\n输出：[1]\n```\n\n~~~cpp\n/**\n思路：采用单调队列解决，队头为最大，每轮进行比较 i-k+1判断是否滑出窗口\n队尾到队头  从小到大\n来个值直接将小于它的全部干掉，塞到队尾\n**/\n~~~\n\n~~~cpp\nclass Solution {\npublic:\n    vector<int> maxSlidingWindow(vector<int>& nums, int k) {\n        //单调队列解决\n        deque<int> dq;\n        vector<int> res;\n        for(int i=0;i<nums.size();i++){\n            //单调队列\n            //有更大的把小的撵走，更大的下标肯定更优先选择，来小的塞到后面，防止前面大的滑出去了，小的可替\n            if(dq.size()&& i-k+1 > dq.front() ) dq.pop_front();\n            while(dq.size() && nums[i]> nums[dq.back()]) dq.pop_back();\n            dq.push_back(i);\n            if(i-k+1>=0) res.push_back(nums[dq.front()]);\n        }\n        return res;\n    }\n};\n~~~\n\n### 76.最小覆盖字串\n\n给你一个字符串 `s` 、一个字符串 `t` 。返回 `s` 中涵盖 `t` 所有字符的最小子串。如果 `s` 中不存在涵盖 `t` 所有字符的子串，则返回空字符串 `\"\"` 。\n\n**注意：**\n\n- 对于 `t` 中重复字符，我们寻找的子字符串中该字符数量必须不少于 `t` 中该字符数量。\n- 如果 `s` 中存在这样的子串，我们保证它是唯一的答案。\n\n**示例 1：**\n\n```\n输入：s = \"ADOBECODEBANC\", t = \"ABC\"\n输出：\"BANC\"\n解释：最小覆盖子串 \"BANC\" 包含来自字符串 t 的 \'A\'、\'B\' 和 \'C\'。\n```\n\n**示例 2：**\n\n```\n输入：s = \"a\", t = \"a\"\n输出：\"a\"\n解释：整个字符串 s 是最小覆盖子串。\n```\n\n**示例 3:**\n\n```\n输入: s = \"a\", t = \"aa\"\n输出: \"\"\n解释: t 中两个字符 \'a\' 均应包含在 s 的子串中，\n因此没有符合条件的子字符串，返回空字符串\n```\n\n~~~cpp\n/*\n思路：采用哈希表法，用两个哈希表 进行比较\n如果遍历的串里存在t的值就让count++，然后进行窗口滑动即可\n*/\n~~~\n\n~~~cpp\nclass Solution {\npublic:\n    string minWindow(string s, string t) {\n        unordered_map<int,int> hs;\n        unordered_map<int,int> ht;\n        for(auto c:t) ht[c]++;\n        int count = 0;\n        string res;\n        for(int i=0,j=0;i<s.size();i++){\n            hs[s[i]]++;\n            //只算到第一个找到的位置即可，后面不会再更新了\n            if(hs[s[i]]<=ht[s[i]]) count++;\n            while(hs[s[j]] > ht[s[j]]) hs[s[j++]]--;\n            if(count == t.size() && (res.empty() || i-j+1<res.size()) ){\n                res = s.substr(j,i-j+1);\n            }            \n        }\n        return res;\n    }\n};\n~~~\n\n## 普通数组\n\n### 53.最大子数组和\n\n给你一个整数数组 `nums` ，请你找出一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。\n\n**子数组** 是数组中的一个连续部分。\n\n**示例 1：**\n\n```\n输入：nums = [-2,1,-3,4,-1,2,1,-5,4]\n输出：6\n解释：连续子数组 [4,-1,2,1] 的和最大，为 6 。\n```\n\n**示例 2：**\n\n```\n输入：nums = [1]\n输出：1\n```\n\n**示例 3：**\n\n```\n输入：nums = [5,4,-1,7,8]\n输出：23\n```\n\n~~~cpp\n1 2 5\n1 3\n~~~\n\n~~~cpp\n/**\n思路：求前缀和：\n如果前缀和为负数，则舍弃掉前缀，采用当前值为最大。\n如果为正数，则利用上前缀和\n**/\n~~~\n\n~~~cpp\nclass Solution {\npublic:\n    int maxSubArray(vector<int>& nums) {\n        //可以求出前缀和 找出最大值和最小值\n        int n = nums.size();\n        if(n==1) return nums[0];\n        vector<int> f(n);\n        f[0] = nums[0];\n        int res = -2e9;\n        for(int i=1;i<n;i++){\n            f[i]=max(nums[i],f[i-1]+nums[i]);\n            res = max(f[i],res);\n        }\n        return max(res,f[0]);\n    }\n};\n~~~\n\n### 56.合并区间\n\n以数组 `intervals` 表示若干个区间的集合，其中单个区间为 `intervals[i] = [starti, endi]` 。请你合并所有重叠的区间，并返回 *一个不重叠的区间数组，该数组需恰好覆盖输入中的所有区间* 。\n\n**示例 1：**\n\n```\n输入：intervals = [[1,3],[2,6],[8,10],[15,18]]\n输出：[[1,6],[8,10],[15,18]]\n解释：区间 [1,3] 和 [2,6] 重叠, 将它们合并为 [1,6].\n```\n\n**示例 2：**\n\n```\n输入：intervals = [[1,4],[4,5]]\n输出：[[1,5]]\n解释：区间 [1,4] 和 [4,5] 可被视为重叠区间。\n```\n\n~~~cpp\n/*\n先将起始位置从头到尾进行排序，然后判断是否有重叠的，有重叠的将末尾更新为最新的即可\n*/\n~~~\n\n~~~cpp\nclass Solution {\npublic:\n    vector<vector<int>> merge(vector<vector<int>>& intervals) {\n        vector<pair<int,int>> s;\n        vector<vector<int>> res;\n        for(auto c:intervals) s.push_back({c[0],c[1]});\n        sort(s.begin(),s.end());\n        int st=-1,ed=-1;\n        for(auto c:s){\n            if(ed<c.first){\n                //说明是分离的\n                if(ed != -1) res.push_back({st,ed});\n                st = c.first,ed=c.second;\n            }else ed=max(ed,c.second);\n        }\n        res.push_back({st,ed});\n        return res;\n    }\n};\n~~~\n\n### 189.轮转数组\n\n给定一个整数数组 `nums`，将数组中的元素向右轮转 `k` 个位置，其中 `k` 是非负数。\n\n**示例 1:**\n\n```\n输入: nums = [1,2,3,4,5,6,7], k = 3\n输出: [5,6,7,1,2,3,4]\n解释:\n向右轮转 1 步: [7,1,2,3,4,5,6]\n向右轮转 2 步: [6,7,1,2,3,4,5]\n向右轮转 3 步: [5,6,7,1,2,3,4]\n```\n\n**示例 2:**\n\n```\n输入：nums = [-1,-100,3,99], k = 2\n输出：[3,99,-1,-100]\n解释: \n向右轮转 1 步: [99,-1,-100,3]\n向右轮转 2 步: [3,99,-1,-100]\n```\n\n~~~cpp\n/*\n思路 \n两部分都逆置\n然后整体逆置\n*/\n~~~\n\n~~~cpp\nclass Solution {\npublic:\n    void rotate(vector<int>& nums, int k) {\n        int n = nums.size();\n        k = k % n; // 处理 k 大于数组长度的情况\n        reverse(nums.begin(),nums.end()-k);\n        reverse(nums.end()-k,nums.end());\n        reverse(nums.begin(),nums.end());\n    }\n};\n~~~\n\n### 238.除自身以外数组的乘积\n\n给你一个整数数组 `nums`，返回 *数组 `answer` ，其中 `answer[i]` 等于 `nums` 中除 `nums[i]` 之外其余各元素的乘积* 。\n\n题目数据 **保证** 数组 `nums`之中任意元素的全部前缀元素和后缀的乘积都在 **32 位** 整数范围内。\n\n请 **不要使用除法，**且在 `O(*n*)` 时间复杂度内完成此题。\n\n**示例 1:**\n\n```\n输入: nums = [1,2,3,4]\n输出: [24,12,8,6]\n```\n\n**示例 2:**\n\n```\n输入: nums = [-1,1,0,-3,3]\n输出: [0,0,9,0,0]\n```\n\n~~~cpp\n/*\n思路：针对每个数字算左边的乘积和右边的乘积，然后遍历每个数字将左右两部分的乘积乘起来即可\n*/\n~~~\n\n~~~cpp\nclass Solution {\npublic:\n    vector<int> productExceptSelf(vector<int>& nums) {\n        //针对每个数算一个左边的乘积和右边的乘积\n        int n=nums.size();\n        vector<int> left(n),right(n);\n        left[0]=1;\n        right[n-1]=1;\n        for(int i=1;i<nums.size();i++){\n            left[i]=left[i-1]*nums[i-1];            \n            right[n-i-1] =right[n-i]*nums[n-i];\n        }\n        vector<int> res(n);\n        for(int i=0;i<n;i++){\n            res[i]=left[i]*right[i];\n        }\n        return res;\n    }\n};\n~~~\n\n### 41.缺失的第一个正数\n\n给你一个未排序的整数数组 `nums` ，请你找出其中没有出现的最小的正整数。\n\n请你实现时间复杂度为 `O(n)` 并且只使用常数级别额外空间的解决方案。\n\n**示例 1：**\n\n```\n输入：nums = [1,2,0]\n输出：3\n```\n\n**示例 2：**\n\n```\n输入：nums = [3,4,-1,1]\n输出：2\n```\n\n**示例 3：**\n\n```\n输入：nums = [7,8,9,11,12]\n输出：1\n```\n\n~~~cpp\n/**\n思路1：哈希表法，但不是使用常数级别额外空间，代码较简单\n思路2：将每个元素放到正确的位置，原地交换，不停进行检查直到当前位置为负数或者大于n或者已经放到正确位置才退出循环\n**/\n~~~\n\n~~~cpp\nclass Solution {\npublic:\n    int firstMissingPositive(vector<int>& nums) {\n        unordered_map<int,int> hash;\n        for(auto c:nums) hash[c]++;\n        for(int i=1;;i++){\n            if(!hash.count(i)) return i;\n        }\n    }\n};\n~~~\n\n~~~cpp\nclass Solution {\npublic:\n    int firstMissingPositive(vector<int>& nums) {\n        int n=nums.size();\n        for(int i=0;i<nums.size();i++){\n            while(nums[i] !=i+1)\n            {\n                //while循环是不停检查\n                if(nums[i]<=0 || nums[i]>n || nums[i] == nums[nums[i]-1]){\n                    break;\n                }\n                //进行互换 nums[3]=8则 将nums[7]的值赋值为nums[3],nums[7]=8;\n                int idx = nums[i]-1;\n                nums[i] = nums[idx];\n                nums[idx] = idx+1;\n            }\n\n        }\n        for(int i=0;i<nums.size();i++){\n            if(nums[i] != i+1) return i+1;\n        }\n        return nums.size()+1;\n    }\n};\n~~~\n\n## 矩阵\n\n### 73.矩阵置零\n\n给定一个 `m x n` 的矩阵，如果一个元素为 **0** ，则将其所在行和列的所有元素都设为 **0** 。请使用 **[原地](http://baike.baidu.com/item/原地算法)** 算法**。**\n\n**示例 1：**\n\n<img src=\"https://assets.leetcode.com/uploads/2020/08/17/mat1.jpg\" alt=\"img\" style=\"zoom:80%;\" />\n\n```\n输入：matrix = [[1,1,1],[1,0,1],[1,1,1]]\n输出：[[1,0,1],[0,0,0],[1,0,1]]\n```\n\n**示例 2：**\n\n<img src=\"https://assets.leetcode.com/uploads/2020/08/17/mat2.jpg\" alt=\"img\" style=\"zoom:80%;\" />\n\n```\n输入：matrix = [[0,1,2,0],[3,4,5,2],[1,3,1,5]]\n输出：[[0,0,0,0],[0,4,5,0],[0,3,1,0]]\n```\n\n~~~cpp\n/*\n思路：采用两个标记数组\n*/\n~~~\n\n~~~cpp\nclass Solution {\npublic:\n    void setZeroes(vector<vector<int>>& matrix) {\n        int m=matrix.size();\n        int n=matrix[0].size();\n        vector<int> row(m,1),col(n,1);\n        for(int i=0;i<m;i++){\n            for(int j=0;j<n;j++){\n                if(matrix[i][j]== 0){\n                    row[i]=0;                    \n                    col[j]=0;\n                }\n            }\n        }\n        for(int i=0;i<m;i++){\n            for(int j=0;j<n;j++){\n                if(!row[i] || !col[j]){\n                    matrix[i][j]=0;\n                }\n            }\n        }\n\n    }\n};\n~~~\n\n### 54.螺旋矩阵\n\n给你一个 `m` 行 `n` 列的矩阵 `matrix` ，请按照 **顺时针螺旋顺序** ，返回矩阵中的所有元素。\n\n**示例 1：**\n\n![img](https://assets.leetcode.com/uploads/2020/11/13/spiral1.jpg)\n\n```\n输入：matrix = [[1,2,3],[4,5,6],[7,8,9]]\n输出：[1,2,3,6,9,8,7,4,5]\n```\n\n**示例 2：**\n\n![img](https://assets.leetcode.com/uploads/2020/11/13/spiral.jpg)\n\n```\n输入：matrix = [[1,2,3,4],[5,6,7,8],[9,10,11,12]]\n输出：[1,2,3,4,8,12,11,10,9,5,6,7]\n```\n\n~~~cpp\n/*\n思路 从右下左上的顺序轮转，用4个变量记录边界\n*/\n~~~\n\n~~~cpp\nclass Solution {\npublic:\n    vector<int> spiralOrder(vector<vector<int>>& matrix) {\n        //从右下左上四个方向遍历\n        int l=0,r=matrix[0].size()-1;\n        int u=0,d=matrix.size()-1;\n        vector<int> res;\n        while(true){\n            for(int j=l;j<=r;j++){ //从左到右\n                res.push_back(matrix[u][j]);\n            }\n            if(++u > d) break;\n            for(int i=u;i<=d;i++){ //从上到下\n                res.push_back(matrix[i][r]);              \n            }\n            if(--r <l) break;\n            for(int i=r;i>=l;i--) //从右到左\n            {\n                res.push_back(matrix[d][i]);\n            }\n            if(--d < u) break;\n            for(int i=d;i>=u;i--) //从下到上\n            {\n                res.push_back(matrix[i][l]);\n            }\n            if(++l > r) break;\n        }\n        return res;\n    }\n};\n~~~\n\n### 48.旋转图像\n\n给定一个 *n* × *n* 的二维矩阵 `matrix` 表示一个图像。请你将图像顺时针旋转 90 度。\n\n你必须在**[ 原地](https://baike.baidu.com/item/原地算法)** 旋转图像，这意味着你需要直接修改输入的二维矩阵。**请不要** 使用另一个矩阵来旋转图像。\n\n**示例 1：**\n\n![img](https://assets.leetcode.com/uploads/2020/08/28/mat1.jpg)\n\n```\n输入：matrix = [[1,2,3],[4,5,6],[7,8,9]]\n输出：[[7,4,1],[8,5,2],[9,6,3]]\n```\n\n**示例 2：**\n\n![img](https://assets.leetcode.com/uploads/2020/08/28/mat2.jpg)\n\n```\n输入：matrix = [[5,1,9,11],[2,4,8,10],[13,3,6,7],[15,14,12,16]]\n输出：[[15,13,2,5],[14,3,4,1],[12,6,8,9],[16,7,10,11]]\n```\n\n~~~cpp\n/**\n思路：先水平旋转 后对角线旋转\n**/\n~~~\n\n~~~cpp\nclass Solution {\npublic:\n    void rotate(vector<vector<int>>& matrix) {\n        int n=matrix.size();\n        //先翻转\n        for(int i=0;i<n/2;i++){\n            for(int j=0;j<n;j++){\n                swap(matrix[i][j],matrix[n-i-1][j]);\n            }\n        }\n        //后主对角线交换\n        for(int i=0;i<n;i++)\n            for(int j=i+1;j<n;j++)\n            swap(matrix[i][j],matrix[j][i]);\n        \n            \n    }\n};\n~~~\n\n### 240.搜索二维矩阵Ⅱ\n\n编写一个高效的算法来搜索 `*m* x *n*` 矩阵 `matrix` 中的一个目标值 `target` 。该矩阵具有以下特性：\n\n- 每行的元素从左到右升序排列。\n- 每列的元素从上到下升序排列。\n\n**示例 1：**\n\n![img](https://assets.leetcode-cn.com/aliyun-lc-upload/uploads/2020/11/25/searchgrid2.jpg)\n\n```\n输入：matrix = [[1,4,7,11,15],[2,5,8,12,19],[3,6,9,16,22],[10,13,14,17,24],[18,21,23,26,30]], target = 5\n输出：true\n```\n\n**示例 2：**\n\n![img](https://assets.leetcode-cn.com/aliyun-lc-upload/uploads/2020/11/25/searchgrid.jpg)\n\n```\n输入：matrix = [[1,4,7,11,15],[2,5,8,12,19],[3,6,9,16,22],[10,13,14,17,24],[18,21,23,26,30]], target = 20\n输出：false\n```\n\n~~~cpp\n//思路：\n/*\n从第一行最后一个开始，target小就往左，target大就往下\n*/\n\n~~~\n\n\n\n~~~cpp\nclass Solution {\npublic:\n    bool searchMatrix(vector<vector<int>>& matrix, int target) {\n        int m=matrix.size();\n        int n=matrix[0].size();\n        int x=0,y=n-1,num;\n        while(x<m && y>=0){\n            num=matrix[x][y];\n            if(num>target) y--;\n            else if(num == target) return true;\n            else if(num < target) x++;\n        }\n        return false;\n    }\n};\n~~~\n\n## 链表\n\n### 160.相交链表\n\n给你两个单链表的头节点 `headA` 和 `headB` ，请你找出并返回两个单链表相交的起始节点。如果两个链表不存在相交节点，返回 `null` 。\n\n图示两个链表在节点 `c1` 开始相交**：**\n\n![img](https://assets.leetcode-cn.com/aliyun-lc-upload/uploads/2018/12/14/160_statement.png)\n\n题目数据 **保证** 整个链式结构中不存在环。\n\n**注意**，函数返回结果后，链表必须 **保持其原始结构** 。\n\n**自定义评测：**\n\n**评测系统** 的输入如下（你设计的程序 **不适用** 此输入）：\n\n- `intersectVal` - 相交的起始节点的值。如果不存在相交节点，这一值为 `0`\n- `listA` - 第一个链表\n- `listB` - 第二个链表\n- `skipA` - 在 `listA` 中（从头节点开始）跳到交叉节点的节点数\n- `skipB` - 在 `listB` 中（从头节点开始）跳到交叉节点的节点数\n\n评测系统将根据这些输入创建链式数据结构，并将两个头节点 `headA` 和 `headB` 传递给你的程序。如果程序能够正确返回相交节点，那么你的解决方案将被 **视作正确答案** \n\n~~~cpp\n/*\n思路:a走到头 走b b走到头 走a 不相交最后都会为空\n*/\n~~~\n\n~~~cpp\n/**\n * Definition for singly-linked list.\n * struct ListNode {\n *     int val;\n *     ListNode *next;\n *     ListNode(int x) : val(x), next(NULL) {}\n * };\n */\nclass Solution {\npublic:\n    ListNode *getIntersectionNode(ListNode *headA, ListNode *headB) {\n        ListNode *p=headA,*q=headB;\n        while(p!=q){  \n            if(!p) p=headB;   \n            if(!q) q=headA;    \n            if(p==q) return p;                           \n            p=p->next;\n            q=q->next;           \n        }\n        return p;        \n    }\n};\n~~~\n\n### 206.反转链表\n\n给你单链表的头节点 `head` ，请你反转链表，并返回反转后的链表。\n\n**示例 1：**\n\n![img](https://assets.leetcode.com/uploads/2021/02/19/rev1ex1.jpg)\n\n```\n输入：head = [1,2,3,4,5]\n输出：[5,4,3,2,1]\n```\n\n**示例 2：**\n\n![img](https://assets.leetcode.com/uploads/2021/02/19/rev1ex2.jpg)\n\n```\n输入：head = [1,2]\n输出：[2,1]\n```\n\n**示例 3：**\n\n```\n输入：head = []\n输出：[]\n```\n\n~~~cpp\n/**\n * Definition for singly-linked list.\n * struct ListNode {\n *     int val;\n *     ListNode *next;\n *     ListNode() : val(0), next(nullptr) {}\n *     ListNode(int x) : val(x), next(nullptr) {}\n *     ListNode(int x, ListNode *next) : val(x), next(next) {}\n * };\n */\nclass Solution {\npublic:\n    ListNode* reverseList(ListNode* head) {\n        ListNode *p=head,*q,*h=new ListNode(-1);\n        while(p){\n            q=p->next;\n            p->next=h->next;\n            h->next=p;\n            p=q;\n        }\n        return h->next;\n    }\n};\n~~~\n\n### 234.回文链表\n\n给你一个单链表的头节点 `head` ，请你判断该链表是否为回文链表。如果是，返回 `true` ；否则，返回 `false` 。\n\n**示例 1：**\n\n![img](https://assets.leetcode.com/uploads/2021/03/03/pal1linked-list.jpg)\n\n```\n输入：head = [1,2,2,1]\n输出：true\n```\n\n**示例 2：**\n\n![img](https://assets.leetcode.com/uploads/2021/03/03/pal2linked-list.jpg)\n\n```\n输入：head = [1,2]\n输出：false\n```\n\n~~~cpp\n/*\n思路 用栈 从前往后和从后往前遍历一样说明是回文串\n*/\n~~~\n\n~~~cpp\n/**\n * Definition for singly-linked list.\n * struct ListNode {\n *     int val;\n *     ListNode *next;\n *     ListNode() : val(0), next(nullptr) {}\n *     ListNode(int x) : val(x), next(nullptr) {}\n *     ListNode(int x, ListNode *next) : val(x), next(next) {}\n * };\n */\nclass Solution {\npublic:\n    bool isPalindrome(ListNode* head) {\n        //回文链表进栈即可\n        stack<ListNode*> st;\n        ListNode* current = head;\n        while (current != nullptr) {\n            st.push(current);\n            current = current->next;\n        }\n        ListNode* c = head;\n        while(c != nullptr){            \n            auto node = st.top();\n            st.pop();\n            if(c->val != node->val) return false;\n            c=c->next;\n         }\n         return true;\n\n    }\n};\n~~~\n\n### 141.环形链表\n\n给你一个链表的头节点 `head` ，判断链表中是否有环。\n\n如果链表中有某个节点，可以通过连续跟踪 `next` 指针再次到达，则链表中存在环。 为了表示给定链表中的环，评测系统内部使用整数 `pos` 来表示链表尾连接到链表中的位置（索引从 0 开始）。**注意：`pos` 不作为参数进行传递** 。仅仅是为了标识链表的实际情况。\n\n*如果链表中存在环* ，则返回 `true` 。 否则，返回 `false` 。\n\n**示例 1：**\n\n![img](https://assets.leetcode-cn.com/aliyun-lc-upload/uploads/2018/12/07/circularlinkedlist.png)\n\n```\n输入：head = [3,2,0,-4], pos = 1\n输出：true\n解释：链表中有一个环，其尾部连接到第二个节点。\n```\n\n**示例 2：**\n\n![img](https://assets.leetcode-cn.com/aliyun-lc-upload/uploads/2018/12/07/circularlinkedlist_test2.png)\n\n```\n输入：head = [1,2], pos = 0\n输出：true\n解释：链表中有一个环，其尾部连接到第一个节点。\n```\n\n**示例 3：**\n\n```\n输入：head = [1], pos = -1\n输出：false\n解释：链表中没有环。\n```\n\n~~~cpp\n/*\n思路 采用快慢指针解决\n*/\n~~~\n\n~~~cpp\n/**\n * Definition for singly-linked list.\n * struct ListNode {\n *     int val;\n *     ListNode *next;\n *     ListNode(int x) : val(x), next(NULL) {}\n * };\n */\nclass Solution {\npublic:\n    bool hasCycle(ListNode *head) {\n        if(!head) return false;\n        auto *p=head,*q=head;\n        do{\n            if(p) p=p->next;\n            if(q) q=q->next;\n            if(q) q=q->next;\n        }while(p!=q);\n        if(q) return true;\n        else return false;\n        \n    }\n};\n~~~\n\n### 142.环形链表Ⅱ\n\n给定一个链表的头节点  `head` ，返回链表开始入环的第一个节点。 *如果链表无环，则返回 `null`。*\n\n如果链表中有某个节点，可以通过连续跟踪 `next` 指针再次到达，则链表中存在环。 为了表示给定链表中的环，评测系统内部使用整数 `pos` 来表示链表尾连接到链表中的位置（**索引从 0 开始**）。如果 `pos` 是 `-1`，则在该链表中没有环。**注意：`pos` 不作为参数进行传递**，仅仅是为了标识链表的实际情况。\n\n**不允许修改** 链表。\n\n~~~cpp\n/**\n思路：先使用快慢指针使得两者相遇判断出有环，\n相遇点之后 时光倒流 慢指针退到交点 快指针退到-y点，也就是说 从交点走x步会走到c‘，那么从相遇点走x步会走到交点，x步恰好是从起点开始走的\n**/\n~~~\n\n~~~cpp\n/**\n * Definition for singly-linked list.\n * struct ListNode {\n *     int val;\n *     ListNode *next;\n *     ListNode(int x) : val(x), next(NULL) {}\n * };\n */\nclass Solution {\npublic:\n    ListNode *detectCycle(ListNode *head) {\n        if(!head) return NULL;\n        auto *p=head,*q=head;\n        do{\n            if(p) p=p->next;\n            if(q) q=q->next;\n            if(q) q=q->next;\n        }while(p!=q);\n        if(!p) return NULL;\n        p=head;\n        while(p!=q){\n            p=p->next;\n            q=q->next;\n        }\n        return q;\n    }\n};\n~~~\n\n### 21.合并两个有序链表\n\n将两个升序链表合并为一个新的 **升序** 链表并返回。新链表是通过拼接给定的两个链表的所有节点组成的。 \n\n**示例 1：**\n\n![img](https://assets.leetcode.com/uploads/2020/10/03/merge_ex1.jpg)\n\n```\n输入：l1 = [1,2,4], l2 = [1,3,4]\n输出：[1,1,2,3,4,4]\n```\n\n**示例 2：**\n\n```\n输入：l1 = [], l2 = []\n输出：[]\n```\n\n**示例 3：**\n\n```\n输入：l1 = [], l2 = [0]\n输出：[0]\n```\n\n~~~cpp\n/**\n思路 一个一个进行比较 最后收尾\n**/\n~~~\n\n~~~cpp\n/**\n * Definition for singly-linked list.\n * struct ListNode {\n *     int val;\n *     ListNode *next;\n *     ListNode() : val(0), next(nullptr) {}\n *     ListNode(int x) : val(x), next(nullptr) {}\n *     ListNode(int x, ListNode *next) : val(x), next(next) {}\n * };\n */\nclass Solution {\npublic:\n    ListNode* mergeTwoLists(ListNode* list1, ListNode* list2) {\n        auto *p=list1,*q=list2;\n        auto *h=new ListNode(0),*r=h;\n        while(p&&q){\n            if(p->val < q->val) {r->next=p;p=p->next;r=r->next;}\n            else {r->next=q;q=q->next;r=r->next;}\n        }\n        //尾部自带为空 无需收尾\n        if(q) {r->next =q;}\n        if(p) {r->next =p;}\n        return h->next;\n        \n    }\n};\n~~~\n\n### 2.两数相加\n\n给你两个 **非空** 的链表，表示两个非负的整数。它们每位数字都是按照 **逆序** 的方式存储的，并且每个节点只能存储 **一位** 数字。\n\n请你将两个数相加，并以相同形式返回一个表示和的链表。\n\n你可以假设除了数字 0 之外，这两个数都不会以 0 开头。\n\n**示例 1：**\n\n![img](https://assets.leetcode-cn.com/aliyun-lc-upload/uploads/2021/01/02/addtwonumber1.jpg)\n\n```\n输入：l1 = [2,4,3], l2 = [5,6,4]\n输出：[7,0,8]\n解释：342 + 465 = 807.\n```\n\n**示例 2：**\n\n```\n输入：l1 = [0], l2 = [0]\n输出：[0]\n```\n\n**示例 3：**\n\n```\n输入：l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]\n输出：[8,9,9,9,0,0,0,1]\n```\n\n~~~cpp\n/**\n思路：逐个相加即可，直到为空,不断往右进位\n**/\n~~~\n\n~~~cpp\n/**\n * Definition for singly-linked list.\n * struct ListNode {\n *     int val;\n *     ListNode *next;\n *     ListNode() : val(0), next(nullptr) {}\n *     ListNode(int x) : val(x), next(nullptr) {}\n *     ListNode(int x, ListNode *next) : val(x), next(next) {}\n * };\n */\nclass Solution {\npublic:\n    ListNode* addTwoNumbers(ListNode* l1, ListNode* l2) {\n        auto *p=l1,*q=l2,*h=new ListNode(),*r=h;\n        int jinwei=0,gewei,x,y,sum;        \n        while(p||q){\n            if(p) {x=p->val;p=p->next;} else x=0;\n            if(q) {y=q->val;q=q->next;} else y=0;\n            gewei = (jinwei+x+y)%10;//用的是上一轮的进位\n            jinwei =(jinwei+x+y)/10;\n            auto n = new ListNode(gewei);\n            r->next = n;r=r->next;\n        }\n        if(jinwei) \n        {\n            auto n = new ListNode(jinwei);\n            r->next=n;r=r->next;\n        }\n        r->next=nullptr;\n        return h->next;\n    }\n};\n~~~\n\n### 19.删除链表的倒数第K个结点\n\n给你一个链表，删除链表的倒数第 `n` 个结点，并且返回链表的头结点。\n\n**示例 1：**\n\n![img](https://assets.leetcode.com/uploads/2020/10/03/remove_ex1.jpg)\n\n```\n输入：head = [1,2,3,4,5], n = 2\n输出：[1,2,3,5]\n```\n\n**示例 2：**\n\n```\n输入：head = [1], n = 1\n输出：[]\n```\n\n**示例 3：**\n\n```\n输入：head = [1,2], n = 1\n输出：[1]\n```\n\n~~~cpp\n/*\n采用倒数第K个元素办法 一个先不走 一个走K步 找到后 拿到前驱删除即可\n*/\n~~~\n\n~~~cpp\n/**\n * Definition for singly-linked list.\n * struct ListNode {\n *     int val;\n *     ListNode *next;\n *     ListNode() : val(0), next(nullptr) {}\n *     ListNode(int x) : val(x), next(nullptr) {}\n *     ListNode(int x, ListNode *next) : val(x), next(next) {}\n * };\n */\nclass Solution {\npublic:\n    ListNode* removeNthFromEnd(ListNode* head, int n) {\n        if(!head->next && n == 1) return nullptr;\n        auto *p=head,*q=head,*pre=new ListNode(-999);\n        int count=0;\n        while(p){\n            if(count>=n) {\n                pre = q;\n                q=q->next;\n            }\n            p=p->next;count++;\n        }\n        if(pre->val == -999)  head =q->next;            \n        else pre->next =q->next;\n        delete q;\n        return head;\n    }\n};\n~~~\n\n### 24.两两交换链表中的节点 \n\n给你一个链表，两两交换其中相邻的节点，并返回交换后链表的头节点。你必须在不修改节点内部的值的情况下完成本题（即，只能进行节点交换）。\n\n**示例 1：**\n\n![img](https://assets.leetcode.com/uploads/2020/10/03/swap_ex1.jpg)\n\n```\n输入：head = [1,2,3,4]\n输出：[2,1,4,3]\n```\n\n**示例 2：**\n\n```\n输入：head = []\n输出：[]\n```\n\n**示例 3：**\n\n```\n输入：head = [1]\n输出：[1]\n```\n\n~~~cpp\n//两两进行交换，直到剩下最后一个为止，如果为奇数个则不交换最后一个\n~~~\n\n~~~cpp\n/**\n * Definition for singly-linked list.\n * struct ListNode {\n *     int val;\n *     ListNode *next;\n *     ListNode() : val(0), next(nullptr) {}\n *     ListNode(int x) : val(x), next(nullptr) {}\n *     ListNode(int x, ListNode *next) : val(x), next(next) {}\n * };\n */\nclass Solution {\npublic:\n    ListNode* swapPairs(ListNode* head) {\n        if(!head || !head->next) return head;\n        auto *p = head;\n        ListNode *q,*tmp,*h=new ListNode(0);\n        ListNode *pre = h;\n        head = head->next;\n        pre->next = p;\n        while(p){\n            if(p->next) \n            {  q=p->next; tmp=q->next;\n                //下面是交换\n                q->next = p;\n                p->next =tmp;\n                pre->next = q;                \n            }\n            pre = p;\n            p=p->next;            \n        }\n        return head;       \n    }\n};\n~~~\n\n### 25.K个一组翻转链表\n\n给你链表的头节点 `head` ，每 `k` 个节点一组进行翻转，请你返回修改后的链表。\n\n`k` 是一个正整数，它的值小于或等于链表的长度。如果节点总数不是 `k` 的整数倍，那么请将最后剩余的节点保持原有顺序。\n\n你不能只是单纯的改变节点内部的值，而是需要实际进行节点交换。\n\n**示例 1：**\n\n![img](https://assets.leetcode.com/uploads/2020/10/03/reverse_ex1.jpg)\n\n```\n输入：head = [1,2,3,4,5], k = 2\n输出：[2,1,4,3,5]\n```\n\n**示例 2：**\n\n![img](https://assets.leetcode.com/uploads/2020/10/03/reverse_ex2.jpg)\n\n```\n输入：head = [1,2,3,4,5], k = 3\n输出：[3,2,1,4,5]\n```\n\n~~~cpp\n/**\n思路 将节点进栈进行操作，然后取出栈内元素即为倒序\n**/\n~~~\n\n~~~cpp\n/**\n * Definition for singly-linked list.\n * struct ListNode {\n *     int val;\n *     ListNode *next;\n *     ListNode() : val(0), next(nullptr) {}\n *     ListNode(int x) : val(x), next(nullptr) {}\n *     ListNode(int x, ListNode *next) : val(x), next(next) {}\n * };\n */\nclass Solution {\npublic:\n    ListNode* reverseKGroup(ListNode* head, int k) {\n        if(!head) return nullptr;\n        stack<ListNode*> st;\n        ListNode *h=new ListNode(0);\n        ListNode *r = h,*p=head;\n        int sum=0;\n        while(p) { p=p->next;sum++;}\n        int n=sum/k,count = 0,js=0;        \n        while(head){\n            st.push(head);\n            head = head ->next;\n            count++;\n            if(count == k){\n                while(!st.empty()){\n                    auto c= st.top();\n                    st.pop();\n                    r->next = c;\n                    r=c;\n                }\n                count = 0;\n                js++;\n            }\n            if(js == n) break;     \n        }\n        if(js == n) r->next = head;\n        \n        return  h->next;\n    }\n};\n~~~\n\n### 138.随机链表的复制\n\n给你一个长度为 `n` 的链表，每个节点包含一个额外增加的随机指针 `random` ，该指针可以指向链表中的任何节点或空节点。\n\n构造这个链表的 **[深拷贝](https://baike.baidu.com/item/深拷贝/22785317?fr=aladdin)**。 深拷贝应该正好由 `n` 个 **全新** 节点组成，其中每个新节点的值都设为其对应的原节点的值。新节点的 `next` 指针和 `random` 指针也都应指向复制链表中的新节点，并使原链表和复制链表中的这些指针能够表示相同的链表状态。**复制链表中的指针都不应指向原链表中的节点** 。\n\n例如，如果原链表中有 `X` 和 `Y` 两个节点，其中 `X.random --> Y` 。那么在复制链表中对应的两个节点 `x` 和 `y` ，同样有 `x.random --> y` 。\n\n返回复制链表的头节点。\n\n用一个由 `n` 个节点组成的链表来表示输入/输出中的链表。每个节点用一个 `[val, random_index]` 表示：\n\n- `val`：一个表示 `Node.val` 的整数。\n- `random_index`：随机指针指向的节点索引（范围从 `0` 到 `n-1`）；如果不指向任何节点，则为 `null` 。\n\n你的代码 **只** 接受原链表的头节点 `head` 作为传入参数。\n\n**示例 1：**\n\n![img](https://assets.leetcode-cn.com/aliyun-lc-upload/uploads/2020/01/09/e1.png)\n\n```\n输入：head = [[7,null],[13,0],[11,4],[10,2],[1,0]]\n输出：[[7,null],[13,0],[11,4],[10,2],[1,0]]\n```\n\n**示例 2：**\n\n![img](https://assets.leetcode-cn.com/aliyun-lc-upload/uploads/2020/01/09/e2.png)\n\n```\n输入：head = [[1,1],[2,1]]\n输出：[[1,1],[2,1]]\n```\n\n**示例 3：**\n\n**![img](https://assets.leetcode-cn.com/aliyun-lc-upload/uploads/2020/01/09/e3.png)**\n\n```\n输入：head = [[3,null],[3,0],[3,null]]\n输出：[[3,null],[3,0],[3,null]]\n```','java刷力扣','http://62.234.62.75:9090/files/1708264795444-image.png','[\"Java\",\"算法\"]',11,'2024-01-23',46,2),(44,'使用Docker部署springboot-vue项目','@[TOC]\n# 使用Docker部署springboot-vue项目\n\n## 一、安装Docker\n\n### 1.手动安装docker\n\n1.卸载旧版本依赖\n\n~~~shell\nyum remove docker \\\n                  docker-client \\\n                  docker-client-latest \\\n                  docker-common \\\n                  docker-latest \\\n                  docker-latest-logrotate \\\n                  docker-logrotate \\\n                  docker-engine\n~~~\n\n2.设置仓库\n\n安装所需的软件包。yum-utils 提供了 yum-config-manager ，并且 device mapper 存储驱动程序需要 device-mapper-persistent-data 和 lvm2。\n\n~~~shell\nsudo yum install -y yum-utils device-mapper-persistent-data lvm2\n~~~\n\n使用以下命令来设置稳定的仓库。阿里云仓库\n\n~~~shell\nsudo yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo\n~~~\n\n3.安装最新版本的 Docker Engine-Community 和 containerd\n\n~~~shell\nsudo yum install docker-ce docker-ce-cli containerd.io\n~~~\n\n### 2.启动Docker\n\n~~~shell\nsystemctl start docker\n~~~\n\n验证docker是否安装成功\n\n~~~shell\ndocker version\n~~~\n\n![image-20240129212012610](C:\\Users\\wcf\\AppData\\Roaming\\Typora\\typora-user-images\\image-20240129212012610.png)\n\nDocker 需要用户具有 sudo 权限，为了避免每次命令都输入sudo，可以把用户加入 Docker 用户组（官方文档）\n\n~~~shell\nsudo usermod -aG docker $USER\n~~~\n\ndocker images：查看镜像文件\n\n### 3.开机自启\n\n~~~shell\nsystemctl enable docker\n~~~\n\n### 4.镜像加速\n\n~~~shell\nsudo mkdir -p /etc/docker\nsudo tee /etc/docker/daemon.json <<-\'EOF\'\n{\n  \"registry-mirrors\": [\"https://3n4m4jry.mirror.aliyuncs.com\"]\n}\nEOF\nsudo systemctl daemon-reload\nsudo systemctl restart docker\n~~~\n\n## 二、Docker安装mysql\n\n### 查看所有镜像\n\n~~~shell\ndocker images\n~~~\n\n### 查看所有进程\n\n~~~shell\ndocker ps -a\n~~~\n\n### 安装mysql\n\n~~~shell\ndocker pull mysql:5.7\n~~~\n\n### 启动mysql\n\n~~~shell\ndocker run -p 3306:3306 --name mysql \\\n-v /mydata/mysql/log:/var/log/mysql \\\n-v /mydata/mysql/data:/var/lib/mysql \\\n-v /mydata/mysql/conf:/etc/mysql \\\n-e MYSQL_ROOT_PASSWORD=root \\\n-d mysql:5.7\n\ndocker run -p 3308:3306 --name mysql #防止本地端口被本地mysql占用\n-e MYSQL_ROOT_PASSWORD=root \n-d mysql:5.7\n\n\ndocker run -p 3308:3306 --name mysql3308 --restart=always \\\n-v /mydata/mysql3308/log:/var/log/mysql \\\n-v /mydata/mysql3308/data:/var/lib/mysql \\\n-v /mydata/mysql3308/conf:/etc/mysql \\\n-e MYSQL_ROOT_PASSWORD=root \\\n-d mysql:5.7\n~~~\n\n**参数解释：**\n\n- --name 容器名字\n- -p 3308:3306 物理机端口：容器内部端口\n- -e 运行参数 初始化 root 用户的密码\n- -d 后台运行 mysq5.7 镜像名字加标签\n\n-v 目录挂载，**-v /mydata/mysql/log:/var/log/mysql** 表示将 docker里面mysql容器的**/var/log/mysql**目录挂载到宿主linux系统的 **/mydata/mysql/log**目录下，方便查看。\n\n### mysql修改密码\n\n~~~shell\nset password for root@62.234.62.75 = password(\'123456\');\n~~~\n\n### mysql首次使用必须设置访问权限\n\n~~~shell\nGRANT ALL PRIVILEGES ON *.* TO \'root\'@\'47.109.28.131\' IDENTIFIED BY \'你的密码\' WITH GRANT OPTION;\nGRANT ALL PRIVILEGES ON *.* TO \'root\'@\'62.234.62.75\' IDENTIFIED BY \'926424qq!\' WITH GRANT OPTION;\nFLUSH PRIVILEGES;\n~~~\n\n### 关闭容器\n\n~~~\ndocker stop [容器ID]\n~~~\n\n### 启动容器\n\n~~~\ndocker start [容器ID]\n~~~\n\n### 移除容器\n\n~~~shell\ndocker rm [容器ID]\n~~~\n\n### 进入容器\n\n~~~shell\n//进入mysql容器\ndocker exec -it 934e3c005153 /bin/bash  #934e3c005153容器编号\n\n//登录mysql\nmysql -uroot -proot\n\n\n~~~\n\n### Navicat使用阿里云镜像中mysql，换成自己映射的端口号即可\n\n## 三、前后端进行配置\n\n### 启动jar命令\n\n~~~shell\nchmod 777 0129.jar\nnohup java -jar 0129.jar & #后台启动\n~~~\n\n### 停止命令\n\n~~~shell\nkill -9 [进程号]\n~~~\n\n### 安装nginx\n\n#### 1.安装依赖和相关库\n\n~~~shell\nyum install gcc-c++ zlib-devel openssl-devel libtool\n~~~\n\n#### 2.下载nginx安装包并解压\n\n~~~shell\ncd /usr/local\nwget http://nginx.org/download/nginx-1.14.0.tar.gz\ntar -zxvf nginx-1.14.0.tar.gz\n~~~\n\n#### 3.配置和安装\n\n~~~shell\ncd nginx-1.14.0\n./configure --prefix=/usr/local/nginx\nmake && make install\n~~~\n\n#### 4.启动nginx\n\n~~~shell\n[root@62.234.62.75 nginx-1.14.0]#  cd ../nginx/sbin\n[root@62.234.62.75 sbin]#  ./nginx\n~~~\n\n#### 5.查看nginx\n\n~~~shell\n[root@62.234.62.75 nginx]#  ps -ef | grep nginx\n#一般安装在 /usr/local/nginx/conf\n~~~\n\n#### 6.nginx配置\n\n~~~nginx\n  server {\n       listen 8080;\n       server_name 62.234.62.75;\n       charset utf-8;\n      location / {\n        root /home/user/cf/vue/dist;\n        index index.html index.htm;\n        try_files $uri $uri/ /index.html;\n        add_header \'Access-Control-Allow-Origin\' \'*\';\n        add_header \'Access-Control-Allow-Methods\' \'GET, POST, OPTIONS, PUT, DELETE\';\n        add_header \'Access-Control-Allow-Headers\' \'DNT, X-Mx-ReqToken, Keep-Alive, User-Agent, X-Requested-With, If-Modified-Since, Cache-Control, Content-Type\';\n }\n    error_page 405 = 200@405;\n    location @405 {\n        proxy_method GET;\n        proxy_pass http://62.234.62.75:9090;\n    }\n}\n~~~\n\n#### 7.nginx重启\n\n~~~shell\nsudo netstat -tulpn | grep :80\nsudo kill -9 PID\nsudo /usr/local/nginx/sbin/nginx\n~~~\n\n## 四、Docker安装Redis \n\n#### 拉取Docker镜像\n\n~~~shell\ndocker pull redis:latest\n~~~\n\n#### 运行Redis容器\n\n~~~shell\ndocker run --name redis -p 6380:6379 -d redis:latest --requirepass \'xxxxxxx\'\n~~~\n\n#### 进入Redis容器\n\n~~~shell\ndocker exec -it 024eeab6bcaf redis-cli -a your_password\n~~~\n\n#### 备份本地Redis数据\n\n~~~redis\n62.234.62.75:6379> SAVE\nOK\n~~~\n\n#### 运行Redis容器\n\n~~~shell\n//首先将本地rdb上传到服务器中\ndocker run -d --name redis -p 6379:6379 -v /home/user/cf/dump.rdb:/data/dump.rdb redis:latest\n~~~\n\n#### 阿里云防火墙放行\n\n~~~shell\n/usr/local/etc/redis# cat redis.conf \n~~~\n\n## 五、安装java\n\n~~~shell\nsudo yum update\nsudo yum install java-1.8.0-openjdk-devel\n~~~\n\n','使用Docker部署springboot-vue项目','http://62.234.62.75:9090/files/1708320162699-image.png','[\"Docker\"]',11,'2024-01-31',191,12),(45,'西北大学844计算机类考研-25级初试高分攻略','@[TOC]\n# 西北大学844计算机类考研-25级初试高分攻略\n\n## 个人介绍\n\n​       本人是西北大学**22级软件工程研究生**，考研专业课**129分**，过去一年里在各大辅导机构任职，辅导考研学生专业课844，辅导总时长达**400小时**，辅导学生超过**20余人**，自编844考研笔记已经帮助**百余名学子**。\n\n## 版本更新 \n\n​      在23级、24级考研过程中，我陆续整理了第一版和第二版844考研笔记，笔记主要内容来源是844、851往年真题以及我给学生上课所整理的课件，通过400小时的辅导以及百余名学子的反馈，近两年对笔记不断优化，题目以及答案不断优化，已经逐步形成了249页的、比较专业的844考研笔记。\n\n## 专业课高分经验分享 \n\n**本人目前辅导超过20余名学生，总结科学复习844经验如下：**\n\n- 前期学习过程：前期学习的过程可以先看王道视频，计网、操作系统、数据结构等。\n\n- 中期刷题过程：1.数据结构本套笔记完全够刷，后续可补充耿国华课本每章节后的典型与提高以及课本例题即可；2.操作系统资料里有近十年真题以及典型例题，后续刷题可根据典型例题再去多找找类似的计算题做一下；3.计算机网络主要是考计算题，本套资料整理了9大类计算题，后续可针对性的找找这9类题进行训练。\n\n- 后期复习过程:**临考试前两个月不需要再刷任何新题，对刷过的题进行反复记忆、理解、背诵**。本套资料里有很多背诵性的概念题考点也有844常考的50道代码题，反复刷资料以及中期补充的计算题即可！\n\n  经过前期、中期、后期科学复习，**844计算机类综合初试125+** 不是什么问题！\n\n## 2025版笔记特点\n\n-  **结构清晰、答案规范、图表清晰、纯键盘输入、格式优美、11万字(共249页)** \n- 真题全面、涉及数据结构、计算机网络、操作系统能找到的所有真题。归纳了网数院845的计算机网络真题、3年的西北大学计算机网络期末题。还有给**某机构出的两套844考研卷及详细解析**\n- **解析全面，力求准确，对真题答案不断进行优化**，已经过**百余名**学子的检验，感谢大家反馈的意见，已优化。\n- **需要资料者，或者对资料里题目或者答案感觉有问题**，欢迎随时咨询，**vx：hello_chiyi** \n\n- 本笔记适用考研人群：**西北大学-计算机科学与技术(学硕-081200)； 西北大学-软件工程(学硕-083500)；西北大学-软件工程(专硕-085405)** \n\n## 2025版笔记购买\n[2025版笔记购买链接](https://m.tb.cn/h.5t2q6vI?tk=VZE2WkhXuj2)\n\n\n## 个人认为本笔记的突出作用\n\n- 帮助844考研学子获得更多844的相关信息，**打破自命题信息壁垒**。\n- 对历年真题进行了详细解析，**格式优美，纯机打**，考研学生不必为各种错误答案烦恼，**节省大家搜索时间**。\n- 对844初试涉及的所有知识点进行了整理，大家不用浪费时间再去自己整理，**节省大家总结时间以及降低试错成本**。\n\n## 2025级（第三版资料）优化内容\n![优化内容.png](http://62.234.62.75:9090/files/1708255642013-优化内容.png)\n## 资料相关图片\n![封面.jpg](http://62.234.62.75:9090/files/1708255698484-封面.jpg)\n<center>资料封面</center>\n\n![目录1.jpg](http://62.234.62.75:9090/files/1708255725910-目录1.jpg)\n<center>目录1</center>\n\n![目录2.jpg](http://62.234.62.75:9090/files/1708255776639-目录2.jpg)\n<center>目录2</center>\n\n![目录3.jpg](http://62.234.62.75:9090/files/1708255788967-目录3.jpg)\n<center>目录3</center>\n\n![节选.jpg](http://62.234.62.75:9090/files/1708255814521-节选.jpg)\n<center>内容节选</center>\n\n![节选2.jpg](http://62.234.62.75:9090/files/1708255824799-节选2.jpg)\n<center>内容节选</center>\n\n\n','有关西北大学计算机的考研攻略','http://62.234.62.75:9090/files/1708264757209-image.png','[\"844\",\"西北大学\",\"计算机考研\"]',11,'2024-02-18',42,10);
/*!40000 ALTER TABLE `blog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '分类名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='博客分类';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'编程语言'),(2,'算法学习'),(4,'操作系统'),(5,'数据库'),(6,'计算机网络'),(7,'设计模式'),(8,'Linux基础'),(10,'计算机考研'),(11,'校招面经分享'),(12,'技术分享');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `collect`
--

DROP TABLE IF EXISTS `collect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `collect` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `fid` int(11) DEFAULT NULL COMMENT '关联ID',
  `user_id` int(11) DEFAULT NULL COMMENT '收藏ID',
  `module` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '模块',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=206 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='收藏表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `collect`
--

LOCK TABLES `collect` WRITE;
/*!40000 ALTER TABLE `collect` DISABLE KEYS */;
INSERT INTO `collect` VALUES (33,9,9,'博客'),(56,4,1,'博客'),(134,9,1,'博客'),(190,19,10,'博客'),(191,3,10,'活动'),(196,6,10,'活动'),(202,9,10,'博客'),(205,25,10,'博客');
/*!40000 ALTER TABLE `collect` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '内容',
  `user_id` int(11) DEFAULT NULL COMMENT '评论人',
  `pid` int(11) DEFAULT NULL COMMENT '父级ID',
  `root_id` int(11) DEFAULT NULL COMMENT '根节点ID',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '评论时间',
  `fid` int(11) DEFAULT NULL COMMENT '关联ID也就是哪篇博客',
  `module` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '模块',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci ROW_FORMAT=DYNAMIC COMMENT='评论表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imsingle`
--

DROP TABLE IF EXISTS `imsingle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imsingle` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `content` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '内容',
  `fromuser` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发送人',
  `fromavatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发送人头像',
  `time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '时间',
  `type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '类型',
  `touser` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '接收人',
  `toavatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '接收人头像',
  `readed` int(10) DEFAULT '0' COMMENT '是否已读',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=316 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='单人聊天表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imsingle`
--

LOCK TABLES `imsingle` WRITE;
/*!40000 ALTER TABLE `imsingle` DISABLE KEYS */;
/*!40000 ALTER TABLE `imsingle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `fid` int(11) DEFAULT NULL COMMENT '关联ID',
  `user_id` int(11) DEFAULT NULL COMMENT '点赞ID',
  `module` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '模块',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=265 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='点赞表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES (66,14,1,'博客'),(80,3,1,'博客'),(99,8,9,'博客'),(197,7,10,'博客'),(201,17,11,'博客'),(203,7,12,'博客'),(213,3,10,'活动'),(215,7,10,'活动'),(223,6,10,'活动'),(232,9,10,'博客'),(234,14,11,'博客'),(248,30,11,'博客'),(249,28,11,'博客'),(264,25,10,'博客');
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notice`
--

DROP TABLE IF EXISTS `notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  `content` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '内容',
  `time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '创建时间',
  `user` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='公告信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notice`
--

LOCK TABLES `notice` WRITE;
/*!40000 ALTER TABLE `notice` DISABLE KEYS */;
INSERT INTO `notice` VALUES (1,'该论坛仅讨论计算机知识方面的问题，其他问题请勿讨论哦！','该论坛仅讨论计算机知识方面的问题，其他问题请勿讨论哦！','2023-09-05','admin'),(2,'844答疑专区请发帖在计算机考研专栏哦','844答疑专区请发帖在计算机考研专栏哦','2023-09-05','admin'),(3,'西北大学计算机学长，需要844考研资料可vx：hello_chiyi','西北大学计算机学长，需要844考研资料可vx：hello_chiyi','2023-09-05','admin');
/*!40000 ALTER TABLE `notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '密码',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '姓名',
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '头像',
  `role` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '角色标识',
  `sex` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '性别',
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电话',
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  `info` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '简介',
  `birth` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '生日',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='用户信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (9,'123','123','池儿','http://62.234.62.75:9090/files/1704983234579-20220914010326732.png.557.332.jpg','USER','男','18392945246','1256933608@qq.com','hello,你好，我是迟意','1999-05-24'),(10,'666','666','访客模式','http://62.234.62.75:9090/files/1708258461416-4a71306d68989d164b800c84964bec67.jpg','USER','男','18392945246','1256933608@qq.com','访客模式','1999-05-24'),(11,'888','888','迟意','http://62.234.62.75:9090/files/1705064298528-4a71306d68989d164b800c84964bec67.jpg','USER',NULL,'18392945246','1256933608@qq.com',NULL,NULL),(12,'999','999','hhh','http://62.234.62.75:9090/files/1705305842991-4a71306d68989d164b800c84964bec67.jpg','USER',NULL,'18392945246','1256933608@qq.com',NULL,NULL),(13,'111','111','hhh','http://62.234.62.75:9090/files/1705318964883-96907262.jfif','USER',NULL,'18392945246','1256933608@qq.com',NULL,NULL),(15,'1','1','heliotrope','http://62.234.62.75:9090/files/1706520057945-8fbe9108b50d48318a7dddafa955b517.jpeg','USER',NULL,NULL,NULL,NULL,NULL),(16,'2','2','2',NULL,'USER',NULL,NULL,NULL,NULL,NULL),(17,'3','3','3',NULL,'USER',NULL,NULL,NULL,NULL,NULL),(18,'4','4','4',NULL,'USER',NULL,NULL,NULL,NULL,NULL),(19,'5','5','5',NULL,'USER',NULL,NULL,NULL,NULL,NULL),(20,'6','6','6',NULL,'USER',NULL,NULL,NULL,NULL,NULL),(21,'7','7','7',NULL,'USER',NULL,NULL,NULL,NULL,NULL),(22,'8','8','8',NULL,'USER',NULL,NULL,NULL,NULL,NULL),(23,'9','9','9',NULL,'USER',NULL,NULL,NULL,NULL,NULL),(24,'10','10','10','http://62.234.62.75:9090/files/1706520324368-8fbe9108b50d48318a7dddafa955b517.jpeg','USER',NULL,NULL,NULL,NULL,NULL),(25,'11','11','11',NULL,'USER',NULL,NULL,NULL,NULL,NULL),(26,'12','12','12',NULL,'USER',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-02-19 14:51:00
