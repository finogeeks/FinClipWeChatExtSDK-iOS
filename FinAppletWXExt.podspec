Pod::Spec.new do |s|
  s.name         = "FinAppletWXExt"
  s.version      = "2.41.0-alpha20230423v02"
  s.summary      = "FinApplet contact sdk."
  s.description  = <<-DESC
                    this is FinApplet contact sdk
                   DESC
  s.homepage     = "https://www.finclip.com"
  s.license      = {
    :type => 'Copyright',
    :text => <<-LICENSE
      Copyright 2017 finogeeks.com. All rights reserved.
      LICENSE
  }
  s.author       = { "developer" => "developer@finogeeks.com" }
  s.platform     = :ios, "9.0"
  s.ios.deployment_target = "9.0"
  s.source       = { :git => "https://gitlab.finogeeks.club/finclipsdk/FinAppletWXExt-ios.git", :tag => s.version.to_s }
  s.source_files  = "FinAppletWXExt/**/*.{h,m,c}"
  s.resources = ['FinAppletWXExt/Resource/*']
  s.static_framework = true
  s.dependency 'FinApplet'
  s.dependency 'WechatOpenSDK'
  s.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
  }
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
end
