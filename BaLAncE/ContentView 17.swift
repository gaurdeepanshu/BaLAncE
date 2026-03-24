





import SwiftUI
import UserNotifications

struct ContentView17: View {
    
    // Dynamic habit list
    @State private var habits = ["Exercise", "Read", "Meditate", "Eat Healthy", "Sleep"]
    
    @State private var selectedHabit = "Exercise"
    @State private var newHabit = "" // for adding new habit
    @State private var time = Date()
    
    var body: some View {
        VStack(spacing: 20) {
            HStack{
                //  Top Header
                Text("Habit Reminder")
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            }
                .padding()
            
            // Picker to select/change habit
            Picker("Select Habit", selection: $selectedHabit) {
                ForEach(habits, id: \.self) { habit in
                    Text(habit)
                }
            }
            .pickerStyle(.menu)
            
            Text("Habit: \(selectedHabit)")
                .font(.headline)
            
            // Add New Habit
            HStack {
                TextField("New Habit", text: $newHabit)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Add") {
                    addHabit()
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            
            // Time Picker
            DatePicker("Select Time", selection: $time, displayedComponents: .hourAndMinute)
                .padding(.top)
            
            Spacer() // push button to bottom
            
            // Set Reminder Button
            Button("Set Reminder") {
                requestPermission()
                scheduleNotification()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
    
    // MARK: - Functions
    
    func addHabit() {
        let trimmed = newHabit.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { return }
        habits.append(trimmed)
        selectedHabit = trimmed // automatically select the new habit
        newHabit = ""
    }
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { success, _ in
            print(success ? "Permission granted" : "Permission denied")
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Habit Reminder"
        content.body = "Time for \(selectedHabit) "
        content.sound = .default
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: time)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
        
        print("Reminder set for \(selectedHabit) at \(time)")
    }
}

// Preview
#Preview {
    ContentView17()
}
