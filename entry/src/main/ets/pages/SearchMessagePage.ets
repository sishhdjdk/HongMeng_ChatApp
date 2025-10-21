/**
 * 聊天记录搜索页
 * 功能：搜索聊天内容
 */
import router from '@ohos.router'

class SearchResult {
  id: number
  contactName: string
  content: string
  time: string

  constructor(id: number, contactName: string, content: string, time: string) {
    this.id = id
    this.contactName = contactName
    this.content = content
    this.time = time
  }
}

@Entry
@Component
struct SearchMessagePage {
  @State searchText: string = ''
  @State searchResults: SearchResult[] = []

  // 执行搜索
  handleSearch() {
    if (this.searchText.trim().length > 0) {
      // 模拟搜索结果
      this.searchResults = [
        new SearchResult(1, '张三', '晚上一起吃饭吧', '2024-01-15 18:30'),
        new SearchResult(2, '李四', '文件已发送', '2024-01-14 15:10'),
      ]
    } else {
      this.searchResults = []
    }
  }

  @Builder
  SearchResultItem(result: SearchResult) {
    Column() {
      Row() {
        Text(result.contactName.substring(0, 1))
          .width(40)
          .height(40)
          .borderRadius(4)
          .backgroundColor('#07C160')
          .fontColor('#FFFFFF')
          .fontSize(16)
          .textAlign(TextAlign.Center)
          .margin({ right: 12 })

        Column() {
          Text(result.contactName)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 4 })

          Text(result.content)
            .fontSize(14)
            .fontColor('#666666')
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Text(result.time)
          .fontSize(12)
          .fontColor('#999999')
      }
      .width('100%')
      .padding(16)
      .onClick(() => {
        router.pushUrl({ url: 'pages/ChatDetailPage' })
      })
    }
    .width('100%')
    .backgroundColor('#FFFFFF')
  }

  build() {
    Column() {
      // 顶部搜索栏
      Row() {
        Image($r('sys.media.ohos_ic_public_arrow_left'))
          .width(24)
          .height(24)
          .margin({ right: 12 })
          .onClick(() => {
            router.back()
          })

        Row() {
          Image($r('sys.media.ohos_ic_public_search_filled'))
            .width(20)
            .height(20)
            .fillColor('#999999')
            .margin({ right: 8 })

          TextInput({ text: this.searchText, placeholder: '搜索聊天记录' })
            .layoutWeight(1)
            .backgroundColor('transparent')
            .onChange((value: string) => {
              this.searchText = value
              this.handleSearch()
            })
        }
        .layoutWeight(1)
        .height(36)
        .backgroundColor('#F5F5F5')
        .borderRadius(18)
        .padding({ left: 12, right: 12 })
      }
      .width('100%')
      .padding(12)
      .backgroundColor('#FFFFFF')

      // 搜索结果
      if (this.searchResults.length > 0) {
        List() {
          ForEach(this.searchResults, (result: SearchResult) => {
            ListItem() {
              this.SearchResultItem(result)
            }
          })
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor('#EDEDED')
        .divider({ strokeWidth: 1, color: '#EDEDED' })
      } else if (this.searchText.length > 0) {
        Column() {
          Text('未找到相关聊天记录')
            .fontSize(16)
            .fontColor('#999999')
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#EDEDED')
      } else {
        Column() {
          Text('🔍')
            .fontSize(60)
            .margin({ bottom: 16 })

          Text('搜索聊天记录')
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
