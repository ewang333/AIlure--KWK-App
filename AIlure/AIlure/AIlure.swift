//
//  Ailure.swift
//  AIlure
//
//  Created by Eileen Wang on 1/25/25.
//

import SwiftUI

@main
struct AIlure: App {
    init() {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            tabBarAppearance.backgroundColor = UIColor.white // Set the background color to white
            UITabBar.appearance().standardAppearance = tabBarAppearance
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }

    var body: some Scene {
        WindowGroup {
            ContentView() 
        }
    }
}
