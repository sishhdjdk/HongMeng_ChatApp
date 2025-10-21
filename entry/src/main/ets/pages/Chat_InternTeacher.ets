/**
 * 与实习老师（王老师）聊天页
 * 功能：显示与实习老师的聊天记录
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
struct Chat_InternTeacher {
  @State inputText: string = ''
  @State canSend: boolean = false
  @State messageList: ChatMessage[] = [
    new ChatMessage(1, true, '王老师，今天跟着您跑市场，学到好多东西，就是下午走太多路，我的运动鞋都快磨破了，看来得买双"实习专用鞋"了。', '17:20'),
    new ChatMessage(2, false, '哈哈，刚开始都这样，我当年实习也是天天暴走，后来直接囤了两双运动鞋换着穿。对了，今天的市场报告记得整理下，明天上班前发给我，不难，别紧张。', '17:25'),
    new ChatMessage(3, true, '好的老师！我今晚一定整理好，争取不加班，保住我的"运动鞋寿命"～', '17:27'),
    new ChatMessage(4, false, '没问题，有不懂的随时问我，别硬撑，咱们实习是学东西，不是"拼鞋"！', '17:30'),
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
            Text('王')
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

        Text('实习老师（王老师）')
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

