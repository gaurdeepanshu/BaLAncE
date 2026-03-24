

import Foundation
import HealthKit
import Combine
import SwiftUI

class CycleViewModel: ObservableObject {
    
    private let healthStore = HKHealthStore()
    
    @Published var cycleToday: Int = 0
    
    init(useMockData: Bool = false) {
        if useMockData {
            // Provide stable mock data for previews/tests and avoid HealthKit
            self.cycleToday = 4_345
            return
        }
        // Defer HealthKit work until after initialization
        Task { [weak self] in
            await self?.requestAuthorization()
        }
    }
    
    @MainActor func requestAuthorization() async {
        guard HKHealthStore.isHealthDataAvailable() else { return }

        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!

        do {
            try await healthStore.requestAuthorization(toShare: [], read: [stepType])
            fetchSteps()
        } catch {
            print("Authorization failed: \(error.localizedDescription)")
        }
    }
    
    func fetchSteps() {
        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepType,
                                      quantitySamplePredicate: predicate,
                                      options: .cumulativeSum) { _, result, _ in
            DispatchQueue.main.async {
                if let sum = result?.sumQuantity() {
                    self.cycleToday = Int(sum.doubleValue(for: HKUnit.count()))
                }
            }
        }
        
        healthStore.execute(query)
    }
}

struct CyclePreviewView: View {
    @StateObject private var viewModel = CycleViewModel(useMockData: true)

    var body: some View {
        VStack(spacing: 8) {
           // Text("cycling Today")
           //     .font(.headline)
            Image(systemName: "bicycle")
                .font(.largeTitle)
                .padding()
                .foregroundColor(.green)

            Text("\(viewModel.cycleToday)")
                .font(.largeTitle)
                .bold()
        }
        .padding()
    }
}
#Preview("Cycle Preview") {
    CyclePreviewView()
}
