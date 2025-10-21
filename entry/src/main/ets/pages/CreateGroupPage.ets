/**
 * 创建群聊页
 * 功能：选择联系人创建群聊
 */
import router from '@ohos.router'

class Contact {
  id: number
  name: string
  avatar: string
  selected: boolean

  constructor(id: number, name: string, avatar: string) {
    this.id = id
    this.name = name
    this.avatar = avatar
    this.selected = false
  }
}

@Entry
@Component
struct CreateGroupPage {
  @State contactList: Contact[] = [
    new Contact(1, '张三', ''),
    new Contact(2, '李四', ''),
    new Contact(3, '王五', ''),
    new Contact(4, '赵六', ''),
    new Contact(5, '孙七', ''),
  ]
  @State selectedCount: number = 0

  // 切换选中状态
  toggleSelect(id: number) {
    const contact = this.contactList.find(c => c.id === id)
    if (contact) {
      contact.selected = !contact.selected
      this.selectedCount = this.contactList.filter(c => c.selected).length
    }
  }

  // 创建群聊
  createGroup() {
    if (this.selectedCount >= 2) {
      router.pushUrl({ url: 'pages/GroupDetailPage' })
    }
  }

  @Builder
  ContactItem(contact: Contact) {
    Row() {
      // 选择框 - 使用简单的方框表示
      Text(contact.selected ? '✓' : '○')
        .width(24)
        .height(24)
        .fontSize(20)
        .fontColor(contact.selected ? '#07C160' : '#CCCCCC')
        .textAlign(TextAlign.Center)
        .margin({ right: 12 })

      // 头像
      Text(contact.name.substring(0, 1))
        .width(40)
        .height(40)
        .borderRadius(4)
        .backgroundColor('#07C160')
        .fontColor('#FFFFFF')
        .fontSize(16)
        .textAlign(TextAlign.Center)
        .margin({ right: 12 })

      // 昵称
      Text(contact.name)
        .fontSize(16)
        .layoutWeight(1)
    }
    .width('100%')
    .height(60)
    .padding({ left: 16, right: 16 })
    .backgroundColor('#FFFFFF')
    .onClick(() => {
      this.toggleSelect(contact.id)
    })
  }

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Text('取消')
          .fontSize(16)
          .fontColor('#666666')
          .onClick(() => {
            router.back()
          })

        Text('选择联系人')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('完成')
          .fontSize(16)
          .fontColor(this.selectedCount >= 2 ? '#07C160' : '#CCCCCC')
          .onClick(() => {
            this.createGroup()
          })
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#FFFFFF')

      // 已选择的联系人
      if (this.selectedCount > 0) {
        Row() {
          Text(`已选择 ${this.selectedCount} 人`)
            .fontSize(14)
            .fontColor('#666666')
        }
        .width('100%')
        .height(40)
        .padding({ left: 16, right: 16 })
        .backgroundColor('#F5F5F5')
      }

      // 联系人列表
      List() {
        ForEach(this.contactList, (contact: Contact) => {
          ListItem() {
            this.ContactItem(contact)
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#EDEDED')
      .divider({ strokeWidth: 1, color: '#EDEDED' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#EDEDED')
  }
}
