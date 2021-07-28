//
//  userInbox.swift
//  chat
//
//  Created by Hashil semin on 23/07/21.
//

import SwiftUI

struct PlayerView: View {
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage:UIImage?
    @State var name: String
    var client: String
    @State private var message: String = ""
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
    var body: some View {
    
        NavigationView{
                List(txt,id: \.messageContent)
            {item in
                    Text(item.messageContent)
                
                    .foregroundColor(item.senderName==client ? .red : .blue)
                }}
            .navigationTitle("Stargram")
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
                    print(type(of: imgstring))
                    service.sendImage(base64: imgstring ?? "nil")
                    print("imagoli")
                    return
                }
                let sendMessage = TextMessage(messageContent: self.message, receiverName:self.name,senderName:self.client)
                self.txt += [sendMessage]
                service.sendMessage(message: message, sender: self.client,reciever: name)
                print("sendanghe")
            }
    }   .onAppear(perform: {
            httpRequest.getAllMessages(client: client,username: name){(data) in
                print("LAKALKALLAKALAKALAKA")
                print(data)
                self.txt=data
            }
            service.getMessages(client1: client)
            { (txt1) in
                print("NANANANANANANANANANA")
                print(txt1)
                //self.txt=txt1
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


struct userInbox_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(name: "", client: "")
       
    }
}
