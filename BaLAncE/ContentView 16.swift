

import SwiftUI

struct Habit: Identifiable {
    let id = UUID()
    var name: String
    var icon: String
}

struct ContentView16: View {
    
    @State private var habits: [Habit] = [
        Habit(name: "Exercise Daily", icon: "dumbbell.fill"),
        Habit(name: "Read Books", icon: "book.fill"),
        Habit(name: "Meditate", icon: "brain.head.profile"),
        Habit(name: "Eat Healthy", icon: "leaf.fill"),
        Habit(name: "Sleep 8 Hours", icon: "moon.fill")
    ]
    
    @State private var newHabit: String = ""
    
    var body: some View {
        NavigationView {
            ScrollView { // Make VStack scrollable
                VStack(spacing: 20) {
                    
                    // Input Field + Add Button
                    HStack {
                        TextField("New Habit", text: $newHabit)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        
                        Button(action: addHabit) {
                            HStack {
                                Image(systemName: "plus")
                                Text("Add Habit")
                            }
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Title
                    HStack {
                        Text("My Good Habits")
                            .font(.headline)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    // Habit List
                    VStack(spacing: 12) {
                        ForEach(habits) { habit in
                            HabitRow(habit: habit, removeAction: {
                                removeHabit(habit)
                            })
                        }
                    }
                    .padding(.horizontal)
                    
                    // Clear All Button
                    Button(action: {
                        habits.removeAll()
                    }) {
                        Text("Clear All Habits")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .padding()
                    
                }
                .padding(.top)
            }
            .navigationTitle("Manage Good Habits")
            .scrollDismissesKeyboard(.interactively) // So keyboard dismisses smoothly
        }
    }
    
    // MARK: - Functions
    
    func addHabit() {
        guard !newHabit.isEmpty else { return }
        habits.append(Habit(name: newHabit, icon: "star.fill"))
        newHabit = ""
    }
    
    func removeHabit(_ habit: Habit) {
        habits.removeAll { $0.id == habit.id }
    }
}

// MARK: - Habit Row UI

struct HabitRow: View {
    var habit: Habit
    var removeAction: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: habit.icon)
                .font(.title2)
                .foregroundColor(.green)
                .frame(width: 40)
            
            Text(habit.name)
                .font(.body)
            
            Spacer()
            
            Button(action: removeAction) {
                HStack {
                    Image(systemName: "minus")
                    Text("Remove")
                }
                .padding(8)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(20)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)
    }
}

// MARK: - Preview

#Preview {
    ContentView16()
}
     
 


