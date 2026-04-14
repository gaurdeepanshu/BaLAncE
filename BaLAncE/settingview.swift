import SwiftUI
struct Settingview: View {
    var body: some View {
       
        
        NavigationStack{
            List{
                Section("Account") {
                   NavigationLink{
                        ContentView13()
                   }label: {
                       Text("Edit profile")
                   }
                }
                Section("other") {
                    NavigationLink{
                        notificationview()
                    }label: {
                        Text("Notification")
                    }
                   NavigationLink{
                        termsview()
                       
                   }label: {
                       Text("Privacy Policy")
                   }
               
                //   Text("")
                //   Text("")
                //   Text("")
                //   Text("")
                //   Text("")
               
                    
                    NavigationLink{
                        ContentView2()
                    } label: {
                        Text("Log out")
                          .foregroundColor(.red)
                    }
                    
                    
                  
                   

                    
                }
            }.navigationTitle(Text("Setting"))
        }
    }
}
#Preview {
    Settingview()
}



