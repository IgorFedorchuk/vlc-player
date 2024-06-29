//
//  PipService.swift
//  player
//
//  Created by Igor Fedorchuk on 07.04.2024.
//

import Foundation

import AVFoundation
import AVKit
import Foundation
import vlc_player

protocol IPipService {
    func set(pipModel: PipModel, channels: ([PlayerVC.Channel], Int))
    func playIfInPipMode(url: URL, channels: ([PlayerVC.Channel], Int)) -> Bool
}

final class PipService: NSObject, IPipService {
    static let shared = PipService()

    private var pipModel: PipModel?
    private var channels: ([PlayerVC.Channel], Int)?
    private var pauseTimer: Timer?

    func set(pipModel: PipModel, channels: ([PlayerVC.Channel], Int)) {
        self.pipModel = pipModel
        self.channels = channels
        pipModel.pipController.delegate = self

        invalidatePauseTimer()
        if let pauseTimeInterval = pipModel.pauseTimeInterval {
            pauseTimer = Timer.scheduledTimer(withTimeInterval: pauseTimeInterval, repeats: false) { [weak self] _ in
                pipModel.player.pause()
                self?.invalidatePauseTimer()
            }
        }
    }

    func playIfInPipMode(url: URL, channels: ([PlayerVC.Channel], Int)) -> Bool {
        guard let pipModel = pipModel else { return false }
        pipModel.player.pause()
        pipModel.player.replaceCurrentItem(with: AVPlayerItem(url: url))
        pipModel.player.play()
        self.channels = channels
        return true
    }
}

extension PipService: AVPictureInPictureControllerDelegate {
    func pictureInPictureController(_: AVPictureInPictureController, failedToStartPictureInPictureWithError _: any Error) {
        clear()
    }

    func pictureInPictureControllerWillStopPictureInPicture(_: AVPictureInPictureController) {
        clear()
    }

    func pictureInPictureController(_: AVPictureInPictureController,
                                    restoreUserInterfaceForPictureInPictureStopWithCompletionHandler completionHandler: @escaping (Bool) -> Void)
    {
        guard var pipModel = pipModel,
              let channels = channels
        else {
            completionHandler(false)
            return
        }

        pipModel.pauseTimeInterval = pauseTimer?.fireDate.timeIntervalSince(Date())
        let playerVC = PlayerVC.create(channels: channels.0, currentIndex: channels.1, pipModel: pipModel)
        UIViewController.topViewController()?.present(playerVC, animated: false) {
            self.clear(needToPause: false)
            completionHandler(true)
        }
    }
}

extension PipService {
    private func clear(needToPause: Bool = true) {
        if needToPause {
            pipModel?.player.pause()
        }
        invalidatePauseTimer()
        pipModel = nil
    }

    private func invalidatePauseTimer() {
        pauseTimer?.invalidate()
        pauseTimer = nil
    }
}
