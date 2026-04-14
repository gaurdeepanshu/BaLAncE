

import SwiftUI

struct ContentView4: View {
    
    @State private var selectedDate = Date()
    @State private var currentMonth = Date()
    
    var body: some View{
        NavigationStack{
            VStack(spacing: 10){
                
                // Header
                HStack{
                    Spacer()
                    Text("Status")
                    Image (systemName: "heart.fill")
                        .foregroundStyle(Color.red)
                        .bold()
                    Spacer()
                }.padding()
                
                // 🔥 Month Selector (NEW)
                HStack {
                    
                    Button {
                        changeMonth(by: -1)
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    
                    Spacer()
                    
                    Text(monthYearString(from: currentMonth))
                        .font(.headline)
                        .bold()
                    
                    Spacer()
                    
                    Button {
                        changeMonth(by: 1)
                    } label: {
                        Image(systemName: "chevron.right")
                    }
                }
                .padding(.horizontal)
                
                // 🔥 Scrollable Dynamic Calendar (UPDATED)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15){
                        
                        ForEach(generateDates(), id: \.self){ date in
                            
                            VStack(spacing: 5){
                                
                                Text(getDay(from: date))
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                Text(getDate(from: date))
                                    .font(.headline)
                                    .frame(width: 35, height: 35)
                                    .background(
                                        isSameDay(date1: date, date2: selectedDate) ? Color.blue : Color.clear
                                    )
                                    .foregroundColor(
                                        isSameDay(date1: date, date2: selectedDate) ? .white : .black
                                    )
                                    .clipShape(Circle())
                            }
                            .onTapGesture {
                                selectedDate = date
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                // SAME as before 👇
                Text("weekly progress")
                    .padding(.leading, -170)
                
                ZStack{
                    HStack{
                        ProgressView(value: 6.0, total: 10.0)
                            .tint(Color.green)
                            .scaleEffect(x: 1, y: 5, anchor: .center)
                        
                        Text("50%")
                    }.padding()
                    
                    Rectangle()
                        .foregroundColor(.blue)
                        .frame(height: 90)
                        .cornerRadius(20)
                        .opacity(0.2)
                }
            }.padding(20)
            
            // 🔥 YOUR ORIGINAL LIST (UNCHANGED)
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
                                ProgressView(value: 7.0, total: 10.0)
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
                                ProgressView(value: 3.0, total: 10.0)
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
                                ProgressView(value: 9.0, total: 10.0)
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
                                ProgressView(value: 8.0, total: 10.0)
                                    .tint(Color.purple)
                            }
                            
                            Text("14 Hours")
                        }
                    }
                }
                NavigationLink{
                    ContentView18()
                }label: {
                    VStack{
                        HStack{
                            Image(systemName: "flame.fill")
                                .resizable()
                                .frame(width: 20 , height: 20)
                                .foregroundColor(Color .red )
                                .padding()
                            
                            VStack(alignment: .leading){
                                Text("Burn / Gain calorie")
                                ProgressView(value: 8.0, total: 10.0)
                                    .tint(Color.red)
                            }
                            
                            Text("233")
                            Image(systemName: "flame")
                            
                        }
                    }
                }
                
                NavigationLink{
                    ContentView19()
                }label: {
                    VStack{
                        HStack{
                            Image(systemName: "waterbottle.fill")
                                .resizable()
                                .frame(width: 20 , height: 20)
                                .foregroundColor(Color .pink)
                                .padding()
                            
                            VStack(alignment: .leading){
                                Text(" intake protein")
                                ProgressView(value: 8.0, total: 10.0)
                                    .tint(Color.pink)
                            }
                            
                            Text("233")
                            Image(systemName: "waterbottle")
                            
                        }
                    }
                }
            }
            
            // 🔥 Bottom Bar SAME
            HStack{
                Spacer()
                
                NavigationLink{
                    HomeView()
                }label: {
                    VStack {
                        Image(systemName: "house.fill")
                            .resizable()
                            .frame(width: 30 , height: 30)
                        Text("Home")
                    }
                }
                
                Spacer()
                
                VStack {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .frame(width: 30 , height: 30)
                        .foregroundColor(.red)
                    Text("status")
                }
                
                Spacer()
                
                NavigationLink{
                    Settingview()
                }label: {
                    VStack {
                        Image(systemName: "gearshape.fill")
                            .resizable()
                            .frame(width: 30 , height: 30)
                        Text("Settings")
                    }
                }
                
                Spacer()
            }
        }.toolbar(.hidden)
    }
    
    // MARK: - Calendar Logic
    
    func generateDates() -> [Date] {
        let calendar = Calendar.current
        
        guard let range = calendar.range(of: .day, in: .month, for: currentMonth),
              let firstDay = calendar.date(from: calendar.dateComponents([.year, .month], from: currentMonth))
        else { return [] }
        
        return range.compactMap { day -> Date? in
            calendar.date(byAdding: .day, value: day - 1, to: firstDay)
        }
    }
    
    func changeMonth(by value: Int) {
        if let newMonth = Calendar.current.date(byAdding: .month, value: value, to: currentMonth) {
            currentMonth = newMonth
        }
    }
    
    func monthYearString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
    
    func getDay(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter.string(from: date)
    }
    
    func getDate(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }
    
    func isSameDay(date1: Date, date2: Date) -> Bool {
        Calendar.current.isDate(date1, inSameDayAs: date2)
    }
}

#Preview {
    ContentView4()
}
