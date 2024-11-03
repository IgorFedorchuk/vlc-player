//
//  UIAlertController.swift
//  vlc-player
//
//  Created by Igor Fedorchuk on 09.11.2024.
//

import UIKit

extension UIAlertController {
    static func aletController(title: String?, message: String?) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.view.tintColor = .black
        return alertController
    }

    static func actionSheetController(title: String?, message: String?) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alertController.view.tintColor = .black
        return alertController
    }
}
