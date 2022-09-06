Pod::Spec.new do |s|
s.name = 'AVVPlayer-MARVIN'
s.module_name = 'SRAVVPlayer'
s.version = '0.9.28'
s.swift_version = '5.0'
s.summary = 'AVVPlayer-MARVIN'
s.license = {'type'=>'Sportradar', 'file'=>'AVVPlayer-MARVIN-0.9.28/LICENSE.txt'}
s.authors = {'Mobile Development Team'=>'dev.apps@laola1.at'}
s.homepage = 'https://mdp.sportradar.com'
s.requires_arc = true
s.framework = 'SystemConfiguration','MobileCoreServices'
s.source = { :http => 'https://github.com/sportradar/SR_AVVPlayer_iOS/raw/master/Framework/AVVPlayer-MARVIN-iOS_tvOS-0.9.28_66.zip'}


s.ios.deployment_target  = '11.0'
s.tvos.deployment_target  = '11.0'
s.libraries = 'z'
s.static_framework = true
s.vendored_frameworks  = 'AVVPlayer-MARVIN-0.9.28/SRAVVPlayer.xcframework'
s.dependency 'RxSwift', '6.5.0'
s.dependency 'RxCocoa', '6.5.0'
s.dependency 'SwiftyXMLParser', '5.6.0'
s.dependency 'SDWebImage', '5.13.2'
s.ios.dependency 'GoogleAds-IMA-iOS-SDK', '3.14.3'
s.ios.dependency 'google-cast-sdk', '4.7.0'
s.ios.dependency 'Protobuf', '3.19.4'

end
