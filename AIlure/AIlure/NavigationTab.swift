//
//  NavigationTab.swift
//  AIlure
//
//  Created by Eileen Wang on 1/26/25.
//


import SwiftUI

// Navigation bar at bottom of screen
struct NavigationTab: View {
    let selectedTab: Int

    @State private var currentTab = 0

    var body: some View {
        TabView(selection: $currentTab) {
            
            // ContentView Tab
            NavigationView {
                ContentView()
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            .tag(0)
            
            // Learn Tab
            NavigationView {
                EduIntro() 
            }
            .tabItem {
                Image(systemName: "book.fill")
                Text("Learn")
            }
            .tag(1)

            // Upcycle Tab
            NavigationView {
                Upcycle()
            }
            .tabItem {
                Image(systemName: "arrow.2.circlepath")
                Text("Upcycle")
            }
            .tag(2)

            // Donate Tab
            NavigationView {
                DonationCenters()
            }
            .tabItem {
                Image(systemName: "heart.fill")
                Text("Donate")
            }
            .tag(3)
        }
        .onAppear {
            currentTab = selectedTab
        }
    }
}


