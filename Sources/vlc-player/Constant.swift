//
//  Constant.swift
//  vlc-player
//
//  Created by Igor Fedorchuk on 09.11.2024.
//

import CoreMedia
import Foundation
import UIKit

public extension PlayerVC {
    struct Constant {
        public var hideControlsTimeInterval: CGFloat = 10.0
        public var playButtonWidth: CGFloat = 60
        public var buttonWidth: CGFloat = 40
        public var buttonsIndent: CGFloat = 10
        public var playButtonIndent: CGFloat = 80
        public var buttonsTopIndentPortrait: CGFloat = 50
        public var buttonsTopIndentLandscape: CGFloat = 10
        public var nameLabelTopIndentPortrait: CGFloat = 60
        public var nameLabelTopIndentLandscape: CGFloat = 20
        public var sliderIndentPortrait: CGFloat = 90
        public var sliderIndentLandscape: CGFloat = 0
        public var preferredTimescale: CMTimeScale = 600
        public var pauseImageName = "pause"
        public var playImageName = "play"
        public var soundOnImageName = "sound-on"
        public var soundOffImageName = "sound-off"
        public var outputVolume = "outputVolume"
        public var backColor = UIColor.color(r: 0, g: 0, b: 0, a: 0.2)
        public var defaultCountDownDuration = 60 * 20
        public var timerTitle = "Pause playback after"
        public var timerCancelButtonText = "Cancel"
        public var timerOkButtonText = "Start"
        public var timerStopButtonText = "Stop"
        public var shareButtonTextText = "Share stream"
        public var cancelButtonTextText = "Cancel"
        public var okButtonTextText = "Ok"
        public var addToFavoriteText = "Add to favorites"
        public var removeFromFavoriteText = "Remove from favorites"
        public var lockRotationText = "Lock rotation"
        public var unlockRotationText = "Unlock rotation"
        public var chooseDateText = "Select archive date"
        public var errorText = NSLocalizedString("Video is unreachable", comment: "")
        public var buttonActiveTintColor = UIColor.red
    }
}
