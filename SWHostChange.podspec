Pod::Spec.new do |s|

  s.name         = "SWHostChange"

  s.version      = "0.0.2"

  s.homepage      = 'https://github.com/zhoushaowen/SWHostChange'

  s.ios.deployment_target = '8.0'

  s.summary      = "摇一摇切换项目中的Host"

  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author       = { "Zhoushaowen" => "348345883@qq.com" }

  s.source       = { :git => "https://github.com/zhoushaowen/SWHostChange.git", :tag => s.version }
  
  s.source_files  = "SWHostChange/SWHostChange/*.{h,m}"

  s.dependency 'SWCustomPresentation'
  
  s.requires_arc = true

end
