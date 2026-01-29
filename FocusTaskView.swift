import SwiftUI

struct FocusTaskView: View {
    let chakra: Chakra
    @State private var isFocusing = false
    @State private var progress: CGFloat = 0.0
    @State private var showSuccess = false
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    let targetTime: Double = 15.0
    
    // FIX 1: We create TWO engines. One for rumbling, one for the "Success" ding.
    let impactEngine = UIImpactFeedbackGenerator(style: .heavy)
    let successEngine = UINotificationFeedbackGenerator()
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            if showSuccess {
                SuccessView(chakra: chakra)
            } else {
                VStack {
                    Spacer()
                    ZStack {
                        Circle()
                            .trim(from: 0, to: progress)
                            .stroke(
                                LinearGradient(colors: [.white, chakra.color], startPoint: .top, endPoint: .bottom),
                                style: StrokeStyle(lineWidth: 10, lineCap: .round)
                            )
                            .frame(width: 200, height: 200)
                            .rotationEffect(.degrees(-90))
                            .animation(.linear(duration: 0.1), value: progress)
                        
                        Circle()
                            .fill(chakra.color)
                            .frame(width: 150, height: 150)
                            .shadow(color: chakra.color, radius: isFocusing ? 50 : 10)
                            .overlay(
                                Text(isFocusing ? "" : "HOLD")
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                            )
                            .onLongPressGesture(minimumDuration: 100, pressing: { pressing in
                                handlePress(pressing)
                            }, perform: {})
                    }
                    Text(isFocusing ? "Don't blink.\nJust listen." : "Enough Thinking.")
                        .font(.title2)
                        .foregroundStyle(.white.opacity(0.8))
                        .padding(.top, 50)
                    Spacer()
                }
            }
        }
        .onReceive(timer) { _ in
            if isFocusing && progress < 1.0 {
                progress += 1.0 / (targetTime * 10.0)
                if progress >= 1.0 { finishTask() }
            } else if !isFocusing {
                withAnimation { progress = 0 }
            }
        }
        .onDisappear { AudioManager.shared.stop() }
    }
    
    func handlePress(_ isPressing: Bool) {
        withAnimation { isFocusing = isPressing }
        if isPressing {
            // FIX 2: Correct call to Audio Manager
            AudioManager.shared.play(file: chakra.audioFileName)
            impactEngine.impactOccurred() // Use the impact engine here
        } else {
            if !showSuccess { AudioManager.shared.stop() }
        }
    }
    
    func finishTask() {
        successEngine.notificationOccurred(.success) // Use the success engine here
        withAnimation { showSuccess = true }
    }
}
