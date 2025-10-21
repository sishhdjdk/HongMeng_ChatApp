/**
 * 群聊列表页
 * 功能：显示所有群聊
 */
import router from '@ohos.router'

class GroupItem {
  id: number
  name: string
  avatar: string
  memberCount: number

  constructor(id: number, name: string, avatar: string, memberCount: number) {
    this.id = id
    this.name = name
    this.avatar = avatar
    this.memberCount = memberCount
  }
}

@Entry
@Component
struct GroupListPage {
  @State groupList: GroupItem[] = [
    new GroupItem(1, '产品组', '', 8),
    new GroupItem(2, '研发团队', '', 15),
    new GroupItem(3, '家人', '', 5),
    new GroupItem(4, '大学同学', '', 20),
  ]

  @Builder
  GroupItemView(group: GroupItem) {
    Row() {
      Text('👥')
        .width(50)
        .height(50)
        .fontSize(32)
        .textAlign(TextAlign.Center)
        .backgroundColor('#F5F5F5')
        .borderRadius(8)
        .margin({ right: 12 })

      Column() {
        Text(group.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: 4 })

        Text(`${group.memberCount}人`)
          .fontSize(14)
          .fontColor('#999999')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Image($r('sys.media.ohos_ic_public_arrow_right'))
        .width(20)
        .height(20)
        .fillColor('#CCCCCC')
    }
    .width('100%')
    .height(70)
    .padding({ left: 16, right: 16 })
    .backgroundColor('#FFFFFF')
    .onClick(() => {
      router.pushUrl({ url: 'pages/GroupDetailPage' })
    })
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

        Text('群聊')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin({ left: 16 })
          .layoutWeight(1)

        Image($r('sys.media.ohos_ic_public_add'))
          .width(24)
          .height(24)
          .onClick(() => {
            router.pushUrl({ url: 'pages/CreateGroupPage' })
          })
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#FFFFFF')

      // 群聊列表
      if (this.groupList.length > 0) {
        List() {
          ForEach(this.groupList, (group: GroupItem) => {
            ListItem() {
              this.GroupItemView(group)
            }
          })
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor('#EDEDED')
        .divider({ strokeWidth: 1, color: '#EDEDED' })
      } else {
        Column() {
          Text('暂无群聊')
            .fontSize(16)
            .fontColor('#999999')
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#EDEDED')
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#EDEDED')
  }
}
