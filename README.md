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
- show name of streams
- changing system brightness
- changing system volume
- lock rotation
- pause timer
- progress bar

# Screenshot
![Simulator Screenshot - iPad Pro (12 9-inch) (2nd generation) - 2024-06-29 at 12 18 25](https://github.com/IgorFedorchuk/vlc-player/assets/2764603/0fe5b684-6100-4c73-a6ea-3c61a4a9de3c)

# How to use
For clearer comprehension, please open the project located in the "Example" folder.

```
var streams: [PlayerVC.Stream] =
                [PlayerVC.Stream(url: URL(string: "http://hls1.webcamera.pl/krakowsan_cam_480f1a/krakowsan_cam_480f1a.stream/chunks.m3u8")!, name: "Stream 1", id: "1", isFavorite: false),
                PlayerVC.Stream(url: URL(string: "https://classicarts.akamaized.net/hls/live/1024257/CAS/master.m3u8")!, name: "Stream 2", id: "2", isFavorite: false),
                PlayerVC.Stream(url: URL(string: "https://live-par-2-cdn-alt.livepush.io/live/bigbuckbunnyclip/index.m3u8")!, name: "Stream 3", id: "3", isFavorite: false)]
     
let playerVC = PlayerVC(streams: streams, currentIndex: 0, pipModel: nil)
playerVC.constant.errorText = NSLocalizedString("Video is unreachable", comment: "")
playerVC.modalPresentationStyle = .overFullScreen
playerVC.onViewDidLoad = {}
playerVC.onError = { url, error in
}
playerVC.onPipStarted = { pipModel, streams, currentIndex in
}
playerVC.onNextStream = { stream in
    print("stream:\(stream)")
}
playerVC.onPreviousStream = { stream in
    print("stream:\(stream)")
}
present(playerVC, animated: true)
```
