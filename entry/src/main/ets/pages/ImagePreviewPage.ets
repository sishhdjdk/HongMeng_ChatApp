/**
 * 图片预览页
 * 功能：查看聊天中的图片
 */
import router from '@ohos.router'

@Entry
@Component
struct ImagePreviewPage {
  @State currentIndex: number = 0
  @State imageList: string[] = [
    'image1.jpg',
    'image2.jpg',
    'image3.jpg'
  ]

  build() {
    Stack() {
      // 图片展示区域 - 使用占位符
      Swiper() {
        ForEach(this.imageList, (image: string, index: number) => {
          Column() {
            Text('📷')
              .fontSize(100)
              .fontColor('#FFFFFF')
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .backgroundColor('#000000')
        })
      }
      .width('100%')
      .height('100%')
      .indicator(false)
      .onChange((index: number) => {
        this.currentIndex = index
      })

      // 顶部操作栏
      Column() {
        Row() {
          Image($r('sys.media.ohos_ic_public_arrow_left'))
            .width(24)
            .height(24)
            .fillColor('#FFFFFF')
            .onClick(() => {
              router.back()
            })

          Blank()

          Text(`${this.currentIndex + 1}/${this.imageList.length}`)
            .fontSize(16)
            .fontColor('#FFFFFF')

          Blank()

          Image($r('sys.media.ohos_ic_public_more'))
            .width(24)
            .height(24)
            .fillColor('#FFFFFF')
        }
        .width('100%')
        .height(56)
        .padding({ left: 16, right: 16 })
        .backgroundColor('rgba(0, 0, 0, 0.5)')
      }
      .width('100%')
      .alignRules({
        top: { anchor: '__container__', align: VerticalAlign.Top }
      })

      // 底部操作栏
      Row() {
        Button('发送给朋友')
          .fontSize(14)
          .fontColor('#FFFFFF')
          .backgroundColor('rgba(0, 0, 0, 0.5)')
          .layoutWeight(1)
          .margin({ right: 8 })

        Button('保存图片')
          .fontSize(14)
          .fontColor('#FFFFFF')
          .backgroundColor('rgba(0, 0, 0, 0.5)')
          .layoutWeight(1)
          .margin({ left: 8 })
      }
      .width('100%')
      .padding(16)
      .position({ x: 0, y: '90%' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#000000')
  }
}
