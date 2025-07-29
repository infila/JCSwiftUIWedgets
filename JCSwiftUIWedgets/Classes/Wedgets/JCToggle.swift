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
  public var thumbHeight: CGFloat = 28
  public var thumbOffsetFromCenter: CGFloat = 10

  public var backgroundColor = JCColorPair(normal: JCThemeColor.success.opacity(0.3),
                                           highlight: JCThemeColor.success.opacity(0.1),
                                           disabled: .gray.opacity(0.3))
  public var foregroundColor = JCColorPair(normal: JCThemeColor.navigationBar,
                                           highlight: JCThemeColor.success,
                                           disabled: .gray.opacity(0.5))
  public var borderColor = JCColorPair(normal: JCThemeColor.success,
                                       highlight: JCThemeColor.success,
                                       disabled: .clear)
}

public struct JCToggle: View {
  public init(isOn: Binding<Bool>,
              onChange: ((Bool) -> Void)? = nil,
              config: JCToggleConfig = JCToggleConfig.shared) {
    _isOn = isOn
    self.onChange = onChange
    self.config = config
  }

  public var body: some View {
    ZStack {
      Capsule()
        .fill(!isEnabled ? config.backgroundColor.disabled : (isOn ? config.backgroundColor.highlight : config.backgroundColor.normal))
        .overlay(
          Capsule().stroke(!isEnabled ? config.borderColor.disabled : (isOn ? config.borderColor.highlight : config.borderColor.normal), lineWidth: 1)
        )

      Circle()
        .fill(!isEnabled ? config.foregroundColor.disabled : (isOn ? config.foregroundColor.highlight : config.foregroundColor.normal))
        .frame(height: config.thumbHeight)
        .offset(x: isOn ? config.thumbOffsetFromCenter : -config.thumbOffsetFromCenter)
    }
    .frame(width: config.width, height: config.height)
    .onTapGesture {
      withAnimation {
        isOn.toggle()
      }
      onChange?(isOn)
    }
  }

  @Binding private var isOn: Bool
  private var onChange: ((Bool) -> Void)?
  private var config = JCToggleConfig.shared
  @Environment(\.isEnabled) private var isEnabled
}

#Preview {
  struct PreviewWrapper: View {
    @State private var isOn1 = true
    @State private var isOn2 = false

    let ToggleStyle2 = JCToggleConfig(width: 72, height: 36, thumbHeight: 28, thumbOffsetFromCenter: 16)

    var body: some View {
      JCToggle(isOn: $isOn1)
      JCToggle(isOn: $isOn2)
      JCToggle(isOn: $isOn2, config: ToggleStyle2)
        .disabled(true)
    }
  }

  return PreviewWrapper()
}
