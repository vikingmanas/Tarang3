import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            AuroraBackground()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Good Morning.")
                            .font(.system(size: 40, weight: .light, design: .serif))
                            .foregroundStyle(.white)
                        
                        Text("What does your soul need right now?")
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.7))
                    }
                    .padding(.top, 50)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                    
                    ForEach(chakraList) { chakra in
                        NavigationLink(destination: ChakraDetailView(chakra: chakra)) {
                            TargetCard(chakra: chakra)
                        }
                    }
                }
                .padding(.bottom, 50)
            }
        }
    }
}

struct TargetCard: View {
    let chakra: Chakra
    @State private var animateGradient = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(chakra.target.uppercased())
                    .font(.caption)
                    .fontWeight(.bold)
                    .tracking(2)
                    .foregroundStyle(chakra.color.opacity(0.8))
                
                Text(chakra.feeling)
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.leading)
                
                HStack(spacing: 5) {
                    Image(systemName: "waveform")
                    Text("Use \(chakra.frequency)")
                }
                .font(.caption2)
                .foregroundStyle(.gray)
                .padding(.top, 4)
            }
            
            Spacer()
            
            ZStack {
                Circle()
                    .fill(chakra.color.opacity(0.2))
                    .frame(width: 60, height: 60)
                    .scaleEffect(animateGradient ? 1.1 : 1.0)
                    .animation(.easeInOut(duration: 3).repeatForever(autoreverses: true), value: animateGradient)
                
                Image(systemName: chakra.icon)
                    .font(.title2)
                    .foregroundStyle(chakra.color)
            }
        }
        .padding(25)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(.ultraThinMaterial)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
        )
        .padding(.horizontal, 20)
        .padding(.vertical, 5)
        .onAppear { animateGradient = true }
    }
}

struct AuroraBackground: View {
    @State private var start = UnitPoint(x: 0, y: -2)
    @State private var end = UnitPoint(x: 4, y: 0)
    
    var body: some View {
        LinearGradient(colors: [Color.black, Color(red: 0.1, green: 0.1, blue: 0.2)], startPoint: start, endPoint: end)
            .ignoresSafeArea()
            .onAppear {
                withAnimation(.easeInOut(duration: 10).repeatForever(autoreverses: true)) {
                    start = UnitPoint(x: 4, y: 0)
                    end = UnitPoint(x: 0, y: 2)
                }
            }
    }
}
