//
//  settingview.swift
//  BaLAncE
//
//  Created by applelab02 on 2/27/26.
//
import SwiftUI
struct Settingview: View {
    var body: some View {
        HStack{
            Image(systemName: "chevron.left")
              Spacer()
        }
        
        .padding()
        
        NavigationStack{
            List{
                Section("Account") {
                   Text("Edit profile")
                }
                Section("other") {
                    Text("Notification")
                    Text("Privacy Policy")
                    Text("About Us")
                    Text("Follow Us")
                //   Text("")
                //   Text("")
                //   Text("")
                //   Text("")
                //   Text("")
                    Text("Switch account")
                      .foregroundColor(.blue)
                    Text("Log out")
                      .foregroundColor(.red)
                    
                    
                  
                   
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                }
            }.navigationTitle(Text("Setting"))
        }
    }
}
#Preview {
    Settingview()
}
