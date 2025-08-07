//
//  JCButtonStyle.swift
//  JCSwiftUIWedgets
//
//  Created by James Chen on 2022/10/19.
//

import SwiftUI

// Type Erasure Structor
public struct AnyButtonStyle: ButtonStyle {
  private let _makeBody: (Configuration) -> any View

  public init<Style: ButtonStyle>(_ style: Style) {
    _makeBody = { configuration in
      style.makeBody(configuration: configuration)
    }
  }

  public func makeBody(configuration: Configuration) -> some View {
    AnyView(_makeBody(configuration))
  }
}

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
    @Environment(\.isEnabled) private var isEnabled

    public func makeBody(configuration: Self.Configuration) -> some View {
      configuration.label
        .frame(width: width, height: height)
        .font(textFont)
        .background(RoundedRectangle(cornerSize: CGSize(width: cornerRadius, height: cornerRadius))
          .strokeBorder((!isEnabled ? strokeColor?.disabled : configuration.isPressed ? strokeColor?.highlight : strokeColor?.normal) ?? JCThemeColor.clear, lineWidth: strokeColor == nil ? 0 : strokeWidth)
          .background(!isEnabled ? backgroundColor.disabled : configuration.isPressed ? backgroundColor.highlight : backgroundColor.normal)
          .clipped())
        .foregroundColor(!isEnabled ? textColor.disabled : configuration.isPressed ? textColor.highlight : textColor.normal)
        .cornerRadius(cornerRadius, corners: .allCorners)
    }

    public init(width: CGFloat,
                height: CGFloat,
                cornerRadius: CGFloat = 12,
                textFont: Font = JCThemeFont.L,
                textColor: JCColorPair = JCThemeColor.buttonPrimaryText,
                backgroundColor: JCColorPair = JCThemeColor.buttonPrimary,
                strokeColor: JCColorPair? = JCThemeColor.buttonPrimaryBorder,
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
    @Environment(\.isEnabled) private var isEnabled

    public func makeBody(configuration: Self.Configuration) -> some View {
      configuration.label
        .font(textFont)
        .frame(width: width, height: height)
        .background(
          !isEnabled ? LinearGradient(colors: colors.map({ $0.disabled }), startPoint: .topLeading, endPoint: .bottomTrailing) : configuration.isPressed ?
            LinearGradient(colors: colors.map({ $0.highlight }), startPoint: .topLeading, endPoint: .bottomTrailing) :
            LinearGradient(colors: colors.map({ $0.normal }), startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .foregroundColor(!isEnabled ? textColor.disabled : (configuration.isPressed ? textColor.highlight : textColor.normal))
        .cornerRadius(cornerRadius, corners: .allCorners)
    }

    public init(width: CGFloat,
                height: CGFloat,
                textFont: Font = JCThemeFont.L,
                textColor: JCColorPair = JCThemeColor.buttonPrimaryText,
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
    @Environment(\.isEnabled) private var isEnabled

    public func makeBody(configuration: Self.Configuration) -> some View {
      configuration.label
        .font(textFont)
        .foregroundColor(!isEnabled ? textColor.disabled : configuration.isPressed ? textColor.highlight : textColor.normal)
        .background(!isEnabled ? textColor.disabled : configuration.isPressed ? backgroundColor.highlight : backgroundColor.normal)
    }

    public init(textFont: Font = JCThemeFont.M,
                textColor: JCColorPair = JCThemeColor.buttonPrimaryText,
                backgroundColor: JCColorPair = JCThemeColor.buttonSecondary) {
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
    textColor: JCThemeColor.buttonSecondaryText,
    backgroundColor: JCThemeColor.buttonSecondary,
    strokeColor: JCThemeColor.buttonSecondaryBorder
  )
  static let loginButtonStyle = JCButtonStyle.FixedSizeRounded(
    width: 270,
    height: 52,
    textColor: JCColorPair(normal: .white, highlight: .white, disabled: .white.opacity(0.7)),
    backgroundColor: JCColorPair(normal: .yellow, highlight: .yellow.opacity(0.5)),
    strokeColor: JCColorPair(normal: .yellow, highlight: .orange)
  )

  static let regularButtonStyle = JCButtonStyle.FixedSizeRounded(
    width: 66,
    height: 40,
    cornerRadius: 8,
    textFont: JCThemeFont.S,
    textColor: JCColorPair(normal: .white, highlight: .white, disabled: .white.opacity(0.7)),
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
//    .disabled(true)

    Button("RoundedCorner.secondary") {
      print("Button Clicked")
    }
    .buttonStyle(JCButtonStyle.FixedSizeRounded.secondary)
    //    .disabled(true)

    Button("Login") {
      print("Button Clicked")
    }
    .buttonStyle(JCButtonStyle.FixedSizeRounded.loginButtonStyle)
//    .disabled(true)

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
//    .disabled(true)

    HStack(spacing: 4) {
      Image(systemName: "pencil.circle")
      Text("Edit")
    }
    .buttonWrapped {
      print("Button Clicked")
    }
    .buttonStyle(JCButtonStyle.FixedSizeRounded.regularButtonStyle)
//        .disabled(true)
  }
  .frame(maxWidth: .infinity, maxHeight: .infinity)
  .background(JCThemeColor.background)
}
