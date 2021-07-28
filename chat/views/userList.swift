//
//  userList.swift
//  chat
//
//  Created by Hashil semin on 22/07/21.
//

import SwiftUI

struct userList: View {
    var client: String
    @StateObject var settings = GameSettings()
    @ObservedObject var httpRequest = HttpController()
    let variable = HttpController()
    @State private var user = [User]()
//       init() {
//           variable.fetchAccounts(){ (accounts) in
//               // continue your logic
//
//               self.user=accounts
//            
//           }
//       }
    //@EnvironmentObject private var User: User

   // @State private var user = [User]()
    var body: some View {
        Text("lklkl")
        NavigationView{
            
                List(user,id: \.username){ item in
                    NavigationLink(destination: PlayerView(name: item.username,client:self.client)) {
                        Text(item.username)
                            
                                    }
  }.onAppear {
                    self.variable.fetchAccounts(){ (accounts) in
                        self.user=accounts
                }
            }
               
            
           
            .navigationTitle("Stargram ⭐️")
            
        }
        
}
}

struct userList_Previews: PreviewProvider {
    static var previews: some View {
        userList(client: "nmn")
        List{
            Text("hi")
                .frame(maxWidth: .infinity,alignment: .leading)
                                           
                                              .background(Color.blue)
                                              .foregroundColor(Color.black)
                                              .cornerRadius(4)
                                              .frame(width: 70, height: 50, alignment: .center)
            
            Text("hi")
               
        }
        .padding(.horizontal, 4)
           
    }
}
