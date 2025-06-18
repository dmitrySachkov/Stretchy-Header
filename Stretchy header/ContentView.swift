//
//  ContentView.swift
//  Stretchy header
//
//  Created by Dmitry Sachkov on 16.06.2025.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                parallaxCarousel
                    .padding(.horizontal, 16)
                    .stretchy()
                
                actionButton
                
                Spacer()
                Text("""
                If you have recently relocated to the US, you may transfer your account over. However, if you are transferring your account as a Distributor, please be aware that there are specific legal requirements. You must possess a valid Social Security Number (SSN) and have legal authorization to work in the US Furthermore, you are required to complete the "Become a Distributor" form on the US website BEFORE filling out this form and initiating the region transfer.   If you have any questions or require further assistance, please contact Customer Service at 1-844-224-9987 (toll-free for the US and Canada).
                """)
                .padding(.horizontal, 24)
                .padding(.top, 16)
            }
        }
    }
}

#Preview {
    ContentView()
}

extension ContentView {
    private var actionButton: some View {
        HStack {
            Text("Select a number of:")
                .fontWeight(.bold)
                .foregroundStyle(.secondary)
            Spacer()
            
            RepeatableButton()
        }
        .padding(.horizontal, 24)
        .padding(.top, 16)
    }
    
    private var parallaxCarousel: some View {
        ParallaxCarousel()
    }
}

extension View {
    
    func stretchy() -> some View {
        visualEffect { effect, geometry in
            let currentHeight = geometry.size.height
            let scrollOffset = geometry.frame(in: .scrollView).minY
            let positiveOffset = max(0, scrollOffset)
            let newHeight = currentHeight + positiveOffset
            let scaleFactor = newHeight / currentHeight
            
            return effect.scaleEffect(x: scaleFactor, y: scaleFactor, anchor: .bottom
            )
        }
    }
    
    func resizeContent(_ isHide: Bool) -> some View {
        visualEffect { effect, geometry in
            let currentSize = geometry.size
            let screenBounds = UIScreen.main.bounds
            
            // Вычисляем коэффициент масштабирования для заполнения экрана
            let scaleX = screenBounds.width / currentSize.width
            let scaleY = screenBounds.height / currentSize.height
            let maxScale = max(scaleX, scaleY)
            
            // Используем больший коэффициент для полного покрытия экрана
            let targetScale = isHide ? maxScale : 1.0
            
            return effect
                .scaleEffect(targetScale, anchor: .center)
        }
        .animation(.easeInOut(duration: 0.3), value: isHide)
    }
}
