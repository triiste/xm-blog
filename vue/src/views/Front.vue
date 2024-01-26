<template>
  <div>
    <div class="front-notice"><i class="el-icon-bell" style="margin-right: 2px"></i>公告：{{ top }}</div>
    <!--头部-->
    <div class="front-header">
      <div class="front-header-left">
        <img src="@/assets/imgs/computer.png" alt="">
        <div class="title">计算机交流论坛</div>
      </div>
      <div class="front-header-center">
        <div class="front-header-nav">
          <el-menu :default-active="$route.path" mode="horizontal" router>
						<el-menu-item index="/front/home">首页</el-menu-item>
            <el-menu-item index="/front/activity" v-if="this.user.username !== '666'">活动中心</el-menu-item>
						<el-menu-item index="/front/person" v-if="this.user.username !== '666'">个人中心</el-menu-item>
          </el-menu>
        </div>
      </div>
      <div>
        <el-input style="width: 260px; margin-right: 10px" placeholder="请输入博客内容" v-model="content" clearable></el-input>
        <el-input style="width: 140px; margin-right: 10px" placeholder="请输入博客标题" v-model="title" clearable></el-input>
        <el-input style="width: 140px; margin-right: 10px" placeholder="请输入博客标签" v-model="tags" clearable></el-input>
        <el-input style="width: 140px; margin-right: 10px" placeholder="请输入博主名称" v-model="userName" clearable></el-input>
        <el-button type="success" @click="goSearch">搜 索</el-button>
        <el-button type="warning" plain style="margin-left: 10px" @click="reset">重置</el-button>

      </div>

      <div class="front-header-right">
        <div v-if="!user.username">
          <el-button @click="$router.push('/login')">登录</el-button>
          <el-button @click="$router.push('/register')">注册</el-button>
        </div>
        <div v-else>
          <el-dropdown>
            <div class="front-header-dropdown">
              <img :src="user.avatar" alt="">
              <div style="margin-left: 10px">
                <span style="color: #FFF">{{ user.name }}</span><i class="el-icon-arrow-down" style="margin-left: 5px"></i>
              </div>
            </div>
            <el-dropdown-menu slot="dropdown">
              <el-dropdown-item>
<!--                <div style="text-decoration: none" @click="edit"><a herf="/front/person">修改信息</a></div>-->
                <div style="text-decoration: none" @click="logout">退出</div>
              </el-dropdown-item>
            </el-dropdown-menu>
          </el-dropdown>
        </div>
      </div>
    </div>
    <!--主体-->
    <div class="main-body">
      <router-view ref="child" @update:user="updateUser" />
    </div>
  </div>

</template>

<script>

export default {
  name: "FrontLayout",

  data () {
    return {
      top: '',
      notice: [],
      user: JSON.parse(localStorage.getItem("xm-user") || '{}'),
      title:this.$route.query.title === 'undefined'?'':this.$route.query.title,
      userName:this.$route.query.userName === 'undefined'?'':this.$route.query.userName,
      tags:this.$route.query.tags === 'undefined' ? '': this.$route.query.tags,
      content:this.$route.query.content === 'undefined' ? '': this.$route.query.content,
    }
  },

  mounted() {
    this.loadNotice()
  },
  methods: {
    goSearch(){
      location.href = '/front/search?title=' + this.title +'&&userName='+this.userName +'&&tags='+this.tags +'&&content='+this.content
    },
    loadNotice() {
      this.$request.get('/notice/selectAll').then(res => {
        this.notice = res.data
        let i = 0
        if (this.notice && this.notice.length) {
          this.top = this.notice[0].content
          setInterval(() => {
            this.top = this.notice[i].content
            i++
            if (i === this.notice.length) {
              i = 0
            }
          }, 2500)
        }
      })
    },
    updateUser() {
      this.user = JSON.parse(localStorage.getItem('xm-user') || '{}')   // 重新获取下用户的最新信息
    },
    // 退出登录
    logout() {
      localStorage.removeItem("xm-user");
      this.$router.push("/login");
    },
    reset() {
      this.title = ''
      this.tags = ''
      this.content = ''
      this.userName = ''
      location.href = '/front/search?title=' + this.title +'&&userName='+this.userName +'&&tags='+this.tags +'&&content='+this.content
    },
  }

}
</script>

<style scoped>
  @import "@/assets/css/front.css";
</style>