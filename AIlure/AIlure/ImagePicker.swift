//
//  ImagePicker.swift
//  AIlure
//
//  Created by Eileen Wang on 1/23/25.
//

import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    enum SourceType {
        case photoLibrary
        case camera
    }
    
    var sourceType: SourceType
    @Binding var selectedImage: UIImage?
    var onImagePicked: ((UIImage) -> Void)?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType == .camera ? .camera : .photoLibrary
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
                parent.onImagePicked?(image)
            }
            picker.dismiss(animated: true)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}
/*
import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    // Source type: camera or photo library
    var sourceType: UIImagePickerController.SourceType
    // Binding to pass the selected image back to the parent view
    @Binding var selectedImage: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator // Set the delegate
        picker.sourceType = sourceType // Set the source type (camera or photo library)
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // No update logic required
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    // Coordinator to handle the image picker delegate methods
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        // Delegate method when an image is selected
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image // Assign the selected image
            }
            picker.dismiss(animated: true) // Dismiss the picker
        }

        // Delegate method when cancel is pressed
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true) // Dismiss the picker
        }
    }
}*/
