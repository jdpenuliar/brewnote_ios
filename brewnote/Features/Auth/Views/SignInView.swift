//
//  SignInView.swift
//  brewnote
//
//  Created by JD Penuliar on 3/17/26.
//

import SwiftUI
import ClerkKitUI

struct SignInView: View {
    @State private var isAuthPresented = false

    var body: some View {
        VStack(spacing: 32) {
            Spacer()

            Image(systemName: "cup.and.saucer.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundStyle(.brown)

            VStack(spacing: 8) {
                Text("Brew Note")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Track your coffee journey")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Button {
                isAuthPresented = true
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.brown)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 48)
        }
        .sheet(isPresented: $isAuthPresented) {
            AuthView()
        }
    }
}

#Preview {
    SignInView()
}
