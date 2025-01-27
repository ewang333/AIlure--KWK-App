//
//  AICircularFashion.swift
//  AIlure
//
//  Created by Eileen Wang on 1/25/25.
//

import SwiftUI

struct AICircularFashion: View {
    @State private var showSection1 = false
    @State private var showSection2 = false
    @State private var showSection3 = false
    @State private var showSection4 = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Title
                Text("AI in Circular Fashion")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color("color4"))
                    .multilineTextAlignment(.center)
                    .padding(.top, 10)
                
                // What is Circular Fashion?
                if showSection1 {
                    VStack(spacing: 15) {
                        Text("What is Circular Fashion?")
                            .font(.title2)
                            .foregroundColor(Color("color3"))
                            .fontWeight(.bold)

                        Text("Circular fashion focuses on creating a sustainable system by keeping clothing in use for as long as possible. This involves recycling, upcycling, and donating old clothes to extend their lifecycle.")
                            .font(.body)
                            .foregroundColor(Color("color2"))
                            .multilineTextAlignment(.leading)
                            .padding()
                            .background(Color("color1"))
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .transition(.move(edge: .leading))
                }

                // What is Upcycling?
                if showSection2 {
                    VStack(spacing: 15) {
                        Text("What is Upcycling?")
                            .font(.title2)
                            .foregroundColor(Color("color3"))
                            .fontWeight(.bold)

                        Text("Upcycling involves creatively repurposing old or discarded materials into new, valuable products.")
                            .font(.body)
                            .foregroundColor(Color("color2"))
                            .multilineTextAlignment(.leading)
                            .padding()
                            .background(Color("color1"))
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .transition(.move(edge: .trailing))
                }

                // Section: AI's Role in Upcycling
                if showSection3 {
                    VStack(spacing: 15) {
                        Text("AI’s Role in Upcycling")
                            .font(.title2)
                            .foregroundColor(Color("color3"))
                            .fontWeight(.bold)

                        Text("AI enhances upcycling by identifying fabric types and offering personalized upcycling suggestions. Our app uses AI to scan clothing labels and suggest creative ways to repurpose items, helping to reduce waste and environmental harm.")
                            .font(.body)
                            .foregroundColor(Color("color2"))
                            .multilineTextAlignment(.leading)
                            .padding()
                            .background(Color("color1"))
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .transition(.move(edge: .leading))
                }
        
                // Button to Upcycling Feature
                if showSection3 {
                    NavigationLink(destination: Upcycle()) {
                        Text("Start Upcycling with AI")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color("color4"))
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .padding(.horizontal)
                }

                // Section: Donate to Extend Clothing Lifecycle
                if showSection4 {
                    VStack(spacing: 15) {
                        Text("Donate Clothing")
                            .font(.title2)
                            .foregroundColor(Color("color3"))
                            .fontWeight(.bold)

                        Text("Extending clothing lifespan by nine months can reduce carbon, water, and waste footprints by 30%! Discover nearby donation centers and contribute to circular fashion and save the environment!")
                            .font(.body)
                            .foregroundColor(Color("color2"))
                            .multilineTextAlignment(.leading)
                            .padding()
                            .background(Color("color1"))
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .transition(.move(edge: .trailing))
                }
                
                // Button to Donation Feature
                if showSection4 {
                    NavigationLink(destination: DonationCenters()) {
                        Text("Find Nearby Donation Centers")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color("color4"))
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                }
            }
            .padding()
            .onAppear {
                // Trigger animations sequentially
                withAnimation(.easeInOut(duration: 0.8)) {
                    showSection1 = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    withAnimation(.easeInOut(duration: 0.8)) {
                        showSection2 = true
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                    withAnimation(.easeInOut(duration: 0.8)) {
                        showSection3 = true
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.4) {
                    withAnimation(.easeInOut(duration: 0.8)) {
                        showSection4 = true
                    }
                }
            }
        }
    }
}

#Preview {
    AICircularFashion()
}
