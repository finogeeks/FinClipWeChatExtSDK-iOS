Pod::Spec.new do |s|
  s.name         = "FinAppletWXExt-Min"
  s.version      = "2.43.11"
  s.summary      = "FinApplet wechatExt sdk."
  s.description  = <<-DESC
                    this is FinApplet wechatExt sdk
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
  s.source       = { :http => "https://app.finogeeks.com/finchat/sdk/FinAppletWXExt-Min-2.43.11.zip"  }
  s.vendored_frameworks = "FinAppletWXExt.framework" 
  s.requires_arc = true
  s.libraries = 'c++'
  s.dependency 'FinApplet','2.43.11'
  s.dependency 'WechatOpenSDK'
  s.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
  }
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
end
