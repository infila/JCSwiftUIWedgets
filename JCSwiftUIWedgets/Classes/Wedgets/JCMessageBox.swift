//
//  JCMessageBox.swift
//  JCSwiftUIWedgets
//
//  Created by James Chen on 2022/11/7.
//

import SwiftUI

struct JCMessageBox: View {
  var message = "Message box"
  var boxWidth: CGFloat = UIScreen.main.bounds.width / 3 * 2
  var boxHeight: CGFloat = UIScreen.main.bounds.width / 2

  var body: some View {
    ZStack {
      JCThemeColor.shared.separateLine
        .edgesIgnoringSafeArea(.all)
        .opacity(0.75)
      JCThemeColor.shared.textPrimary
        .frame(width: boxWidth, height: boxHeight)
        .opacity(0.9)
        .cornerRadius(12)
      Text(message)
        .multilineTextAlignment(.center)
        .frame(maxWidth: boxWidth - 20)
        .lineLimit(10)
        .font(JCThemeFont.shared.navigationTitle)
        .minimumScaleFactor(0.7)
        .foregroundColor(JCThemeColor.shared.navigationBar)
    }
  }
}

struct JCMessageBox_Previews: PreviewProvider {
  static var previews: some View {
    JCMessageBox()
  }
}
