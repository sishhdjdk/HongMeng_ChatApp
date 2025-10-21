/**
 * 个人资料编辑页
 * 功能：编辑个人信息
 */
import router from '@ohos.router'

@Entry
@Component
struct EditProfilePage {
  @State username: string = '微信用户'
  @State wechatId: string = 'wxid_123456'
  @State region: string = '广东 深圳'
  @State signature: string = '生活不止眼前的苟且...'


  @Builder
  InfoItem(title: string, content: string, showArrow: boolean = true) {
    Row() {
      Text(title)
        .fontSize(16)
        .width(100)

      Text(content)
        .fontSize(16)
        .fontColor('#666666')
        .layoutWeight(1)
        .textAlign(TextAlign.End)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .margin({ right: 8 })

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

        Text('个人信息')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin({ left: 16 })
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#FFFFFF')

      Scroll() {
        Column() {
          // 头像
          Row() {
            Text('头像')
              .fontSize(16)
              .layoutWeight(1)

            Text(this.username.substring(0, 1))
              .width(60)
              .height(60)
              .borderRadius(8)
              .backgroundColor('#07C160')
              .fontColor('#FFFFFF')
              .fontSize(28)
              .textAlign(TextAlign.Center)
              .margin({ right: 8 })

            Image($r('sys.media.ohos_ic_public_arrow_right'))
              .width(20)
              .height(20)
              .fillColor('#CCCCCC')
          }
          .width('100%')
          .height(80)
          .padding({ left: 16, right: 16 })
          .backgroundColor('#FFFFFF')
          .margin({ top: 8 })

          // 昵称
          Column() {
            this.InfoItem('昵称', this.username)
            Divider().strokeWidth(1).color('#EDEDED')
            this.InfoItem('微信号', this.wechatId)
            Divider().strokeWidth(1).color('#EDEDED')

            // 二维码名片
            Row() {
              Text('我的二维码')
                .fontSize(16)
                .layoutWeight(1)

              Text('📱')
                .fontSize(24)
                .margin({ right: 8 })

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
          .margin({ top: 8 })

          // 更多信息
          Column() {
            this.InfoItem('性别', '男')
            Divider().strokeWidth(1).color('#EDEDED')
            this.InfoItem('地区', this.region)
            Divider().strokeWidth(1).color('#EDEDED')
            this.InfoItem('个性签名', this.signature)
          }
          .margin({ top: 8 })

          // 更多设置
          Column() {
            this.InfoItem('更多', '')
          }
          .margin({ top: 8, bottom: 20 })
        }
      }
      .layoutWeight(1)
      .backgroundColor('#EDEDED')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#EDEDED')
  }
}
