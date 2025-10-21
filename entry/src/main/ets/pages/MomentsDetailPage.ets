/**
 * 朋友圈详情页
 * 功能：查看朋友圈动态列表
 */
import router from '@ohos.router'

class Moment {
  id: number
  userName: string
  avatar: string
  content: string
  images: string[]
  time: string
  likeCount: number
  commentCount: number

  constructor(id: number, userName: string, avatar: string, content: string, images: string[], time: string, likeCount: number, commentCount: number) {
    this.id = id
    this.userName = userName
    this.avatar = avatar
    this.content = content
    this.images = images
    this.time = time
    this.likeCount = likeCount
    this.commentCount = commentCount
  }
}

@Entry
@Component
struct MomentsDetailPage {
  @State momentList: Moment[] = [
    new Moment(1, '张三', '', '今天天气真好！', [''], '2小时前', 15, 3),
    new Moment(2, '李四', '', '分享一张美图', ['', '', ''], '5小时前', 28, 7),
    new Moment(3, '王五', '', '周末愉快~', [], '昨天', 10, 2),
  ]

  @Builder
  MomentItem(moment: Moment) {
    Column() {
      Row() {
        // 头像
        Text(moment.userName.substring(0, 1))
          .width(50)
          .height(50)
          .borderRadius(25)
          .backgroundColor('#07C160')
          .fontColor('#FFFFFF')
          .fontSize(20)
          .textAlign(TextAlign.Center)
          .margin({ right: 12 })

        Column() {
          // 用户名
          Text(moment.userName)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#576B95')
            .margin({ bottom: 8 })

          // 动态内容
          Text(moment.content)
            .fontSize(15)
            .margin({ bottom: 8 })

          // 图片（如果有）
          if (moment.images.length > 0) {
            Grid() {
              ForEach(moment.images, (image: string, index: number) => {
                GridItem() {
                  Text('📷')
                    .width('100%')
                    .aspectRatio(1)
                    .fontSize(40)
                    .textAlign(TextAlign.Center)
                    .backgroundColor('#F5F5F5')
                    .borderRadius(4)
                    .onClick(() => {
                      router.pushUrl({ url: 'pages/ImagePreviewPage' })
                    })
                }
              })
            }
            .columnsTemplate('1fr 1fr 1fr')
            .columnsGap(8)
            .rowsGap(8)
            .width(moment.images.length === 1 ? 150 : '100%')
            .margin({ bottom: 8 })
          }

          // 时间和操作
          Row() {
            Text(moment.time)
              .fontSize(13)
              .fontColor('#999999')

            Blank()

            Row() {
              Text('❤️')
                .fontSize(16)
                .margin({ right: 4 })

              Text(moment.likeCount.toString())
                .fontSize(13)
                .fontColor('#999999')

              Text('💬')
                .fontSize(16)
                .margin({ left: 12, right: 4 })

              Text(moment.commentCount.toString())
                .fontSize(13)
                .fontColor('#999999')
            }
          }
          .width('100%')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)
      .padding(16)
    }
    .width('100%')
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

        Text('朋友圈')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin({ left: 16 })
          .layoutWeight(1)

        Image($r('sys.media.ohos_ic_public_camera'))
          .width(24)
          .height(24)
          .onClick(() => {
            router.pushUrl({ url: 'pages/PublishMomentPage' })
          })
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#FFFFFF')

      // 个人信息卡片
      Stack() {
        // 背景图 - 使用渐变色占位
        Column()
          .width('100%')
          .height(200)
          .linearGradient({
            colors: [[0x07C160, 0.0], [0x576B95, 1.0]]
          })

        // 个人信息
        Row() {
          Blank()

          Column() {
            Text('微信用户')
              .fontSize(18)
              .fontColor('#FFFFFF')
              .fontWeight(FontWeight.Medium)
              .margin({ bottom: 8 })

            Text('我')
              .width(70)
              .height(70)
              .borderRadius(8)
              .backgroundColor('#07C160')
              .fontColor('#FFFFFF')
              .fontSize(32)
              .textAlign(TextAlign.Center)
              .border({ width: 2, color: '#FFFFFF' })
          }
          .alignItems(HorizontalAlign.End)
        }
        .width('100%')
        .height(200)
        .padding(16)
        .alignItems(VerticalAlign.Bottom)
      }
      .width('100%')

      // 朋友圈列表
      if (this.momentList.length > 0) {
        List() {
          ForEach(this.momentList, (moment: Moment) => {
            ListItem() {
              this.MomentItem(moment)
            }
          })
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor('#EDEDED')
        .divider({ strokeWidth: 8, color: '#EDEDED' })
      } else {
        Column() {
          Text('暂无动态')
            .fontSize(16)
            .fontColor('#999999')
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#EDEDED')
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#EDEDED')
  }
}
