
Pod::Spec.new do |s|
  s.name             = 'HYPopoverView'
  s.version          = '0.0.2'
  s.summary          = 'HYPopoverView.'
  s.description      = <<-DESC
自定义的弹出框，类似 UIPopoverPresentationController 
                       DESC

  s.homepage         = 'https://github.com/oceanfive/HYPopoverView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'oceanfive' => '849638313@qq.com' }
  s.source           = { :git => 'https://github.com/oceanfive/HYPopoverView.git', :tag => s.version.to_s }
  s.ios.deployment_target = '7.0'
  s.source_files = 'HYPopoverView/Classes/**/*'
  s.frameworks = 'UIKit'
end
