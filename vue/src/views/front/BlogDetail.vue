<template>
  <div class="main-content main">
    <div style="display: flex; grid-gap: 10px">
<!--      width: 0是为了限制宽度-->
      <div style="flex: 1;width: 0" >
      <div class="card" style="padding: 30px; margin-bottom: 10px; ">
          <div style="font-weight: bold; font-size: 24px; margin-bottom: 20px">{{ blog.title }}</div>
          <div style="color: #666; margin-bottom: 10px">
            <span style="margin-right: 20px"><i class="el-icon-user"></i> {{ blog.userName }}</span>
            <span style="margin-right: 20px"><i class="el-icon-date"></i> {{ blog.date }}</span>
            <span style="margin-right: 20px"><i class="el-icon-eye"></i> {{ blog.readCount }}</span>
            <span>
              <el-tag v-for="item in tagsArr" :key="item" type="primary" style="margin-right:5px">{{ item }}</el-tag>
            </span>

            <span v-if="blog.userId == this.user.id" style="margin-left: 40px; color: #2a60c9; cursor: pointer" @click="editBlog(blog.id)"><i class="el-icon-edit"></i>编辑</span>
            <span v-if="blog.userId == this.user.id" style="margin-left: 10px; color: red; cursor: pointer" @click="del(blog.id)"><i class="el-icon-delete"></i>删除</span>
          </div>
          <mavon-editor
              ref="mavonEditor"
              class="md"
              :value="blog.content"
              :subfield="false"
              :defaultOpen="'preview'"
              :toolbarsFlag="false"
              :editable="false"
              :scrollStyle="true"
              :ishljs="true"

          />

        </div>

        <button @click="scrollToTop" class="rocket-button"></button>

        <!--     点赞和收藏数据   -->
        <div class="card" style="text-align: center; font-size: 20px; color: #666; margin-bottom: 10px;">
          <span style="margin-right: 20px; cursor: pointer;" @click="setLikes" :class="{ 'active' : blog.userLike }"><i class="el-icon-like"></i> {{ blog.likesCount }}</span>
          <span style=" cursor: pointer"  @click="setCollect" :class="{ 'active' : blog.userCollect }"><i class="el-icon-star-off"></i> {{ blog.collectCount }}</span>
        </div>
      <!--评论-->
        <comment :fid="blogId" module="博客" ></comment>
      </div>

      <div style="width: 260px">
        <div class="card" style="margin-bottom: 10px">
          <div style="display: flex; align-items: center; grid-gap: 10px; margin-bottom: 10px">
            <img :src="blog.user?.avatar" alt="" style="width: 50px; height: 50px; border-radius: 50%">
            <div style="flex: 1;">
              <div style="font-weight: bold; margin-bottom: 5px">{{ blog.user?.name }}</div>
              <div style="color: #666; font-size: 13px" class="line2">{{ blog.user?.info }}</div>
            </div>
          </div>

          <div style="display: flex">
            <div style="flex: 1; text-align: center">
              <div style="margin-bottom: 5px">文章</div>
              <div style="color: #888">{{blog.user?.blogCount}}</div>
            </div>
            <div style="flex: 1; text-align: center">
              <div style="margin-bottom: 5px">点赞</div>
              <div style="color: #888">{{blog.user?.likesCount}}</div>
            </div>
            <div style="flex: 1; text-align: center">
              <div style="margin-bottom: 5px">收藏</div>
              <div style="color: #888">{{blog.user?.collectCount}}</div>
            </div>
          </div>
        </div>

        <div class="card" style="margin-bottom: 10px">
          <div style="font-weight: bold; font-size: 20px; padding-bottom: 10px; border-bottom: 1px solid #ddd; margin-bottom: 10px">相关推荐</div>

          <div>
            <div style="margin-bottom: 15px" v-for="item in recommendList" :key="item.id">
              <a :href="'/front/blogDetail?blogId=' + item.id" target="_blank"><div class="recommend-title line2">{{ item.title }}</div></a>
              <div style="color: #888">
                <span>阅读</span> <span>{{ item.readCount }}</span>
                <span style="margin-left: 10px">点赞</span> <span>{{ item.likesCount }}</span>
              </div>
            </div>
          </div>
        </div>

        <!--      广告贴-->
        <div class="card">
          <div style="display: flex;grid-gap: 10px;align-items: center">
            <div style="flex: 1;line-height: 20px">
              <font style="color:cadetblue">西北大学计算机学长,需要计算机考研资料或者一对一辅导请添加哦！😊😊😊</font>
            </div>
            <img src="@/assets/imgs/广告.png" alt="" style="width: 60px;height: 60px; border-radius: 5px">
          </div>
        </div>
        <!--      广告贴结束-->

      </div>



    </div>

    <Footer />
  </div>
</template>

<script>
import Footer from "@/components/Footer";
import Comment from "@/components/Comment";

export default {
  name: "BlogDetail",
  components: {
    Comment,
    Footer
  },
  data() {
    return {
      blogId: this.$route.query.blogId,
      blog: {},
      tagsArr: [],
      recommendList: [],
      user: JSON.parse(localStorage.getItem("xm-user") || '{}'),

    }
  },
  created() {

    this.load()
    this.$request.put('/blog/updateReadCount/' + this.blogId)

    // this.loadComment()
  },
  methods: {
    scrollToTop() {
      // 使用JavaScript实现平滑滚动回到页面顶部
      window.scrollTo({
        top: 0,
        behavior: 'smooth',
      });
    },


    setLikes() {
      this.$request.post('/likes/set', {  fid: this.blogId, module: '博客' }).then(res => {
        if (res.code === '200') {

          this.load()  // 重新加载数据
        }
      })
    },
    setCollect() {
      this.$request.post('/collect/set', {  fid: this.blogId, module: '博客' }).then(res => {
        if (res.code === '200') {
          // this.$message.success('操作成功')

          this.load()  // 重新加载数据
        }
      })
    },

    editBlog(blogId) {
      window.open('/front/newBlog?blogId=' + blogId)
    },
    del(id) {   // 单个删除
      this.$confirm('您确定删除吗？', '确认删除', {type: "warning"}).then(response => {
        this.$request.delete('/blog/delete/' + id).then(res => {
          if (res.code === '200') {   // 表示操作成功
            this.$message.success('操作成功')
            window.open('/front/home')
          } else {
            this.$message.error(res.msg)  // 弹出错误的信息
          }
        })
      }).catch(() => {
      })
    },
    load() {
      this.$request.get('/blog/selectById/' + this.blogId).then(res => {
        this.blog = res.data || {}
        // console.log(this.blog)
        this.tagsArr = JSON.parse(this.blog.tags || '[]')
      })


      this.$request.get('/blog/selectRecommend/' + this.blogId).then(res => {
        this.recommendList = res.data || []
      })
    }
  }
}
</script>

<style>
/* blockquote 样式 */
blockquote {
  display: block;
  border-left: 8px solid #d0e5f2;
  padding: 20px 10px;
  margin: 10px 0;
  line-height: 1.4;
  font-size: 100%;
  background-color: #f1f1f1;
}

/* code 样式 */
code {
  display: inline-block;
  *display: inline;
  *zoom: 1;
  background-color: #f1f1f1;
  border-radius: 3px;
  padding: 3px 5px;
  margin: 0 3px;
}
pre code {
  display: block;
}
p {
  line-height: 30px
}

.active {
  color: orange !important;
}
.recommend-title {
  margin-bottom: 5px;
}
.recommend-title:hover {
  color: #2a60c9;
}
.comment-active {
  color: #2a60c9;
}
p {
  white-space: pre-wrap; /*css-3*/
  white-space: -moz-pre-wrap; /*Mozilla,since1999*/
  white-space: pre-wrap; /*Opera4-6*/
  white-space: -o-pre-wrap; /*Opera7*/
  word-wrap: break-word; /*InternetExplorer5.5+*/
}
.rocket-button {
  position: fixed;
  bottom: 140px;
  right: 250px;
  width: 40px;
  height: 40px;
  background-color: rgba(0, 123, 255, 0); /* 设置按钮背景颜色 */
  border: none; /* 去掉按钮边框 */
  border-radius: 50%; /* 设置按钮为圆形 */
  cursor: pointer;
  background-image: url("@/assets/imgs/rocket.png");; /* 设置火箭图标路径 */
  background-size: cover; /* 图标大小适应按钮 */
  background-repeat: no-repeat; /* 防止图标重复显示 */
  content: ''; /* 伪元素，防止按钮内容被覆盖 */
}

pre {
  background-color: rgb(40,44,52) !important; /* 深灰色背景 */
  color: #cccccc; /* 白色文本 */
  padding: 10px; /* 内边距 */
  border-radius: 5px; /* 圆角边框，可选 */
  overflow: auto; /* 添加滚动条 */
}

/* 设置代码块中的行号样式 */
pre code {
  line-height: 1.5; /* 行高，根据需要调整 */
}
.hljs {
  background-color: rgb(40,44,52) !important; /* 深灰色背景 */
  color: #cccccc !important; /* 白色文本 */
  padding: 10px; /* 内边距 */
  border-radius: 5px; /* 圆角边框，可选 */
  overflow: auto; /* 添加滚动条 */
  font-size: 18px !important;
}
.hljs-title{
  color: #00ffff !important;
}
.hljs-number{
  color: #13ce66 !important;
}
/* 设置 hljs 类代码块中的行号样式 */
.hljs code {
  line-height: 1.5; /* 行高，根据需要调整 */
}

.hljs-string{
  color: #9cd580 !important;
}
.hljs-attribute{
  color: #00ffff !important;
}
.hljs-meta{
  color: #9cd580 !important;
}
.hljs-literal{
  color: #9B5146 !important;
}


</style>