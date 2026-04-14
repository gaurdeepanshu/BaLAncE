import SwiftUI

// Model for Food Item
struct FoodItem: Identifiable {
    let id = UUID()
    var name: String
    var calories: Int
    var date: Date
}

struct ContentView18: View {
    
    @State private var foodName: String = ""
    @State private var caloriesText: String = ""
    @State private var foodItems: [FoodItem] = []
    @State private var lookupResult: String? = nil
    @State private var weekOffset: Int = 0 // 0 = current week, -1 = previous, +1 = next
    
    enum WeekDisplay: String, CaseIterable, Identifiable { case current = "Current Week", previous = "Previous Week"; var id: String { rawValue } }
    @State private var weekDisplay: WeekDisplay = .current
    
    // Simple food database (per serving) — extend as needed
    private let foodCalorieDB: [String: Int] = [
        "apple": 95,
        "banana": 105,
        "orange": 62,
        "bread": 80,
        "rice": 206,
        "chicken breast": 165,
        "pizza slice": 285,
        "burger": 354,
        "salad": 150,
        "yogurt": 100,
        "egg": 78,
        "oatmeal": 158,
        "pasta": 221,
        "chocolate bar": 230,
        "chole bhature": 500,
    ]
    
    // Suggested exercises (calorie burn rates per 30 minutes, approximate)
    private let exerciseBurnRates: [(name: String, calories: Int)] = [
        ("Walking (brisk)", 150),
        ("Running (moderate)", 300),
        ("Cycling (moderate)", 250),
        ("Jump rope", 350),
        ("Swimming", 275),
        ("Bodyweight circuit", 220)
    ]
    
    @State private var exerciseSuggestions: [String] = []
    
    // Calculate total calories
    var totalCalories: Int {
        foodItems.reduce(0) { $0 + $1.calories }
    }
    
    // Live lookup for current food name
    var currentKnownCalories: Int? {
        let key = foodName.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        return foodCalorieDB[key]
    }
    
    // MARK: - Week calculations
    var selectedWeekRange: (start: Date, end: Date) {
        let calendar = Calendar.current
        // Start of current week (using user's locale/week settings)
        let today = Date()
        let currentWeek = calendar.dateInterval(of: .weekOfYear, for: today)!
        let startOfCurrentWeek = currentWeek.start
        // Offset by weekOffset
        let start = calendar.date(byAdding: .weekOfYear, value: weekOffset, to: startOfCurrentWeek)!
        let end = calendar.date(byAdding: .day, value: 7, to: start)!
        return (start, end)
    }

    var previousWeekRange: (start: Date, end: Date) {
        let calendar = Calendar.current
        let start = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: selectedWeekRange.start)!
        let end = calendar.date(byAdding: .day, value: 7, to: start)!
        return (start, end)
    }

    var selectedWeekTotal: Int {
        let range = selectedWeekRange
        return foodItems
            .filter { $0.date >= range.start && $0.date < range.end }
            .reduce(0) { $0 + $1.calories }
    }

    var previousWeekTotal: Int {
        let range = previousWeekRange
        return foodItems
            .filter { $0.date >= range.start && $0.date < range.end }
            .reduce(0) { $0 + $1.calories }
    }

    var weekDelta: Int { selectedWeekTotal - previousWeekTotal }

    var selectedWeekLabel: String {
        let f = DateFormatter()
        f.dateStyle = .medium
        return "\(f.string(from: selectedWeekRange.start)) – \(f.string(from: Calendar.current.date(byAdding: .day, value: -1, to: selectedWeekRange.end)!))"
    }
    
    // Items filtered by current/previous week selection
    var currentWeekItems: [FoodItem] {
        let range = selectedWeekRange
        return foodItems.filter { $0.date >= range.start && $0.date < range.end }
    }

    var previousWeekItems: [FoodItem] {
        let range = previousWeekRange
        return foodItems.filter { $0.date >= range.start && $0.date < range.end }
    }

    var displayedItems: [FoodItem] {
        switch weekDisplay {
        case .current: return currentWeekItems
        case .previous: return previousWeekItems
        }
    }

    var displayedTotal: Int {
        switch weekDisplay {
        case .current: return selectedWeekTotal
        case .previous: return previousWeekTotal
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                // Input Fields
                VStack(spacing: 10) {
                    TextField("Enter food name", text: $foodName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: foodName) { oldValue, newValue in
                            let key = newValue.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
                            if let known = foodCalorieDB[key] {
                                caloriesText = String(known)
                                lookupResult = "Calories for \(newValue): \(known) kcal"
                                exerciseSuggestions = buildExerciseSuggestions(for: known)
                            } else {
                                lookupResult = nil
                                exerciseSuggestions = []
                            }
                        }
                    
                    if let known = currentKnownCalories, !foodName.isEmpty {
                        Text("Known calories: \(known) kcal")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                    
                    TextField("Enter calories", text: $caloriesText)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: addFood) {
                        Text("Add Food")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
                
                // Week display selector
                Picker("Week", selection: $weekDisplay) {
                    ForEach(WeekDisplay.allCases) { w in
                        Text(w.rawValue).tag(w)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                // List of Food Items for selected week
                List {
                    Section(header: Text(weekDisplay == .current ? "Current Week" : "Previous Week")) {
                        ForEach(displayedItems) { item in
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(item.name)
                                    Text(item.date, style: .date)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                Text("\(item.calories) kcal")
                            }
                        }
                        .onDelete(perform: deleteFood)
                    }
                }
                
                if !exerciseSuggestions.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Suggested exercises to burn extra calories")
                            .font(.headline)
                        ForEach(exerciseSuggestions, id: \.self) { suggestion in
                            Text("• \(suggestion)")
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Selected week total
                Text("\(weekDisplay == .current ? "Current" : "Previous") Week Total: \(displayedTotal) kcal")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding()
                
                // Weekly totals and navigation
                VStack(spacing: 8) {
                    HStack {
                        Button(action: { weekOffset -= 1 }) {
                            Image(systemName: "chevron.left")
                        }
                        Spacer()
                        Text(selectedWeekLabel)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Spacer()
                        Button(action: { weekOffset += 1 }) {
                            Image(systemName: "chevron.right")
                        }
                    }
                    .padding(.horizontal)

                    HStack {
                        VStack(alignment: .leading) {
                            Text("This week total: \(selectedWeekTotal) kcal")
                                .font(.headline)
                            Text("Previous week: \(previousWeekTotal) kcal")
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        // Delta indicator
                        let delta = weekDelta
                        Text(delta == 0 ? "No change" : (delta > 0 ? "+\(delta) kcal" : "\(delta) kcal"))
                            .padding(8)
                            .background(delta == 0 ? Color.gray.opacity(0.2) : (delta > 0 ? Color.red.opacity(0.2) : Color.green.opacity(0.2)))
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom)
                
            }
            .navigationTitle("Calorie Tracker")
        }
    }
    
    // Add Food Function
    func addFood() {
        guard !foodName.isEmpty else { return }
        // Prefer DB calories when available; otherwise parse manual entry
        let key = foodName.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let calories: Int
        if let known = foodCalorieDB[key] {
            calories = known
            caloriesText = String(known)
        } else if let typed = Int(caloriesText) {
            calories = typed
        } else {
            return
        }
        
        let newFood = FoodItem(name: foodName, calories: calories, date: Date())
        foodItems.append(newFood)
        
        // Update exercise suggestions based on this item's calories
        exerciseSuggestions = buildExerciseSuggestions(for: calories)
        
        // Clear input
        foodName = ""
        caloriesText = ""
    }
    
    // Delete Food Function
    func deleteFood(at offsets: IndexSet) {
        foodItems.remove(atOffsets: offsets)
    }
    
    // Build exercise suggestions to burn given calories (rounded to 30-min chunks)
    func buildExerciseSuggestions(for calories: Int) -> [String] {
        guard calories > 0 else { return [] }
        return exerciseBurnRates.map { entry in
            let sessions = Int(ceil(Double(calories) / Double(entry.calories)))
            let duration = sessions * 30
            if sessions <= 1 {
                return "\(entry.name): about 30 min"
            } else {
                return "\(entry.name): about \(duration) min"
            }
        }
    }
}

#Preview {
    ContentView18()
}
