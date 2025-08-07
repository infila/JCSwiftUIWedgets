//
//  JCPageIndicator.swift
//  JCSwiftUIWedgets
//
//  Created by James Chen on 2022/11/2.
//

import SwiftUI

// Editing appearance.shared ensures that this component looks the same wherever it is used.
public class JCPageIndicatorAppearance {
  public static let shared = JCPageIndicatorAppearance()

  public var defaultColor = JCThemeColor.success
  public var selectedColor = JCThemeColor.primary

  public var dotSpacing: CGFloat = 8
  public var dotDiameter: CGFloat = 5

  public init(defaultColor: Color = JCThemeColor.success,
              selectedColor: Color = JCThemeColor.primary,
              dotSpacing: CGFloat = 8,
              dotDiameter: CGFloat = 5) {
    self.defaultColor = defaultColor
    self.selectedColor = selectedColor
    self.dotSpacing = dotSpacing
    self.dotDiameter = dotDiameter
  }
}

public struct JCPageIndicator: View {
  public init(pageIndex: Int,
              total: Int,
              appearance: JCPageIndicatorAppearance = JCPageIndicatorAppearance.shared) {
    self.pageIndex = pageIndex
    self.total = total
    self.appearance = appearance
  }

  public var body: some View {
    HStack(spacing: appearance.dotSpacing) {
      ForEach(0 ..< total, id: \.self) { index in
        if index == pageIndex {
          appearance.selectedColor.frame(width: appearance.dotDiameter, height: appearance.dotDiameter).clipShape(Circle())
        } else {
          appearance.defaultColor.frame(width: appearance.dotDiameter, height: appearance.dotDiameter).clipShape(Circle())
        }
      }
    }
  }

  private var pageIndex: Int
  private var total: Int
  private var appearance: JCPageIndicatorAppearance
}

#Preview {
  JCPageIndicator(pageIndex: 0, total: 5, appearance: JCPageIndicatorAppearance(selectedColor: Color.orange))
    .previewLayout(.fixed(width: 100, height: 10))
}
