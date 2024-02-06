

Pod::Spec.new do |spec|
  spec.name         = "TFY_TabBarKit"

  spec.version      = "1.3.2"

  spec.summary      = "底部tabbar工具/分两类一个自定义UIViewController一个系统自带的，把写好的加在系统上处理."

  spec.description  = <<-DESC
                      底部tabbar工具/分两类一个自定义UIViewController一个系统自带的，把写好的加在系统上处理.
                      DESC

  spec.homepage     = "https://github.com/13662049573/TFY_TabBarController"
  
  spec.license      = "MIT"

  spec.platform     = :ios, "13.0"
  
  spec.author       = { "tfyzxc13662049573" => "420144542@qq.com" }
  
  spec.source       = { :git => "https://github.com/13662049573/TFY_TabBarController.git", :tag => spec.version }

  spec.source_files  = "TFY_TabBarController/TFY_TabBarKit/TFY_TabBarKit.h"
  
  spec.subspec 'TFY_SystemTabBar' do |ss|
     ss.source_files  = "TFY_TabBarController/TFY_TabBarKit/TFY_SystemTabBar/**/*.{h,m}"
  end

  spec.frameworks    = "Foundation","UIKit"

  spec.xcconfig      = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include" }
  
  spec.requires_arc = true

end
