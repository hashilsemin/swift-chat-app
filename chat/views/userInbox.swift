//
//  userInbox.swift
//  chat
//
//  Created by Hashil semin on 23/07/21.
//

import SwiftUI

struct PlayerView: View {
    @State var name: String
    @State private var message: String = ""
    @ObservedObject var service = SocketService()
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var body: some View {
        Spacer()
        HStack{
            TextField("Enter your text",text:$message)
                .textFieldStyle(.roundedBorder)
                .padding()
            Button("send"){
                service.sendMessage(message: message, withNickname: name)
                print("send")
            }
        }
            .font(.largeTitle)
            .navigationTitle("")
                           .toolbar {
                               ToolbarItemGroup(placement: .navigationBarLeading) {
                                   Text(name)
//                                   Button("About") {
//                                       print("About tapped!")
//                                   }
//
//                                   Button("Help") {
//                                       print("Help tapped!")
//                                   }
                               }
                           }
//            .navigationTitle(name)
//            .navigationBarBackButtonHidden(true)
//                      .navigationBarItems(leading: Button(action : {
//                          self.mode.wrappedValue.dismiss()
//                      }){
//                          Image(systemName: "arrow.left")
//                      })
    }
}


struct userInbox_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(name: "Some text")
    }
}
