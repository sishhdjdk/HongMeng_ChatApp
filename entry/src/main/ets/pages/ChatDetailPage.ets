/**
 * 聊天详情页
 * 功能：单个聊天会话详情，显示消息列表、发送消息
 */
import router from '@ohos.router'

// 聊天消息数据模型
class ChatMessage {
  id: number
  isSelf: boolean // 是否是自己发送的
  content: string
  time: string

  constructor(id: number, isSelf: boolean, content: string, time: string) {
    this.id = id
    this.isSelf = isSelf
    this.content = content
    this.time = time
  }
}

@Entry
@Component
struct ChatDetailPage {
  @State inputText: string = '' // 输入框文本
  @State canSend: boolean = false // 是否可以发送
  @State messageList: ChatMessage[] = [
    new ChatMessage(1, false, '你好，在吗？', '14:30'),
    new ChatMessage(2, true, '在的，有什么事吗？', '14:31'),
    new ChatMessage(3, false, '晚上一起吃饭吧', '14:32'),
    new ChatMessage(4, true, '好的，几点？', '14:33'),
    new ChatMessage(5, false, '6点半怎么样', '14:34'),
  ]
  private scroller: Scroller = new Scroller()

  // 检查是否可以发送
  checkCanSend(value: string) {
    this.canSend = value.trim().length > 0
  }

  // 发送消息
  sendMessage() {
    if (this.canSend) {
      const newMessage = new ChatMessage(
        this.messageList.length + 1,
        true,
        this.inputText,
        '刚刚'
      )
      this.messageList.push(newMessage)
      this.inputText = ''
      this.canSend = false

      // 滚动到底部
      setTimeout(() => {
        this.scroller.scrollEdge(Edge.Bottom)
      }, 100)
    }
  }

  // 消息气泡组件
  @Builder
  MessageBubble(message: ChatMessage) {
    Row() {
      if (message.isSelf) {
        Blank()
      }

      Column() {
        // 时间
        Text(message.time)
          .fontSize(12)
          .fontColor('#999999')
          .margin({ bottom: 8 })

        Row() {
          // 对方消息显示头像在左边
          if (!message.isSelf) {
            Text('对')
              .width(40)
              .height(40)
              .borderRadius(4)
              .backgroundColor('#07C160')
              .fontColor('#FFFFFF')
              .fontSize(16)
              .textAlign(TextAlign.Center)
              .margin({ right: 8 })
          }

          // 消息内容
          Text(message.content)
            .fontSize(16)
            .fontColor(message.isSelf ? '#FFFFFF' : '#000000')
            .backgroundColor(message.isSelf ? '#07C160' : '#FFFFFF')
            .padding(12)
            .borderRadius(8)
            .maxLines(100)
            .constraintSize({ maxWidth: '60%' })

          // 自己的消息显示头像在右边
          if (message.isSelf) {
            Text('我')
              .width(40)
              .height(40)
              .borderRadius(4)
              .backgroundColor('#576B95')
              .fontColor('#FFFFFF')
              .fontSize(16)
              .textAlign(TextAlign.Center)
              .margin({ left: 8 })
          }
        }
        .alignItems(VerticalAlign.Top)
      }
      .alignItems(message.isSelf ? HorizontalAlign.End : HorizontalAlign.Start)

      if (!message.isSelf) {
        Blank()
      }
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
  }

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Image($r('sys.media.ohos_ic_public_arrow_left'))
          .width(24)
          .height(24)
          .onClick(() => {
            router.back()
          })

        Text('张三')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin({ left: 16 })
          .layoutWeight(1)

        Image($r('sys.media.ohos_ic_public_more'))
          .width(24)
          .height(24)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#FFFFFF')
      .border({ width: { bottom: 1 }, color: '#EDEDED' })

      // 消息列表
      if (this.messageList.length > 0) {
        List({ scroller: this.scroller }) {
          ForEach(this.messageList, (message: ChatMessage) => {
            ListItem() {
              this.MessageBubble(message)
            }
          })
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor('#EDEDED')
      } else {
        // 空状态
        Column() {
          Text('暂无消息')
            .fontSize(16)
            .fontColor('#999999')
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#EDEDED')
      }

      // 底部输入栏
      Row() {
        // 语音按钮
        Image($r('sys.media.ohos_ic_public_voice'))
          .width(28)
          .height(28)
          .margin({ right: 8 })

        // 输入框
        TextInput({ text: this.inputText, placeholder: '请输入消息' })
          .layoutWeight(1)
          .height(36)
          .fontSize(16)
          .backgroundColor('#F5F5F5')
          .borderRadius(4)
          .onChange((value: string) => {
            this.inputText = value
            this.checkCanSend(value)
          })

        // 表情按钮
        Text('😊')
          .fontSize(24)
          .margin({ left: 8, right: 8 })

        // 更多按钮
        Image($r('sys.media.ohos_ic_public_add'))
          .width(28)
          .height(28)
          .margin({ right: 8 })

        // 发送按钮
        Button('发送')
          .fontSize(14)
          .fontColor('#FFFFFF')
          .backgroundColor(this.canSend ? '#07C160' : '#CCCCCC')
          .height(36)
          .borderRadius(4)
          .enabled(this.canSend)
          .onClick(() => {
            this.sendMessage()
          })
      }
      .width('100%')
      .padding(12)
      .backgroundColor('#FFFFFF')
      .border({ width: { top: 1 }, color: '#EDEDED' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#EDEDED')
  }
}
