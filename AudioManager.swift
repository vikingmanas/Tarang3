import AVFoundation

@MainActor // <--- This tag fixes the red error in your screenshot
class AudioManager {
    static let shared = AudioManager()
    var player: AVAudioPlayer?
    
    func play(file: String) {
        guard let url = Bundle.main.url(forResource: file, withExtension: "m4a") else {
            print("Audio file missing: \(file).m4a")
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = 10
            player?.prepareToPlay()
            player?.play()
        } catch {
            print("Error: \(error)")
        }
    }
    
    func stop() {
        player?.setVolume(0, fadeDuration: 0.5)
        // Using a safe Task for the delay
        Task {
            try? await Task.sleep(nanoseconds: 500_000_000)
            self.player?.stop()
        }
    }
}
