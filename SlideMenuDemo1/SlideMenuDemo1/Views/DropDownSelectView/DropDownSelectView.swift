//
//  DropDownSelectView.swift
//  SlideMenuDemo1
//
//  Created by cuongdd on 29/09/2022.
//  Copyright © 2022 duycuong. All rights reserved.
//

import UIKit

class DropDownSelectView: UIView {
    @IBOutlet weak var dropdownButton: UIButton!
    @IBOutlet weak var dropdownIcon: UIImageView!
    
    var showPopup: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dropdownButton.setTitle("", for: .normal)
        dropdownIcon.image = R.image.icons8Sort_down()?.withTintColor(.white, renderingMode: .alwaysTemplate)
    }
    
    @IBAction func showDropdownClicked(_ sender: UIButton) {
        showPopup?()
    }
    
}
