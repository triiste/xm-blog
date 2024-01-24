<template>
  <div>
    <div class="card" style="min-height: 80vh">
      <div class="blog-box" v-for="item in tableData" :key="item.id" v-if="total > 0">
        <div style="flex: 1; width: 0">
          <a :href="'/front/blogDetail?blogId=' + item.id" target="_blank"><div class="blog-title">{{ item.title }}</div></a>
          <div class="line2" style="color: #666; margin-bottom: 10px; font-size: 13px" v-html="item.descr" ></div>
          <div style="display: flex; align-items: center">
            <div style="flex: 1; font-size: 13px">
              <span style="color: #666; margin-right: 20px"><i class="el-icon-user"></i> {{ item.userName }}</span>
              <span style="color: #666; margin-right: 20px"><i class="el-icon-eye"></i> {{ item.readCount }}</span>
              <span style="color: #666"><i class="el-icon-like"></i> {{ item.likesCount }}</span>

              <span v-if="showOpt" style="margin-left: 40px; color: #2a60c9; cursor: pointer" @click="editBlog(item.id)"><i class="el-icon-edit"></i>编辑</span>
              <span v-if="showOpt" style="margin-left: 10px; color: red; cursor: pointer" @click="del(item.id)"><i class="el-icon-delete"></i>删除</span>

            </div>
            <div style="width: fit-content">
              <el-tag v-for="(item, index) in JSON.parse(item.tags || '[]')" :key="index" type="primary" style="margin-right:5px">{{ item }}</el-tag>
            </div>
          </div>
        </div>
        <div style="width: 150px">
          <img style="width: 100%; height: 80px; border-radius: 5px" :src="item.cover" alt="">
        </div>
      </div>
      <div v-if="total === 0" style="padding: 20px ;text-align: center; font-size: 16px; color: #666">暂无数据</div>
      <div style="margin-top: 10px" v-if="total">
        <el-pagination
            background
            @current-change="handleCurrentChange"
            :current-page="pageNum"
            :page-sizes="[5, 10, 20]"
            :page-size="pageSize"
            layout="total, prev, pager, next"
            :total="total">
        </el-pagination>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "BlogList",
  props: {
    categoryName: null,
    type: null,
    showOpt: false
  },
  data() {
    return {
      tableData: [],  // 所有的数据
      pageNum: 1,   // 当前的页码
      pageSize: 10,  // 每页显示的个数
      total: 0,
    }
  },
  watch: {  // 监听数据变化  加载最新数据
    categoryName() {
      this.loadBlogs(1)
    }
  },
  created() {
    this.loadBlogs(1)
  },
  methods: {
    editBlog(blogId) {
      window.open('/front/newBlog?blogId=' + blogId)
    },
    del(id) {   // 单个删除
      this.$confirm('您确定删除吗？', '确认删除', {type: "warning"}).then(response => {
        this.$request.delete('/blog/delete/' + id).then(res => {
          if (res.code === '200') {   // 表示操作成功
            this.$message.success('操作成功')
            this.loadBlogs(1)
          } else {
            this.$message.error(res.msg)  // 弹出错误的信息
          }
        })
      }).catch(() => {
      })
    },
    loadBlogs(pageNum) {
      if (pageNum) this.pageNum = pageNum
      let url
      switch (this.type) {
        case 'user': url = '/blog/selectUser'; break;
        case 'like': url = '/blog/selectLike'; break;
        case 'collect': url = '/blog/selectCollect'; break;
        case 'comment': url = '/blog/selectComment'; break;
        default: url = '/blog/selectPage'
      }
      this.$request.get(url, {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          categoryName: this.categoryName === '全部博客' ? null : this.categoryName,
          title:this.$route.query.title === 'undefined'?'':this.$route.query.title,
          userName:this.$route.query.userName === 'undefined'?'':this.$route.query.userName,
          tags:this.$route.query.tags === 'undefined' ? '': this.$route.query.tags,
          content:this.$route.query.content === 'undefined' ? '': this.$route.query.content,
        }
      }).then(res => {
        // this.$message.success("看看这个"+this.$route.query.title)
        this.tableData = res.data?.list
        this.total = res.data?.total
        if(this.tableData?.length && Boolean(this.$route.query.content)){
          for(var i=0;i<this.tableData.length;i++){
            this.tableData[i].descr = this.tableData[i].descr.replace(
                new RegExp(this.$route.query.content, 'g'),
                '<span style="color: red;font-weight: bold;font-size: 14px">$&</span>'
            );
          }
        }
      })
    },
    handleCurrentChange(pageNum) {
      // this.$message.success('当前页码为'+pageNum)
      this.loadBlogs(pageNum)
    },
  }
}
</script>

<style scoped>
.blog-box {
  display: flex;
  grid-gap: 15px;
  padding: 10px 0;
  border-bottom: 1px solid #ddd;
}
.blog-box:first-child {
  padding-top: 0;
}
.blog-title {
  font-size: 16px;
  font-weight: bold;
  margin-bottom: 10px;
  cursor: pointer;
}
.blog-title:hover {
  color: #2a60c9;
}
</style>