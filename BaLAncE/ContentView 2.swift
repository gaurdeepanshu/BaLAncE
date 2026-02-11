//
//  ContentView.swift
//  BaLAncE
//
//  Created by applelab02 on 2/10/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View{
        Text("BALANCE")
            .font(.system(size: 25))
            .bold()
        VStack(alignment: .leading){
          HStack(alignment: .top){
                Circle()
                    .foregroundColor(Color .blue )
                    .frame(height: 80)
                    .opacity(0.2)
                VStack(alignment: .leading){
                    Text("user name")
                        .bold()
                       // .font(.system(size: 25))
                    Text("User@email.com")
               }
                Spacer()
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)   )
            Spacer()
            List{
                VStack{
                    HStack{
                          Text("Habit Status")
                        Spacer()
                        Image(systemName: "flame.fill")
                        
                        Text("Day streak")
                    }
                }
                VStack{
                    HStack{
                        Image(systemName: "dumbbell")
                        VStack(alignment: .leading){
                            Text("Exclusive workout")
                            Text("5 / 5")
                        }
                        Spacer()
                        Image(systemName: "flame.fill")
                        
                        Text("Day streak")
                    }
                }
                VStack{
                    HStack{
                        Image(systemName: "figure.walk")
                        VStack(alignment: .leading){
                            Text("Walk")
                            Text("5 / 5")
                        }
                        Spacer()
                        Image(systemName: "flame.fill")
                        
                        Text("Day streak")
                    }
                }
                VStack{
                    HStack{
                        Image(systemName: "figure.run")
                        VStack(alignment: .leading){
                            Text("Running")
                            Text("5 / 5")
                        }
                        Spacer()
                        Image(systemName: "flame.fill")
                        
                        Text("Day streak")
                    }
                }
                VStack{
                    HStack{
                        Image(systemName: "figure.outdoor.cycle")
                        VStack(alignment: .leading){
                            Text("Cycling")
                            Text("5 / 5")
                        }
                        Spacer()
                        Image(systemName: "flame.fill")
                        
                        Text("Day streak")
                    }
                }
                VStack{
                    HStack{
                        Image(systemName: "moon")
                        VStack(alignment: .leading){
                            Text("Sleep")
                            Text("5 / 5")
                        }
                        Spacer()
                        Image(systemName: "flame.fill")
                        
                        Text("Day streak")
                    }
                }
                VStack{
                    HStack{
                        Image(systemName: "drop.fill")
                        VStack(alignment: .leading){
                            Text("Water")
                            Text("5 / 5")
                        }
                        Spacer()
                        Image(systemName: "flame.fill")
                        
                        Text("Day streak")
                    }
                }
                ZStack{
                    Rectangle()
                        .frame(height: 40)
                        .opacity(0.3)
                        .cornerRadius(8)
                    HStack {
                        Spacer()
                        Text("manage habbits")
                        Spacer()
                        Image(systemName: "chevron.right")
                            .resizable( )
                            .scaledToFit( )
                            .frame(width: 20 , height: 20)
                    }
               }
                
                ZStack{
                    Rectangle()
                        .frame(height: 40)
                        .opacity(0.3)
                        .cornerRadius(8)
                    HStack {
                        Spacer()
                        Text("reminders")
                        Spacer()
                        Image(systemName: "chevron.right")
                            .resizable( )
                            .scaledToFit( )
                            .frame(width: 20 , height: 20)
                    }
               }
                 }
         }
        
        HStack{
            Spacer()
            VStack {
                Image(systemName: "house")
                    .resizable()
                    .frame(width: 30 , height: 30)
                    .foregroundColor(Color .black )
                Text("Home")
                    .font(.system(size: 15))
                    .bold()
            }
            
            Spacer()
            
            VStack {
                Image(systemName: "heart")
                    .resizable()
                    .frame(width: 30 , height: 30)
                    .foregroundColor(Color .black )
                Text("status")
                    .font(.system(size: 15))
                    .bold()
            }
            Spacer()
            
            VStack {
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 30 , height: 30)
                    .foregroundColor(Color .black )
                Text("profile")
                    .font(.system(size: 15))
                    .bold()
            }
            Spacer()
       }
    }
}
#Preview {
    ContentView()
}
