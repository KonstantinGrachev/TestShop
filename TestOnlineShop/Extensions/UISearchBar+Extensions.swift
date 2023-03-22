//
//  UISearchBar+Extensions.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 17.03.2023.
//

import UIKit

extension UISearchBar {
    func setupSearchBar() {
        self.layoutIfNeeded()
        self.searchBarStyle = .minimal
        self.searchTextField.leftView = UIView()
        self.searchTextField.rightView = UIImageView(image: UIImage(systemName: ThemeImages.systemMagnifyingglass))
        self.searchTextField.tintColor = .gray
        self.searchTextField.rightViewMode = .always
        self.searchTextField.font = ThemeFont.searchbar()
        self.placeholder = LocalizedStrings.searchBarPlaceholder
        var textFieldInsideSearchBar: UITextField?
        if #available(iOS 13.0, *) {
            textFieldInsideSearchBar = self.searchTextField
        } else {
            for view : UIView in (self.subviews[0]).subviews {
                if let textField = view as? UITextField {
                    textFieldInsideSearchBar = textField
                }
            }
        }
        let textFieldInsideSearchBarLabel = textFieldInsideSearchBar?.value(forKey: "placeholderLabel") as? UILabel
        textFieldInsideSearchBarLabel?.textColor = UIColor.black
        //get the sizes
        let searchBarWidth = self.frame.width
        let placeholderIconWidth = textFieldInsideSearchBar?.leftView?.frame.width
        let placeHolderWidth = textFieldInsideSearchBar?.attributedPlaceholder?.size().width
        let offsetIconToPlaceholder: CGFloat = 8
        let placeHolderWithIcon = placeholderIconWidth! + offsetIconToPlaceholder
        
        let offset = UIOffset(horizontal: ((searchBarWidth / 2) - (placeHolderWidth! / 2) - placeHolderWithIcon), vertical: 0)
        self.setPositionAdjustment(offset, for: .search)
    }
}
