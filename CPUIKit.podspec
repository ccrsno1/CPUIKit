#
# Be sure to run `pod lib lint CPUIKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CPUIKit'
  s.version          = '1.0.0'
  s.summary          = 'CPUIKit for ingtube'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/ccrsno1/CPUIKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ccrsno1' => 'qinxu@ingtube.com' }
  s.source           = { :git => 'https://github.com/ccrsno1/CPUIKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'CPUIKit/CPUIKit/**/*.{h,m}'
  
  s.resources    = 'CPUIKit/CPUIKit/**/*.bundle'


  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'Masonry'
   s.dependency 'ReactiveObjC'
   s.dependency 'JSONModel'
   s.dependency 'YYCategories'
   s.dependency 'MJRefresh'
   s.dependency 'SDWebImage'
   s.dependency 'SVProgressHUD'
   s.dependency 'UITextView+Placeholder'

end
