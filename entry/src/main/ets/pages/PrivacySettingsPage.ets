/**
 * 隐私设置页
 * 功能：隐私相关设置
 */
import router from '@ohos.router'

@Entry
@Component
struct PrivacySettingsPage {
  @State addMeByPhone: boolean = true
  @State addMeByWechat: boolean = true

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

  @Builder
  SwitchItem(title: string, isOn: boolean, onChange: () => void) {
    Row() {
      Text(title)
        .fontSize(16)
        .layoutWeight(1)

      Toggle({ type: ToggleType.Switch, isOn: isOn })
        .onChange((value: boolean) => {
          onChange()
        })
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

        Text('隐私设置')
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
        ListItem() {
          Column() {
            this.MenuItem('添加我的方式', '')
            Divider().strokeWidth(1).color('#EDEDED')
            this.MenuItem('不让他(她)看', '')
            Divider().strokeWidth(1).color('#EDEDED')
            this.MenuItem('不看他(她)', '')
          }
          .margin({ top: 8 })
        }

        ListItem() {
          Column() {
            this.SwitchItem('加我为朋友时需要验证', this.addMeByPhone, () => {
              this.addMeByPhone = !this.addMeByPhone
            })
            Divider().strokeWidth(1).color('#EDEDED')
            this.SwitchItem('向我推荐通讯录朋友', this.addMeByWechat, () => {
              this.addMeByWechat = !this.addMeByWechat
            })
          }
          .margin({ top: 8 })
        }

        ListItem() {
          Column() {
            this.MenuItem('授权管理', '')
          }
          .margin({ top: 8 })
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
