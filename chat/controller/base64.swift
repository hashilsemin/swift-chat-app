//
//  base64.swift
//  chat
//
//  Created by Hashil semin on 28/07/21.
//

import Foundation
import UIKit
func convertImageToBase64(image: UIImage) -> String? {
    
    return image.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
  }

func convertBase64StringToImage (imageBase64String:String) -> UIImage {
    print(type(of: imageBase64String))
    print("saras")
    let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
    print(imageData)
    let image = UIImage(data: imageData!)
    print("convert to image");
    return image!
}	
