//
//  UIViewController+Extension.swift
//  SlideMenuDemo1
//
//  Created by cuongdd on 29/09/2022.
//  Copyright © 2022 duycuong. All rights reserved.
//

import UIKit

extension UIViewController {
    
    public func showNavCustom() {
        navigationController?.navigationBar.barTintColor = .systemPink
        navigationController?.navigationBar.tintColor = .white
        if let playfairDisplayBold = R.font.playfairDisplayBold(size: 17) {
            navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: playfairDisplayBold,
            ]
        }
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        let attributes: [NSAttributedString.Key: Any] = [
            .font: R.font.playfairDisplayBold(size: 17) as Any,
            .foregroundColor: UIColor.white,
        ]
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemPink
        appearance.titleTextAttributes = attributes
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
    }
}
