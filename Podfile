platform :ios, "9.0"
source 'ssh://git.finogeeks.club/finoapp-ios/DevPods'
source 'ssh://git.finogeeks.club/finoapp-ios/FinPods'
source 'https://cdn.cocoapods.org/'
use_frameworks!

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ENABLE_STRICT_OBJC_MSGSEND'] = 'NO'
#            if config.name == 'Release'
#              config.build_settings['BITCODE_GENERATION_MODE'] = 'bitcode'
#              config.build_settings['ENABLE_BITCODE'] = 'YES'
#            else
#                config.build_settings['BITCODE_GENERATION_MODE'] = 'marker'
#                config.build_settings['ENABLE_BITCODE'] = 'NO'
#            end
#      
#            cflags = config.build_settings['OTHER_CFLAGS'] || ['$(inherited)']
#      
#            if config.name == 'Release'
#                cflags << '-fembed-bitcode'
#            else
#                cflags << '-fembed-bitcode-marker'
#            end
#      
#            config.build_settings['OTHER_CFLAGS'] = cflags
        end
    end
end

inhibit_all_warnings!

target "FinAppletWXExt" do
    project 'FinAppletWXExt.xcodeproj'
    pod 'FinApplet','2.38.0-alpha20220914v03'
    pod 'WechatOpenSDK'
end

