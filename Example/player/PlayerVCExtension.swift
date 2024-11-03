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
        playerVC.needCloseOnPipPressed = true
        playerVC.needShowFavoriteButton = true
        playerVC.needShowShareButton = true
        playerVC.needShowLockOrientationButton = true
        playerVC.needShowEpgButton = true
        playerVC.needShowHistoryButton = true

        playerVC.onEpgChanged = { stream in
            print("stream:\(stream)")
        }
        playerVC.onHistorySelected = { stream, date in
            print("stream:\(stream), date:\(date)")
            let utcTimestamp = Int(date.timeIntervalSince1970)
            let currentTimestamp = Int(Date().timeIntervalSince1970)

            if var urlComponents = URLComponents(string: stream.url.absoluteString) {
                urlComponents.queryItems = (urlComponents.queryItems ?? []) + [
                    URLQueryItem(name: "utc", value: "\(utcTimestamp)"),
                    URLQueryItem(name: "lutc", value: "\(currentTimestamp)"),
                ]
                if let finalURL = urlComponents.url {
                    playerVC.startPlayer(url: finalURL)
                }
            }
        }
        playerVC.onHistoryChanged = { stream in
            print("stream:\(stream)")
        }
        playerVC.onFavoritePressed = { _ in
            true
        }
        playerVC.onNextStream = { stream in
            print("stream:\(stream)")
        }
        playerVC.onPreviousStream = { stream in
            print("stream:\(stream)")
        }
        playerVC.onEpgTapped = { stream in
            print("onEpgTapped stream:\(stream)")
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

        playerVC.modalPresentationStyle = .overFullScreen
        return playerVC
    }
}
