//
//  ContentView.swift
//  BaLAncE
//
//  Created by applelab02 on 2/10/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View{
        NavigationStack{
            HStack {
             
                    Image(systemName: "chevron.left")
              
                Spacer()
                Text("BALANCE")
                    .font(.system(size: 25))
                    .bold()
                Spacer()
            }.padding()
            VStack(alignment: .leading){
              HStack(alignment: .top){
                    Circle()
                        .foregroundColor(Color .blue )
                        .frame(height: 80)
                        .opacity(0.2)
                    VStack(alignment: .leading){
                        Text("user name")
                            .bold()

                        Text("User@email.com")
                   }
                    Spacer()
                }
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)   )

                List{
                        ZStack{
                            Rectangle()
                                .frame(height: 120)
                                .foregroundColor(Color .gray.opacity(0.3) )
                                .cornerRadius(10)
                            VStack {
                                HStack{
                                    Text("Habit Stats")
                                        .padding()
                                    Text("")
                                    Spacer()
                                    ZStack {
                                        Circle()
                                            .foregroundStyle(Color.white)
                                             .frame(height: 90)
                                             .overlay(RoundedRectangle(cornerRadius: 50).stroke(Color.yellow, lineWidth: 10))
                                             .padding()
                                        Text("75%")
                                             
                                    }
                                    
                                    }
                            }
                    }
                        .padding()
                    ZStack{
                        Rectangle()
                            .frame(height: 120)
                            .foregroundColor(Color .gray.opacity(0.3) )
                            .cornerRadius(10)
    //                    VStack {
                        HStack(spacing: 10){
                            VStack(spacing: 10) {
                                    Text("Goal completed")
    //                                       .padding()
                                       Text("10k")
                                }
                             
                                Rectangle()
                                    .frame(width: 1, height: 70)
                                    .foregroundColor(Color .gray )
                                    .cornerRadius(10)
                                
                            VStack(spacing: 10) {
                                    Text("Longest streak")
    //                                    .padding()
                                       Text("10k")
                                }
                           }
                            
                            
    //                    }
                    }
                    .padding()
               
                    VStack{
                        HStack{
                            Text("Top Habits")
                            Spacer()
                            Image(systemName: "heart.fill")
                                .foregroundColor(Color .red)
                                .padding()
                            //Spacer()
                         
                        }
                    }
                 
                    VStack{
                        HStack{
                            Image(systemName: "dumbbell.fill")
                                .foregroundColor(Color .orange )
                            VStack(alignment: .leading){
                                Text("Exclusive workout")
                                Text("5 / 5")
                            }
                            Spacer()
                            Image(systemName: "flame.fill")
                                .foregroundColor(Color .orange )
                            Text("Day streak")
                        }
                    }
                    VStack{
                        HStack{
                            Image(systemName: "figure.walk")
                                .foregroundColor(Color .gray )
                            VStack(alignment: .leading){
                                Text("Walk")
                                Text("5 / 5")
                            }
                            Spacer()
                            Image(systemName: "flame.fill")
                                .foregroundColor(Color .orange )
                            Text("Day streak")
                        }
                    }
                   
                    VStack{
                        HStack{
                            Image(systemName: "figure.outdoor.cycle")
                                .foregroundColor(Color .green )
                            VStack(alignment: .leading){
                                Text("Cycling")
                                Text("5 / 5")
                            }
                            Spacer()
                            Image(systemName: "flame.fill")
                                .foregroundColor(Color .orange)
                            Text("Day streak")
                        }
                    }
                    VStack{
                        HStack{
                            Image(systemName: "moon.fill")
                                .foregroundColor(Color .yellow)
                            VStack(alignment: .leading){
                                Text("Sleep")
                                Text("5 / 5")
                            }
                            Spacer()
                            Image(systemName: "flame.fill")
                                .foregroundColor(Color .orange )
                            Text("Day streak")
                        }
                    }
                    VStack{
                        HStack{
                            Image(systemName: "drop.fill")
                                .foregroundColor(Color .blue)
                            VStack(alignment: .leading){
                                Text("Water")
                                Text("5 / 5")
                            }
                            Spacer()
                            Image(systemName: "flame.fill")
                                .foregroundColor(Color .orange )
                            Text("Day streak")
                        }
                    }
               
                }
                Spacer()
    //            .frame(height: 500)
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
    ContentView()
}
