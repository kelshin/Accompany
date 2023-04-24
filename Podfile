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



I have demonstrated skills and solid fundamentals and I can add value for your company. I still have a lot to learn but I'm a quick learner, ready to roll up my sleeves and not afraid of challenges. My goal is to grow my iOS skills and learn from the senior developers so that I can provide even more value to your business.