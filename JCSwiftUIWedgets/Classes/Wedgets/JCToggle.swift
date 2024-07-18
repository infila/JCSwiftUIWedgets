//
//  JCToggle.swift
//  JCSwiftUIWedgets
//
//  Created by James Chen on 2022/12/23.
//

import SwiftUI

public struct JCToggle: View {
  var tintColor: Color = JCThemeColor.shared.primary
  @Binding var isOn: Bool
  var onChange: ((Bool) -> Void)?

  var width: CGFloat = 52
  var height: CGFloat = 32

  var backgroundColor = JCColorPair(normal: JCThemeColor.shared.separateLine, pressed: JCThemeColor.shared.separateLine)

  var foregroundColor = JCColorPair(normal: JCThemeColor.shared.navigationBar, pressed: JCThemeColor.shared.success)

  public var body: some View {
    ZStack {
      Capsule()
        .fill(isOn ? backgroundColor.pressed : backgroundColor.normal)

      Circle()
        .fill(isOn ? foregroundColor.pressed : foregroundColor.normal)
        .frame(height: height - 8)
        .offset(x: isOn ? 10 : -10)
    }
    .frame(width: width, height: height)
    .onTapGesture {
      withAnimation {
        isOn.toggle()
      }
      onChange?(isOn)
    }
  }
}

struct JCToggle_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      JCToggle(isOn: .constant(false))
      JCToggle(isOn: .constant(true))
    }
  }
}
