//
//  ImagePicker.swift
//  chat
//
//  Created by Hashil semin on 27/07/21.
//

import Foundation
import SwiftUI
struct ImagePicker : UIViewControllerRepresentable {
    func makeCoordinator() -> Coordinator {
           Coordinator(self)
    }
    
    @Environment(\.presentationMode) var presentationMode
       @Binding var image: UIImage?
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>)
//    {
//       //Update UIViewcontrolleer Method
//    }
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
         var parent: ImagePicker

         init(_ parent: ImagePicker) {
             self.parent = parent
         }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
     }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController 
    {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
       // Create UIViewController which we will display inside the View of the UIViewControllerRepresentable
    }
    
}
