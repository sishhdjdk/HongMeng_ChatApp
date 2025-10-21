/**
 * 发现页
 * 功能：展示朋友圈、扫一扫、摇一摇等功能入口
 */
import router from '@ohos.router'

@Entry
@Component
struct DiscoverPage {
  @State currentTab: number = 2 // 当前选中的Tab，2=发现

  // 功能项组件
  @Builder
  FeatureItem(icon: string, title: string, showArrow: boolean = true, url?: string) {
    Row() {
      Text(icon)
        .width(28)
        .height(28)
        .fontSize(24)
        .textAlign(TextAlign.Center)
        .margin({ right: 12 })

      Text(title)
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
    .onClick(() => {
      if (url) {
        router.pushUrl({ url: url })
      }
    })
  }

  build() {
    Column() {
      // 顶部标题
      Row() {
        Text('发现')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#FFFFFF')

      // 功能列表
      List() {
        // 朋友圈
        ListItem() {
          Column() {
            this.FeatureItem('📷', '朋友圈', true, 'pages/MomentsDetailPage')
          }
          .margin({ top: 8 })
        }

        // 扫一扫、摇一摇
        ListItem() {
          Column() {
            this.FeatureItem('📷', '扫一扫', true, 'pages/ScanPage')
            Divider().strokeWidth(1).color('#EDEDED')
            this.FeatureItem('📱', '摇一摇', true, 'pages/ShakePage')
          }
          .margin({ top: 8 })
        }

        // 看一看、搜一搜
        ListItem() {
          Column() {
            this.FeatureItem('👁️', '看一看', true, 'pages/LookPage')
            Divider().strokeWidth(1).color('#EDEDED')
            this.FeatureItem('🔍', '搜一搜', true, 'pages/SearchDiscoverPage')
          }
          .margin({ top: 8 })
        }

        // 附近、购物
        ListItem() {
          Column() {
            this.FeatureItem('📍', '附近', true, 'pages/NearbyPage')
            Divider().strokeWidth(1).color('#EDEDED')
            this.FeatureItem('🛒', '购物', true, 'pages/ShoppingPage')
          }
          .margin({ top: 8 })
        }

        // 小程序、游戏
        ListItem() {
          Column() {
            this.FeatureItem('📦', '小程序', true, 'pages/MiniProgramPage')
            Divider().strokeWidth(1).color('#EDEDED')
            this.FeatureItem('🎮', '游戏', true, 'pages/GamePage')
          }
          .margin({ top: 8, bottom: 8 })
        }
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#EDEDED')

      // 底部导航栏
      Row() {
        Column() {
          Image($r('sys.media.ohos_ic_public_email'))
            .width(24)
            .height(24)
            .fillColor(this.currentTab === 0 ? '#07C160' : '#999999')
          Text('消息')
            .fontSize(12)
            .fontColor(this.currentTab === 0 ? '#07C160' : '#999999')
            .margin({ top: 4 })
        }
        .layoutWeight(1)
        .onClick(() => {
          this.currentTab = 0
          router.pushUrl({ url: 'pages/MessageListPage' })
        })

        Column() {
          Image($r('sys.media.ohos_ic_public_phone'))
            .width(24)
            .height(24)
            .fillColor(this.currentTab === 1 ? '#07C160' : '#999999')
          Text('通讯录')
            .fontSize(12)
            .fontColor(this.currentTab === 1 ? '#07C160' : '#999999')
            .margin({ top: 4 })
        }
        .layoutWeight(1)
        .onClick(() => {
          this.currentTab = 1
          router.pushUrl({ url: 'pages/ContactsPage' })
        })

        Column() {
          Image($r('sys.media.ohos_ic_public_scan'))
            .width(24)
            .height(24)
            .fillColor(this.currentTab === 2 ? '#07C160' : '#999999')
          Text('发现')
            .fontSize(12)
            .fontColor(this.currentTab === 2 ? '#07C160' : '#999999')
            .margin({ top: 4 })
        }
        .layoutWeight(1)
        .onClick(() => {
          this.currentTab = 2
        })

        Column() {
          Image($r('sys.media.ohos_ic_public_device_phone'))
            .width(24)
            .height(24)
            .fillColor(this.currentTab === 3 ? '#07C160' : '#999999')
          Text('我')
            .fontSize(12)
            .fontColor(this.currentTab === 3 ? '#07C160' : '#999999')
            .margin({ top: 4 })
        }
        .layoutWeight(1)
        .onClick(() => {
          this.currentTab = 3
          router.pushUrl({ url: 'pages/ProfilePage' })
        })
      }
      .width('100%')
      .height(60)
      .backgroundColor('#FFFFFF')
      .border({ width: { top: 1 }, color: '#EDEDED' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#EDEDED')
  }
}
