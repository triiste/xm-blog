<template>
  <div class="main-content">
    <div style="display: flex; align-items: flex-start; grid-gap: 10px">
<!--最左边的分类-->
      <div style="width: 150px" class="card">
<!--        如果item.name选定哪个就把哪个高亮-->
        <div class="category-item" :class="{ 'category-item-active': item.name === current }"
             v-for="item in categoryList" :key="item.id" @click="selectCategory(item.name)">{{ item.name }}</div>
<!--        @click="selectCategory(item.name)选择哪个-->
      </div>

<!--中间的内容-->
      <div style="flex: 1" class="card">

        <div class="blog-box" v-for="item in tableData" :key="item.id" v-if="total > 0">
<!--          文字部分-->
          <div style="flex: 1; width: 0">
<!--            最上面文字标题部分-->
            <div style="font-size: 16px; font-weight: bold; margin-bottom: 10px">{{ item.title }}</div>
            <!--简介 标题部分-->
            <div class="line1" style="color: #666; margin-bottom: 10px; font-size: 13px">{{ item.descr }}</div>
<!--                最下层元素-->
            <div style="display: flex">
              <!--            名称、浏览量、点赞-->
              <div style="flex: 1; font-size: 13px">
                <span style="color: #666; margin-right: 20px"><i class="el-icon-user"></i> {{ item.userName }}</span>
                <span style="color: #666; margin-right: 20px"><i class="el-icon-eye"></i> {{ item.readCount }}</span>
                <span style="color: #666"><i class="el-icon-like"></i> {{ item.likesCount }}</span>
              </div>
<!--              两个标签-->
              <div style="width: fit-content">
                <el-tag type="primary" style="margin-right: 10px">后端</el-tag>
                <el-tag type="primary">面试</el-tag>
              </div>
            </div>
          </div>

<!--          图片部分-->
          <div style="width: 150px">
            <img style="width: 100%; height: 80px; border-radius: 5px" :src="item.cover" alt="">
          </div>
        </div>
        <div v-if="total === 0" style="padding: 20px 0; text-align: center; font-size: 16px; color: #666">暂无数据</div>

<!--        分页模块-->
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

      <!--      最右边的的公告 榜单-->
      <div style="width: 260px" class="card">你是我这一辈子都不想失联的爱hhhhhhhhhhhhhhhhhh</div>

    </div>
  </div>
</template>

<script>

export default {

  data() {
    return {
      current: '全部博客',  //当前选中的分类名称
      categoryList: [],
      tableData: [],  // 所有的数据
      pageNum: 1,   // 当前的页码
      pageSize: 10,  // 每页显示的个数
      total: 0,
    }
  },
  mounted() {
    this.load()

    this.loadBlogs(1)

  },
  // methods：本页面所有的点击事件或者其他函数定义区
  methods: {
    selectCategory(categoryName) {
      this.current = categoryName

      this.loadBlogs(1)
    },
    load() {
      // 请求分类的数据
      this.$request.get('/category/selectAll').then(res => {
        this.categoryList = res.data || []
        // 在数组开头插入一个 全部博客
        this.categoryList.unshift({ name: '全部博客' })
      })
    },
    loadBlogs(pageNum) {
      if (pageNum) this.pageNum = pageNum
      this.$request.get('/blog/selectPage', {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          categoryName: this.current === '全部博客' ? null : this.current,
        }
      }).then(res => {
        this.tableData = res.data?.list
        this.total = res.data?.total
      })
    },
    handleCurrentChange(pageNum) {
      this.load(pageNum)
    },
  }
}
</script>

<style>
.category-item {
  /*第一个div*/
  /*分开前两个个卡片*/
  text-align: center;
  padding: 10px 0;
  font-size: 16px;
  /*鼠标移入是一个小手*/
  cursor: pointer;
}
.category-item-active {
  /*左边全部博客的格式这是高亮样式*/
  background-color: #1890ff;
  color: #fff;
  /*这是圆角格式*/
  border-radius: 15px;
}
.line1 {
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
.blog-box {
  display: flex;
  grid-gap: 15px;
  padding: 10px 0;
  border-bottom: 1px solid #ddd;
}
.blog-box:first-child {
  padding-top: 0;
}
</style>
