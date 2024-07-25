#
# Be sure to run `pod lib lint JCSwiftUIWedgets.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JCSwiftUIWedgets'
  s.version          = '1.0.0'
  s.summary          = 'Customized SwiftUI Wedgets'

  s.description      = "This framework contains some custom components. Since many native SwiftUI methods do not support iOS 13 or 14, I have written some components to support these versions. And all components support "theme mode", which meaning you only need to modify one config, and the appearance will change everywhere.
"

  s.homepage         = 'https://github.com/James/JCSwiftUIWedgets'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'James' => 'infilachen@gmail.com' }
  s.source           = { :git => 'https://github.com/James/JCSwiftUIWedgets.git', :tag => s.version.to_s }
  s.social_media_url = 'https://www.linkedin.com/in/jameschen5428'

  s.ios.deployment_target = '13.0'

  s.source_files = 'JCSwiftUIWedgets/Classes/**/*'
  
  s.subspec 'SwiftUI+Ext' do |ui|
    ui.source_files = 'JCSwiftUIWedgets/Classes/SwiftUI+Ext/*'
  end

  s.subspec 'Configure' do |ui|
    ui.source_files = 'JCSwiftUIWedgets/Classes/Configure/*'
  end
    
  s.subspec 'Wedgets' do |ui|
    ui.source_files = 'JCSwiftUIWedgets/Classes/Wedgets/*'
  end
    
end