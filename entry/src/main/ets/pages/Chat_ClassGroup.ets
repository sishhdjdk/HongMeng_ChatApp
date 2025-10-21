/**
 * 同学班群聊天页
 * 功能：显示班级群聊记录
 */
import router from '@ohos.router'

class ChatMessage {
  id: number
  isSelf: boolean
  content: string
  time: string
  senderName?: string

  constructor(id: number, isSelf: boolean, content: string, time: string, senderName?: string) {
    this.id = id // 消息的唯一标识符
    this.isSelf = isSelf // 是否为当前用户发送的消息
    this.content = content // 消息的具体内容
    this.time = time // 消息的发送时间
    this.senderName = senderName // 消息发送者的名称
  }
}


@Entry
@Component
struct Chat_ClassGroup {
  @State inputText: string = ''
  @State canSend: boolean = false
  @State messageList: ChatMessage[] = [
    new ChatMessage(1, false, '各位同学注意啦！周三之前把市场调研报告交给我，别忘了啊，不然老师又要点名了！', '09:00', '班长'),
    new ChatMessage(2, false, '救命！我咖啡喝完了，图书馆附近谁能借我一杯续命？明天还你两杯！', '09:15', '小红'),
    new ChatMessage(3, false, '我这有速溶咖啡，要不要？虽然不如现磨的，但提神效果还行。', '09:16', '小李'),
    new ChatMessage(4, false, '小李你在哪？我现在就去找你，速溶的也行，我快困死了。', '09:17', '小红'),
    new ChatMessage(5, false, '我在图书馆三楼，靠窗那排，穿蓝色卫衣的就是我。', '09:18', '小李'),
    new ChatMessage(6, false, '有没有人早上买了面包的？我忘记吃早餐了，现在肚子咕咕叫，好尴尬。', '10:30', '小刚'),
    new ChatMessage(7, false, '我有全麦面包，给你留一个，食堂门口见？', '10:31', '小明'),
    new ChatMessage(8, false, '太感动了！咱们班真是"学术丐帮"互助会，明天我请大家喝奶茶！', '10:32', '小刚'),
    new ChatMessage(9, true, '看到你们互相帮助，我这个班长很欣慰啊，大家加油！报告别忘了交！', '10:35'),
    new ChatMessage(10, false, '收到！班长辛苦了！', '10:36', '小明'),
  ]
  private scroller: Scroller = new Scroller()

  checkCanSend(value: string) {
    this.canSend = value.trim().length > 0
  }

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

      setTimeout(() => {
        this.scroller.scrollEdge(Edge.Bottom)
      }, 100)
    }
  }

  @Builder
  MessageBubble(message: ChatMessage) {
    Row() {
      if (message.isSelf) {
        Blank()
      }

      Column() {
        Text(message.time)
          .fontSize(12)
          .fontColor('#999999')
          .margin({ bottom: 8 })

        Row() {
          if (!message.isSelf) {
            Text(message.senderName ? message.senderName.substring(0, 1) : '同')
              .width(40)
              .height(40)
              .borderRadius(4)
              .backgroundColor('#FF9500')
              .fontColor('#FFFFFF')
              .fontSize(16)
              .textAlign(TextAlign.Center)
              .margin({ right: 8 })
          }

          Column() {
            if (!message.isSelf && message.senderName) {
              Text(message.senderName)
                .fontSize(12)
                .fontColor('#666666')
                .margin({ bottom: 4 })
            }

            Text(message.content)
              .fontSize(16)
              .fontColor(message.isSelf ? '#FFFFFF' : '#000000')
              .backgroundColor(message.isSelf ? '#07C160' : '#FFFFFF')
              .padding(12)
              .borderRadius(8)
              .maxLines(100)
          }
          .alignItems(message.isSelf ? HorizontalAlign.End : HorizontalAlign.Start)
          .constraintSize({ maxWidth: '60%' })

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
      Row() {
        Image($r('sys.media.ohos_ic_public_arrow_left'))
          .width(24)
          .height(24)
          .onClick(() => {
            router.back()
          })

        Text('娃哈哈')
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

      Row() {
        Image($r('sys.media.ohos_ic_public_voice'))
          .width(28)
          .height(28)
          .margin({ right: 8 })

        TextInput({ placeholder: '输入消息...', text: this.inputText })
          .layoutWeight(1)
          .backgroundColor('#FFFFFF')
          .borderRadius(4)
          .onChange((value: string) => {
            this.inputText = value
            this.checkCanSend(value)
          })

        Button('发送')
          .fontSize(14)
          .backgroundColor(this.canSend ? '#07C160' : '#CCCCCC')
          .fontColor('#FFFFFF')
          .margin({ left: 8 })
          .enabled(this.canSend)
          .onClick(() => {
            this.sendMessage()
          })
      }
      .width('100%')
      .padding(12)
      .backgroundColor('#F5F5F5')
      .border({ width: { top: 1 }, color: '#EDEDED' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#EDEDED')
  }
}

