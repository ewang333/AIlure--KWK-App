//
//  EduIntro.swift
//  AIlure
//
//  Created by Eileen Wang on 1/24/25.
//

import SwiftUI

struct EduIntro: View {
    @State private var showStatistics = false
    @State private var showPictureCaption = false
    @State private var showAISection = false

    var body: some View {
            ScrollView {
                VStack(spacing: 20) {
                    // Title
                    Text("Welcome to Setting the Stage: Fashion's Impact on the Environment!")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color("color4"))
                        .multilineTextAlignment(.center)
                        .padding(.top, -50) // Adjust top padding
                        //.padding()

                    // Short, impactful statistics with animations
                    VStack(spacing: 10) {
                        if showStatistics {
                            Text("The fashion industry accounts for 10% of global carbon emissions!")
                                .font(.headline)
                                .foregroundColor(Color("color2"))
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal)
                                .transition(.opacity) // Pop-up effect
                                .animation(.easeOut(duration: 0.5), value: showStatistics)

                            Text("The industry is the second biggest consumer of water and is responsible for 20% of global water pollution.")
                                .font(.headline)
                                .foregroundColor(Color("color2"))
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal)
                                .transition(.opacity) // Pop-up effect
                                .animation(.easeOut(duration: 0.5).delay(0.3), value: showStatistics)
                        }
                    }
                    .padding()
                    .background(Color("color3"))
                    .cornerRadius(15)
                    .shadow(radius: 2)

                    // Picture highlighting issue of waste in the fashion industry
                    VStack {
                        Text("Globally, 92 million tons of garments end up in landfills each year!")
                            .font(.headline)
                            .foregroundColor(Color("color2"))
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 10)
                            .opacity(showPictureCaption ? 1 : 0) // Pop-up effect for caption
                            .animation(.easeOut(duration: 0.5).delay(0.8), value: showPictureCaption)

                        // Link the image to a related article
                        Link(destination: URL(string: "https://earth.org/fast-fashions-detrimental-effect-on-the-environment/")!) {
                            Image("waste")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .cornerRadius(10)
                                .shadow(radius: 2)
                                .overlay(
                                    // Place "Tap to Read About..." text at bottom of image
                                    Text("Tap to Read About Fashion's Impact on the Environment")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .padding(8)
                                        .background(Color.black.opacity(0.7))
                                        .cornerRadius(10),
                                    alignment: .bottom // Lower alignment
                                )
                        }
                    }
                    .padding()
                    .background(Color("color1"))
                    .cornerRadius(15)
                    .shadow(radius: 2)

                    // AI's Role Section
                    if showAISection {
                        VStack(spacing: 10) {
                            Text("From supply chain optimization to upcycling and circular fashion, AI can revolutionize sustainability.")
                                .font(.body)
                                .foregroundColor(Color("color2"))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                                .transition(.opacity) // Pop-up effect
                                .animation(.easeInOut(duration: 0.5), value: showAISection)
                        }
                        .padding()
                        .background(Color("color3"))
                        .cornerRadius(15)
                        .shadow(radius: 2)
                    }

                    // Call-to-action button
                    NavigationLink(destination: AISupplyChain()) {
                        Text("Explore AI Solutions")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("color4"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 2)
                    }
                    .padding(.horizontal)
                }
                .padding()
            }
            .onAppear {
                // Trigger animations when the view appears
                withAnimation {
                    showStatistics = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    withAnimation {
                        showPictureCaption = true
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation {
                        showAISection = true
                    }
                }
            }
        
    }
}

#Preview {
    EduIntro()
}
