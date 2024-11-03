//
//  Date.swift
//  vlc-player
//
//  Created by Igor Fedorchuk on 09.11.2024.
//

import Foundation

extension Calendar {
    func dateNDays(days: Int) -> Date? {
        return date(byAdding: .day, value: -days, to: Date())
    }
}
