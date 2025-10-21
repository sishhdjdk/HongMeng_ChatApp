/**
 * 设置页
 * 功能：应用设置入口
 */
import router from '@ohos.router'

@Entry
@Component
struct SettingsPage {
  @State username: string = '微信用户'

  @Builder
  MenuItem(title: string, url?: string, showArrow: boolean = true, rightText?: string) {
    Row() {
      Text(title)
        .fontSize(16)
        .layoutWeight(1)

      if (rightText) {
        Text(rightText)
          .fontSize(16)
          .fontColor('#999999')
          .margin({ right: 8 })
      }

      if (showArrow) {
        Image($r('sys.media.ohos_ic_public_arrow_right'))
          .width(20)
          .height(20)
          .fillColor('#CCCCCC')
      }
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
      // 顶部导航栏
      Row() {
        Image($r('sys.media.ohos_ic_public_arrow_left'))
          .width(24)
          .height(24)
          .onClick(() => {
            router.back()
          })

        Text('设置')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin({ left: 16 })
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#FFFFFF')

      // 设置列表
      List() {
        // 账号
        ListItem() {
          Row() {
            Text(this.username.substring(0, 1))
              .width(50)
              .height(50)
              .borderRadius(8)
              .backgroundColor('#07C160')
              .fontColor('#FFFFFF')
              .fontSize(20)
              .textAlign(TextAlign.Center)
              .margin({ right: 12 })

            Column() {
              Text(this.username)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .margin({ bottom: 4 })

              Text('微信号：wxid_123456')
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
          .height(80)
          .padding({ left: 16, right: 16 })
          .backgroundColor('#FFFFFF')
        }

        // 账号与安全
        ListItem() {
          Column() {
            this.MenuItem('账号与安全', 'pages/AccountSecurityPage')
          }
          .margin({ top: 8 })
        }

        // 新消息通知
        ListItem() {
          Column() {
            this.MenuItem('新消息通知', 'pages/NotificationSettingsPage')
          }
          .margin({ top: 8 })
        }

        // 隐私
        ListItem() {
          Column() {
            this.MenuItem('隐私', 'pages/PrivacySettingsPage')
          }
          .margin({ top: 8 })
        }

        // 通用
        ListItem() {
          Column() {
            this.MenuItem('通用', 'pages/GeneralSettingsPage')
            Divider().strokeWidth(1).color('#EDEDED')
            this.MenuItem('存储空间', '', true, '2.3GB')
          }
          .margin({ top: 8 })
        }

        // 关于
        ListItem() {
          Column() {
            this.MenuItem('关于微信', 'pages/AboutPage')
            Divider().strokeWidth(1).color('#EDEDED')
            this.MenuItem('帮助与反馈', 'pages/HelpPage')
          }
          .margin({ top: 8 })
        }

        // 退出登录
        ListItem() {
          Button('退出登录')
            .width('90%')
            .height(50)
            .fontSize(16)
            .fontColor('#FF3B30')
            .backgroundColor('#FFFFFF')
            .margin({ top: 20, bottom: 20 })
            .onClick(() => {
              router.replaceUrl({ url: 'pages/LoginPage' })
            })
        }
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#EDEDED')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#EDEDED')
  }
}
