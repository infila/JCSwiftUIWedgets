//
//  JCLoadingView.swift
//  JCSwiftUIWedgets
//
//  Created by James Chen on 2022/12/12.
//

import SwiftUI

public extension View {
  func showLoading(_ loading: Bool) -> some View {
    ZStack {
      self.disabled(loading)
      if loading {
        JCLoadingView()
      }
    }
  }
}

public enum JCLoadingSpin {
  case image(Image)
  case circle(trimEnd: CGFloat, lineWidth: CGFloat, strokeColor: Color, diameter: CGFloat)
}

// Editing appearance.shared ensures that this component looks the same wherever it is used.
// Or have a new Appearance() to make it special.
public class JCLoadingViewConfig {
  public static let shared = JCLoadingViewConfig()

  public var backgroundColor = Color.gray.opacity(0.4)
  public var spin: JCLoadingSpin = JCLoadingSpin.circle(trimEnd: 0.6, lineWidth: 4, strokeColor: JCThemeColor.success, diameter: 50)
}

public struct JCLoadingView: View {
  public init(appearance: JCLoadingViewConfig = JCLoadingViewConfig.shared) {
    self.appearance = appearance
  }

  public var body: some View {
    ZStack {
      appearance.backgroundColor
        .edgesIgnoringSafeArea(.all)

      switch appearance.spin {
      case let .image(image):
        image.rotationEffect(.degrees(isRotated ? 360 : 0))
          .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: isRotated)
          .onAppear {
            isRotated = true
          }
      case let .circle(trimEnd, lineWidth, strokeColor, diameter):
        Circle()
          .trim(from: 0, to: trimEnd)
          .stroke(
            strokeColor,
            lineWidth: lineWidth
          )
          .frame(width: diameter, height: diameter)
          .rotationEffect(.degrees(isRotated ? 360 : 0))
          .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: isRotated)
          .onAppear {
            isRotated = true
          }
      }
    }
  }

  private var appearance: JCLoadingViewConfig
  @State private var isRotated = false
}

#Preview {
  struct PreviewWrapper: View {
    @State var isLoading = false

    var body: some View {
      VStack {
        Text("show loading")
          .buttonWrapped {
            isLoading = true
          }
          .buttonStyle(JCButtonStyle.FixedSizeRounded(width: 160, height: 48))
      }
      .showLoading(isLoading)
    }
  }
  return PreviewWrapper()
}
