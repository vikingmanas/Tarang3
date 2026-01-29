//
//  SwiftUIView.swift
//  Tarang
//
//  Created by GU on 29/01/26.
//

import SwiftUI

struct SuccessView: View {
    let chakra: Chakra
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 20) {
                Image(systemName: "brain.head.profile")
                    .font(.system(size: 80))
                    .foregroundStyle(chakra.color)
                
                Text("Loop Broken")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("NEUROLOGY FACT:")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(.gray)
                    
                    Text("You just activated the 'Task Positive Network' (TPN).")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                    
                    Text("Research shows the brain cannot be in 'Worry Mode' (DMN) and 'Focus Mode' (TPN) at the same time. By locking your gaze, you physically forced your anxiety to shut down.")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.8))
                }
                .padding()
                .background(Material.ultraThin)
                .cornerRadius(15)
                .padding(.horizontal)
                
                Button("Return to Center") {
                    presentationMode.wrappedValue.dismiss()
                }
                .padding(.top, 20)
                .foregroundStyle(.white)
            }
        }
    }
}
