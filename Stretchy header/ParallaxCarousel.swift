//
//  ParallaxCarousel.swift
//  Stretchy header
//
//  Created by Dmitry Sachkov on 18.06.2025.
//

import SwiftUI

struct ParallaxCarousel: View {
    
    @State private var selectedCard: CardModel?
    @State private var showFullscreen = false
    @State private var isHide: Bool = false
    
    var body: some View {
        parallaxCarousel
            .resizeContent(isHide)
            .onTapGesture {
                isHide.toggle()
            }
    }
}

#Preview {
    ParallaxCarousel()
}

extension ParallaxCarousel {
    private var parallaxCarousel: some View {
        GeometryReader { geometry in
            let size = geometry.size
            ScrollView(.horizontal) {
                HStack(spacing: 5) {
                    ForEach(sampleCards, id: \.self) { card in
                        /// In order to Move the Card in Revers Direction (Parallax Effect)
                        GeometryReader { proxy in
                            let cardSize = proxy.size
//                            let minX = proxy.frame(in: .scrollView).minX
                            let minX = min((proxy.frame(in: .scrollView).minX * 1.4), proxy.size.width * 1.4)
                            
                            Image(card.image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .offset(x: -minX * 0.6)
                                .frame(width: proxy.size.width * 1.5)
                                .frame(width: cardSize.width, height: cardSize.height)
                                .overlay(content: {
                                    overLayView(card)
                                })
                                .clipShape(.rect(cornerRadius: 15))
                                .shadow(color: .black.opacity(0.2), radius: 8, x: 5, y: 10)
                        }
                        .frame(width: size.width - 60, height: size.height - 50)
                        /// Scroll Animation
                        .scrollTransition(.interactive, axis: .horizontal) { view, phase in
                            view
                                .scaleEffect(phase.isIdentity ? 1 : 0.95)
                        }
                    }
                }
                .padding(.horizontal, 30)
                .scrollTargetLayout()
                .frame(height: size.height, alignment: .top)
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.hidden)
        }
        .frame(height: 500)
        .padding(.horizontal, -15)
        .padding(.top, 10)
    }
    
    @ViewBuilder
    private func overLayView(_ card: CardModel) -> some View {
        ZStack(alignment: .bottomLeading) {
            LinearGradient(colors: [
                .clear,
                .clear,
                .clear,
                .clear,
                .clear,
                .black.opacity(0.1),
                .black.opacity(0.5),
                .black
            ], startPoint: .top, endPoint: .bottom)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(card.title)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundStyle(.white)
                
                Text(card.subtitle)
                    .font(.callout)
                    .foregroundStyle(.white.opacity(0.8))
            }
            .padding(20)
        }
    }
}
