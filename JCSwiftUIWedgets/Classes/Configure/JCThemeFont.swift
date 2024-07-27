//
//  JCThemeFont.swift
//  JCSwiftUIWedgets
//
//  Created by James Chen on 2023/10/20.
//

import SwiftUI

public struct JCThemeFont {
  // font weight regular = 400, medium = 500
  public static let shared = JCThemeFont()

  public var navigationTitle: Font = Font.system(size: 20, weight: .medium)
  public var barbutton: Font = Font.system(size: 9)

  public var title: Font = Font.system(size: 20, weight: .medium)
  public var subTitle: Font = Font.system(size: 14)
  public var content: Font = Font.system(size: 17)

  public var XXS: Font = Font.system(size: 9)
  public var XS: Font = Font.system(size: 11)
  public var S: Font = Font.system(size: 14)
  public var M: Font = Font.system(size: 17)
  public var L: Font = Font.system(size: 20)
  public var XL: Font = Font.system(size: 24, weight: .medium)
  public var XXL: Font = Font.system(size: 28, weight: .medium)
}
