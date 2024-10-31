Pod::Spec.new do |s|
  s.name         = 'vlc-player'
  s.version      = '1.1.2'
  s.summary      = 'Stream player'
  s.description  = <<-DESC
                    vlc-player is a lightweight and modular library written in Swift.
                  DESC
  s.homepage     = 'https://github.com/IgorFedorchuk/vlc-player'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'Igor Fedorchuk' => 'fedorchukjob@gmail.com' }
  s.source       = { :git => 'https://github.com/IgorFedorchuk/vlc-player.git', :tag => s.version.to_s }
  s.ios.deployment_target = '12.0'
  s.swift_version = '5.0'

  s.source_files  = 'Sources/**/*.{swift,h,m}'
  s.dependency 'MobileVLCKit', '3.6.0'
end

