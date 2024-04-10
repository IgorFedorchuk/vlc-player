//
//  PlayerVCExtension.swift
//  player
//
//  Created by Igor Fedorchuk on 07.04.2024.
//

import Foundation
import vlc_player

extension PlayerVC {
    class func create(channels: [PlayerVC.Channel], currentIndex: Int, pipModel: PipModel?) -> PlayerVC {
        let playerVC = PlayerVC(channels: channels, currentIndex: currentIndex, pipModel: pipModel)
        playerVC.modalPresentationStyle = .overFullScreen
        playerVC.needCloseOnPipPressed = true
        playerVC.useVLCPlayer = false
        playerVC.onError = { url, error in
            let link = url.absoluteString
            let errorString = String(describing: error)
            #if DEBUG
                print("Player error:\(errorString)")
                print(link)
            #endif
        }
        playerVC.onPipStarted = { pipModel, channels, currentIndex in
            PipService.shared.set(pipModel: pipModel, channels: (channels, currentIndex))
        }
        playerVC.errorText = NSLocalizedString("Video is unreachable", comment: "")
        return playerVC
    }
}
