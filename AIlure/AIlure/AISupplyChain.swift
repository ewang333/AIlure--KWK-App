//
//  AISupplyChain.swift
//  AIlure
//
//  Created by Eileen Wang on 1/25/25.
//

import SwiftUI

struct AISupplyChain: View {
    @State private var typingFinished = false // Track typing animation completion
    @State private var selectedStage: String? = nil // Track the selected stage for description

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Typing animation for supply chain definition
                TypingTextView(
                    text: "Supply Chain: Network of people, organizations, resources, and processes involved in producing and distributing a good to a consumer",
                    typingFinished: $typingFinished
                )
                .padding(.horizontal, 20)
                .padding(.top, -50)

                if typingFinished {
                    VStack(spacing: 30) {
                        // Instructions for User
                        Text("Click on each picture to learn how AI optimizes supply chains!")
                            .font(.headline)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.white)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color("color1"))
                                    .shadow(radius: 5)
                            )

                        // Supply Chain Steps
                        VStack(spacing: 20) {
                            // Raw Material Sourcing
                            ChainStepView(
                                stageName: "Raw Material Sourcing",
                                imageName: "materials",
                                description: "AI algorithms can analyze data and reports to identify eco-friendly materials like organic cotton or recycled polyester. AI can also leverage predictive analytics to forecast material demand, reducing overuse of resources and waste.",
                                selectedStage: $selectedStage
                            )
                            LongLineView()
                                .padding(.top, -20)

                            // Manufacturing
                            ChainStepView(
                                stageName: "Manufacturing",
                                imageName: "manufacturing",
                                description: "AI can optimize manufacturing processes by adjusting machinery schedules and automating tasks, optimizing fabric-cutting patterns to minimize waste, and creating 3D virtual prototypes to reduce waste.",
                                selectedStage: $selectedStage
                            )
                            LongLineView()
                                .padding(.top, -20)

                            // Logistics and Transportation
                            ChainStepView(
                                stageName: "Logistics and Transportation",
                                imageName: "inventory",
                                description: "AI minimizes carbon emissions with route optimization, helps keep track of inventories, and blockchain-powered AI systems can enhance supply chain transparency and minimize energy usage.",
                                selectedStage: $selectedStage
                            )
                            LongLineView()
                                .padding(.top, -20)

                            // Retail
                            ChainStepView(
                                stageName: "Retail and Sales",
                                imageName: "retail",
                                description: "Up to 40% of clothes are not sold each year! However, with AI analyzing consumer data to forecast fashion trends, offering personalized recommendations, and virtual fittings, this can lead to higher customer satisfaction and less waste.",
                                selectedStage: $selectedStage
                            )
                        }
                        // Learn About AI in Circular Fashion Button
                        NavigationLink(destination: AICircularFashion()) {
                            Text("Learn About AI in Circular Fashion")
                                .font(.headline)
                                .padding()
                                .background(Color("color4"))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                        .padding(.top, 10)
                    }
                    .padding()
                    .background(Color("color3")) // Pink background for all the content below the supply chain definition
                    .cornerRadius(20)
                }
            }
            .padding()
        }
        .navigationTitle("AI in Supply Chain Optimization")
    }
}

// Supply chain step view with centered stage name and description
struct ChainStepView: View {
    var stageName: String
    var imageName: String
    var description: String

    @Binding var selectedStage: String? // Track the selected stage for description

    var body: some View {
        VStack(spacing: 5) {
            // Stage name centered above the picture
            Text(stageName)
                .font(.headline)
                .foregroundColor(Color("color4"))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.bottom, -80)

            // Image and description
            VStack (spacing: 5) {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180, height: 180)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            selectedStage = (selectedStage == stageName) ? nil : stageName
                        }
                    }

                // Each step pops up only when selected
                if selectedStage == stageName {
                    Text(description)
                        .font(.body)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 10)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .transition(.move(edge: .trailing))
                }
            }
        }
    }
}

// Long line for connecting steps to create chain-like structure
struct LongLineView: View {
    var body: some View {
        Rectangle()
            .fill(Color("color4"))
            .frame(width: 2, height: 80)
            .frame(maxWidth: .infinity, alignment: .center)
    }
}

// Typing animation view
struct TypingTextView: View {
    let text: String
    @Binding var typingFinished: Bool
    @State private var displayedText = ""
    @State private var currentIndex = 0

    var body: some View {
        Text(displayedText)
            .font(.headline)
            .foregroundColor(Color("color4"))
            .multilineTextAlignment(.center)
            .onAppear {
                startTyping()
            }
    }

    private func startTyping() {
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            if currentIndex < text.count {
                let index = text.index(text.startIndex, offsetBy: currentIndex)
                displayedText.append(text[index])
                currentIndex += 1
            } else {
                timer.invalidate()
                typingFinished = true
            }
        }
    }
}

#Preview {
    AISupplyChain()
}
