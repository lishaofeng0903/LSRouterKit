Pod::Spec.new do |s|

  s.name         = "LSRouterKit"
  s.version      = "1.0.0"
  s.summary      = "iOS路由工具LSRouterKit"

  s.description  = <<-DESC
			iOS路由工具
                   DESC

  s.homepage     = "https://github.com/lishaofeng0903/LSRouterKit"
  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  s.author             = { "lishaofeng0903" => "571366363@qq.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/lishaofeng0903/LSRouterKit.git", :tag => "#{s.version}" }
  s.source_files  = "LSRouterKit", "LSRouterKit/*.{h,m}"
  s.requires_arc = true

end
