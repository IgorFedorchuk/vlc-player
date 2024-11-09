//
//  ViewController.swift
//  player
//
//  Created by Igor Fedorchuk on 07.04.2024.
//

import UIKit
import vlc_player

class ViewController: UIViewController {
    private var streams: [PlayerVC.Stream] {
        return [PlayerVC.Stream(url: URL(string: "https://live-par-2-abr.livepush.io/vod/bigbuckbunnyclip.mp4")!, name: "Stream 1", id: "1", isFavorite: false, archiveInDays: nil),
                PlayerVC.Stream(url: URL(string: "http://b9044e37.ucomist.net/iptv/YRC9XZGMZSC2QP/523/index.m3u8")!, name: "Stream 2", id: "2", isFavorite: false, archiveInDays: 0),
                PlayerVC.Stream(url: URL(string: "http://184585.ipturk.eu/BektasCoban/69bNAepa4G8y/241346")!, name: "Stream 3", id: "3", isFavorite: true, archiveInDays: 3)]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func link1Tapped(_: UIButton) {
        show(streams: streams, currentIndex: 0, pipModel: nil)
    }

    @IBAction private func link2Tapped(_: UIButton) {
        show(streams: streams, currentIndex: 1, pipModel: nil)
    }

    @IBAction private func link3Tapped(_: UIButton) {
        show(streams: streams, currentIndex: 2, pipModel: nil)
    }

    private func show(streams: [PlayerVC.Stream], currentIndex: Int, pipModel: PipModel?) {
        if PipService.shared.playIfInPipMode(url: streams[currentIndex].url, streams: (streams, currentIndex)) {
            return
        }
        let playerVC = PlayerVC.create(streams: streams, currentIndex: currentIndex, pipModel: pipModel)
        present(playerVC, animated: true)
    }
}
