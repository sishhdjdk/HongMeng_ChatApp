/**
 * 毕业实习群聊天页
 * 功能：显示实习群的聊天记录
 */
import router from '@ohos.router'

class ChatMessage {
  id: number
  isSelf: boolean
  content: string
  time: string
  senderName?: string

  constructor(id: number, isSelf: boolean, content: string, time: string, senderName?: string) {
    this.id = id
    this.isSelf = isSelf
    this.content = content
    this.time = time
    this.senderName = senderName
  }
}

@Entry
@Component
struct Chat_InternshipGroup {
  @State inputText: string = ''
  @State canSend: boolean = false
  @State messageList: ChatMessage[] = [
    new ChatMessage(1, false, '@全体成员 doubleyong 邀请您加入doubleyong的个人会议室\n' +
      '\n' +
      '点击链接直接加入会议：\n' +
      'https://meeting.tencent.com/\n' +
      '\n' +
      '#腾讯会议：787-315-xxxx\n' +
      '\n' +
      '复制该信息，打开手机腾讯会议即可参与。', '14:00', '杨老师'),

    new ChatMessage(2, false, '@杨老师-13699417150 左上角三个点是干嘛用的', '2025/10/15 12:08', '小杨'),
    new ChatMessage(3, false, '换颜色的', '2025/10/15 13:08', '李老师'),
    new ChatMessage(4, false, '不用写代码', '2025/10/15 13:08', '李老师'),
    new ChatMessage(5, false, '直接布局就可以了。', '2025/10/15 13:08', '李老师'),
    new ChatMessage(6, false, '老师教学视频下午可以发一下吗@杨老师-13699417150。', '星期五 12:37', '小贵'),
    new ChatMessage(7, false, '可以的', '星期五 12:50', '杨老师'),
    new ChatMessage(8, true, '我下午发出来', '星期五 12:50','杨老师'),
    new ChatMessage(9, false, 'OpenHarmony第三方库：https://ohpm.openharmony.cn/#/cn/home\n' +
      'mccharts文档：  https://ohpm.openharmony.cn/#/cn/detail/', '周一 09:07', '杨老师'),
    new ChatMessage(10, false, '【金山文档 | WPS云文档】 22级软件工程实习点名、分组表.xlsx\n' +
      'https://www.kdocs.cn/xxx', '周二 11:56', '小余'),
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
              .backgroundColor('#5856D6')
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

        Text('2022 软件工程毕业实习群')
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

