//
//  JCMessageBox.swift
//  JCSwiftUIWedgets
//
//  Created by James Chen on 2022/11/7.
//

import SwiftUI

// Editing appearance.shared ensures that this component looks the same wherever it is used.
// Or have a new Appearance() to make it special.
public class JCMessageBoxAppearance {
  public static let shared: JCMessageBoxAppearance = JCMessageBoxAppearance()

  public var boxWidth: CGFloat = UIScreen.main.bounds.width / 3 * 2
  public var boxHeight: CGFloat = UIScreen.main.bounds.width / 2

  public var backgroundColor: Color = JCThemeColor.separateLine.opacity(0.75)

  public var boxBackgroundColor: Color = JCThemeColor.textPrimary.opacity(0.9)

  public var cornerRadius: CGFloat = 12

  public var textColor: Color = JCThemeColor.navigationBar
  public var font: Font = JCThemeFont.navigationTitle
  public var alignment: TextAlignment = .center

  public init(boxWidth: CGFloat = UIScreen.main.bounds.width / 3 * 2,
              boxHeight: CGFloat = UIScreen.main.bounds.width / 2,
              backgroundColor: Color = JCThemeColor.separateLine.opacity(0.75),
              boxBackgroundColor: Color = JCThemeColor.textPrimary.opacity(0.9),
              cornerRadius: CGFloat = 12,
              textColor: Color = JCThemeColor.navigationBar,
              font: Font = JCThemeFont.navigationTitle,
              alignment: TextAlignment = .center) {
    self.boxWidth = boxWidth
    self.boxHeight = boxHeight
    self.backgroundColor = backgroundColor
    self.boxBackgroundColor = boxBackgroundColor
    self.cornerRadius = cornerRadius
    self.textColor = textColor
    self.font = font
    self.alignment = alignment
  }
}

public struct JCMessageBox: View {
  public init(message: String, appearance: JCMessageBoxAppearance = JCMessageBoxAppearance.shared) {
    self.message = message
    self.appearance = appearance
  }

  public var body: some View {
    ZStack {
      appearance.backgroundColor
        .edgesIgnoringSafeArea(.all)
      appearance.boxBackgroundColor
        .frame(width: appearance.boxWidth, height: appearance.boxHeight)
        .cornerRadius(appearance.cornerRadius)
      Text(message)
        .multilineTextAlignment(appearance.alignment)
        .frame(maxWidth: appearance.boxWidth - 20, maxHeight: appearance.boxHeight - 20)
        .font(appearance.font)
        .minimumScaleFactor(0.7)
        .foregroundColor(appearance.textColor)
    }
  }

  private var message: String
  private var appearance: JCMessageBoxAppearance
}

#Preview {
  JCMessageBox(message: "Message box with a long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long Message")
}
