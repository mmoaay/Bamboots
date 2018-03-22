Pod::Spec.new do |s|
  s.name             = 'Bamboots'
  s.version          = '0.6.0'
  s.summary          = 'Bamboots - Extension 4 Alamofire'
  s.description      = 'Bamboots is a network request framework based on Alamofire and ObjectMapper, aiming at making network request easier for business development'

  s.homepage         = 'https://github.com/mmoaay/Bamboots'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'mmoaay' => 'mmoaay@sina.com' }
  s.source           = { :git => 'https://github.com/mmoaay/Bamboots.git', :tag => s.version.to_s }
  # s.social_media_url = 'http://weibo.com/smmoaay'

  s.ios.deployment_target = '8.0'
  s.default_subspec = 'Core'
  
  # s.resource_bundles = {
  #   'Bamboots' => ['Bamboots/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'

  #s.dependency 'ObjectMapper'
  # s.dependency 'RealmSwift'


  s.subspec 'Core' do |core|
    core.source_files = 'Bamboots/Classes/Core/**/*.swift'
    core.resources = 'Bamboots/Assets/**/*'
    core.dependency 'AlamofireCodable'
    core.dependency 'Alamofire'
  end

  s.subspec 'BambootsProtobuf' do |pb|
    pb.source_files = 'Bamboots/Classes/Protobuf/**/*.swift'
    pb.dependency 'Bamboots/Core', s.version.to_s
    pb.dependency 'SwiftProtobuf', '1.0.2'
  end

end
