//
//  socketConnection.swift
//  chat
//
//  Created by Hashil semin on 22/07/21.
//

import Foundation
import SocketIO
final class SocketService: ObservableObject{
 
    //var chat = user.TextMessage
    private var manager = SocketManager(socketURL: URL(string: "http://localhost:3000/api/v1/message")!,config: [.log(true),.compress])
   private var txt = [TextMessage]()
    @Published var messages = [String]()
    init(){
        print("herer")
        let socket = manager.defaultSocket
        socket.on(clientEvent: .connect){(data,ack) in
          print("connected init")
//            socket.emit("hi node js server")
//            socket.emit("chatMessage", "HAAASHHIIIL", "message")
        }
        //print(client)
        print("------------------------------------------111110++++++++++++++++++++++++++++++++++++++++")

        //socket.auth = { username };
        socket.connect()
       
        print(" qwwQQQQQQQQQQ")
     
    }
    func sendImage (base64:String,sender: String,reciever:String,randomInt1:String,completion: @escaping () -> Void){
        let socket = manager.defaultSocket
        //print(type(of: base64))
        print("kookooo")
        //let randomInt = Int.random(in: 1..<50000000000)
        print(randomInt1)
        socket.emit("sendImage",base64,sender,reciever,randomInt1)
        completion()
    }
    func parseData(_ data: Array<Any>) -> [TextMessage]{
        do{
            // Encode the array of NSDictionary items into Data
             let dataInfo = data.first 
            let data1 = try JSONSerialization.data(withJSONObject: dataInfo, options: [])
            print("SECOND STEP")
            print(data1)
        
            print(type(of: data1))

          print(data)
            print("SECOND STEP")
            // Decode the data into a TextMessage value array
            let decoded = try JSONDecoder().decode([TextMessage].self, from: data1)
            print(decoded)
            return decoded
        }
        catch(let err){
            // Catch and print any error
            print("ERRROOOOR")
            print(err)
            return []
        }
    }
    func subscribe (sender:String,reciever:String,completion: @escaping ([[String: Any]]) -> Void){
        let socket = manager.defaultSocket
        socket.emit("subscribe",sender,reciever)
        socket.on(sender) {(data,ack) in
            print("BEGGGIIIN")
            print(data)
            print(type(of: data))
            print(type(of: data[0]))
            completion(data[0] as! [[String: Any]])
//            var currentUsers: [TextMessage] = []
//
//                    for TextMessage in data {
//                        let name = TextMessage["sender"] as! String
//                        let isConnected = userData["isConnected"] as! Bool
//
//                        let user = TextMessage(username: name, status: isConnected ? .online : .offline)
//
//                        currentUsers.append(user)
//                    }
//
//                    self?.users = currentUsers
            
            //var strings: [String] = data.object(forKey: "myKey") as? [String] ?? []
            //completion(data[0] as! [TextMessage])
         
//            messageDict["messageContent"] = data[2] as! String
//            messageDict["receiverName"] = data[3] as! String
//            let senderName1 = messageDict["senderName"] as! String
//            let messageContent1 = messageDict["messageContent"] as! String
//            let receiverName1 = messageDict["receiverName"] as! String
//
//            let message = TextMessage(messageContent: messageContent1, receiverName:receiverName1,senderName:senderName1)
//                     self.txt.append(message)
            //completion(self.txt)
            print("xxxxxxxxxxxxxxxxxxxxxxxxx")
        }
        //getMessages(client1: sender)
return
    }
    //,completion: @escaping ([TextMessage]) -> Void
    func getMessages(client1 : String,completion: @escaping ([TextMessage]) -> Void){
        print("VILLICHUUU")
        print("VANNILLA KETTO")
        print(client1+"q")
        let socket = manager.defaultSocket
        socket.on(client1+"q") {(data,ack) in
            //print("------------------\(data)-8INIESTA8888++++++++++++++++++++++++++++++++++++++++")
            print("IMAGE UNDA")
            //print(type(of: data[0]))
            var messageDict: [String: Any] = [:]
            print(data[0])
            print(type(of: data[1]))
            //let imageName = messageDict["imageName"] as! String
            print(data[2])
//            let img = data[3]
            messageDict["senderName"] = data[0] as! String
            messageDict["messageContent"] = data[1] as! String
   messageDict["receiverName"] = data[2] as! String
            messageDict["date"] = data[3] as! String
            //completionHandler(messageDict)
   let senderName1 = messageDict["senderName"] as! String
   let messageContent1 = messageDict["messageContent"] as! String
   let receiverName1 = messageDict["receiverName"] as! String
            print(type(of: data[1]))
            print(data[1])
            let date1 = messageDict["date"] as! String
            if data[1] as! String == "null" {
                print("image vanneeeee")
                messageDict["imageName"] = data[3] as! String
                let imageName = messageDict["imageName"] as! String
                let date1 = messageDict["date"] as! String
//               let imgData =  convertBase64StringToImage(imageBase64String: data[3] as! String)
//                print(type(of: imgData))
//                func saveImage(image: UIImage) -> Bool {
//                    let imageSaver = ImageSaver()
//                    imageSaver.writeToPhotoAlbum(image: image)
//                    guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
//                        return false
//                    }
//                    guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
//                        return false
//                    }
//                    do {
//                        print(directory)
//                        print("directory")
//                        try data.write(to: directory.appendingPathComponent("fileName.png")!)
//                        return true
//                    } catch {
//                        print(error.localizedDescription)
//                        return false
//                    }
//                    return true
////                }
//                print(type(of: imgData))
//
//                let success = saveImage(image: imgData)
//                print("success aano?")
//                print(success)
                
                //completion
                let message = TextMessage(messageContent: messageContent1, receiverName:receiverName1,senderName:senderName1, image:imageName, date: date1 )
                         self.txt.append(message)
                completion([message])
                return
            }
           
            //let messageContent1 = messageDict["messageContent"] as! String
            let message = TextMessage(messageContent: messageContent1, receiverName:receiverName1,senderName:senderName1, image: nil,date: date1)
                     //self.txt.append(message)
            completion([message])
            //print(self.parseData(data));
            //self.txt = self.parseData(data)
            //completion(self.txt)
            //print(self.parseData(data));
                //self.txt = self.parseData(data)
//            if let response: TextMessage = try? SocketParser.convert(data: dataInfo) {
//                print("DUFFFFFFFFFFFF")
//                print(response)
////            if let name = data[0] as? String, let typeDict = data[0] as? NSDictionary {
////                           print(name)
////                       }
////            guard let dataInfo = data.first else { return }
////            let jsonData = try JSONSerialization.data(withJSONObject: dataInfo)
////            let decoder = JSONDecoder()
////            print(decoder.decode(self.txt, from: dataInfo))
//
//
//            //print(self.parseData(data));
//            //self.txt = self.parseData(data)
//            //completion(self.txt)
//
        }
    }
    func sendMessage(message: String,sender: String,reciever:String) {
        let socket = manager.defaultSocket
         socket.emit("chatMessage", sender,reciever, message)
        
     }
    func appendMessage( txt:[Any]){
        print("OOOH YEAAAH")
        //self.txt=txt
    }
  
}
