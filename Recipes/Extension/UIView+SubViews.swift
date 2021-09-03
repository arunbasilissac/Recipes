//
//  UIView+SubViews.swift
//  Recipes
//
//  Created by Arun on 28/08/21.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}
