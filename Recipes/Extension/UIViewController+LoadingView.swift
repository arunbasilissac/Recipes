//
//  UIViewController+LoadingView.swift
//  Recipes
//
//  Created by Arun on 28/08/21.
//

import UIKit

private var containerView: UIView?

extension UIViewController {

    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView!)

        containerView!.backgroundColor = .systemBackground
        containerView!.alpha = 0

        UIView.animate(withDuration: 0.25) { containerView!.alpha = 0.8 }

        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
        containerView!.addSubview(activityIndicator)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView!.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView!.centerXAnchor)
        ])

        activityIndicator.startAnimating()
    }

    func dismissLoadingView() {
        DispatchQueue.main.async {
            containerView?.removeFromSuperview()
            containerView = nil
        }
    }
}
