Pod::Spec.new do |s|
  s.name         = "FinAppletWXExt-Min"
  s.version      = "_FinAppletWXExt_version_"
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
  s.platform     = :ios, '9.0'
  s.ios.deployment_target = '9.0'
  s.source       = { :http => "https://app.finogeeks.com/finchat/sdk/FinAppletWXExt-Min-_FinAppletWXExt_version_.zip"  }
  s.vendored_frameworks = "FinAppletWXExt.framework" 
  s.requires_arc = true
  s.libraries = 'c++'
  s.dependency 'FinApplet','_FinAppletWXExt_version_'
  s.dependency 'WechatOpenSDK-XCFramework', '2.0.4'

  s.pod_target_xcconfig = {
    'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
  }
  s.user_target_xcconfig = {
    'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
  }
end
