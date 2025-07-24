//
//  JCRetryView.swift
//  JCSwiftUIWedgets
//
//  Created by James Chen on 2022/12/13.
//

import SwiftUI

// Editing config.shared ensures that this component looks the same wherever it is used.
// Or have a new Config() to make it special.
public struct JCRetryViewConfig {
  public static let shared = JCRetryViewConfig()

  public var spacing: CGFloat = 20

  public var icon: (some View)? = Image(systemName: "info.circle").mask(color: JCThemeColor.primary)

  public var errorTitle: String = "Network Error"
  public var errorTitleFont: Font = JCThemeFont.L
  public var errorTitleColor: Color = JCThemeColor.primary

  public var errorMessageMaxWidth = UIScreen.main.bounds.width - 80
  public var errorMessage: String = "Please check your network environment, and retry later."
  public var errorMessageFont: Font = JCThemeFont.M
  public var errorMessageColor: Color = JCThemeColor.secondary

  public var retryButtonTitle: String = "Retry"

  public var retryButtonStyle = JCButtonStyle.FixedSizeRounded(width: 78, height: 40)
}

public struct JCRetryView: View {
  public init(isloading: Bool,
              retryClicked: (() -> Void)? = nil,
              config: JCRetryViewConfig = JCRetryViewConfig.shared) {
    self.isloading = isloading
    self.retryClicked = retryClicked
    self.config = config
  }

  public var body: some View {
    ZStack {
      JCThemeColor.background
      if isloading {
        JCLoadingView()
      } else {
        VStack(spacing: config.spacing) {
          HStack {
            if let icon = config.icon {
              icon
            }
            Text(config.errorTitle)
              .font(config.errorTitleFont)
              .foregroundColor(config.errorTitleColor)
              .multilineTextAlignment(.center)
          }
          Text(config.errorMessage)
            .frame(maxWidth: config.errorMessageMaxWidth)
            .font(config.errorMessageFont)
            .foregroundColor(config.errorMessageColor)
            .multilineTextAlignment(.center)
          Button {
            retryClicked?()
          } label: {
            Text(config.retryButtonTitle)
          }
          .buttonStyle(config.retryButtonStyle)
          .padding(.top)
        }
      }
    }
  }

  private var isloading: Bool = false
  private var retryClicked: (() -> Void)?
  private var config = JCRetryViewConfig.shared
}

#Preview {
  VStack {
    JCRetryView(isloading: false)
  }.background(Color.gray)
}
