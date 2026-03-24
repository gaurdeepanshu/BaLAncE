

import SwiftUI
struct ContentView14: View {
    let competitionLifts = [
        "Back Squat",
        "Bench Press",
        "Deadlift"
    ]
    
    let variations = [
        "Front Squat",
        "Sumo Deadlift",
        "Conventional Deadlift",
        "Incline Bench Press",
        "Overhead Press",
        "Pause Squat",
        "Pause Bench Press",
        "Romanian Deadlift",
        "Deficit Deadlift"
    ]
    
    let accessories = [
        "Hip Thrust",
        "Barbell Row",
        "Pull-Up",
        "Dips"
    ]
    
    var body: some View{
NavigationStack {
    
    VStack{
        Text("Exclusive Workout")
            .font(.title2.weight(.semibold))
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
        List {
            Section("Competition Lifts") {
                ForEach(competitionLifts, id: \.self) { exercise in
                    Text(exercise)
                }
            }
            
            Section("Variations") {
                ForEach(variations.sorted(), id: \.self) { exercise in
                    Text(exercise)
                }
            }
            
            Section("Accessories") {
                ForEach(accessories.sorted(), id: \.self) { exercise in
                    Text(exercise)
                }
            }
        }
        
    }
    
        }
        
        
    }
}
#Preview {
    ContentView14()
}

