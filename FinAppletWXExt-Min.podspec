Pod::Spec.new do |s|
  s.name         = "FinAppletWXExt-Min"
  s.version      = "2.35.0-alpha20211125v23"
  s.summary      = "FinClip wechatExt sdk."
  s.description  = <<-DESC
                    this is common
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
  s.source       = { :http => "https://app.finogeeks.com/finchat/sdk/FinAppletWXExt-Min-2.35.0-alpha20220402v02.zip"  }
  s.vendored_frameworks = "FinAppletWXExt.framework" 
  s.requires_arc = true
  s.dependency 'FinApplet','2.35.0-alpha20220402v02'
  s.dependency 'WechatOpenSDK'
end
