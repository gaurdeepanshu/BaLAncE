//
//  notification view.swift
//  BaLAncE
//
//  Created by applelab02 on 3/2/26.
//

import SwiftUI
struct notificationview: View {
    var body: some View {
        HStack{
            Image(systemName: "chevron.left")
              Spacer()
        }
        .padding()
        VStack{
            Text("Notification")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
            //Spacer()
        HStack{
               // Text("Notification")
                   Spacer()
            Toggle("Notification", isOn: .constant(true))
                .padding()
                
         }
            
        .padding()
            Spacer()
        }
     
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
}
#Preview {
    notificationview()
}
