/**
 * 通讯录页
 * 功能：显示联系人列表，按字母索引排序
 */
import router from '@ohos.router'

// 联系人数据模型
class Contact {
  id: number
  name: string
  avatar: string
  letter: string // 首字母

  constructor(id: number, name: string, avatar: string, letter: string) {
    this.id = id
    this.name = name
    this.avatar = avatar
    this.letter = letter
  }
}

@Entry
@Component
struct ContactsPage {
  @State currentTab: number = 1 // 当前选中的Tab，1=通讯录
  @State searchText: string = ''
  @State contactList: Contact[] = [
    new Contact(1, '阿强', '', 'A'),
    new Contact(2, '阿明', '', 'A'),
    new Contact(3, '陈大', '', 'C'),
    new Contact(4, '陈小', '', 'C'),
    new Contact(5, '李四', '', 'L'),
    new Contact(6, '李雷', '', 'L'),
    new Contact(7, '王五', '', 'W'),
    new Contact(8, '张三', '', 'Z'),
    new Contact(9, '赵六', '', 'Z'),
  ]
  @State letterList: string[] = ['A', 'C', 'L', 'W', 'Z']

  // 功能入口项组件
  @Builder
  FunctionItem(icon: string, title: string, url: string) {
    Row() {
      Text(icon)
        .width(40)
        .height(40)
        .fontSize(24)
        .textAlign(TextAlign.Center)
        .backgroundColor('#F5F5F5')
        .borderRadius(8)
        .margin({ right: 12 })

      Text(title)
        .fontSize(16)
        .layoutWeight(1)

      Image($r('sys.media.ohos_ic_public_arrow_right'))
        .width(20)
        .height(20)
        .fillColor('#CCCCCC')
    }
    .width('100%')
    .height(60)
    .padding({ left: 16, right: 16 })
    .backgroundColor('#FFFFFF')
    .onClick(() => {
      router.pushUrl({ url: url })
    })
  }

  // 联系人项组件
  @Builder
  ContactItem(contact: Contact) {
    Row() {
      Text(contact.name.substring(0, 1))
        .width(40)
        .height(40)
        .borderRadius(4)
        .backgroundColor('#07C160')
        .fontColor('#FFFFFF')
        .fontSize(16)
        .textAlign(TextAlign.Center)
        .margin({ right: 12 })

      Text(contact.name)
        .fontSize(16)
        .layoutWeight(1)

      Image($r('sys.media.ohos_ic_public_arrow_right'))
        .width(20)
        .height(20)
        .fillColor('#CCCCCC')
    }
    .width('100%')
    .height(60)
    .padding({ left: 16, right: 16 })
    .backgroundColor('#FFFFFF')
    .onClick(() => {
      router.pushUrl({ url: 'pages/ContactDetailPage' })
    })
  }

  build() {
    Column() {
      // 顶部标题
      Row() {
        Text('通讯录')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)

        Blank()

        Image($r('sys.media.ohos_ic_public_add'))
          .width(24)
          .height(24)
          .onClick(() => {
            router.pushUrl({ url: 'pages/AddFriendPage' })
          })
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#FFFFFF')

      // 搜索框
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
      .width('90%')
      .height(36)
      .backgroundColor('#F5F5F5')
      .borderRadius(18)
      .padding({ left: 12, right: 12 })
      .margin({ top: 8, bottom: 8 })

      // 联系人列表
      List() {
        // 功能入口
        ListItem() {
          Column() {
            this.FunctionItem('👥', '新的朋友', 'pages/NewFriendPage')
            Divider().strokeWidth(1).color('#EDEDED')
            this.FunctionItem('👨‍👩‍👧‍👦', '群聊', 'pages/GroupListPage')
            Divider().strokeWidth(1).color('#EDEDED')
            this.FunctionItem('🏷️', '标签', 'pages/TagPage')
          }
          .margin({ bottom: 8 })
        }

        // 联系人列表（按字母分组）
        ForEach(this.letterList, (letter: string) => {
          ListItemGroup({ header: this.GroupHeader(letter) }) {
            ForEach(this.contactList.filter(c => c.letter === letter), (contact: Contact) => {
              ListItem() {
                this.ContactItem(contact)
              }
            })
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#EDEDED')

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
          router.back()
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

  // 分组头部
  @Builder
  GroupHeader(letter: string) {
    Text(letter)
      .fontSize(14)
      .fontColor('#666666')
      .width('100%')
      .height(30)
      .backgroundColor('#F5F5F5')
      .padding({ left: 16 })
  }
}
