import SwiftUI

struct ChakraDetailView: View {
    let chakra: Chakra
    @State private var isPlaying = false
    @State private var pulse = false
    
    // Timer to sync haptics with the "Breathing" animation
    // Triggers every 4 seconds to simulate a breath
    let hapticTimer = Timer.publish(every: 4, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            RadialGradient(colors: [chakra.color.opacity(0.2), .black], center: .topTrailing, startRadius: 0, endRadius: 600)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    
                    // Hero Animation
                    ZStack {
                        Circle()
                            .fill(chakra.color.opacity(0.1))
                            .frame(width: 200, height: 200)
                            .scaleEffect(pulse ? 1.2 : 1.0)
                            .animation(.easeInOut(duration: 3).repeatForever(autoreverses: true), value: pulse)
                        
                        Image(systemName: chakra.icon)
                            .font(.system(size: 80))
                            .foregroundStyle(chakra.color)
                            .shadow(color: chakra.color, radius: 20)
                    }
                    .padding(.top, 40)
                    .padding(.bottom, 40)
                    
                    Text(chakra.target)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    
                    Text(chakra.sanskritName)
                        .font(.headline)
                        .foregroundStyle(chakra.color)
                        .padding(.bottom, 30)
                    
                    // 3-Step Flow
                    VStack(spacing: 15) {
                        InfoCard(title: "Role in Body", text: chakra.roleInBody, icon: "figure.arms.open", color: chakra.color)
                        InfoCard(title: "Frequency", text: "\(chakra.frequency) - \(chakra.medicalFact)", icon: "waveform.path.ecg", color: chakra.color)
                        InfoCard(title: "Posture", text: chakra.position, icon: "figure.mind.and.body", color: chakra.color)
                    }
                    .padding(.horizontal, 20)
                    
                    // Action Button
                    if chakra.name == "Third Eye" {
                        NavigationLink(destination: FocusTaskView(chakra: chakra)) {
                            LargeButton(text: "Start Focus Task", icon: "eye.fill", color: .white, textColor: .black)
                        }
                        .padding(.top, 30)
                    } else {
                        Button(action: toggleAudio) {
                            LargeButton(
                                text: isPlaying ? "Pause Audio" : "Play \(chakra.frequency)",
                                icon: isPlaying ? "pause.fill" : "play.fill",
                                color: chakra.color,
                                textColor: .white
                            )
                        }
                        .padding(.top, 30)
                    }
                    
                    Spacer().frame(height: 50)
                }
            }
        }
        .onAppear {
            pulse = true
            // Prepare the engine when view loads
            HapticManager.shared.prepareHaptics()
        }
        .onDisappear {
            AudioManager.shared.stop()
            HapticManager.shared.stopHaptics()
        }
        // HAPTIC LOOP: Triggers every 4 seconds ONLY if playing
        .onReceive(hapticTimer) { _ in
            if isPlaying {
                HapticManager.shared.playChakraHaptic(for: chakra.name)
            }
        }
    }
    
    func toggleAudio() {
        if isPlaying {
            AudioManager.shared.stop()
            isPlaying = false
        } else {
            AudioManager.shared.play(file: chakra.audioFileName)
            // Trigger first haptic immediately
            HapticManager.shared.playChakraHaptic(for: chakra.name)
            isPlaying = true
        }
    }
}

// Keep your Helper Views (InfoCard, LargeButton) below here...
struct InfoCard: View {
    let title: String
    let text: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(color)
                .frame(width: 30)
                .padding(.top, 5)
            VStack(alignment: .leading, spacing: 5) {
                Text(title.uppercased())
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(.gray)
                Text(text)
                    .font(.body)
                    .foregroundStyle(.white.opacity(0.9))
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.05))
        .cornerRadius(16)
    }
}

struct LargeButton: View {
    let text: String
    let icon: String
    let color: Color
    let textColor: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
            Text(text)
        }
        .font(.headline)
        .foregroundStyle(textColor)
        .padding()
        .frame(maxWidth: .infinity)
        .background(color)
        .cornerRadius(20)
        .padding(.horizontal, 40)
        .shadow(color: color.opacity(0.5), radius: 10, x: 0, y: 5)
    }
}
