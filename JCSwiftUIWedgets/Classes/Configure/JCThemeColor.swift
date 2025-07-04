//
//  JCThemeColor.swift
//  JCSwiftUIWedgets
//
//  Created by James Chen on 2023/10/20.
//

import SwiftUI

public struct JCThemeColor {
  public static var primary: Color = Color(withHex: "#B31942") // red
  public static var secondary: Color = Color(withHex: "#0A3161") // blue

  public static var background: Color = Color(withHex: "#F0F0F0")
  public static var navigationBar: Color = Color(withHex: "#FFFFFF")
  public static var separateLine: Color = Color(withHex: "#dfdfdf")

  public static var success: Color = .green
  public static var error: Color = .red
  public static var warning: Color = .yellow
  public static var clear: Color = .clear

  public static var textPrimary: Color = .black
  public static var textSecondary: Color = .secondary

  public static var buttonPrimary = JCColorPair(normal: .green, highlight: .green.opacity(0.7))
  public static var buttonPrimaryBorder = JCColorPair(normal: .blue.opacity(0.5), highlight: .blue.opacity(0.7))
  public static var buttonPrimaryText = JCColorPair(normal: .white, highlight: .white, disabled: .white.opacity(0.7))

  public static var buttonSecondary = JCColorPair(normal: .gray.opacity(0.3), highlight: .gray.opacity(0.7))
  public static var buttonSecondaryBorder = JCColorPair(normal: .secondary, highlight: .secondary.opacity(0.5))
  public static var buttonSecondaryText = JCColorPair(normal: .black, highlight: .secondary, disabled: .white.opacity(0.7))
}
