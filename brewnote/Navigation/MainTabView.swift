//
//  MainTabView.swift
//  brewnote
//
//  Created by JD Penuliar on 3/17/26.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house.fill") {
                HomeView()
            }

            Tab("Brews", systemImage: "cup.and.saucer.fill") {
                BrewsListView()
            }

            Tab("Beans", systemImage: "leaf.fill") {
                BeansListView()
            }

            Tab("Profile", systemImage: "person.fill") {
                ProfileView()
            }
        }
    }
}

#Preview {
    MainTabView()
}
