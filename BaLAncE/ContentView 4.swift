//
//  ContentView.swift
//  BaLAncE
//
//  Created by applelab02 on 2/10/26.
//

import SwiftUI

struct ContentView4: View {
    var body: some View{
        NavigationStack{
            VStack(spacing: 10){
                HStack{
                    
                    Spacer()
                    Text("Status")
                    Image (systemName: "heart.fill")
                        .foregroundStyle(Color.red)
                        .bold()
                        
                    Spacer()
                }.padding()
                
                HStack(spacing: 20){
                    Text("Mon")
                    Text("Tue")
                    Text("Wed")
                    Text("Thu")
                    Text("Fri")
                    Text("sat")
                    Text("Sun")
                }
               
                HStack(spacing: 38){
                    Text("1")
                    Text("2")
                    Text("3")
                    Text("4")
                    Text("5")
                    Text("6")
                    Text("7")
                }
                
                    Text("weekly progress")
                        .padding(.leading, -170)
                ZStack{
                    HStack{
                        ProgressView(value: 5.0, total: 10.0)
                            .tint(Color.green)
                            .scaleEffect(x: 1, y: 5, anchor: .center) // increases height
                       
                        Text("50%")
                    }.padding()
                        
                      Rectangle()
                        .foregroundColor(.blue)
                        .frame(height: 90)
                        .cornerRadius(20)
                        .opacity(0.2)
                    
                     }
             }.padding(20)
            List{
                NavigationLink{
                    ContentView3()
                }label: {
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
                      
                         Text("210 mins")
                        }
                    }
                }
                NavigationLink{
                    ContentView5()
                }label: {
                    VStack{
                        HStack{
                            Image(systemName: "figure.walk")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color .gray )
                                .padding()
                            
                            VStack(alignment: .leading){
                                Text("walk for 30min's")
                                ProgressView(value: 5.0, total: 10.0)
                                    .tint(Color.black)
                             }
                      
                         Text("210 mins")
                        }
                    }
                }
                NavigationLink{
                    ContentView7()
                }label: {
                    VStack{
                        HStack{
                            Image(systemName: "drop.fill")
                                .resizable()
                                .frame(width: 14 , height: 15)
                                .foregroundColor(Color .blue )
                                .padding()
                            
                            VStack(alignment: .leading){
                                Text("Water Intake(5L)")
                                ProgressView(value: 5.0, total: 10.0)
                                    .tint(Color.blue)
                            }
                            
                            Text("35L")
                        }
                    }
                }
                NavigationLink{
                    ContentView8()
                }label: {
                    VStack{
                        HStack{
                            Image(systemName: "moon.fill")
                                .resizable()
                                .frame(width: 20 , height: 20)
                                .foregroundColor(Color .yellow )
                                .padding()
                            
                            VStack(alignment: .leading){
                                Text("Sleep by 11 PM")
                                ProgressView(value: 10.0, total: 10.0)
                                    .tint(Color.yellow)
                            }
                            
                            Text("56 HOURS")
                        }
                    }
                }
                NavigationLink{
                    ContentView6()
                }label: {
                    VStack{
                        HStack{
                            Image(systemName: "figure.outdoor.cycle")
                                .resizable()
                                .frame(width: 20 , height: 20)
                                .foregroundColor(Color .green )
                                .padding()
                            
                            VStack(alignment: .leading){
                                Text("Cycling")
                                ProgressView(value: 5.0, total: 10.0)
                                    .tint(Color.green)
                            }
                            
                            Text("210 mins")
                        }
                    }
                }
                NavigationLink{
                    ContentView9()
                }label: {
                    VStack{
                        HStack{
                            Image(systemName: "book.fill")
                                .resizable()
                                .frame(width: 20 , height: 20)
                                .foregroundColor(Color .purple )
                                .padding()
                            
                            VStack(alignment: .leading){
                                Text("Read for 2 Hours")
                                ProgressView(value: 5.0, total: 10.0)
                                    .tint(Color.purple)
                            }
                            
                            Text("14 Hours")
                        }
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
                           .foregroundColor(Color .black )
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
    ContentView4()
}
