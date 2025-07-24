//
//  JCMessageBox.swift
//  JCSwiftUIWedgets
//
//  Created by James Chen on 2022/11/7.
//

import SwiftUI

// Editing config.shared ensures that this component looks the same wherever it is used.
// Or have a new Config() to make it special.
public struct JCMessageBoxConfig {
  public static let shared: JCMessageBoxConfig = JCMessageBoxConfig()

  public var boxWidth: CGFloat = UIScreen.main.bounds.width / 3 * 2
  public var boxHeight: CGFloat = UIScreen.main.bounds.width / 2

  public var backgroundColor: Color = JCThemeColor.separateLine.opacity(0.75)

  public var boxBackgroundColor: Color = JCThemeColor.textPrimary.opacity(0.9)

  public var cornerRadius: CGFloat = 12

  public var textColor: Color = JCThemeColor.navigationBar
  public var font: Font = JCThemeFont.navigationTitle
  public var alignment: TextAlignment = .center
}

public struct JCMessageBox: View {
  public init(message: String, config: JCMessageBoxConfig = JCMessageBoxConfig.shared) {
    self.message = message
    self.config = config
  }

  public var body: some View {
    ZStack {
      config.backgroundColor
        .edgesIgnoringSafeArea(.all)
      config.boxBackgroundColor
        .frame(width: config.boxWidth, height: config.boxHeight)
        .cornerRadius(config.cornerRadius)
      Text(message)
        .multilineTextAlignment(config.alignment)
        .frame(maxWidth: config.boxWidth - 20, maxHeight: config.boxHeight - 20)
        .font(config.font)
        .minimumScaleFactor(0.7)
        .foregroundColor(config.textColor)
    }
  }

  private var message: String
  private var config: JCMessageBoxConfig
}

#Preview {
  JCMessageBox(message: "Message box with a long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long Message")
}
