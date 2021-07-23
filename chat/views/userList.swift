//
//  userList.swift
//  chat
//
//  Created by Hashil semin on 22/07/21.
//

import SwiftUI

struct userList: View {
    @StateObject var settings = GameSettings()
    @ObservedObject var httpRequest = HttpController()
    let variable = HttpController()
    @State private var user = [User]()
//       init() {
//           variable.fetchAccounts(){ (accounts) in
//               // continue your logic
//
//               self.user=accounts
//               print("maghrib niskarik")
//           }
//       }
    //@EnvironmentObject private var User: User

   // @State private var user = [User]()
    var body: some View {
        Text("lklkl")
        NavigationView{
            
                List(user,id: \.username){ item in
                    NavigationLink(destination: PlayerView(name: item.username)) {
                        Text(item.username)
                                    }
                        
                  
                }.onAppear {
                    self.variable.fetchAccounts(){ (accounts) in
                        self.user=accounts
                }
            }
            
           
            .navigationTitle("Stargram")
            
        }
        
}
}

struct userList_Previews: PreviewProvider {
    static var previews: some View {
        userList()
    }
}
