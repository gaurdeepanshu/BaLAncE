

import SwiftUI
import UserNotifications

struct ContentView17: View {
    
    // Save habits permanently
    @AppStorage("savedHabits") private var savedHabitsData: String = ""
    
    @State private var habits: [String] = ["Exercise", "Read", "Meditate", "Eat Healthy", "Sleep"]
    @State private var selectedHabit = "Exercise"
    @State private var newHabit = ""
    @State private var editedHabit = ""
    @State private var isEditing = false
    @State private var time = Date()
    @State private var message = ""
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Top Header
            HStack {
                Text("Habit Reminder")
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.top)
            
            // Habit Picker
            Picker("Select Habit", selection: $selectedHabit) {
                ForEach(habits, id: \.self) { habit in
                    Text(habit)
                }
            }
            .pickerStyle(.menu)
            
            Text("Habit: \(selectedHabit)")
                .font(.headline)
            
            // Add new habit
            HStack {
                TextField("select / New Habit", text: $newHabit)
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
            
            // Edit selected habit
            VStack(spacing: 10) {
                HStack {
                    TextField("Edit Selected Habit", text: $editedHabit)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(isEditing ? "Update" : "Edit") {
                        if isEditing {
                            updateHabit()
                        } else {
                            startEditing()
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                
                Button("Delete Selected Habit") {
                    deleteHabit()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            
            // Time Picker
            DatePicker("Select Time", selection: $time, displayedComponents: .hourAndMinute)
                .padding(.top)
            
            // Reminder button
            Button("Set Reminder") {
                requestPermissionAndSchedule()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            if !message.isEmpty {
                Text(message)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.top, 5)
            }
            
            Spacer()
        }
        .padding()
        .onAppear {
            loadHabits()
        }
    }
    
    // MARK: - Functions
    
    func addHabit() {
        let trimmed = newHabit.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmed.isEmpty else {
            message = "Habit name cannot be empty."
            return
        }
        
        guard !habits.contains(where: { $0.lowercased() == trimmed.lowercased() }) else {
            message = "This habit already exists."
            return
        }
        
        habits.append(trimmed)
        selectedHabit = trimmed
        newHabit = ""
        saveHabits()
        message = "Habit added successfully."
    }
    
    func startEditing() {
        editedHabit = selectedHabit
        isEditing = true
        message = "Now edit the selected habit."
    }
    
    func updateHabit() {
        let trimmed = editedHabit.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmed.isEmpty else {
            message = "Updated habit name cannot be empty."
            return
        }
        
        guard !habits.contains(where: { $0.lowercased() == trimmed.lowercased() && $0 != selectedHabit }) else {
            message = "Another habit with this name already exists."
            return
        }
        
        if let index = habits.firstIndex(of: selectedHabit) {
            let oldHabit = selectedHabit
            habits[index] = trimmed
            selectedHabit = trimmed
            isEditing = false
            editedHabit = ""
            saveHabits()
            
            // remove old reminder when name changes
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [oldHabit])
            
            message = "Habit updated successfully."
        }
    }
    
    func deleteHabit() {
        guard habits.count > 1 else {
            message = "At least one habit must remain."
            return
        }
        
        if let index = habits.firstIndex(of: selectedHabit) {
            let deletedHabit = selectedHabit
            habits.remove(at: index)
            selectedHabit = habits.first ?? ""
            saveHabits()
            
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [deletedHabit])
            
            message = "Habit deleted successfully."
        }
    }
    
    func saveHabits() {
        savedHabitsData = habits.joined(separator: "||")
    }
    
    func loadHabits() {
        if !savedHabitsData.isEmpty {
            let loaded = savedHabitsData.components(separatedBy: "||").filter { !$0.isEmpty }
            if !loaded.isEmpty {
                habits = loaded
                if !habits.contains(selectedHabit) {
                    selectedHabit = habits[0]
                }
            }
        }
    }
    
    func requestPermissionAndSchedule() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            DispatchQueue.main.async {
                if granted {
                    scheduleNotification()
                } else {
                    message = "Notification permission denied."
                    if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Habit Reminder"
        content.body = "Time for \(selectedHabit)"
        content.sound = .default
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: time)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        
        // One reminder per habit
        let request = UNNotificationRequest(
            identifier: selectedHabit,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [selectedHabit])
        
        UNUserNotificationCenter.current().add(request) { error in
            DispatchQueue.main.async {
                if let error = error {
                    message = "Failed to set reminder: \(error.localizedDescription)"
                } else {
                    let formatter = DateFormatter()
                    formatter.timeStyle = .short
                    message = "Reminder set for \(selectedHabit) at \(formatter.string(from: time))"
                }
            }
        }
    }
}

#Preview {
    ContentView17()
}
