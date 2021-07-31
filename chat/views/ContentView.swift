//
//  ContentView.swift
//  chat
//
//  Created by Hashil semin on 17/07/21.
//

import SwiftUI
import SocketIO
import Alamofire
class GameSettings: ObservableObject {
    @Published var username = ""
}
struct ContentView: View {
    @StateObject var settings = GameSettings()
   // @EnvironmentObject var username: UserDetails
    @ObservedObject var httpRequest = HttpController()
    @ObservedObject var service = SocketService()
    @State var username :String = ""
    @State private var showingAlert = false
    @State var showLoginView: Bool = false
    var body: some View {
        VStack{
            VStack {
                      if showLoginView {
                          userList(client: self.username)
                              .animation(.spring())
                              .transition(.slide)
                      } else {
                          HStack{
                              Text("Enter user name 🔥")
                                  .alert(isPresented: self.$showingAlert) {
                                              Alert(title: Text("Didn't your parents give a name to you?"))
                                          }
                              TextField("Username",text: $username)
                                  .multilineTextAlignment(.center)
                          }.environmentObject(settings)
                          Button(action: {
                              if username=="" {
                                  showingAlert = true
                                  return
                              }
                            settings.username = username
                              httpRequest.registerUser(username: username)
                              self.showLoginView = true
                          }
                                 
                          )
                          {
                                  Text("Login")
                          }
                          
                      }
                  }
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
