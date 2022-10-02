//
//  SearchDocumentView.swift
//  SlideMenuDemo1
//
//  Created by cuongdd on 29/09/2022.
//  Copyright © 2022 duycuong. All rights reserved.
//

import UIKit

class SearchDocumentView: UIView {
    @IBOutlet var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var clearImageView: UIImageView!
    @IBOutlet weak var clearTextButton: UIButton!
    @IBOutlet weak var widthSearchView: NSLayoutConstraint!
    @IBOutlet weak var dropdownButton: UIButton!
    @IBOutlet weak var dropdownIcon: UIImageView!
    
    var showPopup: ((_ button: UIButton) -> Void)?
    var textChange: ((_ text: String) -> Void)?
    var clearAllSearchText: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        searchTextField.delegate = self
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        widthSearchView.constant = UIScreen.main.bounds.width - 16*2
    }
    
    private func setupUI() {
        widthSearchView.constant = UIScreen.main.bounds.width - 16*2
        searchTextField.textColor = UIColor.white
//        searchTextField.font = LatoFont.regular(with: 16)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.0
        let attributes: [NSAttributedString.Key: Any] = [
            .font: R.font.playfairDisplayRegular(size: 17) as Any,
            .paragraphStyle: paragraphStyle,
            .foregroundColor: UIColor.white,
        ]
        let placeholderText = NSAttributedString(string: SortType.name.text, attributes: attributes)
        searchTextField.attributedPlaceholder = placeholderText
        
//        clearImageView.image = Asset.iconClose.image.withRenderingMode(.alwaysTemplate)
        clearImageView.tintColor = .white
        clearImageView.isHidden = true
//        searchView.backgroundColor = AppColor.Background.lightestGray
        dropdownButton.setTitle("", for: .normal)
        dropdownIcon.image = R.image.icons8Sort_down()?.withTintColor(.white, renderingMode: .alwaysTemplate)
    }
    
    func refreshUI() {
        widthSearchView.constant = UIScreen.main.bounds.width - 16*2
    }
    
    @IBAction func tapClearTextButton(_ sender: UIButton) {
        searchTextField.text = ""
        clearImageView.isHidden = true
        clearAllSearchText?()
    }
    
    @IBAction func selectFilterOption(_ sender: UIButton) {
        showPopup?(sender)
    }
    
}

extension SearchDocumentView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        textChange?(textField.text ?? "")
        clearImageView.isHidden = textField.text == ""
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.location == 0 && (string == " ") {
            return false
        }
        return textField.text!.count < 50
    }
}

extension SearchDocumentView: MedicinalPlantsViewControllerDelegate {
    func selectSortType(sortType: SortType) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.0
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .foregroundColor: UIColor.white,
        ]
        let placeholderText = NSAttributedString(string: sortType.text, attributes: attributes)
        searchTextField.attributedPlaceholder = placeholderText
    }
    
    
}
