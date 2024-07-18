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

public struct JCImagePickerSheet: View {
  @Binding var isPresented: Bool

  var didSelectImage: (UIImage) -> Void

  var grantCameraPermissionString = "Grant camera permission"
  var takePhotoString = "Take a Photo"
  var takePhotoIcon = Image(systemName: "camera")
  var chooseFromAlbumString = "Choose From Album"
  var chooseFromAlbumIcon = Image(systemName: "photo.on.rectangle.angled")

  @State private var isStarted = false
  @State private var showImagePicker = false
  @State private var sourceType: UIImagePickerController.SourceType = .camera

  private let sheetOffsetY: CGFloat = -12
  private let sheetHeight: CGFloat = 162

  public var body: some View {
    ZStack(alignment: .bottom) {
      JCThemeColor.shared.sheetBackground.opacity(isStarted ? 0.75 : 0)
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
          isPresented = false
        }
      VStack {
        Spacer()
        VStack(spacing: 0) {
          Capsule()
            .foregroundColor(JCThemeColor.shared.sheetForeground)
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
            HStack(spacing: 0) {
              takePhotoIcon
                .padding([.leading, .trailing], 24)
              Text(IsCameraDenied() ? grantCameraPermissionString : takePhotoString)
                .foregroundColor(JCThemeColor.shared.sheetBackground)
                .font(JCThemeFont.shared.M)
              Spacer()
            }
            .frame(height: 64)
          }
          .buttonStyle(JCButtonStyle.HighlightStyle())
          Button {
            sourceType = .photoLibrary
            showImagePicker = true
          } label: {
            HStack(spacing: 0) {
              chooseFromAlbumIcon
                .padding([.leading, .trailing], 24)
              Text(chooseFromAlbumString)
                .foregroundColor(JCThemeColor.shared.sheetBackground)
                .font(JCThemeFont.shared.M)
              Spacer()
            }
            .frame(height: 64)
          }
          .buttonStyle(JCButtonStyle.HighlightStyle())
          Spacer()
        }
        .frame(height: sheetHeight + SAFE_AREA_INSETS.bottom)
        .background(Color.white)
        .cornerRadius(8, corners: [.topLeft, .topRight])
      }.offset(y: isStarted ? 0 : sheetHeight + SAFE_AREA_INSETS.bottom)
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

struct JCImagePickerSheet_Previews: PreviewProvider {
  static var previews: some View {
    JCImagePickerSheet(isPresented: .constant(true)) { _ in
    }
  }
}
