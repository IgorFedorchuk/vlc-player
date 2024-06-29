//
//  MPVolumeView.swift
//
//
//  Created by Igor Fedorchuk on 18.04.2024.
//

import Foundation
import MediaPlayer

extension MPVolumeView {
    static func setVolume(_ volume: Float) {
        let volumeView = MPVolumeView()
        let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
            slider?.value = volume
        }
    }
}
