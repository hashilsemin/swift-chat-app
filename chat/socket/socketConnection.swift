//
//  socketConnection.swift
//  chat
//
//  Created by Hashil semin on 22/07/21.
//

import Foundation
import SocketIO
final class SocketService: ObservableObject{
    private var manager = SocketManager(socketURL: URL(string: "http://localhost:3000/api/v1/message")!,config: [.log(true),.compress])

    @Published var messages = [String]()
    init(){
        print("herer")
        let socket = manager.defaultSocket
        socket.on(clientEvent: .connect){(data,ack) in
            print("connected")
            socket.emit("hi node js server")
            socket.emit("chatMessage", "nickname", "message")
        }
        socket.connect()
       
        print(" qwwQQQQQQQQQQ")
    }
    func sendMessage(message: String, withNickname nickname: String) {
        let socket = manager.defaultSocket
         socket.emit("chatMessage", nickname, message)
     }
}
