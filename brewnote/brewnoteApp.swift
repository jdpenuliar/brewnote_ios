//
//  brewnoteApp.swift
//  brewnote
//
//  Created by JD Penuliar on 3/17/26.
//

import SwiftUI
import ClerkKit

@main
struct brewnoteApp: App {
    init() {
        Clerk.configure(publishableKey: Env.clerkPublishableKey)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(Clerk.shared)
        }
    }
}
