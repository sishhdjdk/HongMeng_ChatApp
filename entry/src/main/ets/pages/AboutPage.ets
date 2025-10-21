/**
 * 关于我们页
 * 功能：应用信息展示
 */
import router from '@ohos.router'

@Entry
@Component
struct AboutPage {
  @State appVersion: string = 'v8.0.32'

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

        Text('关于微信')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin({ left: 16 })
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#FFFFFF')

      // Logo和版本信息
      Column() {
        Image($r('sys.media.ohos_app_icon'))
          .width(80)
          .height(80)
          .margin({ top: 60, bottom: 20 })

        Text('微信')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 8 })

        Text(this.appVersion)
          .fontSize(16)
          .fontColor('#999999')
      }
      .width('100%')

      // 功能链接
      Column() {
        Row() {
          Text('功能介绍')
            .fontSize(16)
            .layoutWeight(1)

          Image($r('sys.media.ohos_ic_public_arrow_right'))
            .width(20)
            .height(20)
            .fillColor('#CCCCCC')
        }
        .width('100%')
        .height(56)
        .padding({ left: 16, right: 16 })
        .backgroundColor('#FFFFFF')

        Divider().strokeWidth(1).color('#EDEDED')

        Row() {
          Text('投诉')
            .fontSize(16)
            .layoutWeight(1)

          Image($r('sys.media.ohos_ic_public_arrow_right'))
            .width(20)
            .height(20)
            .fillColor('#CCCCCC')
        }
        .width('100%')
        .height(56)
        .padding({ left: 16, right: 16 })
        .backgroundColor('#FFFFFF')
      }
      .margin({ top: 40 })

      // 底部版权信息
      Column() {
        Text('Copyright © 2011-2024 Tencent')
          .fontSize(12)
          .fontColor('#999999')
          .margin({ bottom: 4 })

        Text('All Rights Reserved')
          .fontSize(12)
          .fontColor('#999999')
      }
      .width('100%')
      .margin({ top: 60 })

      Blank()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#EDEDED')
  }
}
