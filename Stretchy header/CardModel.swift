//
//  CardModel.swift
//  Stretchy header
//
//  Created by Dmitry Sachkov on 18.06.2025.
//

import Foundation

/// Card Model
struct CardModel: Hashable, Identifiable {
    var id: UUID = .init()
    var image: String
    var title: String
    var subtitle: String
}

/// Sample cards
var sampleCards: [CardModel] = [
    .init(image: "mountain-lake", title: "Title 1", subtitle: "Subtitle 1"),
    .init(image: "waterfall_002", title: "Title 2", subtitle: "Subtitle 2"),
    .init(image: "yosemite-valley_001", title: "Title 3", subtitle: "Subtitle 3"),
    .init(image: "yosemite-valley", title: "Title 4", subtitle: "Subtitle 4"),
]
