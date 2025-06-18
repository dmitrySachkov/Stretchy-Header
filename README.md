# Stretchy-Header
# SwiftUI Showcase App

A demo SwiftUI app featuring:

- 📸 **Parallax Carousel** — horizontally scrollable cards with a parallax effect.
- 🖼 **FullscreenImageView** — full-screen image viewer with zoom, pan, and double-tap support.
- ➕ **RepeatableButton** — counter buttons with keyframe animations and tap-and-hold behavior.

## 📦 Features

- Smooth parallax scrolling
- Animated card zoom in/out
- Tap-and-hold buttons with repeated action
- Floating number animations using keyframes
- Pinch-to-zoom and drag support in full-screen mode

## 🧱 Architecture

- `ParallaxCarousel`: displays a horizontal carousel with a parallax offset effect.
- `FullscreenImageView`: shows an image in full-screen mode with zoom and pan.
- `RepeatableButton`: increment/decrement counter with animated number transitions.
- `.stretchy()` and `.resizeContent(_:)` view extensions for scroll-based scaling and fullscreen transitions.

## ▶️ How to Run

1. Open `ContentView.swift` in Xcode.
2. Run the project on Simulator or a physical device.
3. Tap on cards, zoom images, and use the counter to interact with all components.

## 🛠 Requirements

- Xcode 15+
- iOS 17+
- SwiftUI

## 📂 Project Structure
📁 YourProject/
├── Models/
│   └── CardModel.swift
├── Views/
│   ├── ParallaxCarousel.swift
│   ├── FullscreenImageView.swift
│   └── RepeatableButton.swift
├── Extensions/
│   └── View+Effects.swift
└── ContentView.swift

## 🧪 Preview

<img src="preview1.png" width="400" />
<img src="preview2.png" width="400" />

## 📄 License

MIT
