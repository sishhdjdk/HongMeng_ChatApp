/**
 * 通知设置页
 * 功能：消息通知相关设置
 */
import router from '@ohos.router'

@Entry
@Component
struct NotificationSettingsPage {
  @State enableNotification: boolean = true
  @State enableSound: boolean = true
  @State enableVibration: boolean = true

  @Builder
  SwitchItem(title: string, subtitle: string, isOn: boolean, onChange: () => void) {
    Row() {
      Column() {
        Text(title)
          .fontSize(16)
          .margin({ bottom: 4 })

        Text(subtitle)
          .fontSize(14)
          .fontColor('#999999')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Toggle({ type: ToggleType.Switch, isOn: isOn })
        .onChange((value: boolean) => {
          onChange()
        })
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
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

        Text('新消息通知')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin({ left: 16 })
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#FFFFFF')

      // 通知设置
      Column() {
        this.SwitchItem('接收新消息通知', '关闭后将不再收到任何通知', this.enableNotification, () => {
          this.enableNotification = !this.enableNotification
        })

        Divider().strokeWidth(1).color('#EDEDED')

        this.SwitchItem('通知显示消息详情', '关闭后通知不显示发送人和内容摘要', this.enableSound, () => {
          this.enableSound = !this.enableSound
        })

        Divider().strokeWidth(1).color('#EDEDED')

        this.SwitchItem('声音', '', this.enableVibration, () => {
          this.enableVibration = !this.enableVibration
        })
      }
      .width('100%')
      .margin({ top: 8 })

      Blank()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#EDEDED')
  }
}
