//
//  ContentView.swift
//  AIlure
//
//  Created by Eileen Wang on 1/18/25.
//

import SwiftUI

// Wrap Int in an Identifiable Struct
struct TabItem: Identifiable {
    let id = UUID()
    let tabIndex: Int
}

// Home page
struct ContentView: View {
    @State private var displayedText = "" // Typing effect text
    private let fullText = "Reimagine fashion. Restore the planet!" // Full tagline
    @State private var timer: Timer? // Timer to simulate typing effect
    @State private var index = 0 // Tracks the current character index
    @State private var selectedTab: TabItem? = nil // Use TabItem instead of Int

    var body: some View {
        NavigationView {
            ZStack {
                // Background
                Color("color1").edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 10) {
                    // Logo Section
                    VStack {
                        Image("ailureLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 260, height: 260)

                        // Tagline with Typing Effect
                        Text(displayedText)
                            .font(.headline)
                            .italic()
                            .foregroundColor(Color("color2"))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                            .onAppear {
                                startTypingEffect() // Start the typing effect
                            }
                    }

                    // Arrows Circle Layout
                    ZStack {
                        // Connecting Arrows and Buttons
                        RecyclingArrow(rotationAngle: 0) // Top to Bottom-Left
                        RecyclingArrow(rotationAngle: 120) // Bottom-Left to Bottom-Right
                        RecyclingArrow(rotationAngle: 240) // Bottom-Right to Top

                        VStack {
                            // Learn Button
                            Button(action: {
                                selectedTab = TabItem(tabIndex: 1) // Select Learn tab
                            }) {
                                CircleButton(title: "Learn", iconName: "book")
                            }
                        }
                        .offset(y: -100) // Top Button

                        VStack {
                            // Upcycle Button
                            Button(action: {
                                selectedTab = TabItem(tabIndex: 2) // Select Upcycle tab
                            }) {
                                CircleButton(title: "Upcycle", iconName: "upcycling")
                            }
                        }
                        .offset(x: -100, y: 100) // Bottom-Left Button

                        VStack {
                            // Donate Button
                            Button(action: {
                                selectedTab = TabItem(tabIndex: 3) // Select Donate tab
                            }) {
                                CircleButton(title: "Donate", iconName: "donateClothes")
                            }
                        }
                        .offset(x: 100, y: 100) // Bottom-Right Button
                    }
                    Spacer()
                }
            }
            .navigationBarHidden(true)
            .fullScreenCover(item: $selectedTab) { tab in
                NavigationTab(selectedTab: tab.tabIndex) // Pass tab index to MainTabView
            }
        }
    }

    // MARK: - Typing Effect Logic
    private func startTypingEffect() {
        displayedText = "" // Reset the displayed text
        index = 0 // Reset the character index
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            if index < fullText.count {
                let nextCharacter = fullText[fullText.index(fullText.startIndex, offsetBy: index)]
                displayedText.append(nextCharacter) // Append one character at a time
                index += 1
            } else {
                timer.invalidate() // Stop the timer when typing is complete
            }
        }
    }
}

// Circular Button
struct CircleButton: View {
    let title: String
    let iconName: String
    
    var body: some View {
        VStack {
            Image(iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
            Text(title)
                .font(.title2)
                .multilineTextAlignment(.center)
                .foregroundColor(Color("color2"))
        }
        .frame(width: 120, height: 120)
        .background(Color("color3"))
        .clipShape(Circle())
        .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 5)
    }
}

// Recycling Arrow
struct RecyclingArrow: View {
    let rotationAngle: Double
    
    var body: some View {
        Image(systemName: "arrow.triangle.2.circlepath")
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 400)
            .foregroundColor(Color("color4"))
            .rotationEffect(.degrees(rotationAngle))
            .offset(x: 0, y: 20)
    }
}

#Preview {
    ContentView()
}
