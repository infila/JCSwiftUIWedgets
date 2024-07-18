//
//  JCLoadingView.swift
//  JCSwiftUIWedgets
//
//  Created by James Chen on 2022/12/12.
//

import SwiftUI

extension View {
  func showLoading(_ loading: Bool) -> some View {
    modifier(JCLoadingViewModifier(isPresented: loading))
  }
}

struct JCLoadingViewModifier: ViewModifier {
  var isPresented: Bool

  @ViewBuilder
  func body(content: Content) -> some View {
    ZStack {
      content.disabled(isPresented)
      if isPresented {
        JCLoadingView()
      }
    }
  }
}

struct JCLoadingView: View {
  @State private var isAppeared = true
  @State private var isRotated = true

  var backgroundColor = Color.gray

  var body: some View {
    GeometryReader { geo in
      ZStack {
        backgroundColor
          .edgesIgnoringSafeArea(.all)
          .opacity(0.75)
        if isAppeared {
          Circle()
            .trim(from: 0, to: 0.6)
            .stroke(
              JCThemeColor.shared.success,
              lineWidth: 4
            )
            .frame(width: 50, height: 50)
            .rotationEffect(.degrees(isRotated ? 360 : 0))
            .animation(.linear(duration: 1).repeatForever(autoreverses: false))
            .onAppear {
              isRotated = true
            }
        }
      }
      .onAppear {
        if geo.size != .zero {
          isAppeared = true
        }
      }
      .onValueChanged(geo.frame(in: .global)) { _ in
        isAppeared = true
      }
    }
  }
}

struct JCLoadingView_Previews: PreviewProvider {
  static var previews: some View {
    JCLoadingView()
  }
}
