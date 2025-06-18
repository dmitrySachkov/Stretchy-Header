//
//  FullscreenImageView.swift
//  Stretchy header
//
//  Created by Dmitry Sachkov on 18.06.2025.
//

import SwiftUI

struct FullscreenImageView: View {
    let card: CardModel
    @Binding var isPresented: Bool
    @State private var scale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var isDragging = false
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                // Close button
                HStack {
                    Spacer()
                    Button(action: {
                        isPresented = false
                    }) {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.5))
                            .clipShape(Circle())
                    }
                    .padding()
                }
                
                Spacer()
                
                // Image with zoom and pan
                Image(card.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(scale)
                    .offset(offset)
                    .gesture(
                        SimultaneousGesture(
                            // Magnification gesture for zooming
                            MagnificationGesture()
                                .onChanged { value in
                                    scale = max(1.0, min(value, 4.0))
                                }
                                .onEnded { _ in
                                    withAnimation(.easeInOut(duration: 0.3)) {
                                        if scale < 1.2 {
                                            scale = 1.0
                                            offset = .zero
                                        }
                                    }
                                },
                            
                            // Drag gesture for panning
                            DragGesture()
                                .onChanged { value in
                                    if scale > 1.0 {
                                        offset = value.translation
                                    }
                                }
                                .onEnded { _ in
                                    if scale <= 1.0 {
                                        withAnimation(.easeInOut(duration: 0.3)) {
                                            offset = .zero
                                        }
                                    }
                                }
                        )
                    )
                    .onTapGesture(count: 2) {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            if scale > 1.0 {
                                scale = 1.0
                                offset = .zero
                            } else {
                                scale = 2.0
                            }
                        }
                    }
                
                Spacer()
                
                // Card info at bottom
                VStack(alignment: .leading, spacing: 8) {
                    Text(card.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text(card.subtitle)
                        .font(.body)
                        .foregroundColor(.white.opacity(0.8))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(
                    LinearGradient(
                        colors: [.clear, .black.opacity(0.8)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
        }
        .onTapGesture {
            // Close on single tap (only if not zoomed)
            if scale <= 1.0 {
                isPresented = false
            }
        }
    }
}

