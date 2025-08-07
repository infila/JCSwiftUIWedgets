//
//  JCToggle.swift
//  JCSwiftUIWedgets
//
//  Created by James Chen on 2022/12/23.
//

import SwiftUI

// Editing appearance.shared ensures that this component looks the same wherever it is used.
// Or have a new Appearance() to make it special.
public class JCToggleAppearance {
  public static let shared = JCToggleAppearance()

  public init(width: CGFloat = 52,
              height: CGFloat = 32,
              thumbHeight: CGFloat = 28,
              thumbOffsetFromCenter: CGFloat = 10,
              backgroundColor: JCColorPair = JCColorPair(normal: JCThemeColor.separateLine,
                                                         highlight: .white,
                                                         disabled: .gray.opacity(0.3)),
              foregroundColor: JCColorPair = JCColorPair(normal: JCThemeColor.navigationBar,
                                                         highlight: JCThemeColor.success,
                                                         disabled: .gray.opacity(0.5)),
              borderColor: JCColorPair = JCColorPair(normal: JCThemeColor.success,
                                                     highlight: JCThemeColor.success,
                                                     disabled: .clear)) {
    self.width = width
    self.height = height
    self.thumbHeight = thumbHeight
    self.thumbOffsetFromCenter = thumbOffsetFromCenter
    self.backgroundColor = backgroundColor
    self.foregroundColor = foregroundColor
    self.borderColor = borderColor
  }

  public var width: CGFloat
  public var height: CGFloat
  public var thumbHeight: CGFloat
  public var thumbOffsetFromCenter: CGFloat

  public var backgroundColor: JCColorPair
  public var foregroundColor: JCColorPair
  public var borderColor: JCColorPair
}

public struct JCToggle: View {
  public init(isOn: Binding<Bool>,
              onChange: ((Bool) -> Void)? = nil,
              appearance: JCToggleAppearance = JCToggleAppearance.shared) {
    _isOn = isOn
    self.onChange = onChange
    self.appearance = appearance
  }

  public var body: some View {
    ZStack {
      Capsule()
        .fill(!isEnabled ? appearance.backgroundColor.disabled : (isOn ? appearance.backgroundColor.highlight : appearance.backgroundColor.normal))
        .overlay(
          Capsule().stroke(!isEnabled ? appearance.borderColor.disabled : (isOn ? appearance.borderColor.highlight : appearance.borderColor.normal), lineWidth: 1)
        )

      Circle()
        .fill(!isEnabled ? appearance.foregroundColor.disabled : (isOn ? appearance.foregroundColor.highlight : appearance.foregroundColor.normal))
        .frame(height: appearance.thumbHeight)
        .offset(x: isOn ? appearance.thumbOffsetFromCenter : -appearance.thumbOffsetFromCenter)
    }
    .frame(width: appearance.width, height: appearance.height)
    .onTapGesture {
      withAnimation {
        isOn.toggle()
      }
      onChange?(isOn)
    }
  }

  @Binding private var isOn: Bool
  private var onChange: ((Bool) -> Void)?
  private var appearance: JCToggleAppearance
  @Environment(\.isEnabled) private var isEnabled
}

#Preview {
  struct PreviewWrapper: View {
    @State private var isOn1 = true
    @State private var isOn2 = false

    let ToggleStyle2 = JCToggleAppearance(width: 72, height: 36, thumbHeight: 28, thumbOffsetFromCenter: 16)

    var body: some View {
      VStack {
        JCToggle(isOn: $isOn1)
        JCToggle(isOn: $isOn2)
        JCToggle(isOn: $isOn2, appearance: ToggleStyle2)
          .disabled(true)
      }
    }
  }

  return PreviewWrapper()
}
