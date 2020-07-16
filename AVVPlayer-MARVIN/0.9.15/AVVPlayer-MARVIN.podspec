Pod::Spec.new do |s|
s.name = 'AVVPlayer-MARVIN'
s.module_name = 'SRAVVPlayer'
s.version = '0.9.15'
s.swift_version = '5.0'
s.summary = 'AVVPlayer-MARVIN'
s.license = {'type'=>'Sportradar', 'file'=>'AVVPlayer-MARVIN-0.9.15/LICENSE.txt'}
s.authors = {'Mobile Development Team'=>'dev.apps@laola1.at'}
s.homepage = 'https://mdp.sportradar.com'
s.requires_arc = true
s.framework = 'SystemConfiguration','MobileCoreServices'
s.source = { :http => 'https://github.com/sportradar/SR_AVVPlayer_iOS/raw/master/Framework/AVVPlayer-MARVIN-iOS-0.9.15_47.zip'}


s.platform = :ios, '10.0'
s.ios.deployment_target  = '10.0'
s.libraries = 'z'
s.static_framework = true
s.vendored_frameworks  = 'AVVPlayer-MARVIN-0.9.15/SRAVVPlayer.xcframework'
s.dependency 'RxSwift', '5.1.1'
s.dependency 'RxCocoa', '5.1.1'
s.dependency 'SwiftyXMLParser', '5.0.0'
s.dependency 'google-cast-sdk', '4.4.7'
s.dependency 'SDWebImage', '5.8.3'
s.dependency 'GoogleAds-IMA-iOS-SDK', '3.11.4'
s.dependency 'Protobuf', '3.12.0'

end
