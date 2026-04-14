//
//  BaLAncEApp.swift
//  BaLAncE
//
//  Created by applelab02 on 2/10/26.
//

import SwiftUI
import FirebaseCore
@main
struct BaLAncEApp: App {
    @StateObject var auth = AuthViewModel()
    @StateObject var profile = UserProfile()
    @StateObject var habits = HabitsViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView2()
                .environmentObject(auth)
                .environmentObject(profile)
                .environmentObject(habits)
        }
    }
}


