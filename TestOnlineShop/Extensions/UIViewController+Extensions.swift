//
//  UIViewController+Extensions.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 19.03.2023.
//

import UIKit

extension UIViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func showActionSheet() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: LocalizedStrings.fromCamera, style: .default) { [self] _ in
            showPicker(source: .camera)
        }
        
        let cameraIcon = UIImage(systemName: ThemeImages.systemCamera)
        cameraAction.setValue(cameraIcon, forKey: "image")
        cameraAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        let photoLibraryAction = UIAlertAction(title: LocalizedStrings.fromPhotos, style: .default) { [self] _ in
            showPicker(source: .photoLibrary)
        }
        let photoLibraryIcon = UIImage(systemName: ThemeImages.systemPhoto)
        photoLibraryAction.setValue(photoLibraryIcon, forKey: "image")
        photoLibraryAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        
        let cancelAction = UIAlertAction(title: LocalizedStrings.cancel, style: .cancel)
        
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(photoLibraryAction)
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true)
        
    }
    
    func showPicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let picker = UIImagePickerController()
            picker.sourceType = source
            picker.allowsEditing = true
            picker.delegate = self
            present(picker, animated: true, completion: nil)
        }
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var chosenImage = UIImage()
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            chosenImage = image
        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            chosenImage = image
        }
        handlePickedImage(chosenImage)
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func handlePickedImage(_ image: UIImage) {
    }
}


extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK",
                               style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    
    func showAlert(title: String,
                   message: String,
                   method: @escaping ((UIAlertAction) -> Void)) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let ok = UIAlertAction(title: LocalizedStrings.tryAgain,
                               style: .default)
        alert.addAction(ok)
        
        let cancel = UIAlertAction(title: LocalizedStrings.goBack,
                                   style: .cancel,
                                   handler: method)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    
}
