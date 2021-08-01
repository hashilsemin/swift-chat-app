//
//  userInbox.swift
//  chat
//
//  Created by Hashil semin on 23/07/21.
//

import SwiftUI
import UIKit
import SDWebImageSwiftUI


struct PlayerView: View {
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage:UIImage?
    @State var name: String
     var client: String
    
    @State private var message: String = ""
    //@State private var randomInt: Int
    @ObservedObject var service = SocketService()
    @EnvironmentObject var settings: GameSettings
    @State private var txt = [TextMessage]()
    
    @State private var isHidden  = false
    @ObservedObject var httpRequest = HttpController()
    //@State private var txt = [TextMessage]()
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    func loadImage(){
        guard let  inputImage = inputImage else {
            return
        }
       
image = Image(uiImage: inputImage)
    }
    func readImageFromDocs()->UIImage?{
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let filePath = URL(fileURLWithPath: documentsPath).appendingPathComponent("filename.png").path
        if FileManager.default.fileExists(atPath: filePath) {
            return UIImage(contentsOfFile: filePath)
        } else {
            return nil
        }
    }
    let jam = 3175670394
    //var imageView : UIImageView
    var body: some View {
   // imageView.sd_setImage(with: URL(string: "http://www.domain.com/path/to/image.jpg"), placeholderImage: UIImage(named: "placeholder.png"))
//WebImage(url: URL(string: "http://localhost:3000/user-image/331993.jpg"))
        //WebImage(url: URL(string: "http://localhost:3000/user-image/3175670394.jpg")).resizable().frame(width: 80, height: 80).clipShape(Circle())
        //print("http://localhost:3000/user-image/.jpg")
        let theImg = readImageFromDocs()
        //Image(uiImage: UIImage(theImg)!)
//        NavigationView{
//                List(txt,id: \.messageContent)
//            { item in
//               // UIImage(data: item.image)
//                if ((item.image) != nil) {
//                    WebImage(url: URL(string: "http://localhost:3000/user-image/\(item.image ?? "Anonymous").jpg")).resizable().frame(width: 80, height: 80).clipShape(Circle())
//                } else {
//                    Text(item.messageContent)
//                    .foregroundColor(item.senderName==client ? .red : .blue)
//                }
//
//                //Text(item.image ?? "nil")
//                //Text("http://localhost:3000/user-image/\(item.image ?? "Anonymous").jpg");
//
////                DispatchQueue.main.async {
//
////                         }
//                }}
//            .navigationTitle("Stargram")
        ScrollView(.vertical ,showsIndicators: false){
            VStack{
                ForEach(txt,id: \.date){i in
                    chatCell(data: i,client : client)
                }
            }
        }
        Spacer()
        
        HStack{
            VStack {
                      image?
                          .resizable()
                          .scaledToFit()
			
                      Button("Select Image") {
                          self.isHidden =  true
                         self.showingImagePicker = true
                      }
                  }
                  .sheet(isPresented: $showingImagePicker ,onDismiss: loadImage) {
                      ImagePicker(image: self.$inputImage)
                      
                  }	
            TextField("\(self.client)",text:$message)
                .opacity(showingImagePicker ? 0 : 1)
                .textFieldStyle(.roundedBorder)
                .padding()
//            Button("“Open Camera”"){
//                        //Button Action Goes here
//                     }.padding()
//                      .foregroundColor(Color.white)
//                      .background(Color.orange)
//                      .cornerRadius(10)
               
            Button("send"){
                print(inputImage)
                print("pickerrrr")
                if (inputImage != nil) {
                    print("aaadu")
                    let imgstring =  convertImageToBase64(image: inputImage!)
                    let RI = Int.random(in: 1..<50000000000)
                    var randomInt1 = String(RI)
                    service.sendImage(base64: imgstring ?? "nil", sender:self.client,reciever:self.name,randomInt1:randomInt1){() in
                        print("imagoli")
                        print(randomInt1)
                        let date = Date()

                        // Create Date Formatter
                        let dateFormatter = DateFormatter()

                        // Set Date Format
                        dateFormatter.dateFormat = "YY, MMM d, HH:mm:ss"

                        // Convert Date to String
                        dateFormatter.string(from: date)
                        let sendImgMessage = TextMessage(messageContent: "null", receiverName:self.name,senderName:self.client, image: randomInt1,date:   dateFormatter.string(from: date))
                        //self.txt += [sendImgMessage]
                    }
                    inputImage = nil
                    return
                  
                }
                let date = Date()

                // Create Date Formatter
                let dateFormatter = DateFormatter()

                // Set Date Format
                dateFormatter.dateFormat = "YY, MMM d, HH:mm:ss"

                // Convert Date to String
                dateFormatter.string(from: date)
                let sendMessage = TextMessage(messageContent: self.message, receiverName:self.name,senderName:self.client, image: nil, date:dateFormatter.string(from: date))
                self.txt += [sendMessage]
                service.sendMessage(message: message, sender: self.client,reciever: name)
                print("sendanghe")
            }
    }   .onAppear(perform: {
            httpRequest.getAllMessages(client: client,username: name){(data) in
                print("chaya")
                self.txt=data
            }
            service.getMessages(client1: client)
            { (txt1) in
                self.txt += txt1
        }
        })
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
        }
        
//            .navigationTitle(name)
//            .navigationBarBackButtonHidden(true)
//                      .navigationBarItems(leading: Button(action : {
//                          self.mode.wrappedValue.dismiss()
//                      }){
//                          Image(systemName: "arrow.left")
//                      })
    
}
struct chatCell : View {
    var data : TextMessage
    var client : String
    var body: some View{
        HStack{
                        
            
            if data.senderName==client {
                Spacer()
                if ((data.image) != nil) {
                    //Text(data.image ?? "")
                    WebImage(url: URL(string: "http://localhost:3000/user-image/\(data.image ?? "Anonymous").jpg")).resizable().frame(width: 140, height: 120).clipShape(RoundedRectangle(cornerRadius: 25))
                } else{
                    Text(data.messageContent)
                        .padding()
                        .background(Color.blue)
                        .clipShape(msgTail(myMsg: false))
}
        }
            else{
                if ((data.image) != nil) {
                    WebImage(url: URL(string: "http://localhost:3000/user-image/\(data.image ?? "Anonymous").jpg")).resizable().frame(width: 80, height: 80).clipShape(Circle())
                } else{
                    Text(data.messageContent)
                        .padding()
                        .background(Color(.red))
                        .clipShape(msgTail(myMsg: true))
                    Spacer()
                }
            
            }
        }
        .padding(data.senderName==client ? .leading : .trailing, 55)
        .padding(.vertical,10)
    }
}
struct msgTail : Shape{
    var myMsg : Bool
    func path (in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight,myMsg ? .bottomRight : .bottomLeft],cornerRadii: CGSize(width: 25, height: 25))
        return Path(path.cgPath)
    }
}
struct userInbox_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(name: "", client: "")
       
    }
}
