/**
 * 账号与安全页
 * 功能：账号安全相关设置
 */
import router from '@ohos.router'

@Entry
@Component
struct AccountSecurityPage {
  @Builder
  MenuItem(title: string, rightText?: string, showArrow: boolean = true) {
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

        Text('账号与安全')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin({ left: 16 })
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#FFFFFF')

      // 设置列表
      Column() {
        this.MenuItem('微信号', 'wxid_123456')
        Divider().strokeWidth(1).color('#EDEDED')
        this.MenuItem('手机号', '138****8888')
        Divider().strokeWidth(1).color('#EDEDED')
        this.MenuItem('邮箱地址', '未绑定')
        Divider().strokeWidth(1).color('#EDEDED')
        this.MenuItem('微信密码', '已设置')
        Divider().strokeWidth(1).color('#EDEDED')
        this.MenuItem('声音锁', '未设置')
        Divider().strokeWidth(1).color('#EDEDED')
        this.MenuItem('登录设备管理', '')
        Divider().strokeWidth(1).color('#EDEDED')
        this.MenuItem('更多安全设置', '')
      }
      .width('100%')
      .margin({ top: 8 })

      // 安全提示
      Text('保护账号安全，定期修改密码')
        .fontSize(14)
        .fontColor('#999999')
        .margin({ top: 20 })
        .padding({ left: 16, right: 16 })

      Blank()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#EDEDED')
  }
}
