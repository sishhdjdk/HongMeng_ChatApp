/**
 * 消息列表页（主页）
 * 功能：显示所有聊天会话列表，底部导航栏
 */
import router from '@ohos.router'

// 消息数据模型
class MessageItem {
  id: number
  avatar: string
  name: string
  lastMessage: string
  time: string
  unreadCount: number
  chatPage: string // 添加聊天页面路由

  constructor(id: number, avatar: string, name: string, lastMessage: string, time: string, unreadCount: number, chatPage: string) {
    this.id = id
    this.avatar = avatar
    this.name = name
    this.lastMessage = lastMessage
    this.time = time
    this.unreadCount = unreadCount
    this.chatPage = chatPage
  }
}

@Entry
@Component
struct MessageListPage {
  @State currentTab: number = 0 // 当前选中的Tab，0=消息
  @State searchText: string = '' // 搜索文本
  @State messageList: MessageItem[] = [
    new MessageItem(1, '', '同学班群', '小明：豆浆加油条，不见不散', '20:36', 2, 'pages/Chat_ClassGroup'),
    new MessageItem(2, '', '2022软件工程 毕业实习', '小余：【金山文档 | WPS云文档】 22级软件工程实习点名、分组表.xlsx\n' +
      'https://www.kdocs.cn/xxxx', '18:45', 3, 'pages/Chat_InternshipGroup'),
    new MessageItem(3, '', '论文指导群', '张老师：选题要结合实际', '17:20', 5, 'pages/Chat_ThesisGroup'),
    new MessageItem(4, '', '娃哈哈', '小魏：一念通天,神魔无惧', '16:50', 1, 'pages/Chat_FunGroup'),
    new MessageItem(5, '', '王老师（实习）', '今天跑市场辛苦了', '15:30', 0, 'pages/Chat_InternTeacher'),
    new MessageItem(6, '', '刘老师', '这个知识点要好好理解', '14:45', 1, 'pages/Chat_Teacher'),
    new MessageItem(7, '', '小明', '放心吧！这次绝对不鸽！', '14:10', 0, 'pages/Chat_XiaoMing'),
    new MessageItem(8, '', '小红', '咱们都是论文战友', '13:30', 0, 'pages/Chat_XiaoHong'),
    new MessageItem(9, '', '小丽', '谢谢你的实习经验分享', '12:20', 0, 'pages/Chat_XiaoLi'),
    new MessageItem(10, '', '小刚', '周末电影走起', '11:15', 0, 'pages/Chat_XiaoGang'),
  ]

  // 消息项组件
  @Builder
  MessageItemView(item: MessageItem) {
    Row() {
      // 头像 - 使用文本占位符
      Text(item.name.substring(0, 1))
        .width(50)
        .height(50)
        .borderRadius(8)
        .backgroundColor('#07C160')
        .fontColor('#FFFFFF')
        .fontSize(20)
        .textAlign(TextAlign.Center)
        .margin({ right: 12 })

      // 消息内容
      Column() {
        Row() {
          Text(item.name)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .maxLines(1)
            .layoutWeight(1)

          Text(item.time)
            .fontSize(12)
            .fontColor('#999999')
        }
        .width('100%')
        .margin({ bottom: 6 })

        Row() {
          Text(item.lastMessage)
            .fontSize(14)
            .fontColor('#666666')
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .layoutWeight(1)

          // 未读消息数
          if (item.unreadCount > 0) {
            Text(item.unreadCount > 99 ? '99+' : item.unreadCount.toString())
              .fontSize(12)
              .fontColor('#FFFFFF')
              .backgroundColor('#FF3B30')
              .borderRadius(10)
              .padding({ left: 6, right: 6, top: 2, bottom: 2 })
              .textAlign(TextAlign.Center)
          }
        }
        .width('100%')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .backgroundColor('#FFFFFF')
    .onClick(() => {
      // 导航到对应的聊天页面
      router.pushUrl({ url: item.chatPage })
    })
  }

  build() {
    Column() {
      // 顶部搜索栏
      Row() {
        Row() {
          Image($r('sys.media.ohos_ic_public_search_filled'))
            .width(20)
            .height(20)
            .fillColor('#999999')
            .margin({ right: 8 })

          TextInput({ placeholder: '搜索' })
            .layoutWeight(1)
            .backgroundColor('transparent')
            .onChange((value: string) => {
              this.searchText = value
            })
        }
        .width('85%')
        .height(36)
        .backgroundColor('#F5F5F5')
        .borderRadius(18)
        .padding({ left: 12, right: 12 })

        // 添加按钮
        Image($r('sys.media.ohos_ic_public_add'))
          .width(24)
          .height(24)
          .margin({ left: 12 })
      }
      .width('100%')
      .padding(12)
      .backgroundColor('#FFFFFF')

      // 消息列表
      if (this.messageList.length > 0) {
        List() {
          ForEach(this.messageList, (item: MessageItem) => {
            ListItem() {
              this.MessageItemView(item)
            }
          })
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor('#EDEDED')
        .divider({ strokeWidth: 1, color: '#EDEDED' })
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

      // 底部导航栏
      Row() {
        // 消息
        Column() {
          Image($r('sys.media.ohos_ic_public_email'))
            .width(24)
            .height(24)
            .fillColor(this.currentTab === 0 ? '#07C160' : '#999999')
          Text('消息')
            .fontSize(12)
            .fontColor(this.currentTab === 0 ? '#07C160' : '#999999')
            .margin({ top: 4 })
        }
        .layoutWeight(1)
        .onClick(() => {
          this.currentTab = 0
        })

        // 通讯录
        Column() {
          Image($r('sys.media.ohos_ic_public_phone'))
            .width(24)
            .height(24)
            .fillColor(this.currentTab === 1 ? '#07C160' : '#999999')
          Text('通讯录')
            .fontSize(12)
            .fontColor(this.currentTab === 1 ? '#07C160' : '#999999')
            .margin({ top: 4 })
        }
        .layoutWeight(1)
        .onClick(() => {
          this.currentTab = 1
          router.pushUrl({ url: 'pages/ContactsPage' })
        })

        // 发现
        Column() {
          Image($r('sys.media.ohos_ic_public_scan'))
            .width(24)
            .height(24)
            .fillColor(this.currentTab === 2 ? '#07C160' : '#999999')
          Text('发现')
            .fontSize(12)
            .fontColor(this.currentTab === 2 ? '#07C160' : '#999999')
            .margin({ top: 4 })
        }
        .layoutWeight(1)
        .onClick(() => {
          this.currentTab = 2
          router.pushUrl({ url: 'pages/DiscoverPage' })
        })

        // 我
        Column() {
          Image($r('sys.media.ohos_ic_public_device_phone'))
            .width(24)
            .height(24)
            .fillColor(this.currentTab === 3 ? '#07C160' : '#999999')
          Text('我')
            .fontSize(12)
            .fontColor(this.currentTab === 3 ? '#07C160' : '#999999')
            .margin({ top: 4 })
        }
        .layoutWeight(1)
        .onClick(() => {
          this.currentTab = 3
          router.pushUrl({ url: 'pages/ProfilePage' })
        })
      }
      .width('100%')
      .height(60)
      .backgroundColor('#FFFFFF')
      .border({ width: { top: 1 }, color: '#EDEDED' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#EDEDED')
  }
}
