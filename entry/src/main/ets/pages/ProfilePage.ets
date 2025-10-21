/**
 * 个人中心页
 * 功能：显示个人信息、功能入口、设置等
 */
import router from '@ohos.router'

@Entry
@Component
struct ProfilePage {
  @State currentTab: number = 3 // 当前选中的Tab，3=我
  @State username: string = '微信用户'
  @State wechatId: string = 'wxid_123456'

  // 功能项组件
  @Builder
  MenuItem(icon: string, title: string, url?: string, showBadge: boolean = false) {
    Row() {
      Text(icon)
        .width(24)
        .height(24)
        .fontSize(20)
        .textAlign(TextAlign.Center)
        .margin({ right: 12 })

      Text(title)
        .fontSize(16)
        .layoutWeight(1)

      if (showBadge) {
        Text('New')
          .fontSize(12)
          .fontColor('#FFFFFF')
          .backgroundColor('#FF3B30')
          .borderRadius(4)
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          .margin({ right: 8 })
      }

      Image($r('sys.media.ohos_ic_public_arrow_right'))
        .width(20)
        .height(20)
        .fillColor('#CCCCCC')
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .backgroundColor('#FFFFFF')
    .onClick(() => {
      if (url) {
        router.pushUrl({ url: url })
      }
    })
  }

  build() {
    Column() {
      // 顶部个人信息卡片
      Row() {
        // 头像 - 使用文本占位符
        Text(this.username.substring(0, 1))
          .width(70)
          .height(70)
          .borderRadius(8)
          .backgroundColor('#07C160')
          .fontColor('#FFFFFF')
          .fontSize(32)
          .textAlign(TextAlign.Center)
          .margin({ right: 16 })

        Column() {
          // 昵称
          Text(this.username)
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: 8 })

          // 微信号
          Row() {
            Text(`微信号：${this.wechatId}`)
              .fontSize(14)
              .fontColor('#666666')

            Image($r('sys.media.ohos_ic_public_copy'))
              .width(16)
              .height(16)
              .fillColor('#999999')
              .margin({ left: 8 })
          }
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        // 二维码
        Text('📱')
          .fontSize(24)
          .margin({ left: 8 })
      }
      .width('100%')
      .padding(20)
      .backgroundColor('#FFFFFF')
      .onClick(() => {
        router.pushUrl({ url: 'pages/EditProfilePage' })
      })

      // 功能列表
      List() {
        // 服务
        ListItem() {
          Column() {
            this.MenuItem('💼', '服务', 'pages/ServicePage')
          }
          .margin({ top: 8 })
        }

        // 收藏、朋友圈、卡包、表情
        ListItem() {
          Column() {
            this.MenuItem('⭐', '收藏', 'pages/FavoritePage')
            Divider().strokeWidth(1).color('#EDEDED')
            this.MenuItem('📷', '朋友圈', 'pages/MomentsDetailPage')
            Divider().strokeWidth(1).color('#EDEDED')
            this.MenuItem('💳', '卡包', 'pages/CardsPage')
            Divider().strokeWidth(1).color('#EDEDED')
            this.MenuItem('😊', '表情', 'pages/EmojiPage')
          }
          .margin({ top: 8 })
        }

        // 设置
        ListItem() {
          Column() {
            this.MenuItem('⚙️', '设置', 'pages/SettingsPage')
          }
          .margin({ top: 8, bottom: 8 })
        }
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#EDEDED')

      // 底部导航栏
      Row() {
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
          router.pushUrl({ url: 'pages/MessageListPage' })
        })

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
