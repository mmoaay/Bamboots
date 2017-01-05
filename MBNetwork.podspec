#
# Be sure to run `pod lib lint MBNetwork.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Pod	spec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MBNetwork'
  s.version          = '0.2.0'
  s.summary          = 'MBNetwork - Network request can be easier'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'MBNetwork is a network request framework based on Alamofire and ObjectMapper, aiming at making network request easier for business development'

  s.homepage         = 'https://github.com/mmoaay/MBNetwork'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'mmoaay' => 'mmoaay@sina.com' }
  s.source           = { :git => 'https://github.com/mmoaay/MBNetwork.git', :tag => s.version.to_s }
  # s.social_media_url = 'http://weibo.com/smmoaay'

  s.ios.deployment_target = '8.0'

  s.source_files = 'MBNetwork/Classes/**/*'
  s.resources = 'MBNetwork/Assets/**/*'
  
  # s.resource_bundles = {
  #   'MBNetwork' => ['MBNetwork/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Alamofire', '~>4'
  s.dependency 'SwiftProtobuf'
  s.dependency 'AlamofireObjectMapper'
end
