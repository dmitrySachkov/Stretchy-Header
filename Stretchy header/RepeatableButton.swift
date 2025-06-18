//
//  RepeatableButton.swift
//  Stretchy header
//
//  Created by Dmitry Sachkov on 18.06.2025.
//

import SwiftUI

struct RepeatableButton: View {
    
    @State private var count = 0
    @State private var buttonFrames: [ButtonFrame] = []
    
    var body: some View {
        HStack(spacing: 12) {
            minusButton
            
            counterText
            
            plusButton
        }
    }
}

#Preview {
    RepeatableButton()
}

extension RepeatableButton {
    private var minusButton: some View {
        Button {
            if count != 0 {
                let frame = ButtonFrame(value: count)
                buttonFrames.append(frame)
                toggleAnimation(frame.id, false)
            }
        } label: {
            Image(systemName: "minus")
                .fontWeight(.bold)
                .tint(.red)
                
        }
        .buttonRepeatBehavior(.enabled)
    }
    
    private var counterText: some View {
        Text("\(count)")
            .fontWeight(.bold)
            .frame(width: 44, height: 44)
            .background(.white.shadow(.drop(color: .black.opacity(0.15), radius: 5)),
                        in: .rect(cornerRadius: 10))
            .overlay {
                ForEach(buttonFrames) { brFrame in
                    KeyframeAnimator(initialValue: ButtonFrame(value: 0), trigger: brFrame.triggerKeyFrame) { frame in
                        Text("\(brFrame.value)")
                            .fontWeight(.bold)
                            .background(.black.opacity(0.6 - frame.opacity))
                            .offset(frame.offset)
                            .opacity(frame.opacity)
                            .blur(radius: (1 - frame.opacity) * 10)
                    } keyframes: { _ in
                        KeyframeTrack(\.offset) {
                            LinearKeyframe(CGSize(width: 0, height: -20), duration: 0.2)
                            LinearKeyframe(CGSize(width: .random(in: -2...2), height: -40), duration: 0.2)
                            LinearKeyframe(CGSize(width: .random(in: -2...2), height: -70), duration: 0.4)
                        }
                        
                        KeyframeTrack(\.opacity) {
                            LinearKeyframe(1, duration: 0.2)
                            LinearKeyframe(1, duration: 0.2)
                            LinearKeyframe(0.7, duration: 0.2)
                            LinearKeyframe(0, duration: 0.2)
                        }
                    }
                }
            }
    }
    
    private var plusButton: some View {
        Button {
            let frame = ButtonFrame(value: count)
            buttonFrames.append(frame)
            toggleAnimation(frame.id)
        } label: {
            Image(systemName: "plus")
                .fontWeight(.bold)
                .tint(.red)
        }
        .buttonRepeatBehavior(.enabled)
    }
    
    private func toggleAnimation(_ id: UUID, _ isIncrement: Bool = true) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let index = buttonFrames.firstIndex(where: { $0.id == id }) {
                buttonFrames[index].triggerKeyFrame = true
                
                if isIncrement {
                    count += 1
                } else {
                    count -= 1
                }
                
                removeFrame(id)
            }
        }
    }
    
    private func removeFrame(_ id: UUID) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            buttonFrames.removeAll { $0.id == id }
        }
    }
}
