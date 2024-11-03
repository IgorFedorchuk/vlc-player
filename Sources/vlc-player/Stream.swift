//
//  Stream.swift
//  vlc-player
//
//  Created by Igor Fedorchuk on 09.11.2024.
//

import Foundation

public extension PlayerVC {
    struct Stream {
        public let url: URL
        public let name: String
        public let id: String
        public var isFavorite: Bool
        public let epgChannelId: String?
        public let archiveInDays: Int?

        public init(url: URL, name: String, id: String, isFavorite: Bool, epgChannelId: String? = nil, archiveInDays: Int? = nil) {
            self.url = url
            self.name = name
            self.id = id
            self.isFavorite = isFavorite
            self.epgChannelId = epgChannelId
            self.archiveInDays = archiveInDays
        }
    }
}
