//
//  JCColorPair.swift
//  JCSwiftUIWedgets
//
//  Created by James Chen on 2023-07-15.
//

import SwiftUI

public struct JCColorPair {
  public var normal: Color
  public var highlight: Color
  public var disabled: Color

  public init(normal: Color, highlight: Color, disabled: Color = JCThemeColor.separateLine) {
    self.normal = normal
    self.highlight = highlight
    self.disabled = disabled
  }
}
