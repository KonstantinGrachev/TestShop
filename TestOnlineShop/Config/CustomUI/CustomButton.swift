//
//  CustomButton.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 12.03.2023.
//

import UIKit

enum CustomButtonType {
    
    private enum Constants {
        static let cornerRadius: CGFloat = 10
    }
    
    case empty
         
         //log in / sign in
    case loginButtonLoginScreen,
         loginButtonSignScreen,
         signInButton,
         signInWithGoogle,
         signInWithApple
         
         //details
    case detailsPlusButton,
         detailsMinusButton,
         addToCartButton,
         
         //main
         burgerButton,
         viewAllIntoSupplementaryView,
         location,
         
         //cells
         plusIntoCell,
         heartIntoSaleCell,
         plusIntoSaleCell,
         
         //profile
         uploadItem,
         changePhotoButton
    
    case detailsLikeButton,
         detailsShareButton
    
    var image: UIImage? { //some titles
        switch self {
        case .loginButtonLoginScreen,
                .loginButtonSignScreen,
                .detailsPlusButton,
                .detailsMinusButton,
                .viewAllIntoSupplementaryView:
            return nil
        case .signInWithGoogle:
            return UIImage(named: ThemeImages.googleIcon)
        case .signInWithApple:
            return UIImage(named: ThemeImages.appleIcon)

        case .burgerButton:
            return UIImage(named: ThemeImages.burgerButton)
        case .plusIntoCell:
            return UIImage(named: ThemeImages.plusButton)
        case .heartIntoSaleCell:
            return UIImage(named: ThemeImages.heartButton)
        case .plusIntoSaleCell:
            return UIImage(named: ThemeImages.plusSaleButton)
        case .uploadItem:
            return UIImage(named: ThemeImages.upload)
        case .location:
            return UIImage(systemName: ThemeImages.systemChevronDown)
        case .detailsLikeButton:
            return UIImage(systemName: ThemeImages.systemHeart)
        case .detailsShareButton:
            return UIImage(named: ThemeImages.share)
        default:
            return nil
        }
    }
    
    var title: String {
        switch self {
        case .loginButtonLoginScreen,
                .loginButtonSignScreen:
            return LocalizedStrings.loginButton
        case .signInWithGoogle:
            return LocalizedStrings.googleSignIn
        case .signInWithApple:
            return LocalizedStrings.appleSignIn
        case .signInButton:
            return LocalizedStrings.signInTitle
        case .detailsPlusButton:
            return "+"
        case .detailsMinusButton:
            return "-"
        case .viewAllIntoSupplementaryView:
            return LocalizedStrings.supplementaryViewTitleButton
        case .uploadItem:
            return LocalizedStrings.uploadItemTitle
        case .location:
            return LocalizedStrings.locationTitle
        case .changePhotoButton:
            return LocalizedStrings.changePhotoTitleButton
        case .addToCartButton:
            return LocalizedStrings.addToCartTitleButton
        default:
            return ""
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .loginButtonLoginScreen,
                .detailsPlusButton,
                .detailsMinusButton,
                .uploadItem,
                .signInButton:
            return ThemeColor.buttonBackgroundColor
        default:
            return .clear
        }
    }
    
    var cornerRadius: CGFloat {
        switch self {
        case .loginButtonLoginScreen,
                .detailsPlusButton,
                .detailsMinusButton,
                .uploadItem,
                .signInButton:
            return Constants.cornerRadius
        default: return 0
        }
    }
    
    var tintColor: UIColor {
        switch self {
        case .loginButtonLoginScreen,
                .detailsPlusButton,
                .detailsMinusButton,
                .uploadItem,
                .signInButton,
                .addToCartButton:
            return .white
            
        case .loginButtonSignScreen:
            return .systemBlue
            
        case .signInWithGoogle,
                .signInWithApple,
                .burgerButton,
                .location:
            return .black
            
        case .plusIntoCell,
             .plusIntoSaleCell,
             .heartIntoSaleCell,
             .detailsShareButton,
             .detailsLikeButton:
            return ThemeColor.buttonIconTintColor
            
        case .viewAllIntoSupplementaryView,
             .changePhotoButton:
            return .gray
            
        case .empty:
            return .clear
        
        }
    }
    
    var font: UIFont? {
        switch self {
        case .loginButtonLoginScreen,
             .uploadItem,
             .signInButton:
            return ThemeFont.buttonFont()
        case .loginButtonSignScreen,
             .viewAllIntoSupplementaryView,
             .location,
             .changePhotoButton:
            return ThemeFont.primaryFont()
        case .signInWithGoogle, .signInWithApple:
            return ThemeFont.signInWithButtonFont()
        case .addToCartButton:
            return ThemeFont.addToCartButton()
            case .detailsPlusButton,
                .detailsMinusButton:
            return ThemeFont.plusMinusDetailsButton()
        default:
            return .systemFont(ofSize: 14)
        }
    }
}

final class CustomButton: UIButton {
    private var type: CustomButtonType = .empty
    
    convenience init(_ type: CustomButtonType, action: UIAction) {
        self.init(frame: .zero)
        self.layer.cornerRadius = type.cornerRadius
        self.backgroundColor = type.backgroundColor
        var configuration = UIButton.Configuration.plain()
        var container = AttributeContainer()
        container.font = type.font
        configuration.attributedTitle = AttributedString(type.title, attributes: container)
        configuration.image = type.image
        configuration.imagePlacement = .leading
        configuration.imagePadding = 10
        
        self.configuration = configuration
        
        tintColor = type.tintColor
        backgroundColor = type.backgroundColor
        layer.cornerRadius = type.cornerRadius
        self.addAction(action, for: .touchUpInside)
        
        switch type {
        case .location:
            self.configuration?.preferredSymbolConfigurationForImage = .init(pointSize: 6)
            self.configuration?.imagePadding = 3
            self.configuration?.imagePlacement = .trailing
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

