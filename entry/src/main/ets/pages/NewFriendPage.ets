/**
 * 新朋友页
 * 功能：显示好友申请列表
 */
import router from '@ohos.router'

class FriendRequest {
  id: number
  name: string
  avatar: string
  message: string
  status: number // 0=待处理，1=已同意，2=已拒绝

  constructor(id: number, name: string, avatar: string, message: string, status: number) {
    this.id = id
    this.name = name
    this.avatar = avatar
    this.message = message
    this.status = status
  }
}

@Entry
@Component
struct NewFriendPage {
  @State requestList: FriendRequest[] = [
    new FriendRequest(1, '王五', '', '我是王五', 0),
    new FriendRequest(2, '赵六', '', '你好，加个好友', 1),
    new FriendRequest(3, '孙七', '', '', 0),
  ]

  // 同意好友申请
  acceptRequest(id: number) {
    const index = this.requestList.findIndex(item => item.id === id)
    if (index !== -1) {
      this.requestList[index].status = 1
    }
  }

  // 拒绝好友申请
  rejectRequest(id: number) {
    const index = this.requestList.findIndex(item => item.id === id)
    if (index !== -1) {
      this.requestList[index].status = 2
    }
  }

  @Builder
  RequestItem(request: FriendRequest) {
    Row() {
      Text(request.name.substring(0, 1))
        .width(50)
        .height(50)
        .borderRadius(8)
        .backgroundColor('#07C160')
        .fontColor('#FFFFFF')
        .fontSize(20)
        .textAlign(TextAlign.Center)
        .margin({ right: 12 })

      Column() {
        Text(request.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: 4 })

        if (request.message) {
          Text(request.message)
            .fontSize(14)
            .fontColor('#999999')
            .maxLines(1)
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      // 操作按钮
      if (request.status === 0) {
        Row() {
          Button('拒绝')
            .fontSize(14)
            .fontColor('#666666')
            .backgroundColor('#F5F5F5')
            .height(32)
            .margin({ right: 8 })
            .onClick(() => {
              this.rejectRequest(request.id)
            })

          Button('接受')
            .fontSize(14)
            .fontColor('#FFFFFF')
            .backgroundColor('#07C160')
            .height(32)
            .onClick(() => {
              this.acceptRequest(request.id)
            })
        }
      } else if (request.status === 1) {
        Text('已添加')
          .fontSize(14)
          .fontColor('#999999')
      } else {
        Text('已拒绝')
          .fontSize(14)
          .fontColor('#999999')
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
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

        Text('新的朋友')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin({ left: 16 })
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#FFFFFF')

      // 好友申请列表
      if (this.requestList.length > 0) {
        List() {
          ForEach(this.requestList, (request: FriendRequest) => {
            ListItem() {
              this.RequestItem(request)
            }
          })
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor('#EDEDED')
        .divider({ strokeWidth: 1, color: '#EDEDED' })
      } else {
        Column() {
          Text('暂无新朋友')
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
