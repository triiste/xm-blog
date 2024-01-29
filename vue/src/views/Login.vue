<template>
  <div class="container">
    <div style="width: 380px; padding: 30px 30px; background-color: rgba(255, 255, 255, 0.4);; border-radius: 5px;">
      <div style="text-align: center; font-size: 24px; margin-bottom: 30px; color:#000b17; text-shadow: 0 0 10px rgba(53,217,81,0.33);">
        计算机交流论坛
      </div>
      <el-form :model="form" :rules="rules" ref="formRef">
        <el-form-item prop="username">
          <el-input size="medium" prefix-icon="el-icon-user" placeholder="请输入账号" v-model="form.username"></el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input size="medium" prefix-icon="el-icon-lock" placeholder="请输入密码" show-password  v-model="form.password"></el-input>
        </el-form-item>
        <el-form-item prop="role">
          <el-radio-group v-model="form.role">
            <el-radio label="ADMIN">管理员</el-radio>
            <el-radio label="USER">用户</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item prop="code">
          <div style="display: flex">
            <el-input style="flex: 1" size="medium" v-model="code"></el-input>
            <Identify :identifyCode="identifyCode" @click.native="refreshCode" />
          </div>
        </el-form-item>
        <el-form-item>
          <el-button size="medium" style="width: 100%; background-color: #2a60c9; border-color: #2a60c9; color: white" @click="login">登 录</el-button>
        </el-form-item>
        <div style="display: flex; align-items: center">
          <div style="flex: 1"></div>
          <div style="flex: 1; text-align: right">

          </div>
        </div>
        <div style="display: flex; align-items: center">

          <el-button style="margin-left: 5px; font-size: 14px; color: green; font-weight: bold; background-color: transparent; border: none;" @click="visit">访客直接进入</el-button>

          <div style="flex: 1; text-align: right">

            还没有账号？请 <a href="/register">注册</a>
          </div>
        </div>
      </el-form>
    </div>
  </div>
</template>

<script>
import Identify from "@/components/Identify";

export default {
  name: "Login",
  components: {
    Identify
  },
  data() {
    return {
      form: { role: 'USER' },
      form1: { role: 'USER' },
      rules: {
        username: [
          { required: true, message: '请输入账号', trigger: 'blur' },
        ],
        password: [
          { required: true, message: '请输入密码', trigger: 'blur' },
        ]
      },
      code: '',   // 表单绑定的验证码
      // 图片验证码
      identifyCode: '',
      // 验证码规则
      identifyCodes: '123456789ABCDEFGHGKMNPQRSTUVWXY',
    }
  },
  mounted() {
    this.refreshCode()
  },
  methods: {
    // 切换验证码
    refreshCode() {
      this.identifyCode = ''
      this.makeCode(this.identifyCodes, 4)
    },
    // 生成随机验证码
    makeCode(o, l) {
      for (let i = 0; i < l; i++) {
        this.identifyCode += this.identifyCodes[Math.floor(Math.random() * (this.identifyCodes.length))]
      }
    },
    visit(){
      this.form1.username = '666'
      this.form1.password = '666'
      this.$request.post('/login', this.form1).then(res => {
        console.log("到这没1有")

        if (res.code === '200') {
          console.log("到这没2有")
          localStorage.setItem("xm-user", JSON.stringify(res.data))  // 存储用户数据
          this.$message.success('访客模式')
          setTimeout(() => {
            // 跳转主页通过location,可能导致前台变黑，闪屏
            location.href = '/front/home'
          }, 500)
          // 延时500ms
        }
      })
    },
    login() {
      if (!this.code) {
        this.$message.warning('请输入验证码')
        this.refreshCode()
        return
      }
      if (this.code.toLowerCase() !== this.identifyCode.toLowerCase()) {
        this.$message.warning('验证码错误')
        this.refreshCode()
        return
      }
      this.$refs['formRef'].validate((valid) => {
        if (valid) {
          // 验证通过
          this.$request.post('/login', this.form).then(res => {
            if (res.code === '200') {
              localStorage.setItem("xm-user", JSON.stringify(res.data))  // 登录之后在本地存储用户数据
              this.$message.success('登录成功')


              setTimeout(() => {
                // 跳转主页通过location,可能导致前台变黑，闪屏
                if (res.data.role === 'ADMIN') {
                  location.href = '/home'
                } else {
                  location.href = '/front/home'
                }
              }, 500)
              // 延时500ms
            } else {
              this.refreshCode()  //给用户试错成本 不能一个一个去试
              this.$message.error(res.msg)
            }
          })
        }
      })
    }
  }
}
</script>

<style scoped>
.container {
  height: 100vh;
  overflow: hidden;
  background-image: url("@/assets/imgs/deng.jpg");
  /*background-size: 100%;*/
  background-size: cover;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #666;
}
a {
  color: #2a60c9;
}
</style>