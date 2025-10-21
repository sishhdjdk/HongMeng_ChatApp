/**
 * 启动页
 * 功能：应用启动欢迎页，显示Logo，3秒后自动跳转到登录页
 */
import router from '@ohos.router'

@Entry
@Component
struct SplashPage {
  @State alpha: number = 0 // 透明度动画

  // 页面生命周期：页面即将显示
  aboutToAppear() {
    // 渐显动画
    animateTo({ duration: 1000 }, () => {
      this.alpha = 1
    })

    // 3秒后跳转到登录页
    setTimeout(() => {
      router.pushUrl({ url: 'pages/LoginPage' })
    }, 3000)
  }

  build() {
    Column() {
      // Logo图标 - 使用系统应用图标
      Image($r('sys.media.ohos_app_icon'))
        .width(120)
        .height(120)
        .margin({ bottom: 20 })
        .opacity(this.alpha)

      // 应用名称
      Text('聊天助手')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor('#07C160')
        .opacity(this.alpha)

      // 欢迎语
      Text('连接你我，沟通无限')
        .fontSize(16)
        .fontColor('#999999')
        .margin({ top: 10 })
        .opacity(this.alpha)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor('#FFFFFF')
  }
}
