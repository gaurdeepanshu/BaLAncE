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
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(auth)
        }
    }
}
