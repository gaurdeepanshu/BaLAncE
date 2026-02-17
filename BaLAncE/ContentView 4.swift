//
//  ContentView.swift
//  BaLAncE
//
//  Created by applelab02 on 2/10/26.
//

import SwiftUI

struct ContentView3: View {
    var body: some View{
        VStack{
            HStack{
                Image(systemName: "chevron.left")
                Spacer()
                Text("Exercise")
                    .font(.system(size: 20))
                Spacer()
                
            }  .padding()
            ScrollView(.vertical, showsIndicators: false){
                
                
                ZStack{
                    Rectangle()
                        .foregroundStyle(Color.blue)
                        .frame(height: 40)
                        .cornerRadius(20)
                        .opacity(0.3)
                    
                    HStack{
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding()
                        Text("3/6 Completed")
                        Spacer()
                        Text("50%")
                            .padding()
                        
                    }
                    
                }
                
                VStack{
                    ZStack {
                        Circle()
                            .foregroundStyle(Color.white)
                            .frame(height: 150)
                            .overlay(RoundedRectangle(cornerRadius: 100).stroke(Color.purple, lineWidth: 10))
                            .padding()
                        Text("15min")
                            .font(.system(size: 30))
                        
                        
                    }
                }
                Text("YOU'RE HALF WAY THERE !")
                VStack{
                    ZStack{
                        Rectangle()
                            .foregroundStyle(Color.blue)
                            .frame(height: 60)
                            .cornerRadius(20)
                            .opacity(0.3)
                        HStack{
                            Spacer()
                            Text("5m 10m 15m")
                            Spacer()
                            Rectangle()
                                .frame(width: 1, height: 19)
                            Spacer()
                            Image(systemName: "plus")
                            
                            Text("Add TIME")
                            
                            Spacer()
                            
                            
                            
                            
                        }.padding()
                    }
                }
                VStack{
                    HStack{
                        Text("Weekly Progress")
                            .font(.system(size: 20))
                            .bold()
                        Spacer()
                        Image(systemName: "ellipsis")
                            .resizable()
                            .frame(width: 20, height: 5)
                    }.padding()
                }
                HStack{
                    Text("Mon")
                    Spacer()
                    
                    Text("Tue")
                    Spacer()
                    
                    Text("Wed")
                    Spacer()
                    
                    Text("Thu")
                    Spacer()
                    
                    Text("Fri")
                    Spacer()
                    
                    Text("Sat")
                    Spacer()
                    
                    Text("Sun")
                    
                }.padding()
                Spacer()
            }
            VStack{
                HStack{
                    Text("sun")
                    Spacer()
                    Text("Mon")
                    Spacer()
                    
                    Text("Tue")
                    Spacer()
                    
                    Text("Wed")
                    Spacer()
                    
                    Text("Thu")
                    Spacer()
                    
                    Text("Fri")
                    Spacer()
                    
                    Text("Sat")
                    Spacer()
                
               
                }.padding()
            }
                VStack{
                    ZStack{
                        Rectangle()
                            .frame(height: 60)
                            .foregroundStyle(Color.blue)
                            .opacity(0.3)
                        HStack{
                            Text("Make as Complete")
                        }
                        }
                            
                        }
          
  }
        
    }
}
#Preview {
    ContentView3()
}
