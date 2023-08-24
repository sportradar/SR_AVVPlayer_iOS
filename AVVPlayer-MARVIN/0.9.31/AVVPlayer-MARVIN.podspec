Pod::Spec.new do |s|
s.name = 'AVVPlayer-MARVIN'
s.module_name = 'SRAVVPlayer'
s.version = '0.9.31'
s.swift_version = '5.8'
s.summary = 'AVVPlayer-MARVIN'
s.license = {'type'=>'Sportradar', 'file'=>'AVVPlayer-MARVIN-0.9.31/LICENSE.txt'}
s.authors = {'Mobile Development Team'=>'dev.apps@laola1.at'}
s.homepage = 'https://mdp.sportradar.com'
s.requires_arc = true
s.framework = 'SystemConfiguration','MobileCoreServices'
s.source = { :http => 'https://github.com/sportradar/SR_AVVPlayer_iOS/raw/master/Framework/AVVPlayer-MARVIN-iOS_tvOS-0.9.31_72.zip'}


s.ios.deployment_target  = '13.0'
s.tvos.deployment_target  = '13.0'
s.libraries = 'z'
s.static_framework = true
s.vendored_frameworks  = 'AVVPlayer-MARVIN-0.9.31/SRAVVPlayer.xcframework'
s.dependency 'RxSwift', '6.5.0'
s.dependency 'RxCocoa', '6.5.0'
s.dependency 'SwiftyXMLParser', '5.6.0'
s.dependency 'SDWebImage', '5.14.3'
s.ios.dependency 'GoogleAds-IMA-iOS-SDK', '3.18.4'
s.ios.dependency 'google-cast-sdk', '4.8.0'
s.ios.dependency 'Protobuf', '3.24.1'

end
