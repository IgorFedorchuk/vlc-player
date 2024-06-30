//
//  PlayerVCExtension.swift
//  player
//
//  Created by Igor Fedorchuk on 07.04.2024.
//

import Foundation
import vlc_player

extension PlayerVC {
    class func create(streams: [PlayerVC.Stream], currentIndex: Int, pipModel: PipModel?) -> PlayerVC {
        let playerVC = PlayerVC(streams: streams, currentIndex: currentIndex, pipModel: pipModel)
        playerVC.modalPresentationStyle = .overFullScreen
        playerVC.needCloseOnPipPressed = true
        playerVC.needShowFavoriteButton = true
        playerVC.needShowLockOrientationButton = true
        playerVC.onFavoritePressed = { _ in
            true
        }
        playerVC.onNextStream = { stream in
            print("stream:\(stream)")
        }
        playerVC.onPreviousStream = { stream in
            print("stream:\(stream)")
        }
        playerVC.onError = { stream, error in
            let link = stream.url.absoluteString
            let errorString = String(describing: error)
            #if DEBUG
                print("Player error:\(errorString)")
                print(link)
            #endif
        }
        playerVC.onPipStarted = { pipModel, streams, currentIndex in
            PipService.shared.set(pipModel: pipModel, streams: (streams, currentIndex))
        }
        return playerVC
    }
}
