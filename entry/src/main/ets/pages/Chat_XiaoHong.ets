/**
 * 与小红聊天页
 * 功能：显示与同学小红的聊天记录
 */
import router from '@ohos.router'

class ChatMessage {
  id: number
  isSelf: boolean
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
struct Chat_XiaoHong {
  @State inputText: string = ''
  @State canSend: boolean = false
  @State messageList: ChatMessage[] = [
    new ChatMessage(1, false, '救命！我论文选题还没定，看了好多文献，脑子都乱了，你选好没？给我点灵感呗。', '14:00'),
    new ChatMessage(2, true, '我也刚定好，之前也纠结好久，后来结合咱们专业课的消费心理学，选了"大学生直播购物决策影响因素"，你可以试试从自己感兴趣的方向找。', '14:05'),
    new ChatMessage(3, false, '这个方向不错啊！我平时也爱刷直播，说不定能有新思路，等我定好选题，请你喝奶茶，谢谢你啊！', '14:08'),
    new ChatMessage(4, true, '客气啥，咱们都是"论文战友"，互相帮忙应该的，有啥不懂的再问我～', '14:10'),
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
            Text('红')
              .width(40)
              .height(40)
              .borderRadius(4)
              .backgroundColor('#FF6B9D')
              .fontColor('#FFFFFF')
              .fontSize(16)
              .textAlign(TextAlign.Center)
              .margin({ right: 8 })
          }

          Text(message.content)
            .fontSize(16)
            .fontColor(message.isSelf ? '#FFFFFF' : '#000000')
            .backgroundColor(message.isSelf ? '#07C160' : '#FFFFFF')
            .padding(12)
            .borderRadius(8)
            .maxLines(100)
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

        Text('小红')
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

        Text('😊')
          .fontSize(24)
          .margin({ left: 8, right: 8 })

        Image($r('sys.media.ohos_ic_public_add'))
          .width(28)
          .height(28)
          .margin({ right: 8 })

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

