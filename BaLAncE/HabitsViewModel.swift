import Foundation
import SwiftUI
import Combine

struct Habit: Identifiable, Hashable {
    let id: UUID
    var name: String
    var icon: String
    // Dates when the habit was completed (normalized to start of day)
    var completionDates: Set<Date> = []

    init(id: UUID = UUID(), name: String, icon: String = "star.fill", completionDates: Set<Date> = []) {
        self.id = id
        self.name = name
        self.icon = icon
        self.completionDates = completionDates
    }
}

final class HabitsViewModel: ObservableObject {
    @Published var habits: [Habit]

    init(habits: [Habit] = [
        Habit(name: "Exclusive workout", icon: "dumbbell.fill"),
        Habit(name: "Walk", icon: "figure.walk"),
        Habit(name: "Cycling", icon: "figure.outdoor.cycle"),
        Habit(name: "Sleep", icon: "moon.fill"),
        Habit(name: "Water", icon: "drop.fill")
    ]) {
        self.habits = habits
    }

    private let calendar = Calendar.current

    private func startOfDay(_ date: Date) -> Date {
        calendar.startOfDay(for: date)
    }

    func isCompletedToday(_ habit: Habit, today: Date = Date()) -> Bool {
        let day = startOfDay(today)
        return habit.completionDates.contains(day)
    }

    func toggleCompleteToday(for habitID: UUID, today: Date = Date()) {
        let day = startOfDay(today)
        guard let idx = habits.firstIndex(where: { $0.id == habitID }) else { return }
        if habits[idx].completionDates.contains(day) {
            habits[idx].completionDates.remove(day)
        } else {
            habits[idx].completionDates.insert(day)
        }
    }

    // Current streak: number of consecutive days up to today that are completed
    func currentStreak(for habit: Habit, today: Date = Date()) -> Int {
        var count = 0
        var date = startOfDay(today)
        while habit.completionDates.contains(date) {
            count += 1
            if let prev = calendar.date(byAdding: .day, value: -1, to: date) {
                date = startOfDay(prev)
            } else { break }
        }
        return count
    }

    // Longest streak: compute from completion dates; reset to 0 if habit missed today and yesterday (as per request: if user can't perform any task, longest becomes 0)
    func longestStreak(for habit: Habit, today: Date = Date()) -> Int {
        // If not completed today and not completed yesterday, treat as reset to 0
        let todayDay = startOfDay(today)
        let yesterday = startOfDay(calendar.date(byAdding: .day, value: -1, to: todayDay) ?? todayDay)
        if !habit.completionDates.contains(todayDay) && !habit.completionDates.contains(yesterday) {
            return 0
        }
        // Otherwise, compute the maximum run of consecutive days
        let days = habit.completionDates.map { startOfDay($0) }.sorted()
        guard !days.isEmpty else { return 0 }
        var maxRun = 1
        var run = 1
        for i in 1..<days.count {
            if let prev = calendar.date(byAdding: .day, value: -1, to: days[i]) , startOfDay(prev) == days[i-1] {
                run += 1
            } else {
                maxRun = max(maxRun, run)
                run = 1
            }
        }
        maxRun = max(maxRun, run)
        return maxRun
    }

    // Overall stats
    var completedTodayCount: Int {
        habits.filter { isCompletedToday($0) }.count
    }

    var progressToday: Double { // 0.0 ... 1.0
        guard !habits.isEmpty else { return 0 }
        return Double(completedTodayCount) / Double(habits.count)
    }

    var longestStreakAcrossHabits: Int {
        habits.map { longestStreak(for: $0) }.max() ?? 0
    }
}






//import SwiftUI
//import UIKit
//
//struct HabitItem: Identifiable {
//    let id = UUID()
//    var title: String
//    var icon: String
//    var color: Color
//    var goalPerDay: Int
//    var completedToday: Int
//    var streak: Int
//    var streakAddedToday: Bool = false
//
//    var isCompleted: Bool {
//        completedToday >= goalPerDay
//    }
//}
//
//struct ContentView: View {
//    @Environment(\.dismiss) private var dismiss
//    @EnvironmentObject var profile: UserProfile
//
//    @State private var habits: [HabitItem] = [
//        HabitItem(title: "Exclusive workout", icon: "dumbbell.fill", color: .orange, goalPerDay: 5, completedToday: 0, streak: 0),
//        HabitItem(title: "Walk", icon: "figure.walk", color: .gray, goalPerDay: 5, completedToday: 0, streak: 0),
//        HabitItem(title: "Cycling", icon: "figure.outdoor.cycle", color: .green, goalPerDay: 5, completedToday: 0, streak: 0),
//        HabitItem(title: "Sleep", icon: "moon.fill", color: .yellow, goalPerDay: 5, completedToday: 0, streak: 0),
//        HabitItem(title: "Water", icon: "drop.fill", color: .blue, goalPerDay: 5, completedToday: 0, streak: 0),
//        HabitItem(title: "Protein", icon: "fork.knife", color: .purple, goalPerDay: 5, completedToday: 0, streak: 0),
//        HabitItem(title: "Calories", icon: "flame", color: .red, goalPerDay: 5, completedToday: 0, streak: 0)
//    ]
//
//    var goalCompletedCount: Int {
//        habits.filter { $0.isCompleted }.count
//    }
//
//    var longestStreakValue: Int {
//        habits.map(\.streak).max() ?? 0
//    }
//
//    var habitStatsPercent: Int {
//        let totalGoal = habits.reduce(0) { $0 + $1.goalPerDay }
//        let totalCompleted = habits.reduce(0) { $0 + min($1.completedToday, $1.goalPerDay) }
//
//        guard totalGoal > 0 else { return 0 }
//        return Int((Double(totalCompleted) / Double(totalGoal)) * 100)
//    }
//
//    var body: some View {
//        NavigationStack {
//            VStack {
//                HStack {
//                    Button(action: {
//                        dismiss()
//                    }) {
//                        Image(systemName: "chevron.left")
//                            .font(.system(size: 25))
//                    }
//                    .foregroundStyle(.primary)
//
//                    Spacer()
//
//                    Text("BALANCE")
//                        .font(.system(size: 25))
//                        .bold()
//
//                    Spacer()
//                }
//                .padding()
//
//                VStack(alignment: .leading) {
//                    HStack(alignment: .top) {
//                        if let data = profile.imageData,
//                           let img = UIImage(data: data) {
//                            Image(uiImage: img)
//                                .resizable()
//                                .scaledToFill()
//                                .frame(width: 80, height: 80)
//                                .clipShape(Circle())
//                        } else {
//                            Circle()
//                                .foregroundColor(.blue)
//                                .frame(width: 80, height: 80)
//                                .opacity(0.2)
//                                .overlay(
//                                    Image(systemName: "person.fill")
//                                        .foregroundStyle(.secondary)
//                                )
//                        }
//
//                        VStack(alignment: .leading) {
//                            Text(profile.name.isEmpty ? "user name" : profile.name)
//                                .bold()
//
//                            Text(profile.email.isEmpty ? "User@email.com" : profile.email)
//                        }
//
//                        Spacer()
//                    }
//                    .padding(.horizontal, 10)
//
//                    List {
//                        ZStack {
//                            Rectangle()
//                                .frame(height: 120)
//                                .foregroundColor(Color.gray.opacity(0.3))
//                                .cornerRadius(10)
//
//                            VStack {
//                                HStack {
//                                    Text("Habit Stats")
//                                        .padding()
//
//                                    Spacer()
//
//                                    ZStack {
//                                        Circle()
//                                            .foregroundStyle(Color.white)
//                                            .frame(width: 90, height: 90)
//
//                                        Circle()
//                                            .trim(from: 0, to: CGFloat(habitStatsPercent) / 100)
//                                            .stroke(Color.yellow, lineWidth: 10)
//                                            .frame(width: 90, height: 90)
//                                            .rotationEffect(.degrees(-90))
//
//                                        Text("\(habitStatsPercent)%")
//                                            .bold()
//                                    }
//                                    .padding()
//                                }
//                            }
//                        }
//                        .padding(.vertical, 4)
//                        .listRowSeparator(.hidden)
//
//                        ZStack {
//                            Rectangle()
//                                .frame(height: 120)
//                                .foregroundColor(Color.gray.opacity(0.3))
//                                .cornerRadius(10)
//
//                            HStack(spacing: 10) {
//                                VStack(spacing: 10) {
//                                    Text("Goal completed")
//                                    Text("\(goalCompletedCount)")
//                                        .bold()
//                                }
//
//                                Rectangle()
//                                    .frame(width: 1, height: 70)
//                                    .foregroundColor(Color.gray)
//
//                                VStack(spacing: 10) {
//                                    Text("Longest streak")
//                                    Text("\(longestStreakValue)")
//                                        .bold()
//                                }
//                            }
//                        }
//                        .padding(.vertical, 4)
//                        .listRowSeparator(.hidden)
//
//                        VStack {
//                            HStack {
//                                Text("Top Habits")
//                                Spacer()
//                                Image(systemName: "heart.fill")
//                                    .foregroundColor(.red)
//                                    .padding()
//                            }
//                        }
//                        .listRowSeparator(.hidden)
//
//                        ForEach(habits.indices, id: \.self) { index in
//                            VStack(spacing: 12) {
//                                HStack {
//                                    Image(systemName: habits[index].icon)
//                                        .foregroundColor(habits[index].color)
//
//                                    VStack(alignment: .leading, spacing: 4) {
//                                        Text(habits[index].title)
//
//                                        Text("\(habits[index].completedToday) / \(habits[index].goalPerDay)")
//                                            .foregroundColor(.secondary)
//                                            .font(.subheadline)
//                                    }
//
//                                    Spacer()
//
//                                    Image(systemName: "flame.fill")
//                                        .foregroundColor(.orange)
//
//                                    Text("\(habits[index].streak) Day streak")
//                                        .font(.subheadline)
//                                }
//
//                                VStack(alignment: .leading, spacing: 10) {
//                                    Text("Tap stars to mark progress")
//                                        .font(.caption)
//                                        .foregroundColor(.secondary)
//
//                                    HStack(spacing: 8) {
//                                        ForEach(1...max(habits[index].goalPerDay, 1), id: \.self) { value in
//                                            Button {
//                                                updateStars(at: index, value: value)
//                                            } label: {
//                                                Image(systemName: value <= habits[index].completedToday ? "star.fill" : "star")
//                                                    .font(.system(size: 22))
//                                                    .foregroundColor(value <= habits[index].completedToday ? .yellow : .gray)
//                                            }
//                                            .buttonStyle(.plain)
//                                        }
//                                    }
//
//                                    Stepper(
//                                        "Set range: \(habits[index].goalPerDay)",
//                                        value: Binding(
//                                            get: { habits[index].goalPerDay },
//                                            set: { newValue in
//                                                updateGoal(at: index, newGoal: newValue)
//                                            }
//                                        ),
//                                        in: 1...10
//                                    )
//                                }
//
//                                if habits[index].isCompleted {
//                                    Text("Task completed")
//                                        .font(.caption)
//                                        .foregroundColor(.green)
//                                        .frame(maxWidth: .infinity, alignment: .leading)
//                                }
//                            }
//                            .padding(.vertical, 6)
//                            .listRowSeparator(.hidden)
//                        }
//                    }
//                    .listStyle(.plain)
//
//                    Spacer()
//
//                    NavigationLink {
//                        ContentView16()
//                    } label: {
//                        ZStack {
//                            Rectangle()
//                                .frame(height: 40)
//                                .opacity(0.3)
//                                .cornerRadius(8)
//
//                            HStack {
//                                Spacer()
//                                Text("manage habbits")
//                                Spacer()
//                                Image(systemName: "chevron.right")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 20, height: 20)
//                            }
//                        }
//                    }
//
//                    NavigationLink {
//                        ContentView17()
//                    } label: {
//                        ZStack {
//                            Rectangle()
//                                .frame(height: 40)
//                                .opacity(0.3)
//                                .cornerRadius(8)
//
//                            HStack {
//                                Spacer()
//                                Text("reminders")
//                                Spacer()
//                                Image(systemName: "chevron.right")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 20, height: 20)
//                            }
//                        }
//                    }
//                }
//            }
//            .toolbar(.hidden)
//        }
//    }
//
//    private func updateStars(at index: Int, value: Int) {
//        guard habits.indices.contains(index) else { return }
//
//        let oldWasCompleted = habits[index].isCompleted
//        habits[index].completedToday = value
//        let newIsCompleted = habits[index].isCompleted
//
//        handleCompletionChange(at: index, oldWasCompleted: oldWasCompleted, newIsCompleted: newIsCompleted)
//    }
//    private func updateGoal(at index: Int, newGoal: Int) {
//        guard habits.indices.contains(index) else { return }
//        let oldWasCompleted = habits[index].isCompleted
//        habits[index].goalPerDay = max(1, newGoal)
//        if habits[index].completedToday > habits[index].goalPerDay {
//            habits[index].completedToday = habits[index].goalPerDay
//        }
//        let newIsCompleted = habits[index].isCompleted
//        handleCompletionChange(at: index, oldWasCompleted: oldWasCompleted, newIsCompleted: newIsCompleted)
//    }
//    private func handleCompletionChange(at index: Int, oldWasCompleted: Bool, newIsCompleted: Bool) {
//        if newIsCompleted && !oldWasCompleted && habits[index].streakAddedToday == false {
//            habits[index].streak += 1
//            habits[index].streakAddedToday = true
//        }
//        if !newIsCompleted {
//            habits[index].streakAddedToday = false
//        }
//    }
//}
//#Preview {
//    ContentView()
//        .environmentObject(UserProfile())
//}
