# Requirements
- iOS 12.0
- Xcode 15.0+
- iPhone/iPad

# Features
- picture in picture mode
- sound off/on
- airplay
- play/pause
- full screen
- play back/forwad
- show name of channel
- changing system brightness
- changing system volume
- lock rotation
- pause timer

# Screenshot
![Simulator Screenshot - iPad Pro (12 9-inch) (6th generation) - 2024-05-12 at 14 41 15](https://github.com/IgorFedorchuk/vlc-player/assets/2764603/f7b61607-cae5-4993-a09a-33203d86af41)

# How to use
For clearer comprehension, please open the project located in the "Example" folder.

```
var channels: [PlayerVC.Channel] =
                [PlayerVC.Channel(url: URL(string: "http://hls1.webcamera.pl/krakowsan_cam_480f1a/krakowsan_cam_480f1a.stream/chunks.m3u8")!, name: "Channel 1", id: "1", isFavorite: false),
                PlayerVC.Channel(url: URL(string: "https://classicarts.akamaized.net/hls/live/1024257/CAS/master.m3u8")!, name: "Channel 2", id: "2", isFavorite: false),
                PlayerVC.Channel(url: URL(string: "https://live-par-2-cdn-alt.livepush.io/live/bigbuckbunnyclip/index.m3u8")!, name: "Channel 3", id: "3", isFavorite: false)]
     
let playerVC = PlayerVC(channels: channels, currentIndex: 0, pipModel: nil)
playerVC.constant.errorText = NSLocalizedString("Video is unreachable", comment: "")
playerVC.modalPresentationStyle = .overFullScreen
playerVC.onViewDidLoad = {}
playerVC.onError = { url, error in
}
playerVC.onPipStarted = { pipModel, channels, currentIndex in
}
present(playerVC, animated: true)
```
