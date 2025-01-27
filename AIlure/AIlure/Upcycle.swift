//
//  Upcycle.swift
//  AIlure
//
//  Created by Eileen Wang on 1/24/25.
//

import SwiftUI
import PhotosUI
import Vision
import VisionKit

struct Upcycle: View {
    @State private var selectedImage: UIImage? = nil // For selected or captured images
    @State private var detectedText: String = "" // Detected text from the clothing label
    @State private var upcyclingSuggestions: String = "" // Upcycling suggestions
    @State private var sustainabilityFact: String = "" // Sustainability fact
    @State private var isImagePickerPresented = false // Trigger for the image picker
    @State private var isCameraPresented = false // Trigger for the camera
    @State private var isAnalyzing = false // Analyzing state
    @State private var manualInputText: String = "" // Manual input for material type
    @State private var isManualInputActive: Bool = false // Toggle for manual input mode
    @State private var tutorials: [(material: String, link: String)] = [] // List of detected material tutorials
    
    let upcycledImages = ["rug", "bow", "pillow", "scarf", "curtain", "denim", "wallet"] // For image gallery

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Conditionally display the title and photo gallery
                if upcyclingSuggestions.isEmpty && !isManualInputActive {
                    Text("Scan a clothing label and use AI to find upcycling ideas like these!")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color("color1")) // Updated color
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    // Horizontal photo gallery
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(upcycledImages, id: \.self) { imageName in
                                Image(imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 120, height: 120)
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                            }
                        }
                        .padding(.horizontal)
                    }
                }

                // Show selected image or instruction
                if let selectedImage = selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 180)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }

                // Show analyzing progress
                if isAnalyzing {
                    ProgressView("Analyzing...")
                        .padding()
                }

                // Display sustainability facts, upcycling ideas, featured tutorials, or manual input options
                if !upcyclingSuggestions.isEmpty {
                    VStack(spacing: 15) {
                        // Sustainability fact
                        if !sustainabilityFact.isEmpty {
                            Text("Did you know?")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color("color4"))
                            Text(sustainabilityFact)
                                .font(.body)
                                .foregroundColor(Color("color2"))
                                .multilineTextAlignment(.leading)
                                .padding()
                                .background(Color("color3"))
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                        
                        // Display upcycling ideas
                        Text("Upcycling Ideas:")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color("color2"))

                        ScrollView {
                            Text(upcyclingSuggestions)
                                .font(.body)
                                .foregroundColor(.black)
                                .multilineTextAlignment(.leading)
                                .padding()
                                .background(Color("color1"))
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                        
                        // Display Tutorials for Detected Materials
                        if !tutorials.isEmpty {
                            VStack(spacing: 15) {
                                Text("Featured Tutorials")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("color2"))
                                    .multilineTextAlignment(.center)

                                ForEach(tutorials, id: \.material) { tutorial in
                                    VStack(spacing: 10) {
                                        Text(tutorial.material)
                                            .font(.headline)
                                            .foregroundColor(Color.white)

                                        Button(action: {
                                            if let url = URL(string: tutorial.link) {
                                                UIApplication.shared.open(url)
                                            }
                                        }) {
                                            Text("View \(tutorial.material) Tutorial")
                                                .font(.subheadline)
                                                .padding()
                                                .frame(maxWidth: .infinity)
                                                .background(Color("color3"))
                                                .foregroundColor(Color("color2"))
                                                .cornerRadius(10)
                                        }
                                    }
                                    .padding()
                                    .background(Color("color4"))
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                                }
                            }
                            .padding()
                            // Encouraging message
                            Text("Amazing work! Your upcycling efforts contribute to a greener planet! 🌱")
                                .font(.headline)
                                .foregroundColor(Color("color4"))
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                    }
                } else if isManualInputActive {
                    VStack(spacing: 10) {
                        Text("Enter Material Manually:")
                            .font(.headline)
                            .foregroundColor(Color("color4"))
                            .padding(.bottom, 10)

                        ZStack {
                            // Custom outline of textfield
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color("color2"), lineWidth: 2) // Customize outline color and width
                                .frame(height: 50) // Match the height of the TextField

                            // TextField itself
                            TextField("Enter material type (e.g., cotton)", text: $manualInputText)
                                .padding(.horizontal)
                                .multilineTextAlignment(.center)
                                .frame(height: 50) // Ensure the height matches the outline
                                .background(Color.white)
                                .cornerRadius(8)
                        }
                        .padding(.horizontal)
                        .padding(.bottom)

                        Button("Submit") {
                            suggestUpcyclingIdeas(from: manualInputText)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(Color("color1"))
                    }
                    .padding()
                }

                // Buttons for camera, photo library, and manual input
                HStack {
                    Button("Take Photo") {
                        resetState()
                        isCameraPresented = true
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color("color4"))
                    
                    Button("Upload Label Photo") {
                        resetState()
                        isImagePickerPresented = true
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color("color3"))

                    Button("Enter Material Manually") {
                        resetState()
                        isManualInputActive = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { // To help with reset transitions
                            isManualInputActive = true
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color("color2"))
                }
                .padding()
            }
            .padding()
        }
        // Image picker for photo library
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $selectedImage)
                .onDisappear {
                    if let image = selectedImage {
                        isAnalyzing = true
                        analyzeCareLabel(image)
                        isAnalyzing = false
                    }
                }
        }
        // Image picker for camera
        .sheet(isPresented: $isCameraPresented) {
            ImagePicker(sourceType: .camera, selectedImage: $selectedImage)
                .onDisappear {
                    if let image = selectedImage {
                        isAnalyzing = true
                        analyzeCareLabel(image)
                        isAnalyzing = false
                    }
                }
        }
    }
    
    // Reset settings if user wants to scan or manually input another clothing label
    func resetState() {
        selectedImage = nil
        detectedText = ""
        upcyclingSuggestions = ""
        sustainabilityFact = ""
        manualInputText = ""
    }

    // Analyze the clothing label using Apple's Vision framework
    func analyzeCareLabel(_ image: UIImage) {
        guard let cgImage = image.cgImage else {
            print("Failed to get CGImage from UIImage.")
            return
        }

        let request = VNRecognizeTextRequest { request, error in
            if let error = error {
                print("Error recognizing text: \(error.localizedDescription)")
                return
            }
            guard let observations = request.results as? [VNRecognizedTextObservation] else {
                return
            }

            let recognizedText = observations.compactMap { $0.topCandidates(1).first?.string }
            DispatchQueue.main.async {
                self.detectedText = recognizedText.joined(separator: "\n")
                self.suggestUpcyclingIdeas(from: self.detectedText)
            }
        }

        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try requestHandler.perform([request])
            } catch {
                print("Error performing text recognition: \(error.localizedDescription)")
            }
        }
    }

    // Suggest upcycling ideas based on detected or manually entered text
    func suggestUpcyclingIdeas(from text: String) {
        let lowercasedText = text.lowercased()
        var ideas: [String] = []
        var facts: [String] = []
        var detectedTutorials: [(material: String, link: String)] = []

        if lowercasedText.contains("cotton") {
            ideas.append(contentsOf: ["Cotton:", "Turn into cleaning rags", "Make a braided rug", "Use for DIY crafts"])
            facts.append("Cotton is biodegradable, but reusing it can save up to 20,000 liters of water per kilogram of fabric.")
            detectedTutorials.append(("Cotton", "https://www.1dogwoof.com/crochet-rug-from-t-shirts/"))
        }
        if lowercasedText.contains("polyester") {
            ideas.append(contentsOf: ["Polyester:", "Make scrunchies or bows", "Turn into shower caps", "Create banners"])
            facts.append("Polyester is not biodegradable. One laundry load of polyester clothes can discharge 700,000 microplastic fibres! Upcycling can reduce pollution in oceans.")
            detectedTutorials.append(("Polyester", "https://www.waynearthurgallery.com/how-to-make-a-fabric-bow/"))
        }
        if lowercasedText.contains("wool") {
            ideas.append(contentsOf: ["Wool:", "Make pillows", "Use for slippers", "Craft warm mittens"])
            facts.append("Wool is renewable and 100% biodegradable but also produces high methane emissions. Upcycling it can reduce pollution and water use.")
            detectedTutorials.append(("Wool", "https://missykatecreations.com/how-to-sell-an-envelope-pillowcase/"))
        }
        if lowercasedText.contains("silk") {
            ideas.append(contentsOf: ["Silk:", "Create decorative scarves", "Use for fabric flowers", "Make sleep masks"])
            facts.append("Silk is biodegradable, but its production has a high environmental impact due to water use. Around 2,500 silkworms are needed to produce less than 500g of silk!")
            detectedTutorials.append(("Silk", "https://highlatitudestyle.com/how-to-turn-an-old-shirt-into-a-great-scarf/#XYZ"))
        }
        if lowercasedText.contains("linen") {
            ideas.append(contentsOf: ["Linen:", "Make drawstring bags", "Transform into curtains", "Turn into placemats"])
            facts.append("Linen is eco-friendly due to its durability and low water use in production.")
            detectedTutorials.append(("Linen", "https://afarmtokeep.com/how-to-make-a-linen-curtain-from-a-vintage-tablecloth/"))
        }
        if lowercasedText.contains("denim") {
            ideas.append(contentsOf: ["Denim:", "Create tote bags", "Make pencil pouches", "Turn into aprons"])
            facts.append("A pair of jeans can consume up to 20,000 liters of water along its supply chain. Reusing denim can save water and reduce use of toxic chemicals and dyes.")
            detectedTutorials.append(("Denim", "https://www.thesewingdirectory.co.uk/upcycled-denim-tote-bag-project/"))
        }
        if lowercasedText.contains("leather") {
            ideas.append(contentsOf: ["Leather:", "Create wallets", "Make jewelry", "Create pet collars"])
            facts.append("Leather manufacturing requires high water and energy consumption and relies on cattle ranching, which is reliable for 80% of deofrestation in the Amazon.")
            detectedTutorials.append(("Leather", "https://www.instructables.com/Leather-Wallet-From-a-Boot/"))
        }

        if ideas.isEmpty {
            ideas.append("No specific upcycling ideas found. Try entering a different material.")
            facts.append("Upcycling any material can reduce waste and contribute to sustainability.")
        }
        
        let combinedFacts = facts.joined(separator: "\n\n")

        DispatchQueue.main.async {
            self.upcyclingSuggestions = ideas.joined(separator: "\n")
            self.sustainabilityFact = combinedFacts
            self.tutorials = detectedTutorials // Save detected tutorials
        }
    }
}

#Preview {
    Upcycle()
}
