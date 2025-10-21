/**
 * 登录页
 * 功能：用户登录界面，包含账号密码输入、登录按钮、注册入口
 */
import router from '@ohos.router'

@Entry
@Component
struct LoginPage {
  @State account: string = '' // 账号
  @State password: string = '' // 密码
  @State isPasswordVisible: boolean = false // 密码是否可见
  @State canLogin: boolean = false // 是否可以登录

  // 检查是否可以登录
  checkCanLogin() {
    this.canLogin = this.account.length > 0 && this.password.length >= 6
  }

  // 登录操作
  handleLogin() {
    if (this.canLogin) {
      // 跳转到主页
      router.replaceUrl({ url: 'pages/MessageListPage' })
    }
  }

  build() {
    Column() {
      // 顶部返回按钮
      Row() {
        Image($r('sys.media.ohos_ic_public_arrow_left'))
          .width(24)
          .height(24)
          .onClick(() => {
            router.back()
          })
      }
      .width('100%')
      .padding(16)

      // Logo - 使用系统应用图标
      Image($r('sys.media.ohos_app_icon'))
        .width(80)
        .height(80)
        .margin({ top: 40, bottom: 20 })

      Text('欢迎登录')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 40 })

      // 账号输入框
      Column() {
        TextInput({ placeholder: '请输入手机号/账号' })
          .height(50)
          .fontSize(16)
          .backgroundColor('#F5F5F5')
          .borderRadius(8)
          .onChange((value: string) => {
            this.account = value
            this.checkCanLogin()
          })

        // 密码输入框
        Row() {
          TextInput({ placeholder: '请输入密码' })
            .height(50)
            .fontSize(16)
            .backgroundColor('#F5F5F5')
            .type(this.isPasswordVisible ? InputType.Normal : InputType.Password)
            .layoutWeight(1)
            .onChange((value: string) => {
              this.password = value
              this.checkCanLogin()
            })

          // 显示/隐藏密码按钮 - 使用文本替代
          Text(this.isPasswordVisible ? '隐藏' : '显示')
            .fontSize(14)
            .fontColor('#07C160')
            .margin({ left: 10 })
            .onClick(() => {
              this.isPasswordVisible = !this.isPasswordVisible
            })
        }
        .width('100%')
        .height(50)
        .backgroundColor('#F5F5F5')
        .borderRadius(8)
        .padding({ left: 16, right: 16 })
        .margin({ top: 16 })
      }
      .width('100%')
      .padding({ left: 20, right: 20 })

      // 登录按钮
      Button('登录')
        .width('90%')
        .height(50)
        .fontSize(18)
        .fontColor('#FFFFFF')
        .backgroundColor(this.canLogin ? '#07C160' : '#CCCCCC')
        .borderRadius(8)
        .margin({ top: 40 })
        .enabled(this.canLogin)
        .onClick(() => {
          this.handleLogin()
        })

      // 注册入口
      Row() {
        Text('还没有账号？')
          .fontSize(14)
          .fontColor('#666666')

        Text('立即注册')
          .fontSize(14)
          .fontColor('#07C160')
          .onClick(() => {
            router.pushUrl({ url: 'pages/RegisterPage' })
          })
      }
      .margin({ top: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
