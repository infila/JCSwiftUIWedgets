//
//  JCRetryView.swift
//  JCSwiftUIWedgets
//
//  Created by James Chen on 2022/12/13.
//

import SwiftUI

struct JCRetryView: View {
  var isloading: Bool = false
  var errorTitle: String = "Error"
  var errorMessage: String = "Need retry"
  var retryButtonTitle: String = "Retry"
  var retryClicked: (() -> Void)?
  var width = UIScreen.main.bounds.width - 32

  var body: some View {
    ZStack {
      JCThemeColor.shared.background
      if isloading {
        JCLoadingView()
      } else {
        VStack(spacing: 16) {
          Image("info_dark")
          Text(errorTitle)
            .font(JCThemeFont.shared.L)
            .foregroundColor(JCThemeColor.shared.primary)
            .multilineTextAlignment(.center)
          Text(errorMessage)
            .font(JCThemeFont.shared.M)
            .foregroundColor(JCThemeColor.shared.secondary)
            .multilineTextAlignment(.center)
          Button {
            retryClicked?()
          } label: {
            Text(retryButtonTitle)
          }
          .buttonStyle(JCButtonStyle.FixedSizeRounded(width: 64, height: 40))
          .padding(.top)
        }.padding([.trailing, .leading], 20)
      }
    }
  }
}

struct JCRetryView_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      JCRetryView(isloading: true)
    }.background(Color.gray)
  }
}
