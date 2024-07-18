//
//  JCButtonStyle.swift
//  JCSwiftUIWedgets
//
//  Created by James Chen on 2022/10/19.
//

import SwiftUI

public struct JCButtonStyle {
  // A fixed-size with rounded corner style
  // see JCButtonStyles_Previews for examples
  struct FixedSizeRounded: ButtonStyle {
    var width: CGFloat
    var height: CGFloat
    var cornerRadius: CGFloat = 16
    var textFont: Font = JCThemeFont.shared.L
    var textColor: JCColorPair = JCColorPair(normal: JCThemeColor.shared.buttonPrimaryText.normal, pressed: JCThemeColor.shared.buttonPrimaryText.pressed)
    var backgroundColor: JCColorPair = JCColorPair(normal: JCThemeColor.shared.buttonPrimary.normal, pressed: JCThemeColor.shared.buttonPrimary.pressed)
    var strokeColor: JCColorPair? = JCColorPair(normal: JCThemeColor.shared.buttonPrimaryBorder.normal, pressed: JCThemeColor.shared.buttonPrimaryBorder.pressed)
    var strokeWidth: CGFloat = 2

    public func makeBody(configuration: Self.Configuration) -> some View {
      configuration.label
        .frame(width: width, height: height)
        .font(textFont)
        .background(RoundedRectangle(cornerSize: CGSize(width: cornerRadius, height: cornerRadius))
          .strokeBorder((configuration.isPressed ? strokeColor?.pressed : strokeColor?.normal) ?? JCThemeColor.shared.clear, lineWidth: strokeColor == nil ? 0 : strokeWidth)
          .background(configuration.isPressed ? backgroundColor.pressed : backgroundColor.normal)
          .clipped())
        .foregroundColor(configuration.isPressed ? textColor.pressed : textColor.normal)
        .cornerRadius(cornerRadius, corners: .allCorners)
    }
  }

  // A fixed-size with gradient background style
  // see JCButtonStyles_Previews for examples
  struct GradientBackground: ButtonStyle {
    var width: CGFloat
    var height: CGFloat
    var textFont: Font = JCThemeFont.shared.L
    var textColor: JCColorPair = JCColorPair(normal: JCThemeColor.shared.buttonPrimaryText.normal,
                                             pressed: JCThemeColor.shared.buttonPrimaryText.pressed)
    var colors: [JCColorPair] = [JCColorPair(normal: Color.purple.opacity(0.7),
                                             pressed: Color.purple.opacity(0.9)),
                                 JCColorPair(normal: Color.blue.opacity(0.7),
                                             pressed: Color.blue.opacity(0.9))]
    var cornerRadius: CGFloat = 16

    public func makeBody(configuration: Self.Configuration) -> some View {
      configuration.label
        .font(textFont)
        .frame(width: width, height: height)
        .background(
          configuration.isPressed ?
            LinearGradient(colors: colors.map({ $0.pressed }), startPoint: .topLeading, endPoint: .bottomTrailing) :
            LinearGradient(colors: colors.map({ $0.normal }), startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .foregroundColor(configuration.isPressed ? textColor.pressed : textColor.normal)
        .cornerRadius(cornerRadius, corners: .allCorners)
    }
  }

  struct HighlightStyle: ButtonStyle {
    var textFont: Font = JCThemeFont.shared.M
    var textColor: JCColorPair = JCColorPair(normal: JCThemeColor.shared.buttonPrimaryText.normal, pressed: JCThemeColor.shared.buttonPrimaryText.pressed)
    var backgroundColor: JCColorPair = JCColorPair(normal: JCThemeColor.shared.buttonSecondary.normal, pressed: JCThemeColor.shared.buttonSecondary.pressed)

    func makeBody(configuration: Self.Configuration) -> some View {
      configuration.label
        .font(textFont)
        .foregroundColor(configuration.isPressed ? textColor.pressed : textColor.normal)
        .background(configuration.isPressed ? backgroundColor.pressed : backgroundColor.normal)
    }
  }
}

// Just for examples
// make your own extension to fit in your project
private extension JCButtonStyle.FixedSizeRounded {
  static let main = JCButtonStyle.FixedSizeRounded(
    width: UIScreen.main.bounds.width - 60,
    height: 55
  )
  static let secondary = JCButtonStyle.FixedSizeRounded(
    width: UIScreen.main.bounds.width - 60,
    height: 55,
    textColor: JCThemeColor.shared.buttonSecondaryText,
    backgroundColor: JCThemeColor.shared.buttonSecondary,
    strokeColor: JCThemeColor.shared.buttonSecondaryBorder
  )
  static let loginButtonStyle = JCButtonStyle.FixedSizeRounded(
    width: 300,
    height: 52,
    textColor: JCColorPair(normal: .white, pressed: .white),
    backgroundColor: JCColorPair(normal: .yellow, pressed: .yellow.opacity(0.5)),
    strokeColor: JCColorPair(normal: .yellow, pressed: .orange)
  )

  static let regularButtonStyle = JCButtonStyle.FixedSizeRounded(
    width: 66,
    height: 40,
    cornerRadius: 8,
    textFont: JCThemeFont.shared.S,
    textColor: JCColorPair(normal: .white, pressed: .white),
    backgroundColor: JCColorPair(normal: .yellow, pressed: .yellow.opacity(0.5)),
    strokeColor: JCColorPair(normal: .yellow, pressed: .orange)
  )
}

struct JCButtonStyles_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 30) {
      Button("RoundedCorner.main") {
        print("Button Clicked")
      }
      .buttonStyle(JCButtonStyle.FixedSizeRounded.main)

      Button("RoundedCorner.secondary") {
        print("Button Clicked")
      }
      .buttonStyle(JCButtonStyle.FixedSizeRounded.secondary)

      Button("RoundedCorner.loginButtonStyle") {
        print("Button Clicked")
      }
      .buttonStyle(JCButtonStyle.FixedSizeRounded.loginButtonStyle)

      Button("GradientBackground") {
        print("Button Clicked")
      }
      .buttonStyle(JCButtonStyle.GradientBackground(width: 220, height: 44))

      HStack(spacing: 4) {
        Image(systemName: "pencil.circle")
        Text("Edit")
      }
      .buttonWrapped {
        print("Button Clicked")
      }
      .buttonStyle(JCButtonStyle.FixedSizeRounded.regularButtonStyle)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(JCThemeColor.shared.background)
  }
}
