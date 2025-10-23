/**
 * 启动页
 * 功能：应用启动欢迎页，显示Logo，3秒后自动跳转到登录页
 */
import router from '@ohos.router'

@Entry
@Component
struct SplashPage {


  build() {
    Column() {
      // Logo图标 - 使用系统应用图标
      Image($r('sys.media.ohos_app_icon'))
        .width(120)
        .height(120)
        .margin({ bottom: 20 })
      // 应用名称
      Text('聊天助手')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor('#07C160')

      // 欢迎语
      Text('连接你我，沟通无限')
        .fontSize(16)
        .fontColor('#999999')
        .margin({ top: 10 })
      //跳转按钮
      Button('前往登录')
        .width('90%')
        .height(50)
        .fontSize(18)
        .fontColor('#FFFFFF')
        .backgroundColor('#CCCCCC')
        .borderRadius(8)
        .margin({ top: 40 })
        .onClick(() => {
          this.getUIContext().getRouter().replaceUrl({
            url:"pages/LoginPage"
          }
          )
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor('#FFFFFF')
  }
}
