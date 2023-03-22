//
//  CustomTextField.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 12.03.2023.
//

import UIKit

enum CustomTextFieldType {
    case firstname,
         lastname,
         password,
         email,
         empty
    
    var placeholder: String {
        switch self {
        case .firstname:
            return LocalizedStrings.firstNamePlaceholder
        case .lastname:
            return LocalizedStrings.lastNamePlaceholder
        case .password:
            return LocalizedStrings.passwordPlaceholder
        case .email:
            return LocalizedStrings.emailPlaceholder
        default:
            return ""
        }
    }
}

final class CustomTextField: UITextField {
    private var type: CustomTextFieldType = .empty
    
    convenience init(_ type: CustomTextFieldType) {
        self.init(frame: .zero)
        layer.cornerRadius = 14
        textAlignment = .center
        backgroundColor = ThemeColor.placeholderBackgroundColor
        attributedPlaceholder = NSAttributedString(string: type.placeholder,
                                                   attributes: [NSAttributedString.Key.foregroundColor: ThemeColor.placeholderTextColor])
        font = ThemeFont.placeholderFont()
        
        switch type {
        case .password:
            isSecureTextEntry = true
        case .email:
            keyboardType = .emailAddress
        default: break
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
}
