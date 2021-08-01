//
//  Textmessage.swift
//  chat
//
//  Created by Hashil semin on 24/07/21.
//

import Foundation
import UIKit


 struct  TextMessage : Codable {

    let  messageContent : String
    let receiverName : String
    let senderName : String
    let image : String?
     let date:String?
}
extension UIImage {
    var data: Data? {
        if let data = self.jpegData(compressionQuality: 1.0) {
            return data
        } else {
            return nil
        }
    }
}

extension Data {
    var image: UIImage? {
        if let image = UIImage(data: self) {
            return image
        } else {
            return nil
        }
    }
}
//_id: 60fe8ab392e4df11cb1e5afa,
//date: '2021-07-26 15:43:07',
//sender: '7',
//reciever: '7',
//messageContent: 'B'
