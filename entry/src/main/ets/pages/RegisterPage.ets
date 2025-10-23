import {register} from "../http/userHttp"
/**
 * 注册页
 * 功能：用户注册界面，包含用户名、手机号、密码输入和注册按钮
 */
import router from '@ohos.router'

@Entry
@Component
struct RegisterPage {
  @State username: string = '' // 用户名
  @State phone: string = '' // 手机号
  @State password: string = '' // 密码
  @State confirmPassword: string = '' // 确认密码
  @State canRegister: boolean = false // 是否可以注册

  // 检查是否可以注册
  checkCanRegister() {
    this.canRegister = this.username.length > 0 &&
                       this.phone.length === 11 &&
                       this.password.length >= 6 &&
                       this.password === this.confirmPassword
  }


  // 注册操作
  handleRegister() {
    if (this.canRegister) {
    let date = JSON.stringify({"username":this.username,"password":this.password,"phone":this.phone})
      console.log(date)
    register(date).then((res)=>{
      console.log("res" + JSON.stringify(res));
      this.getUIContext().getRouter().replaceUrl({
        url:"pages/LoginPage"
      })


    }).catch(()=>{})
    }
  }

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Image($r('sys.media.ohos_ic_public_arrow_left'))
          .width(24)
          .height(24)
          .onClick(() => {
            this.getUIContext().getRouter().replaceUrl({
              url:"pages/LoginPage"
            })
          })

        Text('注册账号')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin({ left: 16 })
      }
      .width('100%')
      .padding(16)

      // 注册表单
      Column() {
        // 用户名输入框
        TextInput({ placeholder: '请输入用户名' })
          .height(50)
          .fontSize(16)
          .backgroundColor('#F5F5F5')
          .borderRadius(8)
          .margin({ bottom: 16 })
          .onChange((value: string) => {
            this.username = value
            this.checkCanRegister()
          })

        // 手机号输入框
        TextInput({ placeholder: '请输入手机号' })
          .height(50)
          .fontSize(16)
          .backgroundColor('#F5F5F5')
          .borderRadius(8)
          .type(InputType.PhoneNumber)
          .maxLength(11)
          .margin({ bottom: 16 })
          .onChange((value: string) => {
            this.phone = value
            this.checkCanRegister()
          })

        // 密码输入框
        TextInput({ placeholder: '请设置密码（至少6位）' })
          .height(50)
          .fontSize(16)
          .backgroundColor('#F5F5F5')
          .borderRadius(8)
          .type(InputType.Password)
          .margin({ bottom: 16 })
          .onChange((value: string) => {
            this.password = value
            this.checkCanRegister()
          })

        // 确认密码输入框
        TextInput({ placeholder: '请再次输入密码' })
          .height(50)
          .fontSize(16)
          .backgroundColor('#F5F5F5')
          .borderRadius(8)
          .type(InputType.Password)
          .onChange((value: string) => {
            this.confirmPassword = value
            this.checkCanRegister()
          })
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 20 })

      // 注册按钮
      Button('注册')
        .width('90%')
        .height(50)
        .fontSize(18)
        .fontColor('#FFFFFF')
        .backgroundColor(this.canRegister ? '#07C160' : '#CCCCCC')
        .borderRadius(8)
        .margin({ top: 40 })
        .enabled(this.canRegister)
        .onClick(() => {
          this.handleRegister()
        })

      // 用户协议
      Row() {
        Text('注册即表示同意')
          .fontSize(12)
          .fontColor('#999999')

        Text('《用户协议》')
          .fontSize(12)
          .fontColor('#07C160')

        Text('和')
          .fontSize(12)
          .fontColor('#999999')

        Text('《隐私政策》')
          .fontSize(12)
          .fontColor('#07C160')
      }
      .margin({ top: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
