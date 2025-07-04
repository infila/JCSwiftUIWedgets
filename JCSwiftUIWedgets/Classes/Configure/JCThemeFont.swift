//
//  JCThemeFont.swift
//  JCSwiftUIWedgets
//
//  Created by James Chen on 2023/10/20.
//

import SwiftUI

public struct JCThemeFont {
  // font weight regular = 400, medium = 500
  public static var navigationTitle: Font = Font.system(size: 20, weight: .medium)
  public static var barbutton: Font = Font.system(size: 9)

  public static var title: Font = Font.system(size: 20, weight: .medium)
  public static var subTitle: Font = Font.system(size: 14)
  public static var content: Font = Font.system(size: 17)

  public static var XXS: Font = Font.system(size: 9)
  public static var XS: Font = Font.system(size: 11)
  public static var S: Font = Font.system(size: 14)
  public static var M: Font = Font.system(size: 17)
  public static var L: Font = Font.system(size: 20)
  public static var XL: Font = Font.system(size: 24, weight: .medium)
  public static var XXL: Font = Font.system(size: 28, weight: .medium)
}
