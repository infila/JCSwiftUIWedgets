//
//  JCThemeColor.swift
//  JCSwiftUIWedgets
//
//  Created by James Chen on 2023/10/20.
//

import SwiftUI

public struct JCThemeColor {
  static let shared = JCThemeColor()

  var primary: Color = Color(withHex: "#B31942") // red
  var secondary: Color = Color(withHex: "#0A3161") // blue

  var background: Color = Color(withHex: "#F0F0F0")
  var navigationBar: Color = Color(withHex: "#FFFFFF")
  var separateLine: Color = Color(withHex: "#dfdfdf")

  var success: Color = .green
  var error: Color = .red
  var warning: Color = .yellow
  var clear: Color = .clear

  var textPrimary: Color = .black
  var textSecondary: Color = .secondary

  var buttonPrimary = JCColorPair(normal: .green, pressed: .green.opacity(0.7))
  var buttonPrimaryBorder = JCColorPair(normal: .blue.opacity(0.5), pressed: .blue.opacity(0.7))
  var buttonPrimaryText = JCColorPair(normal: .white, pressed: .white)

  var buttonSecondary = JCColorPair(normal: .gray.opacity(0.3), pressed: .gray.opacity(0.7))
  var buttonSecondaryBorder = JCColorPair(normal: .secondary, pressed: .secondary.opacity(0.5))
  var buttonSecondaryText = JCColorPair(normal: .black, pressed: .secondary)

  var sheetBackground = Color(withHex: "#212121")
  var sheetForeground = Color(withHex: "#757575")
}
