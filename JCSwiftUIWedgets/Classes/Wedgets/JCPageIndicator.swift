//
//  JCPageIndicator.swift
//  JCSwiftUIWedgets
//
//  Created by James Chen on 2022/11/2.
//

import SwiftUI

// Editing config.shared ensures that this component looks the same wherever it is used.
public struct JCPageIndicatorConfig {
  public static let shared = JCPageIndicatorConfig()

  public var defaultColor = JCThemeColor.success
  public var selectedColor = JCThemeColor.primary

  public var dotSpacing: CGFloat = 8
  public var dotDiameter: CGFloat = 5
}

public struct JCPageIndicator: View {
  public init(pageIndex: Int,
              total: Int,
              config: JCPageIndicatorConfig = JCPageIndicatorConfig.shared) {
    self.pageIndex = pageIndex
    self.total = total
    self.config = config
  }

  public var body: some View {
    HStack(spacing: config.dotSpacing) {
      ForEach(0 ..< total, id: \.self) { index in
        if index == pageIndex {
          config.selectedColor.frame(width: config.dotDiameter, height: config.dotDiameter).clipShape(Circle())
        } else {
          config.defaultColor.frame(width: config.dotDiameter, height: config.dotDiameter).clipShape(Circle())
        }
      }
    }
  }

  private var pageIndex: Int
  private var total: Int
  private var config: JCPageIndicatorConfig
}

#Preview {
  JCPageIndicator(pageIndex: 0, total: 5, config: JCPageIndicatorConfig(selectedColor: Color.orange))
    .previewLayout(.fixed(width: 100, height: 10))
}
