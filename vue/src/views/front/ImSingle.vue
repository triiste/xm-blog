<template>
  <div>
    <div  class="main-body-content center-container" style="margin-left: 400px;margin-top: 50px;">
      <div style="display: flex; align-items: flex-start;" >
        <!--        125px-->
        <div style="width: 240px; border: 1px solid #000b17; border-radius: 5px; height: calc(50vh + 125px);">
          <div class="header">论坛用户</div>
          <!--          学生框-->
          <div class="user-list-box" style="height:calc(50vh + 125px - 42px);overflow-y: scroll;background-color: #f0f0f0">


            <div class="user-list-item" v-for="item in users.USER" @click="selectToUser(item)">
              <img :src="item.avatar" :class="{ online: item.info === '在线', offline: item.info === '离线' }">
              <span style="flex: 1; margin-left: 10px;font-size: 16px" :style="{ color: item.id.toString() === toUser.toString() ? '#3a8ee6' :''} ">
              {{ item.name }}
                <span v-if="item.info === '在线'" style="color: #4CAF50;">在线</span>
                <span v-else style="color: gray;">离线</span>
             </span>

              <div class="user-list-item-badge" v-if="unRead?.[item.id ]">{{ unRead?.[item.id ] }}</div>
              <!--              表示未读数量-->
            </div>
          </div>
        </div>
        <!--  中间部分  -->
        <div style="width: 50%; border: 1px solid #ddd; border-radius: 5px; background-color: #f1f1f1; margin: 0 10px;">
          <div style="padding: 20px 0; text-align: center; border-bottom: 1px solid #ddd; color: #000; background-color: #eee; height: 60px">
            {{ toUserName }}
          </div>
          <div class="im-message-box">
            <!--            遍历整个聊天记录-->
            <div v-for="(group, date) in groupedMessages" :key="date">
              <div v-for="(item, index) in group" :key="index">
                <div v-if="index === 0" style="text-align: center;font-weight: bold;margin-bottom: 5px">{{ date }}</div>
                <div v-if="shouldDisplayTime(index, group)">
                  <div style="text-align: center" v-html="item.time"></div>
                </div>
                <!--  右边的气泡   判断当前用户是不是发送者，如果是就执行这个 自己来了就执行这里-->
                <div style="display: flex; flex-direction: row-reverse; align-items: flex-start"
                     v-if="item.fromuser === fromUser.toString()">
                  <!--                判断当前用户是不是发送者，如果是就执行这个-->
                  <img :src="item.fromavatar" alt=""
                       style="width: 40px; height: 40px; border-radius: 50%; margin-left: 10px">


                  <div class="im-message im-message-right" v-html="item.content"
                       v-if="item.type === 'text'"></div>
                  <div class="im-message" style="padding: 0" v-if="item.type === 'img'">
                    <!-- 注意  el-image 的load函数必须加上，否则无法触发滚动条到最底端 -->
                    <el-image style="width: 100px" :src="item.content" alt=""
                              :preview-src-list=[item.content] @load="scrollToBottom"></el-image>
                  </div>
                  <!--                发送的是文件-->
                  <div class="im-message im-message-download" v-if="item.type === 'file'"
                       @click="download(item.content)">
                    <div><i class="el-icon-folder-opened"></i>
                      <span>{{ item.content.substring(item.content.indexOf('-') + 1) }}</span>
                    </div>
                  </div>

                </div>

                <!--  左边的气泡 -->
                <!--             v-else说明两个互斥的接收者 -->
                <div style="display: flex; align-items: flex-start" v-else>
                  <!--                头像-->
                  <img :src="item.fromavatar" alt=""
                       style="width: 40px; height: 40px; border-radius: 50%; margin-right: 10px">
                  <div style="width: 100%">
                    <div style="color: #888; font-size: 12px; width: 50%">
                      <!--                    内容左侧人名-->
                      {{ toUserName }}
                    </div>
                    <!--                  发送的是文字-->
                    <div class="im-message im-message-left"  v-html="item.content"
                         v-if="item.type === 'text'"></div>
                    <!--                  发送的是图片-->
                    <div class="im-message" style="padding: 0" v-if="item.type === 'img'">
                      <!-- 注意  el-image 的load函数必须加上，否则无法触发滚动条到最底端 -->
                      <el-image style="width: 100px" :src="item.content" alt=""
                                :preview-src-list=[item.content]
                                @load="scrollToBottom"></el-image>
                    </div>
                    <!--                  发送的是文件的话-->
                    <div class="im-message im-message-download" v-if="item.type === 'file'"
                         @click="download(item.content)">
                      <div><i class="el-icon-folder-opened"></i>
                        <span>{{ item.content.substring(item.content.indexOf('-') + 1) }}</span>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- 输入区域 -->
          <div style="padding: 10px 5px; border-top: 1px solid #ddd; display: flex; align-items: center; width: 100%;">
            <!--            表情包-->
            <el-popover placement="top" width="300" trigger="click">
              <div class="emoji-box">
                <span v-for="(item, index) in emojis" :key="index"
                      style="margin-right: 5px; font-size: 20px; cursor: pointer" v-html="item"
                      @click="clickEmoji(item)">
                </span>
              </div>
              <i slot="reference" class="fa fa-smile-o" style="font-size: 22px; color: #666;"></i>
            </el-popover>
            <!--            上传图片文件-->
            <div style="margin-left: 5px">
              <el-upload action="http://47.109.28.131:9090/files/upload" :show-file-list="false" :on-success="handleFile">
                <i class="fa fa-folder-open-o" style="font-size: 20px; color: #666;"></i>
              </el-upload>
            </div>
            <!--输入框-->
            <div
                id="im-content"
                contenteditable
                @keydown.enter.prevent
                @keyup.enter="send"
                style="flex: 1; background-color: #fff; margin: 0 5px;max-height: 50px;overflow-y: auto;padding: 10px; border: 1px solid #ddd; border-radius: 2px; outline: none; font-size: 18px;"
            ></div>
            <el-button type="primary" @click="send" style="border: none">发送</el-button>

          </div>

        </div>
        <!--  中间部分结束  -->
      </div>
    </div>
  </div>


</template>

<script>
import request from "@/utils/request";
import emojis from "@/assets/emoji";

let client
export default {
  data() {
    return {
      user: {},
      permission: [],
      emojis: [],
      messages: [],
      users: {},
      fromUser: '',// 当前用户
      toUser: '',
      toAvatar: '',
      unRead: {},
      toUserName:'',
      timeIntervalThreshold: 3 * 60 * 1000
    }
  },
  computed:{
    groupedMessages() {
      const grouped = {};
      this.messages.forEach(item => {
        const date = item.time.split(' ')[0]; // 提取日期部分
        if (!grouped[date]) {
          grouped[date] = [];
        }
        grouped[date].push(item);
      });
      return grouped;
    },
  },

  // 页面加载的时候，做一些事情，在created里面
  mounted() {
    this.emojis = emojis.split(',')
    this.user = JSON.parse(localStorage.getItem('xm-user') || "{}")

    this.fromUser = this.user.id
    this.fromUser = this.fromUser + ""
    // 字符串存储
    let id = this.user?.id.toString();
    client = new WebSocket(`ws://47.109.28.131:9090/imserverSingle/${id}`)
    client.onopen = () => {
      console.log('websocket open')
    }
    client.onclose = () => {  // 页面刷新的时候和后台websocket服务关闭的时候
      console.log('websocket close')
    }
    client.onmessage = (msg) => { //WebSocket 对象的事件监听器，用于处理从服务器接收到的消息。
      if (msg.data) { // 检查接收到的消息是否存在。
        let json = JSON.parse(msg.data)
        if (json.users && json.users.length){
          this.loadOnline();
          return
        }
      if(json.touser === this.fromUser.toString()){
        this.loadOnline();
      }
        if (json.content && (json.fromuser === this.fromUser.toString() && json.touser === this.toUser.toString())
            || json.touser === this.fromUser.toString() && json.fromuser === this.toUser.toString()) {  // 说明是两者互相发消息
          this.messages.push(json) //放到消息队列里
          this.scrollToBottom()  // 滚动页面到最底部
          this.loadOnline();
        }
        // 加载消息数字 两者通信如果是对面发来的消息 说明当前正在两个人的通信窗口
        if (this.toUser.toString() === json.fromuser) {
          this.setUnReadNums()  // 把对方消息设为已读,更新未读消息数量
          this.loadOnline();
        } else {  //用户发给对方的
          // 可能是当前用户发给对方的消息，或者是其他人通信 都 加载当前用户的未读消息数量 每次监听到通信事件就更新未读记录
          this.loadUnReadNums()
          this.loadOnline();
        }
      }
    }

    // 加载聊天数据
    this.load()

    request.get('/user/selectAllOnline?userId='+ this.user.id.toString()).then(res => {
      //过滤掉自己就可以 //实时刷新
      res.data = res.data.filter(v => v.id  !== this.user.id )
      this.$set(this.users, 'USER', res.data)
    })


  },
  // Vue实例销毁之前执行  释放资源
  beforeDestroy() {
    if (client) {
      client.close()
    }
  },
  // 定义一些页面上控件出发的事件调用的方法
  methods: {
    //
    shouldDisplayTime(index, group) {
      if (index === 0) {
        return true;
      }
      const currentTime = new Date(group[index].time).getTime();
      const prevTime = new Date(group[index - 1].time).getTime();
      return currentTime - prevTime > this.timeIntervalThreshold;
    },
    load() {
      request.get('/imsingle?fromUser=' + this.fromUser.toString() + '&toUser=' + this.toUser.toString()).then(res => {
        // console.log(res)
        if (res.code === '200') {
          //把对方消息设为已读 这是两者的消息传递
          this.messages = res.data
          this.scrollToBottom()  // 滚动条滚动到最底部
        } else {
           this.$notify.error(res.msg)
        }
        this.loadUnReadNums()
      })
    },
    // 查询两个人的所有消息 同时把 对方 的消息设为已读
    setUnReadNums() {
      request.get('/imsingle?fromUser=' + this.fromUser.toString() + '&toUser=' + this.toUser.toString()).then(res => {
        this.loadUnReadNums()
      })
    },
    // 查询当前用户的所有未读数量并标记
    loadUnReadNums() {
      request.get('/imsingle/unReadNums?toUsername=' + this.fromUser.toString()).then(res => {
        this.unRead = res.data
        // console.log(this.unRead)STUDENT_池:2
      })
    },
    //查询所有的在线人数
    loadOnline(){
      // 查询用户是否在线
      // '/imsingle/unReadNums?toUsername=' + this.fromUser.toString()
      request.get('/user/selectAllOnline?userId='+ this.user.id.toString()).then(res => {
        //过滤掉自己就可以 //实时刷新
        res.data = res.data.filter(v => v.id  !== this.user.id )
        this.$set(this.users, 'USER', res.data)
      })
    },

    //发送消息
    send() {
      let inputBox = document.getElementById('im-content') //输入框输入的东西进行获取
      const content = inputBox.textContent.trim(); // 使用 trim() 去除两端空白字符

      if (content.length === 0) {
        this.$notify.error('请输入聊天内容!');
        return;
      } else if (content.length > 150) {
        this.$notify.error('字数超过150，请重新输入!');
        return;
      }


      if (!this.toUser) {
        this.$notify.error('请选择聊天用户')
        return
      }
      if (client) {
        let message = this.getMessage('text')
        client.send(JSON.stringify(message))
      }
      document.getElementById('im-content').innerHTML = ''  // 清空输入框
    },
    //选择对方并查询两个人的所有消息 同时把 对方 的消息设为已读 更新所有未读记录
    selectToUser(item) {
      console.log(this.user.id)
      if(this.user.id.toString() === '10'){
        this.$notify.error("访客无权查看，请注册账号哦")
        return
      }
      //设置发送的人以及对方的头像
      this.toUserName = item.name
      this.toUser = item.id 
      this.toAvatar = item.avatar
      //查询聊天记录 同时把对方消息的设为已读
      this.load()
    },
    //下载文件
    download(file) {
      window.open(file)
    },
    //发送的信息
    getMessage(type) {
      let inputBox = document.getElementById('im-content') //输入框输入的东西进行获取
      const content = inputBox.innerHTML
      if (!content && type === 'text') { //没有聊天内容
        this.$notify.error('请输入聊天内容')
        return
      }
      return {
        fromuser: this.fromUser,//自己
        fromavatar: this.user.avatar,
        touser: this.toUser,
        toavatar: this.toAvatar,
        content: content,
        type: type
      }
    },
    // 设置文件类型 是图片还是文件 发送文件
    handleFile(file) {
      if (client) {
        let message = this.getMessage('img')
        message.content = file.data
        //这是一个地址
        let extName = file.data.substring(file.data.lastIndexOf('.') + 1)
        if (['png', 'jpg', 'jpeg', 'gif', 'bmp', 'tiff', 'svg', 'webp','jfif'].includes(extName)) {
          message.type = 'img'
        } else {
          message.type = 'file'
        }
        client.send(JSON.stringify(message))
      }
    },
    //设置发送的表情
    clickEmoji(emoji) {
      document.getElementById('im-content').innerHTML += emoji
    },
    //滚动到最底部
    scrollToBottom() {
      this.$nextTick(() => {
        // 设置聊天滚动条到底部
        let imMessageBox = document.getElementsByClassName("im-message-box")[0]
        //设置滚动条到最底部
        imMessageBox.scrollTop = imMessageBox.scrollHeight
        console.log('触发滚动')
      })
    },
  }
}




</script>




<style scoped>
.im-message-box {
  height: 50vh;
  padding: 10px;
  overflow-y: auto;
  background-color: white;
}

.emoji-box {
  height: 200px;
  overflow-y: scroll;
  line-height: 30px;
}

.user-list-box {
  overflow-y: auto;
}

.im-message-box::-webkit-scrollbar, .emoji-box::-webkit-scrollbar, .user-list-box::-webkit-scrollbar {
  width: 4px;
}

.im-message-box::-webkit-scrollbar-thumb, .emoji-box::-webkit-scrollbar-thumb, .user-list-box::-webkit-scrollbar-thumb {
  border-radius: 10px;
  background: rgba(0, 0, 0, 0.1);
}

.im-message-box::-webkit-scrollbar-track, .emoji-box::-webkit-scrollbar-track, .user-list-box::-webkit-scrollbar-track {
  border-radius: 0;
  background: rgba(0, 0, 0, 0.1);
}

.im-message {
  font-size: 14px;
  padding: 10px;
  margin: 5px 0;
  border-radius: 5px;
  color: #000;
  max-width: 50%;
  line-height: 20px;
  width: fit-content;
}

.im-message-left {
  background-color: #fff;

}

.im-message-right {
  background-color: #26d470;
}

.im-message-download {
  background-color: #DBEDFF;
  cursor: pointer;
}

.user-list-item {
  display: flex;
  padding: 10px;
  align-items: center;
  border-bottom: 1px solid #eee;
  cursor: pointer;
  font-size: 14px;
}

.user-list-item-badge {
  padding: 2px 6px;
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 12px;
  color: white;
  background-color: red;
}
.header{
  padding: 10px;
  border-bottom: 1px solid #ddd;
  color: #000;
  background-color: #eee;
  font-weight: bold;
  text-align: center

}
.user-list-item:nth-last-child(1) {
  border: none;
}

.online {
  width: 30px;
  height: 30px;
  border-radius: 50%;
  border: 2px solid #4CAF50;
  background-color: #4CAF50;
}

.offline {
  width: 30px;
  height: 30px;
  border-radius: 50%;
  border: 2px solid #ccc;
  background-color: #ccc;
}

.online-text {
  color: #4CAF50;
}

.offline-text {
  color: gray;
}

</style>