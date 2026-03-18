//
//  ContentView.swift
//  brewnote
//
//  Created by JD Penuliar on 3/17/26.
//

import SwiftUI
import Combine
import ConvexMobile

struct ContentView: View {
    @State private var authState: AuthState<String> = .loading

    var body: some View {
        Group {
            switch authState {
            case .loading:
                ProgressView("Loading...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

            case .unauthenticated:
                SignInView()

            case .authenticated:
                MainTabView()
            }
        }
        .task {
            for await state in convexClient.authState.values {
                authState = state
            }
        }
    }
}

#Preview {
    ContentView()
}
