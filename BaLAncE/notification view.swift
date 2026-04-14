//
//  notification view.swift
//  BaLAncE
//
//  Created by applelab02 on 3/2/26.
//

import SwiftUI
import UserNotifications

struct notificationview: View {
    @AppStorage("notificationsEnabled") private var notificationsEnabled: Bool = false
    @State private var deliveredMessages: [String] = []
    
    var body: some View {
        NavigationStack {
            VStack{
                Text("Notification")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                HStack{
                    Spacer()
                    Toggle("Notifications", isOn: $notificationsEnabled)
                        .onChange(of: notificationsEnabled) { _, newValue in
                            if newValue {
                                // Request permission when turning on
                                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
                                    DispatchQueue.main.async {
                                        notificationsEnabled = granted
                                        if granted {
                                            loadDeliveredNotifications()
                                        }
                                    }
                                }
                            } else {
                                // Turning off: clear delivered list (app-level preference)
                                deliveredMessages.removeAll()
                            }
                        }
                        .padding()
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Recent Notifications")
                            .font(.headline)
                        Spacer()
                        Button("Refresh") {
                            loadDeliveredNotifications()
                        }
                    }
                    if deliveredMessages.isEmpty {
                        Text("No notifications yet.")
                            .foregroundColor(.secondary)
                    } else {
                        List(deliveredMessages, id: \.self) { msg in
                            Text(msg)
                        }
                        .listStyle(.plain)
                        .frame(maxHeight: 300)
                    }
                }
                .padding(.horizontal)
                Spacer()
            }
            .onAppear {
                if notificationsEnabled {
                    loadDeliveredNotifications()
                }
            }
        }
    }
    
    private func loadDeliveredNotifications() {
        guard notificationsEnabled else {
            deliveredMessages.removeAll()
            return
        }
        UNUserNotificationCenter.current().getDeliveredNotifications { notes in
            let messages = notes.map { $0.request.content.title.isEmpty ? $0.request.content.body : $0.request.content.title }
            DispatchQueue.main.async {
                self.deliveredMessages = messages
            }
        }
    }
}

#Preview {
    notificationview()
}
