//
//  JCPageIndicator.swift
//  JCSwiftUIWedgets
//
//  Created by James Chen on 2022/11/2.
//

import SwiftUI

struct JCPageIndicator: View {
  var pageIndex: Int
  var total: Int

  var defaultColor = JCThemeColor.shared.success
  var selectedColor = JCThemeColor.shared.primary

  var body: some View {
    HStack {
        ForEach(0 ..< total, id: \.self) { index in
        if index == pageIndex {
          selectedColor.frame(width: 5, height: 5).clipShape(Circle())
        } else {
          defaultColor.frame(width: 5, height: 5).clipShape(Circle())
        }
      }
    }
  }
}

struct JCPageIndicator_Previews: PreviewProvider {
  static var previews: some View {
    JCPageIndicator(pageIndex: 0, total: 5)
      .previewLayout(.fixed(width: 100, height: 10))
  }
}
