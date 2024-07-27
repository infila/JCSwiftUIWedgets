//
//  JCThemeColor.swift
//  JCSwiftUIWedgets
//
//  Created by James Chen on 2023/10/20.
//

import SwiftUI

public struct JCThemeColor {
  public static let shared = JCThemeColor()

  public var primary: Color = Color(withHex: "#B31942") // red
  public var secondary: Color = Color(withHex: "#0A3161") // blue

  public var background: Color = Color(withHex: "#F0F0F0")
  public var navigationBar: Color = Color(withHex: "#FFFFFF")
  public var separateLine: Color = Color(withHex: "#dfdfdf")

  public var success: Color = .green
  public var error: Color = .red
  public var warning: Color = .yellow
  public var clear: Color = .clear

  public var textPrimary: Color = .black
  public var textSecondary: Color = .secondary

  public var buttonPrimary = JCColorPair(normal: .green, highlight: .green.opacity(0.7))
  public var buttonPrimaryBorder = JCColorPair(normal: .blue.opacity(0.5), highlight: .blue.opacity(0.7))
  public var buttonPrimaryText = JCColorPair(normal: .white, highlight: .white)

  public var buttonSecondary = JCColorPair(normal: .gray.opacity(0.3), highlight: .gray.opacity(0.7))
  public var buttonSecondaryBorder = JCColorPair(normal: .secondary, highlight: .secondary.opacity(0.5))
  public var buttonSecondaryText = JCColorPair(normal: .black, highlight: .secondary)
}
