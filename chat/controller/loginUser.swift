//
//  loginUser.swift
//  chat
//
//  Created by Hashil semin on 22/07/21.
//

import Foundation

final class HttpController : ObservableObject{
    //@Published var accounts: [User]
    func fetchAccounts(completion: @escaping ([User]) -> Void)  {
        let url = URL(string: "http://localhost:3000/getUser/nmnmnm)")
        guard let requestUrl = url else {fatalError()}
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with:request) {(data,response,error) in
            print(data)
            print(response)
            if let error = error {
                print ("ERROR")
                return
            }
            
//            if let data = data, let dataString = String(data: data, encoding: .utf8) {
//                print("EUREKAAAAA:\n \(dataString)")
//            }
            if let data = data{
                
               print(data)
                if let accounts = try? JSONDecoder().decode([User].self, from:data){
                    print("YEEEES YOU GOT IT:\n \(data)")
                    print(accounts)
                    completion(accounts)
                    print("INSIDE USER CONTROLLER IN LOGINUSER")
                }
           }
        }
        task.resume()
//            guard let data = try? Data(contentsOf: accountsFileURL) else { return [] }
//            let decoder = JSONDecoder()
//            let accounts = try? decoder.decode([Account].self, from: data)
//            return accounts ?? []
       
        }
    func registerUser(username:String){
        print("user registering starting")
        let url = URL(string: "http://localhost:3000/login")
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        let json = [
            "username": username
        ]
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
             request.addValue("application/json", forHTTPHeaderField: "Accept")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                // Check for Error
                if let error = error {
                    print("Error took place \(error)")
                    return
                }
         
                // Convert HTTP Response Data to a String
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("Response data string:\n \(dataString)")
                }
            
        }
        task.resume()
    }
        
   
}

