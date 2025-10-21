/**
 * 群聊详情页
 * 功能：显示群聊信息和成员列表
 */
import router from '@ohos.router'

class GroupMember {
  id: number
  name: string
  avatar: string

  constructor(id: number, name: string, avatar: string) {
    this.id = id
    this.name = name
    this.avatar = avatar
  }
}

@Entry
@Component
struct GroupDetailPage {
  @State groupName: string = '产品组'
  @State memberList: GroupMember[] = [
    new GroupMember(1, '张三', ''),
    new GroupMember(2, '李四', ''),
    new GroupMember(3, '王五', ''),
    new GroupMember(4, '赵六', ''),
    new GroupMember(5, '孙七', ''),
    new GroupMember(6, '周八', ''),
  ]
  @State showNickname: boolean = true

  @Builder
  MemberItem(member: GroupMember) {
    Column() {
      Text(member.name.substring(0, 1))
        .width(50)
        .height(50)
        .borderRadius(8)
        .backgroundColor('#07C160')
        .fontColor('#FFFFFF')
        .fontSize(20)
        .textAlign(TextAlign.Center)
        .margin({ bottom: 6 })

      Text(member.name)
        .fontSize(12)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .width(70)
    .margin(8)
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
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#FFFFFF')

      Scroll() {
        Column() {
          // 成员列表
          Column() {
            Grid() {
              ForEach(this.memberList, (member: GroupMember) => {
                GridItem() {
                  this.MemberItem(member)
                }
              })

              // 添加成员按钮
              GridItem() {
                Column() {
                  Text('+')
                    .width(50)
                    .height(50)
                    .fontSize(32)
                    .fontColor('#999999')
                    .textAlign(TextAlign.Center)
                    .borderRadius(8)
                    .backgroundColor('#F5F5F5')
                }
                .width(70)
                .margin(8)
              }

              // 删除成员按钮
              GridItem() {
                Column() {
                  Text('-')
                    .width(50)
                    .height(50)
                    .fontSize(32)
                    .fontColor('#999999')
                    .textAlign(TextAlign.Center)
                    .borderRadius(8)
                    .backgroundColor('#F5F5F5')
                }
                .width(70)
                .margin(8)
              }
            }
            .columnsTemplate('1fr 1fr 1fr 1fr')
            .width('100%')
            .padding(8)
          }
          .width('100%')
          .backgroundColor('#FFFFFF')

          // 群聊名称
          Row() {
            Text('群聊名称')
              .fontSize(16)
              .layoutWeight(1)

            Text(this.groupName)
              .fontSize(16)
              .fontColor('#999999')
              .margin({ right: 8 })

            Image($r('sys.media.ohos_ic_public_arrow_right'))
              .width(20)
              .height(20)
              .fillColor('#CCCCCC')
          }
          .width('100%')
          .height(56)
          .padding({ left: 16, right: 16 })
          .backgroundColor('#FFFFFF')
          .margin({ top: 8 })

          // 群公告
          Row() {
            Text('群公告')
              .fontSize(16)
              .layoutWeight(1)

            Text('未设置')
              .fontSize(16)
              .fontColor('#999999')
              .margin({ right: 8 })

            Image($r('sys.media.ohos_ic_public_arrow_right'))
              .width(20)
              .height(20)
              .fillColor('#CCCCCC')
          }
          .width('100%')
          .height(56)
          .padding({ left: 16, right: 16 })
          .backgroundColor('#FFFFFF')
          .margin({ top: 8 })

          // 显示群成员昵称
          Row() {
            Text('显示群成员昵称')
              .fontSize(16)
              .layoutWeight(1)

            Toggle({ type: ToggleType.Switch, isOn: this.showNickname })
              .onChange((value: boolean) => {
                this.showNickname = value
              })
          }
          .width('100%')
          .height(56)
          .padding({ left: 16, right: 16 })
          .backgroundColor('#FFFFFF')
          .margin({ top: 8 })

          // 退出群聊
          Button('退出群聊')
            .width('90%')
            .height(50)
            .fontSize(16)
            .fontColor('#FF3B30')
            .backgroundColor('#FFFFFF')
            .margin({ top: 20, bottom: 20 })
        }
      }
      .layoutWeight(1)
      .backgroundColor('#EDEDED')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#EDEDED')
  }
}
