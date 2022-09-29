//
//  SearchView.swift
//  SlideMenuDemo1
//
//  Created by cuongdd on 29/09/2022.
//  Copyright © 2022 duycuong. All rights reserved.
//

import UIKit

class SearchView: UIView {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var widthSearchView: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        widthSearchView.constant = UIScreen.main.bounds.width - 16 * 2
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.0
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .foregroundColor: UIColor.white,
        ]
        let placeholderText = NSAttributedString(string: "Tìm theo tên cây thuốc", attributes: attributes)
        searchTextField.attributedPlaceholder = placeholderText
        searchTextField.delegate = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        widthSearchView.constant = UIScreen.main.bounds.width - 16 * 2
    }

}

extension SearchView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
}
