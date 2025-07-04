//
//  JCToggle.swift
//  JCSwiftUIWedgets
//
//  Created by James Chen on 2022/12/23.
//

import SwiftUI

// Editing config.shared ensures that this component looks the same wherever it is used.
// Or have a new Config() to make it special.
public struct JCToggleConfig {
  public static let shared = JCToggleConfig()

  public var width: CGFloat = 52
  public var height: CGFloat = 32

  public var backgroundColor = JCColorPair(normal: JCThemeColor.separateLine, highlight: JCThemeColor.success.opacity(0.3))
  public var foregroundColor = JCColorPair(normal: JCThemeColor.navigationBar, highlight: JCThemeColor.success)

  public var thumbHeight: CGFloat = 24
  public var thumbOffset: CGFloat = 10
}

public struct JCToggle: View {
  public var tintColor: Color = JCThemeColor.primary
  @Binding public var isOn: Bool
  public var onChange: ((Bool) -> Void)?

  public var config = JCToggleConfig.shared

  public var body: some View {
    ZStack {
      Capsule()
        .fill(isOn ? config.backgroundColor.highlight : config.backgroundColor.normal)

      Circle()
        .fill(isOn ? config.foregroundColor.highlight : config.foregroundColor.normal)
        .frame(height: config.thumbHeight)
        .offset(x: isOn ? config.thumbOffset : -config.thumbOffset)
    }
    .frame(width: config.width, height: config.height)
    .onTapGesture {
      withAnimation {
        isOn.toggle()
      }
      onChange?(isOn)
    }
  }
}

#Preview {
  VStack {
    JCToggle(isOn: .constant(false))
    JCToggle(isOn: .constant(true))
  }
}
