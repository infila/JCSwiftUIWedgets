//
//  JCImagePickerSheet.swift
//  JCSwiftUIWedgets
//
//  Created by James Chen on 2023/1/12.
//

import AVFoundation
import SwiftUI

let SAFE_AREA_INSETS = UIApplication.shared.windows.first?.safeAreaInsets ?? UIEdgeInsets()

public extension View {
  func showImagePickerSheet(_ isPresented: Binding<Bool>, onImageSelected: @escaping (UIImage) -> Void) -> some View {
    modifier(JCImagePickerSheetModifier(isPresented: isPresented, onImageSelected: onImageSelected))
  }
}

struct JCImagePickerSheetModifier: ViewModifier {
  @Binding var isPresented: Bool
  var onImageSelected: (UIImage) -> Void

  @ViewBuilder
  func body(content: Content) -> some View {
    ZStack {
      content.disabled(isPresented)
      if isPresented {
        JCImagePickerSheet(isPresented: $isPresented) { image in
          self.onImageSelected(image)
        }
      }
    }
  }
}

// Editing appearance.shared ensures that this component looks the same wherever it is used.
// Or have a new Appearance() to make it special.
public class JCImagePickerSheetAppearance {
  public static let shared = JCImagePickerSheetAppearance()

  public var grantCameraPermissionString = "Grant camera permission"
  public var takePhotoIcon: Image = Image(systemName: "camera")
  public var takePhotoString = "Take a Photo"
  public var chooseFromAlbumIcon: Image = Image(systemName: "photo.on.rectangle.angled")
  public var chooseFromAlbumString = "Choose From Album"

  public var overlayColor: Color = Color.gray.opacity(0.5)
  public var sheetHeight: CGFloat = 178
  public var backgroundColor = Color(withHex: "F0F0F0")
  public var foregroundColor = Color(withHex: "#333333")

  public var leftMargin: CGFloat = 32
  public var buttonHeight: CGFloat = 64
  public var buttonStyle: AnyButtonStyle = AnyButtonStyle(JCButtonStyle.HighlightStyle(backgroundColor: JCColorPair(normal: Color.clear, highlight: Color(withHex: "#CCCCCC"))))
}

public struct JCImagePickerSheet: View {
  @Binding var isPresented: Bool

  public var didSelectImage: (UIImage) -> Void

  public var appearance = JCImagePickerSheetAppearance.shared

  @State private var isStarted = false
  @State private var showImagePicker = false
  @State private var sourceType: UIImagePickerController.SourceType = .camera

  public var body: some View {
    ZStack(alignment: .bottom) {
      appearance.overlayColor.opacity(isStarted ? 1 : 0)
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
          isPresented = false
        }
      VStack {
        Spacer()
        VStack(spacing: 0) {
          Capsule()
            .foregroundColor(appearance.foregroundColor)
            .frame(width: 32, height: 2)
            .padding(12)
          Button {
            if IsCameraDenied() {
              GoToSystemSettingScreen()
              return
            }
            sourceType = .camera
            showImagePicker = true
          } label: {
            HStack {
              appearance.takePhotoIcon
                .mask(color: appearance.foregroundColor)
                .padding([.leading], appearance.leftMargin)
              Text(IsCameraDenied() ? appearance.grantCameraPermissionString : appearance.takePhotoString)
                .foregroundColor(appearance.foregroundColor)
                .font(JCThemeFont.M)
              Spacer()
            }
            .frame(height: appearance.buttonHeight)
          }
          .buttonStyle(appearance.buttonStyle)
          Button {
            sourceType = .photoLibrary
            showImagePicker = true
          } label: {
            HStack {
              appearance.chooseFromAlbumIcon
                .mask(color: appearance.foregroundColor)
                .padding([.leading], appearance.leftMargin)
              Text(appearance.chooseFromAlbumString)
                .foregroundColor(appearance.foregroundColor)
                .font(JCThemeFont.M)
              Spacer()
            }
            .frame(height: appearance.buttonHeight)
          }
          .buttonStyle(appearance.buttonStyle)
          Spacer()
        }
        .frame(height: appearance.sheetHeight + SAFE_AREA_INSETS.bottom)
        .background(appearance.backgroundColor)
        .cornerRadius(8, corners: [.topLeft, .topRight])
      }.offset(y: isStarted ? 0 : appearance.sheetHeight + SAFE_AREA_INSETS.bottom)
    }.edgesIgnoringSafeArea(.all)
      .onAppear {
        withAnimation {
          isStarted = true
        }
      }.sheet(isPresented: $showImagePicker) {
        JCImagePicker(sourceType: $sourceType) { image in
          didSelectImage(image)
          isPresented = false
        }
        .edgesIgnoringSafeArea(.all)
      }
  }

  func IsCameraDenied() -> Bool {
    let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
    return authStatus == .denied
  }

  func GoToSystemSettingScreen() {
    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
  }
}

#Preview {
  JCImagePickerSheet(isPresented: .constant(true)) { _ in
  }
}
