//
//  JCRetryView.swift
//  JCSwiftUIWedgets
//
//  Created by James Chen on 2022/12/13.
//

import SwiftUI

// Editing appearance.shared ensures that this component looks the same wherever it is used.
public class JCRetryViewAppearance {
  public static let shared = JCRetryViewAppearance()

  public var spacing: CGFloat = 20

  public var icon: AnyView? = AnyView(Image(systemName: "info.circle").mask(color: JCThemeColor.primary))

  public var errorTitle: String = "Network Error"
  public var errorTitleFont: Font = JCThemeFont.L
  public var errorTitleColor: Color = JCThemeColor.primary

  public var errorMessageWidth: CGFloat = UIScreen.main.bounds.width - 80
  public var errorMessage: String = "Please check your network environment, and retry later."
  public var errorMessageFont: Font = JCThemeFont.M
  public var errorMessageColor: Color = JCThemeColor.secondary

  public var retryButtonTitle: String = "Retry"

  public var retryButtonStyle: AnyButtonStyle = AnyButtonStyle(JCButtonStyle.FixedSizeRounded(width: 78, height: 40))
}

public struct JCRetryView: View {
  public init(isloading: Bool,
              retryClicked: (() -> Void)? = nil,
              appearance: JCRetryViewAppearance = JCRetryViewAppearance.shared) {
    self.isloading = isloading
    self.retryClicked = retryClicked
    self.appearance = appearance
  }

  public var body: some View {
    ZStack {
      JCThemeColor.background
      if isloading {
        JCLoadingView()
      } else {
        VStack(spacing: appearance.spacing) {
          HStack {
            if let icon = appearance.icon {
              icon
            }
            Text(appearance.errorTitle)
              .font(appearance.errorTitleFont)
              .foregroundColor(appearance.errorTitleColor)
              .multilineTextAlignment(.center)
          }
          Text(appearance.errorMessage)
            .frame(width: appearance.errorMessageWidth)
            .font(appearance.errorMessageFont)
            .foregroundColor(appearance.errorMessageColor)
            .multilineTextAlignment(.center)
          Text(appearance.retryButtonTitle)
            .buttonWrapped {
              retryClicked?()
            }
            .buttonStyle(appearance.retryButtonStyle)
            .padding(.top)
        }
        .padding(.horizontal, 20)
      }
    }
    .edgesIgnoringSafeArea(.all)
  }

  private var isloading: Bool = false
  private var retryClicked: (() -> Void)?
  private var appearance: JCRetryViewAppearance
}

#Preview {
  VStack {
    JCRetryView(isloading: false)
  }
  .background(Color.gray)
}
