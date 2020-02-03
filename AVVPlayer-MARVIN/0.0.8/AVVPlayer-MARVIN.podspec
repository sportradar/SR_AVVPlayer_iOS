Pod::Spec.new do |s|
s.name = 'AVVPlayer-MARVIN'
s.module_name = 'AVVPlayer'
s.version = '0.0.8'
s.swift_version = '5.0'
s.summary = 'AVVPlayer-MARVIN'
s.license = {'type'=>'Sportradar', 'file'=>'SR_AVVPlayer_iOS-0.0.1/LICENSE.txt'}
s.authors = {'Mobile Development Team'=>'dev.apps@laola1.at'}
s.homepage = 'https://mdp.sportradar.com'
s.requires_arc = true
s.framework = 'SystemConfiguration','MobileCoreServices'
s.source = { :http => 'https://github.com/sportradar/SR_AVVPlayer_iOS/raw/master/Framework/AVVPlayer-MARVIN-iOS-0.0.8_25.zip'}


s.platform = :ios, '10.0'
s.ios.deployment_target  = '10.0'
s.libraries = 'z'
s.static_framework = true
s.vendored_frameworks  = 'AVVPlayer-MARVIN-0.0.8/AVVPlayer.framework'
s.dependency 'RxSwift', '5.0.0'
s.dependency 'RxCocoa', '5.0.0'
s.dependency 'SwiftyXMLParser', '5.0.0'
s.dependency 'google-cast-sdk', '4.4.5'
s.dependency 'SDWebImage', '5.0.4'
s.dependency 'GoogleAds-IMA-iOS-SDK', '3.9.0'

end
