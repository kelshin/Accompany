# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Accompany' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Accompany
  pod 'SnapKit', '~> 5.0.0'
  pod 'Gallery'
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        # Force CocoaPods targets to always build for x86_64
        config.build_settings['ARCHS[sdk=iphonesimulator*]'] = 'x86_64'
      end
    end
  end
end

都知道