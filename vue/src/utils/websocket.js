let socket = null;
let timer = null;

export default {
    state: {
        message: null,
        sellerid: '',
        account: '',
        close: false,
        time: 60000,
    },
    mutations: {
        //开启
        SOCKET_ONOPEN (state, info) {
            console.log('开启WebSocket连接', info);
            // 开启心跳定时器
            timer = setInterval(() => {
                info.workerID = localStorage.getItem('workerID')
                info.connectionID = localStorage.getItem('connectionID')
                info.id = localStorage.getItem('id')
                info.HEARTBEAT_TIME = parseInt(new Date().getTime() / 1000);
                console.log('info信息', { ...info });
                if (info.connectionID && info.workerID) {
                    console.log('发送心跳信息', { ...info });
                    socket.send(JSON.stringify(info));// 发送心跳消息
                } else {
                    console.log('未发送心跳信息', { ...info });
                }
            }, state.time);
        },
        // 关闭
        SOCKET_ONCLOSE (state, event) {
            console.log('WebSocket连接已关闭');
            if (state.close) {//浏览器关闭
                clearInterval(timer);// 关闭心跳定时器
                socket.send('close');// 发送心跳消息
            } else {//连接错误 || 服务器连接已关闭 || 收到消息返回信息不对
                this.commit('againRequest')
            }
        },
        // 收到消息
        SOCKET_ONMESSAGE (state, message) {
            state.message = message;
            console.log('收到消息:', message);
            if ((message && message.workerID) || message.workerID == 0) localStorage.setItem('workerID', message.workerID)
            if ((message && message.connectionID || message.connectionID == 0)) localStorage.setItem('connectionID', message.connectionID)
            if (message.success != 'HEARTBEAT_OK') {//返回的字段success为HEARTBEAT_OK代表请求成功
                console.log('收到消息---需要重连');
                this.commit('againRequest')
            }
        },
        // 连接错误
        SOCKET_ONERROR (state, event) {
            console.error('WebSocket连接错误:', event);
            this.commit('againRequest')
        },
        // 重新开启ws
        againRequest (state) {
            console.log('重新开启ws');
            clearInterval(timer);// 关闭心跳定时器
            localStorage.removeItem('workerID')
            localStorage.removeItem('connectionID')
            setTimeout(() => {
                this.dispatch('onopenWebSocket', {
                    id:'1'
                });
            }, state.time)
        }
    },
    actions: {
        // 创建WebSocket连接
        onopenWebSocket ({ state, commit }, data) {
            let hasExecuted = false;
            state.id= data.id;
            socket = new WebSocket(`ws://地址?id=${data.id}`);
            // 监听WebSocket事件
            socket.onopen = (event) => {
                console.log('监听WebSocket事件-----连接ws', event);
                commit('SOCKET_ONOPEN', { id: state.sellerid });
            };
            socket.onclose = (event) => {
                console.log('监听WebSocket事件-----关闭ws', event);
                if (!hasExecuted) {
                    commit('SOCKET_ONCLOSE', event);
                    hasExecuted = true;
                }
            };
            socket.onmessage = (event) => {
                commit('SOCKET_ONMESSAGE', JSON.parse(event.data));
            };
            socket.onerror = (event) => {
                console.log('监听WebSocket事件-----连接ws错误');
                if (!hasExecuted) {
                    commit('SOCKET_ONERROR', event);
                    hasExecuted = true;
                }
            };
        },
        // 关闭浏览器  关闭WebSocket连接
        disconnectWebSocket ({ state }) {
            if (socket) {
                state.close = true
                socket.send(JSON.stringify('close'));// 发送心跳消息
                socket.close();
            }
        }
    }
};
