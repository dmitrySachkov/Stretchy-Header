//
//  ButtonFrame.swift
//  Stretchy header
//
//  Created by Dmitry Sachkov on 18.06.2025.
//

import Foundation

struct ButtonFrame: Identifiable, Equatable {
    var id: UUID = .init()
    var value: Int
    var offset: CGSize = .zero
    var opacity: CGFloat = 1
    var triggerKeyFrame: Bool = false
}

