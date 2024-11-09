//
//  PlayerRouter.swift
//  vlc-player
//
//  Created by Igor Fedorchuk on 09.11.2024.
//

import UIKit

extension PlayerVC {
    struct SettinsAlert {
        var shareButtonText: String?
        var onShare: () -> Void

        var favoriteButtonText: String?
        var onFavoriteTapped: () -> Void

        var lockRotaionButtonText: String?
        var onLockRotaionTapped: () -> Void

        var cancelText: String
        var sourceView: UIView?
    }

    struct ChooseDateAlert {
        var title = ""
        var okText = ""
        var onOk: (Date) -> Void
        var cancelText = ""
        var minimumDate: Date
    }

    class Router {
        private weak var viewController: UIViewController?

        init(viewController: UIViewController) {
            self.viewController = viewController
        }

        func showSettings(settinsAlert: SettinsAlert) {
            let alertController = UIAlertController.actionSheetController(title: nil, message: nil)
            if let shareButtonText = settinsAlert.shareButtonText {
                let action = UIAlertAction(title: shareButtonText, style: .default, handler: { _ in
                    settinsAlert.onShare()
                })
                alertController.addAction(action)
            }

            if let favoriteButtonText = settinsAlert.favoriteButtonText {
                let action = UIAlertAction(title: favoriteButtonText, style: .default, handler: { _ in
                    settinsAlert.onFavoriteTapped()
                })
                alertController.addAction(action)
            }

            if let lockRotaionButtonText = settinsAlert.lockRotaionButtonText {
                let action = UIAlertAction(title: lockRotaionButtonText, style: .default, handler: { _ in
                    settinsAlert.onLockRotaionTapped()
                })
                alertController.addAction(action)
            }

            alertController.addAction(UIAlertAction(title: settinsAlert.cancelText, style: .cancel))
            if let presenter = alertController.popoverPresentationController {
                if let sourceView = settinsAlert.sourceView {
                    presenter.sourceView = sourceView
                    presenter.sourceRect = sourceView.bounds
                }
            }
            viewController?.present(alertController, animated: true)
        }

        func showHistory(alert: ChooseDateAlert) {
            let alertController = UIAlertController.aletController(title: alert.title, message: nil)
            let datePicker = UIDatePicker()
            datePicker.locale = Locale.current
            datePicker.maximumDate = Date()
            datePicker.minimumDate = alert.minimumDate
            datePicker.datePickerMode = .dateAndTime
            if #available(iOS 13.4, *) {
                datePicker.preferredDatePickerStyle = .wheels
            }
            datePicker.translatesAutoresizingMaskIntoConstraints = false
            alertController.view.addSubview(datePicker)
            NSLayoutConstraint.activate([
                datePicker.leadingAnchor.constraint(equalTo: alertController.view.leadingAnchor, constant: 8),
                datePicker.trailingAnchor.constraint(equalTo: alertController.view.trailingAnchor, constant: -8),
                datePicker.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: 50),
                datePicker.heightAnchor.constraint(equalToConstant: 200),
            ])

            alertController.view.widthAnchor.constraint(equalToConstant: 270).isActive = true
            alertController.view.heightAnchor.constraint(equalToConstant: 300).isActive = true

            let cancelAction = UIAlertAction(title: alert.cancelText, style: .cancel, handler: nil)
            let okAction = UIAlertAction(title: alert.okText, style: .default) { _ in
                let selectedDate = datePicker.date
                alert.onOk(selectedDate)
            }

            alertController.addAction(cancelAction)
            alertController.addAction(okAction)

            viewController?.present(alertController, animated: true, completion: nil)
        }
    }
}
