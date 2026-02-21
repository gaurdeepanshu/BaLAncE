//
//  ContentView.swift
//  BaLAncE
//
//  Created by applelab02 on 2/10/26.
//

import SwiftUI

struct ContentView2: View {
    @StateObject private var auth = AuthViewModel()
    var body: some View {
        Group {
            if auth.isAuthenticated {
                TabView {
                    NavigationStack {
                        HomeView()
                    }
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                }
                .tint(.black)
            } else {
                AuthView(auth: auth)
            }
        }
    }
}

struct HomeView: View {
    var body: some View{
        NavigationStack{
            Text("BALANCE")
                .font(.system(size: 30))
                .bold()
            Spacer()
            VStack{
                HStack{
                    Text("Today")
                        .font(.system(size: 20))
                        .bold()
                    Spacer()
                   // NavigationLink{
                  //      ContentView()
//                    } label: {
//                        Image(systemName: "person.fill")
//                            .resizable()
//                            .frame(width: 20, height: 20)
//                    }.foregroundColor(.black)
              }
                .padding()
                VStack{
                    HStack{
                        Text("Track your habits and stay consistent")
                        Spacer()
                    }
                    .padding()
                }
           }
         List{
             ZStack{
                 Rectangle()
                     .frame(height: 40)
                     .foregroundColor(Color .black.opacity(0.1))
                     .cornerRadius(11)
                 HStack{
                     Image(systemName: "magnifyingglass")
                         .resizable()
                         .frame(width: 20 , height: 20)
                         .foregroundColor(Color .black )
                    Text("Search")
                     Spacer()
                     Image(systemName: "ellipsis")
                   }.padding()
             }
            
                 VStack{
                     HStack{
                         Image(systemName: "dumbbell.fill")
                             .resizable()
                             .frame(width: 20 , height: 10)
                             .foregroundColor(Color .orange )
                             .padding()
                         
                         VStack(alignment: .leading){
                             Text("Exclusive workout")
                             ProgressView(value: 5.0, total: 10.0)
                                 .tint(Color.orange)
                          }
                   
                      Text("30mins")
                     }
                 }
           
             VStack{
                 HStack{
                     Image(systemName: "figure.walk")
                         .resizable()
                         .frame(width: 15 , height: 20)
                         .foregroundColor(Color .gray )
                         .padding()
                     VStack(alignment: .leading){
                         Text("Walk (10k Steps)")
                         HStack(alignment: .bottom){
                             Image(systemName: "figure.walk")
                                 .resizable()
                                 .frame(width: 15 , height: 20)
                                 .foregroundColor(Color .black )
                             Image(systemName: "figure.walk")
                                 .resizable()
                                 .frame(width: 14 , height: 19)
                                 .foregroundColor(Color .black )
                             Image(systemName: "figure.walk")
                                 .resizable()
                                 .frame(width: 13 , height: 18)
                                 .foregroundColor(Color .black )
                             Image(systemName: "figure.walk")
                                 .resizable()
                                 .frame(width: 12 , height: 17)
                                 .foregroundColor(Color .gray)
                             Image(systemName: "figure.walk")
                                 .resizable()
                                 .frame(width: 13 , height: 18)
                                 .foregroundColor(Color .gray )
                             Image(systemName: "figure.walk")
                                 .resizable()
                                 .frame(width: 14 , height: 19)
                                 .foregroundColor(Color .gray )
                             Image(systemName: "figure.walk")
                                 .resizable()
                                 .frame(width: 15 , height: 20)
                                 .foregroundColor(Color .gray,)
                         }
                     }
                     Spacer()
                   Text("3217 steps")
                 }
             }
             VStack{
                 HStack{
                     Image(systemName: "drop.fill")
                         .resizable()
                         .frame(width: 15 , height: 20)
                         .foregroundColor(Color .blue )
                         .padding()
                     
                     VStack(alignment: .leading){
                         Text("Water Intake (5L)")
                         HStack(alignment: .bottom){
                             Image(systemName: "drop.fill")
                                 .resizable()
                                 .frame(width: 12 , height: 17)
                                 .foregroundColor(Color .blue )
                             Image(systemName: "drop.fill")
                                 .resizable()
                                 .frame(width: 12 , height: 17)
                                 .foregroundColor(Color .blue )
                             Image(systemName: "drop.fill")
                                 .resizable()
                                 .frame(width: 12 , height: 17)
                                 .foregroundColor(Color .blue )
                             Image(systemName: "drop.fill")
                                 .resizable()
                                 .frame(width: 12 , height: 17)
                                 .foregroundColor(Color .gray)
                             Image(systemName: "drop.fill")
                                 .resizable()
                                 .frame(width: 12 , height: 17)
                                 .foregroundColor(Color .gray )
                         }
                     }
                     Spacer()
                  Text("3L")
                 }
             }
             VStack{
                 HStack{
                     Image(systemName: "moon.fill")
                         .resizable()
                         .frame(width: 20 , height: 20)
                         .foregroundColor(Color .yellow )
                         .padding()
                      VStack(alignment: .leading){
                         Text("Sleep (8 hours)")
                         ProgressView(value: 5.0, total: 10.0)
                             .tint(Color.yellow)
                     }
                     Spacer()
                  Text("4 hours")
                 }
             }
             VStack{
                 HStack{
                     Image(systemName: "figure.outdoor.cycle")
                         .resizable()
                         .frame(width: 20 , height: 20)
                         .foregroundColor(Color .green )
                         .padding()
                      VStack(alignment: .leading){
                         Text(" cycling (5km)")
                         ProgressView(value: 5.0, total: 10.0)
                             .tint(Color.green)
                     }
                     Spacer()
                  Text(" 2.5 km")
                 }
             }
             VStack{
                 HStack{
                     Image(systemName: "book.fill")
                         .resizable()
                         .frame(width: 20 , height: 20)
                         .foregroundColor(Color.purple)
                         .padding()
                     VStack(alignment: .leading){
                         Text(" Read (2 hours)")
                         ProgressView(value: 5.0, total: 10.0)
                             .tint(Color.purple)
                     }
                     Spacer()
                  Text(" 1 hours")
                 }
             }
              }
           HStack{
                Spacer()
                VStack {
                    Image(systemName: "house.fill")
                        .resizable()
                        .frame(width: 30 , height: 30)
                        .foregroundColor(Color .black )
                    Text("Home")
                        .font(.system(size: 15))
                        .bold()
                }
                Spacer()
             
                   VStack {
                        Image(systemName: "heart.fill")
                            .resizable()
                            .frame(width: 30 , height: 30)
                            .foregroundColor(Color .red )
                        Text("status")
                            .font(.system(size: 15))
                            .bold()
                    }
               
                Spacer()
                VStack {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 30 , height: 30)
                        .foregroundColor(Color .brown )
                    Text("search")
                        .font(.system(size: 15))
                        .bold()
                }
                Spacer()
           }
       }.toolbar(.hidden)
    }
}
#Preview {
    ContentView2()
}
