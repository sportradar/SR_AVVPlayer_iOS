Pod::Spec.new do |s|
s.name = 'AVVPlayer-MARVIN'
s.module_name = 'AVVPlayer'
s.version = '0.0.6'
s.swift_version = '4.2'
s.summary = 'AVVPlayer-MARVIN'
s.license = {'type'=>'Sportradar', 'file'=>'SR_AVVPlayer_iOS-0.0.1/LICENSE.txt'}
s.authors = {'Mobile Development Team'=>'dev.apps@laola1.at'}
s.homepage = 'https://mdp.sportradar.com'
s.requires_arc = true
s.framework = 'SystemConfiguration','MobileCoreServices'
s.source = { :http => 'https://avvpl-staging.sportradar.com/dist/ios/latest/AVVPlayer-MARVIN-iOS-0.0.6_7.zip'}


s.platform = :ios, '10.0'
s.ios.deployment_target  = '10.0'
s.libraries = 'z'
s.static_framework = true
s.vendored_frameworks  = 'AVVPlayer-MARVIN-0.0.6/AVVPlayer.framework'
s.dependency 'Alamofire', '~> 5.0.0-beta'
s.dependency 'RxSwift'
s.dependency 'RxCocoa'
s.dependency 'SwiftyXMLParser'
s.dependency 'google-cast-sdk', '~> 4.3'
s.dependency 'SDWebImage'
s.dependency 'GoogleAds-IMA-iOS-SDK', '~> 3.9'
end

