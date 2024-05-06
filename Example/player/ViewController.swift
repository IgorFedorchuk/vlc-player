//
//  ViewController.swift
//  player
//
//  Created by Igor Fedorchuk on 07.04.2024.
//

import UIKit
import vlc_player

class ViewController: UIViewController {
    private var channels: [PlayerVC.Channel] {
        return [PlayerVC.Channel(url: URL(string: "http://b0b4d514.amazzin.pw/iptv/V7CS89BDUTXR3K/9187/index.m3u8")!, name: "Channel 1", id: "1", isFavorite: false),
                PlayerVC.Channel(url: URL(string: "http://b0b4d514.amazzin.pw/iptv/V7CS89BDUTXR3K/17023/index.m3u8")!, name: "Channel 2", id: "2", isFavorite: false),
                PlayerVC.Channel(url: URL(string: "https://live-par-2-cdn-alt.livepush.io/live/bigbuckbunnyclip/index.m3u8")!, name: "Channel 3", id: "3", isFavorite: true)]
                
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func link1Tapped(_ sender: UIButton) {
        show(channels: channels, currentIndex: 0, pipModel: nil)
    }

    @IBAction private func link2Tapped(_ sender: UIButton) {
        show(channels: channels, currentIndex: 1, pipModel: nil)
    }
    
    @IBAction private func link3Tapped(_ sender: UIButton) {
        show(channels: channels, currentIndex: 2, pipModel: nil)
    }
    
    private func show(channels: [PlayerVC.Channel], currentIndex: Int, pipModel: PipModel?) {
        if PipService.shared.playIfInPipMode(url: channels[currentIndex].url, channels: (channels, currentIndex)) {
            return
        }
        let playerVC = PlayerVC.create(channels: channels, currentIndex: currentIndex, pipModel: pipModel)
        present(playerVC, animated: true)
    }

}

