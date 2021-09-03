//
//  UIViewController+Alerts.swift
//  Recipes
//
//  Created by Arun on 28/08/21.
//

import UIKit

extension UIViewController {
    func presentREAlert(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC: REAlertViewController = REAlertViewController(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle  = .overFullScreen
            alertVC.modalTransitionStyle    = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
