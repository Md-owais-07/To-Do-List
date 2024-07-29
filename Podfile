# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'To-Do List' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for To-Do List
  pod 'IQKeyboardManager' #iOS13 and later
  pod 'FirebaseAuth'
  pod 'FirebaseFirestore'
  pod 'FirebaseCore'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 13.0
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      end
    end

    if ['GoogleUtilities'].include? target.name
      target.build_configurations.each do |config|
        Dir.glob("#{installer.sandbox.root}/GoogleUtilities/**/*.h").each do |header|
          begin
            text = File.read(header)
            new_contents = text.gsub(/#import <(.*)>/, '#import "\1"')
            File.open(header, "w") { |file| file.puts new_contents }
          rescue => e
            puts "Failed to process #{header}: #{e.message}"
          end
        end
      end
    end
  end
end








