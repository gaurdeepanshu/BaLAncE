import SwiftUI
let weekDays = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"]
let days = weekDays.count
struct ContentView3: View {
    var body: some View{
        NavigationStack{
            VStack{
                HStack{
                    NavigationLink{
                        ContentView4()
                    } label: {
                        Image(systemName: "chevron.left")
                    }.foregroundColor(.black)
                    Spacer()
                    Text("Exclusive workout")
                    Image(systemName: "dumbbell.fill")
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
                                .overlay(RoundedRectangle(cornerRadius: 100).stroke(Color.orange, lineWidth: 10))
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
                        VStack{
                            HStack{
                                ForEach(weekDays, id: \.self) { index in
                                    VStack{
                                        Text("\(index)")
                                            .offset(y: -60)
                                        ProgressView(value: 5.0, total: 10.0)
                                            .rotationEffect(.degrees(-90))
                                            .scaleEffect(x: 8, y: 1, anchor: .center)
                                    }
                                    .frame(height: 200)
                                    .clipped()
                                }
                            }
                         }
                    }
                    ZStack{
                        Rectangle()
                            .frame(height: 60)
                            .foregroundStyle(Color.blue)
                            .opacity(0.3)
                        VStack{
                            Text("Make as Complete")
                        }
                    }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
        }
        }.toolbar(.hidden)
    }
}
#Preview {
    ContentView3()
}
