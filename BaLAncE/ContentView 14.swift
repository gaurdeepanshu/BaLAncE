import SwiftUI
import WebKit

struct ContentView14: View {
    let competitionLifts = [
        "Back Squat",
        "Bench Press",
        "Deadlift",
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

    // Map exercise names to a representative YouTube video URL.
    // You can replace these with your preferred videos.
    private let videoURLs: [String: URL] = [
        "Back Squat": URL(string: "https://www.youtube.com/watch?v=ultWZbUMPL8")!,
        "Bench Press": URL(string: "https://www.youtube.com/watch?v=gRVjAtPip0Y")!,
        "Deadlift": URL(string: "https://www.youtube.com/watch?v=op9kVnSso6Q")!,
        "Front Squat": URL(string: "https://www.youtube.com/watch?v=tlfahNdNPPI")!,
        "Sumo Deadlift": URL(string: "https://www.youtube.com/watch?v=2P6Ck6kX2JQ")!,
        "Conventional Deadlift": URL(string: "https://www.youtube.com/watch?v=ytGaGIn3SjE")!,
        "Incline Bench Press": URL(string: "https://www.youtube.com/watch?v=SrqOu55lrYU")!,
        "Overhead Press": URL(string: "https://www.youtube.com/watch?v=B-aVuyhvLHU")!,
        "Pause Squat": URL(string: "https://www.youtube.com/watch?v=4Y2ZdHCOXok")!,
        "Pause Bench Press": URL(string: "https://www.youtube.com/watch?v=9XfD3w5Gq0Q")!,
        "Romanian Deadlift": URL(string: "https://www.youtube.com/watch?v=JCXUYuzwNrM")!,
        "Deficit Deadlift": URL(string: "https://www.youtube.com/watch?v=9T0w0z1Vx8o")!,
        "Hip Thrust": URL(string: "https://www.youtube.com/watch?v=LM8XHLYJoYs")!,
        "Barbell Row": URL(string: "https://www.youtube.com/watch?v=GZbfZ033f74")!,
        "Pull-Up": URL(string: "https://www.youtube.com/watch?v=eGo4IYlbE5g")!,
        "Dips": URL(string: "https://www.youtube.com/watch?v=2z8JmcrW-As")!
    ]
    
    var body: some View{
        NavigationStack {
            VStack {
                Text("Exclusive Workout")
                    .font(.title2.weight(.semibold))
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                List {
                    Section("Competition Lifts") {
                        ForEach(competitionLifts, id: \.self) { exercise in
                            exerciseRow(exercise)
                        }
                    }
                    
                    Section("Variations") {
                        ForEach(variations.sorted(), id: \.self) { exercise in
                            exerciseRow(exercise)
                        }
                    }
                    
                    Section("Accessories") {
                        ForEach(accessories.sorted(), id: \.self) { exercise in
                            exerciseRow(exercise)
                        }
                    }
                }
                .listStyle(.insetGrouped)
            }
//            .navigationTitle("Workout Library")
        }
    }
    
    @ViewBuilder
    private func exerciseRow(_ name: String) -> some View {
        if let url = videoURLs[name] {
            NavigationLink(destination: YouTubeWebView(url: url).navigationTitle(name)) {
                Text(name)
            }
        } else {
            // Fallback: perform a YouTube search if no direct URL mapping exists
            let searchQuery = name.replacingOccurrences(of: " ", with: "+") + "+exercise"
            let searchURL = URL(string: "https://www.youtube.com/results?search_query=\(searchQuery)")!
            NavigationLink(destination: YouTubeWebView(url: searchURL).navigationTitle(name)) {
                Text(name)
            }
        }
    }
}

// Simple SwiftUI wrapper around WKWebView for in-app YouTube viewing
struct YouTubeWebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

#Preview {
    ContentView14()
}

