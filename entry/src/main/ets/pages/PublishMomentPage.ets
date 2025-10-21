/**
 * 发布动态页
 * 功能：发布朋友圈动态
 */
import router from '@ohos.router'

@Entry
@Component
struct PublishMomentPage {
  @State content: string = ''
  @State selectedImages: string[] = []
  @State canPublish: boolean = false

  // 检查是否可以发布
  checkCanPublish() {
    this.canPublish = this.content.trim().length > 0 || this.selectedImages.length > 0
  }

  // 发布动态
  publishMoment() {
    if (this.canPublish) {
      // 发布成功，返回朋友圈
      router.back()
    }
  }

  // 选择图片
  selectImage() {
    // 模拟选择图片
    if (this.selectedImages.length < 9) {
      this.selectedImages.push('image.jpg')
      this.checkCanPublish()
    }
  }

  // 删除图片
  removeImage(index: number) {
    this.selectedImages.splice(index, 1)
    this.checkCanPublish()
  }

  @Builder
  ImageItem(image: string, index: number) {
    Stack() {
      Text('📷')
        .width('100%')
        .height('100%')
        .fontSize(40)
        .textAlign(TextAlign.Center)
        .backgroundColor('#F5F5F5')
        .borderRadius(8)

      // 删除按钮
      Text('×')
        .width(24)
        .height(24)
        .fontSize(20)
        .fontColor('#FFFFFF')
        .backgroundColor('#FF3B30')
        .borderRadius(12)
        .textAlign(TextAlign.Center)
        .position({ x: '85%', y: -8 })
        .onClick(() => {
          this.removeImage(index)
        })
    }
    .width(100)
    .height(100)
    .margin(8)
  }

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Text('取消')
          .fontSize(16)
          .fontColor('#666666')
          .onClick(() => {
            router.back()
          })

        Text('发表')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('发布')
          .fontSize(16)
          .fontColor(this.canPublish ? '#07C160' : '#CCCCCC')
          .onClick(() => {
            this.publishMoment()
          })
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#FFFFFF')

      Scroll() {
        Column() {
          // 文本输入区域
          TextArea({ text: this.content, placeholder: '这一刻的想法...' })
            .width('100%')
            .height(200)
            .fontSize(16)
            .backgroundColor('#FFFFFF')
            .onChange((value: string) => {
              this.content = value
              this.checkCanPublish()
            })

          // 图片网格
          Column() {
            Grid() {
              ForEach(this.selectedImages, (image: string, index: number) => {
                GridItem() {
                  this.ImageItem(image, index)
                }
              })

              // 添加图片按钮
              if (this.selectedImages.length < 9) {
                GridItem() {
                  Column() {
                    Text('+')
                      .width(40)
                      .height(40)
                      .fontSize(32)
                      .fontColor('#999999')
                      .textAlign(TextAlign.Center)
                  }
                  .width(100)
                  .height(100)
                  .margin(8)
                  .backgroundColor('#F5F5F5')
                  .borderRadius(8)
                  .justifyContent(FlexAlign.Center)
                  .onClick(() => {
                    this.selectImage()
                  })
                }
              }
            }
            .columnsTemplate('1fr 1fr 1fr')
            .width('100%')
            .padding(8)
          }
          .width('100%')
          .margin({ top: 16 })

          // 功能选项
          Column() {
            Row() {
              Text('所在位置')
                .fontSize(16)
                .layoutWeight(1)

              Text('不显示')
                .fontSize(16)
                .fontColor('#999999')
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

            Divider().strokeWidth(1).color('#EDEDED')

            Row() {
              Text('提醒谁看')
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
              Text('谁可以看')
                .fontSize(16)
                .layoutWeight(1)

              Text('公开')
                .fontSize(16)
                .fontColor('#999999')
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
          .width('100%')
          .margin({ top: 8 })
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
