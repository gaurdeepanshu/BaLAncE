import SwiftUI

struct ContentView2: View {
    @AppStorage("firstUseDate") private var firstUseDate: Double = 0
    @AppStorage("hasShown60DayCongrats") private var hasShown60DayCongrats: Bool = false
    @State private var showCongratsAlert: Bool = false
    @StateObject private var auth = AuthViewModel()
    var body: some View {
      NavigationStack{
          Group{
              if auth.isAuthenticated{
                  NavigationStack{
                      HomeView()
                  }
              } else{
                  AuthView(auth: auth)
              }
          }
      }
      .onAppear {
          // Initialize first use date if not set
          if firstUseDate == 0 {
              firstUseDate = Date().timeIntervalSince1970
          }
          // Calculate days since first use
          let daysSinceFirstUse = Int((Date().timeIntervalSince1970 - firstUseDate) / (60 * 60 * 24))
          // If 60 days or more and we haven't shown the alert yet, trigger it
          if daysSinceFirstUse >= 60 && !hasShown60DayCongrats {
              showCongratsAlert = true
          }
      }
      .alert("Congratulations!", isPresented: $showCongratsAlert) {
          Button("Awesome!") {
              // Mark as shown so we don't show it again
              hasShown60DayCongrats = true
          }
      } message: {
          Text("You've been with us for 60 days. You will get a surprise gift from us! 🎉")
      }
      .toolbar(.hidden)

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
                    NavigationLink{
                        ContentView()
                    } label: {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }.foregroundColor(.black)
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
            
                NavigationLink(destination: ContentView14()){
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
                        .foregroundColor(Color .green)
                    Text("Home")
                        .font(.system(size: 15))
                        .bold()
                        .foregroundColor(Color .green)
                }
                Spacer()
             
               NavigationLink{
                   ContentView4()
               }label: {
                   VStack {
                        Image(systemName: "heart.fill")
                            .resizable()
                            .frame(width: 30 , height: 30)
                            .foregroundColor(Color .red )
                        Text("status")
                            .font(.system(size: 15))
                            .bold()
                            .foregroundColor(Color .red )
                    }
               }
               
                Spacer()
               NavigationLink{
                     Settingview()
                 }label: {
                     VStack {
                         Image(systemName: "gearshape.fill")
                             .resizable()
                             .frame(width: 30 , height: 30)
                             .foregroundColor(Color .brown )
                         Text("Settings")
                             .font(.system(size: 15))
                             .foregroundColor(Color .brown)
                     }
                 }
                 Spacer()
           }
       }.toolbar(.hidden)
    }
}
#Preview {
    ContentView2()
        .environmentObject(UserProfile())
}
