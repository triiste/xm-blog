"use strict";(self["webpackChunkvue"]=self["webpackChunkvue"]||[]).push([[372],{2372:function(t,e,r){r.r(e),r.d(e,{default:function(){return p}});var o=function(){var t=this,e=t._self._c;return e("div",{staticStyle:{width:"50%",margin:"5px auto"}},[e("div",{staticClass:"card",staticStyle:{"margin-bottom":"100px"}},[e("div",{staticStyle:{"font-weight":"bold","font-size":"24px","margin-bottom":"50px"}},[t._v("发表新博客/编辑博客")]),e("el-form",{ref:"formRef",staticStyle:{"padding-right":"50px"},attrs:{model:t.form,"label-width":"100px",rules:t.rules}},[e("el-form-item",{attrs:{label:"标题",prop:"title"}},[e("el-input",{attrs:{placeholder:"标题"},model:{value:t.form.title,callback:function(e){t.$set(t.form,"title",e)},expression:"form.title"}})],1),e("el-form-item",{attrs:{label:"简介",prop:"descr"}},[e("el-input",{attrs:{type:"textarea",placeholder:"简介"},model:{value:t.form.descr,callback:function(e){t.$set(t.form,"descr",e)},expression:"form.descr"}})],1),e("el-form-item",{attrs:{label:"封面",prop:"cover"}},[e("el-upload",{attrs:{action:"http://47.109.28.131:9090/files/upload",headers:{token:t.user.token},"list-type":"picture","on-success":t.handleCoverSuccess}},[e("el-button",{attrs:{type:"primary"}},[t._v("上传封面")])],1)],1),e("el-form-item",{attrs:{label:"分类",prop:"categoryId"}},[e("el-select",{staticStyle:{width:"100%"},model:{value:t.form.categoryId,callback:function(e){t.$set(t.form,"categoryId",e)},expression:"form.categoryId"}},t._l(t.categoryList,(function(t){return e("el-option",{key:t.id,attrs:{value:t.id,label:t.name}})})),1)],1),e("el-form-item",{attrs:{label:"标签",prop:"tags"}},[e("el-select",{staticStyle:{width:"100%"},attrs:{multiple:"",filterable:"","allow-create":"","default-first-option":""},model:{value:t.tagsArr,callback:function(e){t.tagsArr=e},expression:"tagsArr"}},[e("el-option",{attrs:{value:"后端"}}),e("el-option",{attrs:{value:"Java"}}),e("el-option",{attrs:{value:"面试"}}),e("el-option",{attrs:{value:"Vue"}}),e("el-option",{attrs:{value:"前端"}}),e("el-option",{attrs:{value:"大数据"}}),e("el-option",{attrs:{value:"算法"}}),e("el-option",{attrs:{value:"程序员"}}),e("el-option",{attrs:{value:"小白"}})],1)],1),e("el-form-item",{staticStyle:{"max-height":"300px","overflow-y":"auto"},attrs:{label:"文章内容",prop:"content"}},[e("mavon-editor",{ref:"md",attrs:{ishljs:!0},on:{imgAdd:t.imgAdd},model:{value:t.form.content,callback:function(e){t.$set(t.form,"content",e)},expression:"form.content"}})],1)],1),e("div",{staticStyle:{"text-align":"center"}},[e("el-button",{staticStyle:{width:"100px"},attrs:{type:"primary",size:"medium"},on:{click:t.save}},[t._v("保 存")])],1)],1)])},a=[],s=r(7438),l=r.n(s),i=r(5792),d=r(4161),n={name:"NewBlog",data(){return{form:{},user:JSON.parse(localStorage.getItem("xm-user")||"{}"),rules:{},tagsArr:[],categoryList:[],editor:null,blogId:this.$route.query.blogId}},mounted(){this.$request.get("/category/selectAll").then((t=>{this.categoryList=t.data||[]})),this.$request.get("/blog/selectById/"+this.blogId).then((t=>{this.form=t.data||{},this.form.id&&(this.tagsArr=JSON.parse(this.form.tags||"[]"))}))},methods:{save(){this.$refs.formRef.validate((t=>{t&&(this.form.tags=JSON.stringify(this.tagsArr),this.$request({url:this.form.id?"/blog/update":"/blog/add",method:this.form.id?"PUT":"POST",data:this.form}).then((t=>{"200"===t.code?this.$message.success("保存成功"):this.$message.error(t.msg)})))}))},handleCoverSuccess(t){this.form.cover=t.data},setRichText(){this.$nextTick((()=>{this.editor=new(l())("#editor"),this.editor.highlight=i.Z,this.editor.config.uploadImgServer="http://47.109.28.131:9090/files/editor/upload",this.editor.config.uploadFileName="file",this.editor.config.uploadImgHeaders={token:this.user.token},this.editor.config.uploadImgParams={type:"img"},this.editor.config.zIndex=0,this.editor.create()}))},imgAdd(t,e){let r=this.$refs.md;const o=new FormData;o.append("file",e),(0,d.Z)({url:"http://47.109.28.131:9090/files/editor/upload",method:"post",data:o,headers:{"Content-Type":"multipart/form-data"}}).then((e=>{var o=e.data.data[0].url;r.$img2Url(t,o)}))}}},c=n,m=r(3736),u=(0,m.Z)(c,o,a,!1,null,"dbb5de80",null),p=u.exports}}]);
//# sourceMappingURL=372.00c9bb60.js.map