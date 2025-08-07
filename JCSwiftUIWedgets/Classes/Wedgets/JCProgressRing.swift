//
//  JCProgressRing.swift
//  JCSwiftUIWedgets
//
//  Created by James Chen on 2024-07-24.
//

import SwiftUI

public enum JCProgressRingStartPosition {
  case top
  case bottom
  case left
  case right
}

// Editing appearance.shared ensures that this component looks the same wherever it is used,
// Or have a new Appearance() to make it special.
public class JCProgressRingAppearance {
  public static let shared = JCProgressRingAppearance()

  public var width: CGFloat = 100
  public var ringWidth: CGFloat = 12
  public var ringColor: Color = JCThemeColor.primary

  public var start: JCProgressRingStartPosition = .top

  public init(width: CGFloat = 100,
              ringWidth: CGFloat = 12,
              ringColor: Color = JCThemeColor.primary,
              start: JCProgressRingStartPosition = .top) {
    self.width = width
    self.ringWidth = ringWidth
    self.ringColor = ringColor
    self.start = start
  }
}

public struct JCProgressRing: View {
  public init(percent: CGFloat,
              appearance: JCProgressRingAppearance = JCProgressRingAppearance.shared) {
    self.percent = percent
    self.appearance = appearance
  }

  public var body: some View {
    ZStack {
      Circle()
        .trim(to: percent)
        .stroke(
          appearance.ringColor,
          lineWidth: appearance.ringWidth
        )
        .frame(width: appearance.width - appearance.ringWidth, height: appearance.width - appearance.ringWidth)
        .rotationEffect(.degrees(degress()))
        .shadow(radius: 2)
    }.frame(width: appearance.width, height: appearance.width)
  }

  private func degress() -> Double {
    switch appearance.start {
    case .top:
      return 270
    case .bottom:
      return 90
    case .left:
      return 180
    case .right:
      return 0
    }
  }

  private var percent: CGFloat
  private var appearance: JCProgressRingAppearance
}

#Preview {
  VStack {
    JCProgressRing(percent: 0.3)
    JCProgressRing(percent: 0.9, appearance: JCProgressRingAppearance(width: 100, ringWidth: 50, start: .bottom))
    ZStack {
      JCProgressRing(percent: 0.4, appearance: JCProgressRingAppearance(width: 52, ringColor: Color.orange))
      JCProgressRing(percent: 0.3, appearance: JCProgressRingAppearance(width: 76, ringColor: Color.red))
      JCProgressRing(percent: 0.6, appearance: JCProgressRingAppearance(width: 100, ringColor: Color.green))
      JCProgressRing(percent: 0.4, appearance: JCProgressRingAppearance(width: 124, ringColor: Color.blue))
    }
  }
}
