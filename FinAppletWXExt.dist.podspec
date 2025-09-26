Pod::Spec.new do |s|
  s.name         = "FinAppletWXExt"
<<<<<<< HEAD
  s.version      = "2.49.10-dev20250925v09"
=======
  s.version      = "2.49.10-dev20250925v10"
>>>>>>> 56dc021d79dc287a1bbd16b4d7e5933935d78a83
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
  s.platform     = :ios, "14.0"
  s.ios.deployment_target = "14.0"
  s.source       = { :http => "https://app.finogeeks.com/finchat/sdk/FinAppletWXExt-2.49.10-dev20250925v10.zip"  }
  s.vendored_frameworks = "FinAppletWXExt.xcframework" 
  s.requires_arc = true
  s.libraries = 'c++'
  s.dependency 'FinApplet','2.49.10-dev20250925v10'
  s.dependency 'WechatOpenSDK-XCFramework', '~> 2.0.5'
end
