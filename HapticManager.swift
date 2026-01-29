import CoreHaptics
import UIKit

// 1. ADD THIS TAG to fix the red error
@MainActor
class HapticManager {
    static let shared = HapticManager()
    private var engine: CHHapticEngine?
    
    init() {
        prepareHaptics()
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Haptic Engine Error: \(error.localizedDescription)")
        }
    }
    
    func playChakraHaptic(for name: String) {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        // Restart engine if needed
        try? engine?.start()
        
        // Define texture based on Chakra
        var sharpness: Float = 0.5
        var intensity: Float = 0.5
        
        switch name {
        case "Root":
            sharpness = 0.0; intensity = 1.0
        case "Sacral":
            sharpness = 0.2; intensity = 0.8
        case "Solar Plexus":
            sharpness = 0.4; intensity = 0.9
        case "Heart":
            sharpness = 0.5; intensity = 0.6
        case "Throat":
            sharpness = 0.7; intensity = 0.5
        case "Third Eye":
            sharpness = 0.9; intensity = 0.4
        case "Crown":
            sharpness = 1.0; intensity = 0.3
        default:
            sharpness = 0.5; intensity = 0.5
        }
        
        let hapticEvent = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [
                CHHapticEventParameter(parameterID: .hapticSharpness, value: sharpness),
                CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity)
            ],
            relativeTime: 0,
            duration: 3.0
        )
        
        do {
            let pattern = try CHHapticPattern(events: [hapticEvent], parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play haptic: \(error)")
        }
    }
    
    func stopHaptics() {
        engine?.stop(completionHandler: nil)
    }
}
