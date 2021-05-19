// Copyright (C) 2021 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI
import Combine

public struct LoadingIndicator: View {
    static let duration = 0.2
    let count = 5
    
    private let timerPublisher = Timer.publish(every: duration, on: .main, in: .common)
    private var subscription: Cancellable?
    
    public var isAnimating: Bool {
        return subscription != nil
    }
    
    @State private var currentIndex: Int = -1
    
    public var body: some View {
        HStack() {
            HStack {
                Text("Loading")
                    .font(.system(size: 17, weight: .semibold)
                            .italic())
                    .foregroundColor(.secondary)
                    .padding(.trailing, 4)
                    .layoutPriority(1)
                ForEach(0..<count, id: \.self) { index in
                    Circle()
                        .fill(Color.primary)
                        .frame(width: 6, height: 6)
                        .opacity(isAnimating ? index == currentIndex ? 1.0 : 0.2 : 1)
                        .scaleEffect(index == currentIndex ? 1.5 : 1.0)
                        .animation(.easeInOut(duration: Self.duration * Double(count - 2)))
                }
            }
            .onReceive(timerPublisher) { _ in
                guard isAnimating else {
                    currentIndex = -1
                    return
                }
                currentIndex = (currentIndex + 1) % count
            }
        }
    }
    
    public init(isAnimating: Bool = true) {
        if (isAnimating) {
            start()
        }
    }
    
    public mutating func start() {
        subscription = timerPublisher.connect()
    }
    
    public mutating func stop() {
        subscription?.cancel()
        subscription = nil
    }
}

struct LoadingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoadingIndicator(isAnimating: true)
            LoadingIndicator(isAnimating: false)
        }
    }
}
