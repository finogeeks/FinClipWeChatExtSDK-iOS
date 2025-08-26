Pod::Spec.new do |s|
  s.name         = "FinAppletWXExt"
  s.version      = "_FinAppletWXExt_version_"
  s.summary      = "FinApplet FinAppletWXExt sdk."
  s.description  = <<-DESC
                    this is FinApplet FinAppletWXExt sdk
                   DESC
  s.homepage     = "https://www.finclip.com"
  s.license      = {
    :type => 'Copyright',
    :text => <<-LICENSE
      Copyright 2017 finogeeks.com. All rights reserved.
      LICENSE
  }
  s.author       = { "developer" => "developer@finogeeks.com" }
  s.platform     = :ios, "12.0"
  s.ios.deployment_target = "12.0"
  s.source       = { :http => "https://app.finogeeks.com/finchat/sdk/FinAppletWXExt-_FinAppletWXExt_version_.zip"  }
  s.vendored_frameworks = "FinAppletWXExt.xcframework" 
  s.requires_arc = true
  s.libraries = 'c++'
  s.dependency 'FinApplet','_FinAppletWXExt_version_'
  s.dependency 'WechatOpenSDK-XCFramework', '~> 2.0.5'
end
