import SwiftUI

// MARK: - Model
struct ProteinItem: Identifiable {
    let id = UUID()
    var name: String
    var protein: Double
    var date: Date
}

// MARK: - Main View
struct ContentView19: View {
    
    let proteinDatabase: [String: Double] = [
        "chicken breast": 31,
        "egg": 6,
        "egg white": 3.6,
        "milk (1 cup)": 8,
        "greek yogurt (170g)": 17,
        "tofu (100g)": 8,
        "paneer (100g)": 18,
        "lentils (100g cooked)": 9,
        "whey protein scoop": 24,
        "casein protein scoop": 24,
        "soy protein scoop": 23,
        "peanut butter (2 tbsp)": 7,
        "almonds (28g)": 6,
        "salmon (100g)": 20,
        "tuna (100g)": 25
    ]
    
    @State private var items: [ProteinItem] = []
    @State private var foodName: String = ""
    @State private var proteinAmount: String = ""
    @State private var suggestions: [String] = []
    @State private var infoMessage: String? = nil
    @State private var weekOffset: Int = 0 // 0 current, -1 previous, +1 next (if needed later)
    
    // Calculate total protein
    var totalProtein: Double {
        items.reduce(0) { $0 + $1.protein }
    }
    
    // MARK: - Weekly calculations
    var selectedWeekRange: (start: Date, end: Date) {
        let calendar = Calendar.current
        let today = Date()
        let currentWeek = calendar.dateInterval(of: .weekOfYear, for: today)!
        let startOfCurrentWeek = currentWeek.start
        let start = calendar.date(byAdding: .weekOfYear, value: weekOffset, to: startOfCurrentWeek)!
        let end = calendar.date(byAdding: .day, value: 7, to: start)!
        return (start, end)
    }

    var previousWeekRange: (start: Date, end: Date) {
        let calendar = Calendar.current
        let start = calendar.date(byAdding: .weekOfYear, value: -1, to: selectedWeekRange.start)!
        let end = calendar.date(byAdding: .day, value: 7, to: start)!
        return (start, end)
    }

    var selectedWeekTotalProtein: Double {
        let range = selectedWeekRange
        return items.filter { $0.date >= range.start && $0.date < range.end }
            .reduce(0) { $0 + $1.protein }
    }

    var previousWeekTotalProtein: Double {
        let range = previousWeekRange
        return items.filter { $0.date >= range.start && $0.date < range.end }
            .reduce(0) { $0 + $1.protein }
    }

    var weekDeltaProtein: Double { selectedWeekTotalProtein - previousWeekTotalProtein }

    var selectedWeekLabel: String {
        let f = DateFormatter()
        f.dateStyle = .medium
        let endDisplay = Calendar.current.date(byAdding: .day, value: -1, to: selectedWeekRange.end)!
        return "\(f.string(from: selectedWeekRange.start)) – \(f.string(from: endDisplay))"
    }
    
    var body: some View {
        NavigationView {
            VStack {
                
                // Input Section
                VStack(spacing: 12) {
                    TextField("Food / Supplement Name", text: $foodName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: foodName) { oldValue, newValue in
                            let trimmed = newValue.trimmingCharacters(in: .whitespacesAndNewlines)
                            let lower = trimmed.lowercased()
                            // Update suggestions based on prefix match
                            if lower.isEmpty {
                                suggestions = []
                                infoMessage = nil
                            } else {
                                suggestions = proteinDatabase.keys
                                    .filter { $0.hasPrefix(lower) || $0.contains(lower) }
                                    .sorted()
                                if let grams = proteinDatabase[lower] {
                                    proteinAmount = String(format: "%.1f", grams)
                                    infoMessage = nil
                                } else {
                                    infoMessage = suggestions.isEmpty ? "No match found. You can enter grams manually." : nil
                                }
                            }
                        }
                    
                    if !suggestions.isEmpty {
                        VStack(alignment: .leading, spacing: 6) {
                            ForEach(Array(suggestions.prefix(5)), id: \.self) { suggestion in
                                Button(action: {
                                    foodName = suggestion
                                    if let grams = proteinDatabase[suggestion.lowercased()] {
                                        proteinAmount = String(format: "%.1f", grams)
                                    }
                                    suggestions = []
                                    infoMessage = nil
                                }) {
                                    HStack {
                                        Text(suggestion.capitalized)
                                        Spacer()
                                        if let grams = proteinDatabase[suggestion] {
                                            Text(String(format: "%.1f g", grams))
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                }
                            }
                        }
                        .padding(8)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                    }
                    
                    TextField("Protein (grams)", text: $proteinAmount)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    if let info = infoMessage {
                        Text(info)
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                    
                    Button(action: addItem) {
                        Text("Add")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
                
                // List of Items
                List {
                    ForEach(items) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            Text("\(item.protein, specifier: "%.1f") g")
                                .foregroundColor(.green)
                        }
                    }
                    .onDelete(perform: deleteItem)
                }
                
                // Total Protein Display
                VStack {
                    Text("Total Protein Intake")
                        .font(.headline)
                    
                    Text("\(totalProtein, specifier: "%.1f") g")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
                .padding()
                
                // Weekly Summary
                VStack(spacing: 10) {
                    HStack {
                        Button(action: { weekOffset -= 1 }) {
                            Image(systemName: "chevron.left.circle.fill").font(.title3)
                        }
                        Spacer()
                        VStack(spacing: 2) {
                            Text("Week").font(.caption).foregroundColor(.secondary)
                            Text(selectedWeekLabel).font(.headline)
                        }
                        Spacer()
                        Button(action: { weekOffset += 1 }) {
                            Image(systemName: "chevron.right.circle.fill").font(.title3)
                        }
                    }
                    Divider()
                    HStack(spacing: 12) {
                        weeklyStat(title: "This Week", value: String(format: "%.1f g", selectedWeekTotalProtein), color: .blue)
                        weeklyStat(title: "Previous", value: String(format: "%.1f g", previousWeekTotalProtein), color: .gray)
                        let delta = weekDeltaProtein
                        weeklyStat(title: "Delta", value: String(format: "%@%.1f g", delta >= 0 ? "+" : "", delta), color: delta == 0 ? .gray : (delta > 0 ? .green : .red))
                    }
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
                .padding(.horizontal)
            }
            .navigationTitle("Protein Tracker")
        }
    }
    
    // MARK: - Functions
    
    func addItem() {
        let trimmedName = foodName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else { return }

        var protein: Double?
        if let typed = Double(proteinAmount) {
            protein = typed
        } else {
            let key = trimmedName.lowercased()
            protein = proteinDatabase[key]
        }

        guard let grams = protein else { return }

        let newItem = ProteinItem(name: trimmedName, protein: grams, date: Date())
        items.append(newItem)

        // Reset fields
        foodName = ""
        proteinAmount = ""
        suggestions = []
        infoMessage = nil
    }
    
    func deleteItem(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
}

@ViewBuilder
private func weeklyStat(title: String, value: String, color: Color) -> some View {
    VStack(spacing: 4) {
        Text(title)
            .font(.caption)
            .foregroundColor(.secondary)
        Text(value)
            .font(.headline)
            .foregroundColor(color)
    }
    .frame(maxWidth: .infinity)
    .padding(8)
    .background(color.opacity(0.08))
    .cornerRadius(8)
}

// MARK: - Preview
#Preview {
    ContentView19()
}
