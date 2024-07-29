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
  public struct FixedSizeRounded: ButtonStyle {
    public var width: CGFloat
    public var height: CGFloat
    //  cornerRadius should be suitable
    public var cornerRadius: CGFloat
    public var textFont: Font
    public var textColor: JCColorPair
    public var backgroundColor: JCColorPair
    public var strokeColor: JCColorPair?
    public var strokeWidth: CGFloat = 2

    public func makeBody(configuration: Self.Configuration) -> some View {
      configuration.label
        .frame(width: width, height: height)
        .font(textFont)
        .background(RoundedRectangle(cornerSize: CGSize(width: cornerRadius, height: cornerRadius))
          .strokeBorder((configuration.isPressed ? strokeColor?.highlight : strokeColor?.normal) ?? JCThemeColor.shared.clear, lineWidth: strokeColor == nil ? 0 : strokeWidth)
          .background(configuration.isPressed ? backgroundColor.highlight : backgroundColor.normal)
          .clipped())
        .foregroundColor(configuration.isPressed ? textColor.highlight : textColor.normal)
        .cornerRadius(cornerRadius, corners: .allCorners)
    }

    public init(width: CGFloat,
                height: CGFloat,
                cornerRadius: CGFloat = 12,
                textFont: Font = JCThemeFont.shared.L,
                textColor: JCColorPair = JCThemeColor.shared.buttonPrimaryText,
                backgroundColor: JCColorPair = JCThemeColor.shared.buttonPrimary,
                strokeColor: JCColorPair? = JCThemeColor.shared.buttonPrimaryBorder,
                strokeWidth: CGFloat = 2) {
      self.width = width
      self.height = height
      self.cornerRadius = cornerRadius
      self.textFont = textFont
      self.textColor = textColor
      self.backgroundColor = backgroundColor
      self.strokeColor = strokeColor
      self.strokeWidth = strokeWidth
    }
  }

  // A fixed-size with gradient background style
  // see JCButtonStyles_Previews for examples
  public struct GradientBackground: ButtonStyle {
    public var width: CGFloat
    public var height: CGFloat
    public var textFont: Font
    public var textColor: JCColorPair
    public var colors: [JCColorPair]
    public var cornerRadius: CGFloat

    public func makeBody(configuration: Self.Configuration) -> some View {
      configuration.label
        .font(textFont)
        .frame(width: width, height: height)
        .background(
          configuration.isPressed ?
            LinearGradient(colors: colors.map({ $0.highlight }), startPoint: .topLeading, endPoint: .bottomTrailing) :
            LinearGradient(colors: colors.map({ $0.normal }), startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .foregroundColor(configuration.isPressed ? textColor.highlight : textColor.normal)
        .cornerRadius(cornerRadius, corners: .allCorners)
    }

    public init(width: CGFloat,
                height: CGFloat,
                textFont: Font = JCThemeFont.shared.L,
                textColor: JCColorPair = JCThemeColor.shared.buttonPrimaryText,
                colors: [JCColorPair],
                cornerRadius: CGFloat = 16) {
      self.width = width
      self.height = height
      self.textFont = textFont
      self.textColor = textColor
      self.colors = colors
      self.cornerRadius = cornerRadius
    }
  }

  public struct HighlightStyle: ButtonStyle {
    public var textFont: Font
    public var textColor: JCColorPair
    public var backgroundColor: JCColorPair

    public func makeBody(configuration: Self.Configuration) -> some View {
      configuration.label
        .font(textFont)
        .foregroundColor(configuration.isPressed ? textColor.highlight : textColor.normal)
        .background(configuration.isPressed ? backgroundColor.highlight : backgroundColor.normal)
    }

    public init(textFont: Font = JCThemeFont.shared.M,
                textColor: JCColorPair = JCThemeColor.shared.buttonPrimaryText,
                backgroundColor: JCColorPair = JCThemeColor.shared.buttonSecondary) {
      self.textFont = textFont
      self.textColor = textColor
      self.backgroundColor = backgroundColor
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
    width: 270,
    height: 52,
    textColor: JCColorPair(normal: .white, highlight: .white),
    backgroundColor: JCColorPair(normal: .yellow, highlight: .yellow.opacity(0.5)),
    strokeColor: JCColorPair(normal: .yellow, highlight: .orange)
  )

  static let regularButtonStyle = JCButtonStyle.FixedSizeRounded(
    width: 66,
    height: 40,
    cornerRadius: 8,
    textFont: JCThemeFont.shared.S,
    textColor: JCColorPair(normal: .white, highlight: .white),
    backgroundColor: JCColorPair(normal: .yellow, highlight: .yellow.opacity(0.5)),
    strokeColor: JCColorPair(normal: .yellow, highlight: .orange)
  )
}

#Preview {
  VStack(spacing: 20) {
    Button("RoundedCorner.main") {
      print("Button Clicked")
    }
    .buttonStyle(JCButtonStyle.FixedSizeRounded.main)

    Button("RoundedCorner.secondary") {
      print("Button Clicked")
    }
    .buttonStyle(JCButtonStyle.FixedSizeRounded.secondary)

    Button("Login") {
      print("Button Clicked")
    }
    .buttonStyle(JCButtonStyle.FixedSizeRounded.loginButtonStyle)

    // Small button needs suitable cornerRadius to avoid border issue, seems like a System bug
    let width: CGFloat = 44, height: CGFloat = 32
    HStack {
      Button("A small FixedSizeRounded") {
        print("Button Clicked")
      }.buttonStyle(JCButtonStyle.FixedSizeRounded(width: width, height: height, cornerRadius: 8))
      Button("A small FixedSizeRounded") {
        print("Button Clicked")
      }.buttonStyle(JCButtonStyle.FixedSizeRounded(width: width, height: height, cornerRadius: 10))
      Button("A small FixedSizeRounded") {
        print("Button Clicked")
      }.buttonStyle(JCButtonStyle.FixedSizeRounded(width: width, height: height, cornerRadius: 12))
      Button("A small FixedSizeRounded") {
        print("Button Clicked")
      }.buttonStyle(JCButtonStyle.FixedSizeRounded(width: width, height: height, cornerRadius: 14))
      Button("A small FixedSizeRounded") {
        print("Button Clicked")
      }.buttonStyle(JCButtonStyle.FixedSizeRounded(width: width, height: height, cornerRadius: 16))
      Button("A small FixedSizeRounded") {
        print("Button Clicked")
      }.buttonStyle(JCButtonStyle.FixedSizeRounded(width: width, height: height, cornerRadius: 18))
    }

    Button("GradientBackground") {
      print("Button Clicked")
    }
    .buttonStyle(JCButtonStyle.GradientBackground(width: 220, height: 44, colors: [JCColorPair(normal: Color.purple.opacity(0.7),
                                                                                               highlight: Color.purple.opacity(0.9)),
                                                                                   JCColorPair(normal: Color.blue.opacity(0.7),
                                                                                               highlight: Color.blue.opacity(0.9))]))

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
