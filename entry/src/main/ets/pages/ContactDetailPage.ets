/**
 * 联系人详情页
 * 功能：查看联系人详细信息，发送消息、视频通话等操作
 */
import router from '@ohos.router'

@Entry
@Component
struct ContactDetailPage {
  @State contactName: string = '张三'
  @State wechatId: string = 'zhangsan123'
  @State tags: string[] = ['同事', '朋友']
  @State region: string = '广东 深圳'

  // 功能项组件
  @Builder
  InfoItem(title: string, content: string, showArrow: boolean = false) {
    Row() {
      Text(title)
        .fontSize(16)
        .fontColor('#666666')
        .width(100)

      Text(content)
        .fontSize(16)
        .layoutWeight(1)

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
          .fillColor('#FFFFFF')
          .onClick(() => {
            router.back()
          })

        Blank()

        Image($r('sys.media.ohos_ic_public_more'))
          .width(24)
          .height(24)
          .fillColor('#FFFFFF')
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#07C160')

      // 内容区域
      Scroll() {
        Column() {
          // 头像和昵称
          Column() {
            Text(this.contactName.substring(0, 1))
              .width(80)
              .height(80)
              .borderRadius(8)
              .backgroundColor('#07C160')
              .fontColor('#FFFFFF')
              .fontSize(36)
              .textAlign(TextAlign.Center)
              .margin({ top: 20, bottom: 16 })

            Text(this.contactName)
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .margin({ bottom: 8 })

            Text(`微信号：${this.wechatId}`)
              .fontSize(14)
              .fontColor('#666666')
              .margin({ bottom: 20 })
          }
          .width('100%')
          .backgroundColor('#FFFFFF')
          .padding({ bottom: 20 })

          // 操作按钮
          Row() {
            Column() {
              Text('💬')
                .fontSize(28)
                .margin({ bottom: 8 })

              Text('发消息')
                .fontSize(14)
                .fontColor('#666666')
            }
            .layoutWeight(1)
            .onClick(() => {
              router.pushUrl({ url: 'pages/ChatDetailPage' })
            })

            Divider().vertical(true).height(40).color('#EDEDED')

            Column() {
              Text('📹')
                .fontSize(28)
                .margin({ bottom: 8 })

              Text('视频通话')
                .fontSize(14)
                .fontColor('#666666')
            }
            .layoutWeight(1)

            Divider().vertical(true).height(40).color('#EDEDED')

            Column() {
              Text('📞')
                .fontSize(28)
                .margin({ bottom: 8 })

              Text('语音通话')
                .fontSize(14)
                .fontColor('#666666')
            }
            .layoutWeight(1)
          }
          .width('100%')
          .height(80)
          .backgroundColor('#FFFFFF')
          .margin({ top: 8 })

          // 详细信息
          Column() {
            this.InfoItem('备注', '张三', true)
            Divider().strokeWidth(1).color('#EDEDED')
            this.InfoItem('标签', this.tags.join('、'), true)
            Divider().strokeWidth(1).color('#EDEDED')
            this.InfoItem('地区', this.region, false)
            Divider().strokeWidth(1).color('#EDEDED')
            this.InfoItem('个性签名', '生活不止眼前的苟且...', false)
          }
          .width('100%')
          .margin({ top: 8 })

          // 朋友圈
          Row() {
            Text('朋友圈')
              .fontSize(16)
              .layoutWeight(1)

            Row() {
              Text('📷')
                .width(50)
                .height(50)
                .fontSize(32)
                .textAlign(TextAlign.Center)
                .backgroundColor('#F5F5F5')
                .borderRadius(4)
                .margin({ right: 8 })

              Image($r('sys.media.ohos_ic_public_arrow_right'))
                .width(20)
                .height(20)
                .fillColor('#CCCCCC')
            }
          }
          .width('100%')
          .height(70)
          .padding({ left: 16, right: 16 })
          .backgroundColor('#FFFFFF')
          .margin({ top: 8 })

          // 更多信息
          Column() {
            Row() {
              Text('更多信息')
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
          }
          .width('100%')
          .backgroundColor('#FFFFFF')
          .margin({ top: 8, bottom: 20 })
        }
      }
      .layoutWeight(1)
      .backgroundColor('#EDEDED')
    }
    .width('100%')
    .height('100%')
  }
}
