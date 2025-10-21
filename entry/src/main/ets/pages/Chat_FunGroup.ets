/**
 * 没有老师的同学群聊天页
 * 功能：显示没有老师的同学群的聊天记录
 */
import router from '@ohos.router'

class ChatMessage {
  id: number
  sender: string
  isSelf: boolean
  content: string
  time: string

  constructor(id: number, sender: string, isSelf: boolean, content: string, time: string) {
    this.id = id
    this.sender = sender
    this.isSelf = isSelf
    this.content = content
    this.time = time
  }
}

@Entry
@Component
struct FunGroupChatPage {
  @State inputText: string = ''
  @State canSend: boolean = false
  @State messageList: ChatMessage[] = [
    new ChatMessage(1, '同学E', false, '家人们，刚发现学校食堂新出了"麻辣香锅半价日"，今晚有人一起去吗？AA制，吃垮食堂！', '17:30'),
    new ChatMessage(2, '我', true, '算我一个！上周写作业错过食堂优惠，这次必须补上，我能吃两盘肥牛卷，别嫌我能吃～', '17:32'),
    new ChatMessage(3, '同学F', false, '我也去！不过先说好，吃完别聊论文和实习，谁提谁买单，咱们今晚只当"快乐干饭人"！', '17:33'),
    new ChatMessage(4, '同学G', false, '收到！我现在就收拾书包，下课直接冲食堂，晚了就没位置了，大家速度点！', '17:35'),
    new ChatMessage(5, '同学E', false, '那就18:00食堂门口集合，谁迟到谁请奶茶！', '17:36'),
    new ChatMessage(6, '我', false, '快死到临头了, 有没有代码救救！', '20:40'),
    new ChatMessage(7, '我', false, '(；′⌒`)', '20:50'),
  ]
  private scroller: Scroller = new Scroller()

  checkCanSend(value: string) {
    this.canSend = value.trim().length > 0
  }

  sendMessage() {
    if (this.canSend) {
      const newMessage = new ChatMessage(
        this.messageList.length + 1,
        '我',
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
        if (!message.isSelf) {
          Text(message.sender)
            .fontSize(12)
            .fontColor('#999999')
            .margin({ bottom: 4 })
        }

        Text(message.time)
          .fontSize(12)
          .fontColor('#999999')
          .margin({ bottom: 8 })

        Row() {
          if (!message.isSelf) {
            Text(message.sender.substring(0, 1))
              .width(40)
              .height(40)
              .borderRadius(4)
              .backgroundColor('#07C160')
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

        Text('没有老师的同学群')
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

        TextInput({ text: this.inputText, placeholder: '输入消息...' })
          .layoutWeight(1)
          .backgroundColor('#FFFFFF')
          .borderRadius(4)
          .onChange((value: string) => {
            this.inputText = value
            this.checkCanSend(value)
          })

        Button('发送')
          .fontSize(14)
          .fontColor('#FFFFFF')
          .backgroundColor(this.canSend ? '#07C160' : '#CCCCCC')
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
