//
//  LoadImage.swift
//  chat
//
//  Created by Hashil semin on 29/07/21.
//

import Foundation
import UIKit
func imageFromLocal(){
    let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
    let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
    let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
    let dirPath          = "file:///Users/hashil/Library/Developer/CoreSimulator/Devices/AB856BCA-CE34-48B0-A89D-16C549216AAC/data/Containers/Data/Application/AF1049FB-CAEE-42F0-B854-7FDFD0988586/Documents/"

       let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent("Image2.png")
       let image    = UIImage(contentsOfFile: imageURL.path)
}
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
   // Do whatever you want with the image

