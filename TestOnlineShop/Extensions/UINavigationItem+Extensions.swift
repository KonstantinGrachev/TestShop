//
//  UINavigationItem+Extensions.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 17.03.2023.
//

import UIKit

extension UINavigationItem {
    
    
    func setMainNavigationBar() {
        setCustomMainTitle()
        setCustomMainNavButtons()
    }
    
    func setProfileNavigationBar() {
        let navLabel = UILabel()
        let navTitle = NSMutableAttributedString(string: LocalizedStrings.profileTitleLabel,
                                                 attributes: [
                                                    .font: ThemeFont.titleFont(),
                                                 ])
        navLabel.attributedText = navTitle
        self.titleView = navLabel
    }
    
    private func setCustomMainTitle() {
        let navLabel = UILabel()
        let navTitle = NSMutableAttributedString(string: LocalizedStrings.mainScreenFirstPartTitle,
                                                 attributes: [
                                                    .font: ThemeFont.titleFont(),
                                                 ])
        
        navTitle.append(NSMutableAttributedString(string: LocalizedStrings.mainScreenSecondPartTitle,
                                                  attributes: [
                                                    .foregroundColor: ThemeColor.buttonBackgroundColor,
                                                    .font: ThemeFont.titleFont()
                                                  ]))
        
        navLabel.attributedText = navTitle
        self.titleView = navLabel
    }
    
    private func setCustomMainNavButtons() {
        let burgerButton = UIButton(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: 25,
                                                  height: 25))
        burgerButton.setImage(UIImage(named: ThemeImages.burgerButton), for: .normal)
        self.leftBarButtonItem = UIBarButtonItem(customView: burgerButton)
        let rightItemView = UserViewNavigationItem()
        self.rightBarButtonItem = UIBarButtonItem(customView: rightItemView)
    }
    
}
