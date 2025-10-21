/**
 * 论文指导群聊天页
 * 功能：显示论文指导群的聊天记录
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
struct ThesisGroupChatPage {
  @State inputText: string = ''
  @State canSend: boolean = false
  @State messageList: ChatMessage[] = [
    new ChatMessage(1, '张老师', false, '@全体成员 论文选题初稿本周五截止，有疑问的同学直接在群里问，别私下单独找我，避免重复解答哈。', '09:00'),
    new ChatMessage(2, '我', true, '老师，选题能写"当代大学生奶茶消费与学习效率的关系"吗？我有丰富的实践数据！', '09:05'),
    new ChatMessage(3, '同学D', false, '哈哈哈哈，我本来想写"外卖配送时长对论文写作进度的影响"，看来我们是"干饭系学术选手"！', '09:06'),
    new ChatMessage(4, '张老师', false, '想法很有趣，但要结合专业方向哦，比如市场营销专业可以往"消费行为分析"靠，再调整下选题，周五前改好发给我。', '09:10'),
    new ChatMessage(5, '我', true, '好的老师，我重新调整一下方向！', '09:11'),
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

        Text('论文指导群')
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
