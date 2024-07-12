Pod::Spec.new do |s|
  s.name         = "FinAppletWXExt"
  s.version      = "2.44.9-alpha20240712v03"
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
  s.author             = { "finclip" => "contact@finogeeks.com" }
  s.platform     = :ios, "9.0"
  s.ios.deployment_target = "9.0"
  s.source       = { :http => "https://app.finogeeks.com/finchat/sdk/FinAppletWXExt-2.44.9-alpha20240712v03.zip"  }
  s.vendored_frameworks = "FinAppletWXExt.framework" 
  s.requires_arc = true
  s.libraries = 'c++'
  s.dependency 'FinApplet','2.44.9-alpha20240712v03'
  s.dependency 'WechatOpenSDK'
  s.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
  }
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
end
