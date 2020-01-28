Pod::Spec.new do |s|
s.name = 'AVVPlayer-MARVIN-Analytics-Bitmovin'
s.module_name = 'AVVPlayer-Analytics-Bitmovin'
s.version = '0.0.8'
s.swift_version = '5.0'
s.summary = 'AVVPlayer-MARVIN-Analytics-Bitmovin'
s.license = {'type'=>'Sportradar', 'file'=>'SR_AVVPlayer_iOS-0.0.1/LICENSE.txt'}
s.authors = {'Mobile Development Team'=>'dev.apps@laola1.at'}
s.homepage = 'https://mdp.sportradar.com'
s.requires_arc = true
s.source = { :http => 'https://github.com/sportradar/SR_AVVPlayer_iOS/raw/master/Framework/Analytics/Bitmovin/AVVPlayer-Analytics-Bitmovin-0.0.1.zip'}


s.platform = :ios, '10.0'
s.ios.deployment_target  = '10.0'
s.dependency 'BitmovinAnalyticsCollector', git: 'https://github.com/bitmovin/bitmovin-analytics-collector-ios.git', tag: '1.10.1'
s.dependency 'BitmovinPlayer', git: 'https://github.com/bitmovin/bitmovin-player-ios-sdk-cocoapod.git', tag: '2.22.0'


end
