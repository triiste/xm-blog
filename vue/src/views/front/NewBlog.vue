<template>
  <div style="width: 50%; margin: 5px auto">
    <div class="card" style="margin-bottom: 100px">
      <div style="font-weight: bold; font-size: 24px; margin-bottom: 50px">发表新博客/编辑博客</div>
      <el-form :model="form" label-width="100px" style="padding-right: 50px" :rules="rules" ref="formRef">
        <el-form-item label="标题" prop="title">
          <el-input v-model="form.title" placeholder="标题"></el-input>
        </el-form-item>
        <el-form-item label="简介" prop="descr">
          <el-input type="textarea" v-model="form.descr" placeholder="简介"></el-input>
        </el-form-item>
        <el-form-item label="封面" prop="cover">
          <div style="display: flex;">
            <el-upload
                :action="'http://127.0.0.1:9090' + '/files/upload'"
                :headers="{ token: user.token }"
                list-type="picture"
                :on-success="handleCoverSuccess"
            >
              <el-button type="primary">上传封面</el-button>
            </el-upload>

            <el-button type="primary" @click="generateCover" style="margin-left: 5px">生成封面</el-button>
          </div>

          <canvas v-if="showCanvas" ref="coverCanvas" width="300" height="150" style="margin-top: 5px;"></canvas>
        </el-form-item>

        <el-form-item label="分类" prop="categoryId">
          <el-select v-model="form.categoryId" style="width: 100%">
            <el-option v-for="item in categoryList" :key="item.id" :value="item.id" :label="item.name"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="标签" prop="tags">
          <el-select v-model="tagsArr" multiple filterable allow-create default-first-option style="width: 100%">
            <el-option value="Java"></el-option>
            <el-option value="Docker"></el-option>
            <el-option value="Redis"></el-option>
            <el-option value="Mysql"></el-option>
            <el-option value="SpingBoot"></el-option>
            <el-option value="vue"></el-option>
            <el-option value="LeetCode"></el-option>
            <el-option value="算法"></el-option>
<!--            <el-option value="小白"></el-option>-->
          </el-select>
        </el-form-item>
<!--        <el-form-item label="内容" prop="content">-->
<!--          <div id="editor"></div>-->
<!--        </el-form-item>-->
<!--        style="height: 200px"-->
        <el-form-item label="文章内容" prop="content" style="max-height: 300px; overflow-y: auto">
          <mavon-editor ref="md" v-model="form.content" :ishljs="true" @imgAdd="imgAdd"/>
        </el-form-item>


      </el-form>
      <div style="text-align: center"><el-button type="primary" size="medium" style="width: 100px" @click="save">保 存</el-button></div>

    </div>

    <Footer />
  </div>
</template>

<script>
// import E from "wangeditor";
import hljs from "highlight.js";
import axios from "axios";
import Footer from "@/components/Footer";
import markdownIt from 'markdown-it';
import mavonEditor from 'mavon-editor';


export default {
  components: {
    Footer
  },
  name: "NewBlog",
  data() {
    return {
      form: {},
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      rules: {},
      tagsArr: [],
      categoryList: [],
      editor: null,
      blogId: this.$route.query.blogId,
      imageDataURL:'',
      showCanvas: false, // 初始时不显示 canvas
    }
  },
  mounted() {

    this.$request.get('/category/selectAll').then(res => {
      this.categoryList = res.data || []
    })

    this.$request.get('/blog/selectById/' + this.blogId).then(res => {
      this.form = res.data || {}
      if (this.form.id) {
        this.tagsArr = JSON.parse(this.form.tags || '[]')
        // setTimeout(() => {
        //   this.editor.txt.html(this.form.content)
        // }, 0)
      }
    })
    // this.setRichText()
  },
  methods: {
    generateCover() {

      console.log(this.tagsArr)
      if(this.tagsArr.length === 0){
        this.$notify.error("请先输入标签!")
        return
      }
      this.showCanvas = true;
      this.$nextTick(() => {
        const canvas = this.$refs.coverCanvas;
        const context = canvas.getContext("2d");
        context.clearRect(0, 0, canvas.width, canvas.height);

        // 生成随机背景颜色（蓝色或绿色）
        const randomColor = Math.random() < 0.5 ? "#007acc" : "#00a854"; // 蓝色或绿色



        // 设置背景颜色
        context.fillStyle = randomColor;
        context.fillRect(0, 0, canvas.width, canvas.height);
        var randomNumber = Math.floor(Math.random() * this.tagsArr.length);
        // 添加标签文本
        const text = "#"+this.tagsArr[randomNumber];
        context.font = "bold 48px Arial"; // 调整字体大小
        context.fillStyle = "#000"; // 设置文字颜色为黑色
        // 计算文本宽度和高度
        const textMetrics = context.measureText(text);
        const textWidth = textMetrics.width;
        const textHeight = textMetrics.actualBoundingBoxAscent + textMetrics.actualBoundingBoxDescent;

// 设置文本位置为画布中心
        const centerX = canvas.width / 2 - textWidth / 2;
        const centerY = canvas.height / 2 + textHeight / 2;
        context.fillText(text, centerX, centerY);
        // 将生成的图片保存为DataURL
        this.imageDataURL = canvas.toDataURL("image/png");
      });
    },

    uploadGeneratedImage(imageDataURL) {
      const imageData = imageDataURL.split(',')[1];
      const binaryImageData = atob(imageData);
      const arrayBuffer = new ArrayBuffer(binaryImageData.length);
      const uint8Array = new Uint8Array(arrayBuffer);
      for (let i = 0; i < binaryImageData.length; i++) {
        uint8Array[i] = binaryImageData.charCodeAt(i);
      }
      // 使用 File 对象创建 FormData
      const file = new File([new Blob([arrayBuffer], { type: 'image/png' })], 'image.png', { type: 'image/png' });
      const formData = new FormData();
      formData.append('file', file);
      axios({
        url: 'http://127.0.0.1:9090/files/editor/upload',
        method: 'post',
        data: formData,
        headers: {'Content-Type': 'multipart/form-data'},
      }).then((res) => {
        // 在Markdown文本中插入图片

        var url = res.data.data[0].url

        this.form.cover = url
        // this.$notify.error(this.form.cover)
        // console.log("正在执行中"+url);
        // $vm.$img2Url(pos, url);
      });
    },

    async save() {   // 保存按钮触发的逻辑  它会触发新增或者更新
      if(this.imageDataURL !== ''){
        console.log("执行了没有")
        this.uploadGeneratedImage(this.imageDataURL);
        await  new Promise(resolve => setTimeout(resolve,200));
      }
      console.log("cishide "+this.form.cover)
      this.$refs.formRef.validate((valid) => {
        if (valid) {
          this.form.tags = JSON.stringify(this.tagsArr)  // 把json数组转换成json字符串存到数据库
          // this.form.content = this.editor.txt.html()
          this.$request({
            url: this.form.id ? '/blog/update' : '/blog/add',
            method: this.form.id ? 'PUT' : 'POST',
            data: this.form
          }).then(res => {
            if (res.code === '200') {  // 表示成功保存
              if(!this.form.id){
                // console.log(res.data)
                this.$message.success('发布成功')
                setTimeout(() => {
                  location.href = "/front/blogDetail?blogId="+parseInt(res.data.id)
                },500)
              }else{
                this.$message.success('保存成功')
                setTimeout(() => {
                  location.href = "/front/blogDetail?blogId="+this.form.id
                }, 500)
              }
            } else {
              this.$message.error(res.msg)  // 弹出错误的信息
            }
          })
        }
      })
    },
    handleCoverSuccess(res) {
      this.form.cover = res.data
    },
    setRichText() {
      this.$nextTick(() => {
        this.editor = new E(`#editor`)
        this.editor.highlight = hljs
        this.editor.config.uploadImgServer = 'http://127.0.0.1:9090' + '/files/editor/upload'
        this.editor.config.uploadFileName = 'file'
        this.editor.config.uploadImgHeaders = {
          token: this.user.token
        }
        this.editor.config.uploadImgParams = {
          type: 'img',
        }
        this.editor.config.zIndex = 0
        this.editor.create()  // 创建
      })
    },
    // 绑定@imgAdd event
      imgAdd(pos, $file) {
      let $vm = this.$refs.md
      // 第一步.将图片上传到服务器.
      const formData = new FormData();
      formData.append('file', $file);
      axios({
        url: 'http://127.0.0.1:9090/files/editor/upload',
        method: 'post',
        data: formData,
        headers: {'Content-Type': 'multipart/form-data'},
      }).then((res) => {
        // 在Markdown文本中插入图片
        var url = res.data.data[0].url
        // console.log(url)
        // const markdownText = `http://127.0.0.1:9090/files/1705996022610-头像.jpg`;
        $vm.$img2Url(pos, url);
      })
    },
  }
}
</script>

<style scoped>
/* 根据需要调整高度 */
.el-form-item__content .mavon-editor {
  max-height: 300px !important;
  overflow-y: auto !important; /* 添加垂直滚动条 */
}
</style>