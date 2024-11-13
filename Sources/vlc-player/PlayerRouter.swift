//
//  PlayerRouter.swift
//  vlc-player
//
//  Created by Igor Fedorchuk on 09.11.2024.
//

import UIKit

public extension PlayerVC {
    struct SettinsAlert {
        public var shareButtonText: String?
        public var onShare: () -> Void

        public var favoriteButtonText: String?
        public var onFavoriteTapped: () -> Void

        public var lockRotaionButtonText: String?
        public var onLockRotaionTapped: () -> Void

        public var cancelText: String
        public var sourceView: UIView?

        public init(shareButtonText: String?, onShare: @escaping () -> Void, favoriteButtonText: String?, onFavoriteTapped: @escaping () -> Void, lockRotaionButtonText: String?, onLockRotaionTapped: @escaping () -> Void, cancelText: String, sourceView: UIView?) {
            self.shareButtonText = shareButtonText
            self.onShare = onShare
            self.favoriteButtonText = favoriteButtonText
            self.onFavoriteTapped = onFavoriteTapped
            self.lockRotaionButtonText = lockRotaionButtonText
            self.onLockRotaionTapped = onLockRotaionTapped
            self.cancelText = cancelText
            self.sourceView = sourceView
        }
    }

    struct ChooseDateAlert {
        public var title = ""
        public var subtitle = ""
        public var okText = ""
        public var onOk: (Date) -> Void
        public var cancelText = ""
        public var minimumDate: Date
        public var startDate = Date()

        public init(title: String, subtitle: String, okText: String, onOk: @escaping (Date) -> Void, cancelText: String, minimumDate: Date) {
            self.title = title
            self.subtitle = subtitle
            self.okText = okText
            self.onOk = onOk
            self.cancelText = cancelText
            self.minimumDate = minimumDate
        }
    }

    class Router {
        private weak var viewController: UIViewController?

        public init(viewController: UIViewController) {
            self.viewController = viewController
        }

        public func showSettings(settinsAlert: SettinsAlert) {
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

        public func showHistory(alert: ChooseDateAlert) {
            let alertController = UIAlertController.aletController(title: alert.title, message: alert.subtitle)
            let datePicker = UIDatePicker()
            datePicker.locale = Locale.current
            datePicker.date = alert.startDate
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
