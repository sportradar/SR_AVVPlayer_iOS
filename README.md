AVVPlayer-MARVIN-iOS
===================
#  Changelog
------

## v0.9.17 (@2020-10-19)

- adds PictureInPicture Mode to iOS (defaultEnabled = true, configure in AVVPlayerConfig.isPicturInPictureEnabled )

- changes in Chromecast Setup for iOS 14 (Check Docs, Info.plist file needs to be modified)
- changes progress slider for HLS livestream (sets liveoffset label to "00:00" if  offset <= 10)

- fixes/refactoring heartbeat (switch between channels)
- fixes "casting" overlay on tvOS (when startet on real device)
- removes restore Button ("try again") after heartbeat validation error on heartbeat type .validateOnly --> no restoring available --> reset config and restart player


Dependencies: 
- SDWebImage v5.9.3 (from v5.8.3)
- RxSwift v5.1.1
- RxCocoa v5.1.1
- Bitmovin Analytics v1.15.0 (from v1.10.1)

[iOS Only]:
- GoogleAds-IMA-iOS-SDK v3.11.4
- google-cast-sdk v4.5.1 (from v4.4.7)
- SwiftyXMLParser v5.0.0
- Protobuf v3.13.0  (from v3.12.0)

------

## v0.9.16 (@2020-09-08)

- supports tvOS

- refactors AVVMediaSession (Decouple Cast SDK)

Dependencies: 
- SDWebImage v5.8.3 (from v5.8.1)
- RxSwift v5.1.1
- RxCocoa v5.1.1
[iOS Only]:
- GoogleAds-IMA-iOS-SDK v3.11.4
- google-cast-sdk v4.4.7
- SwiftyXMLParser v5.0.0
- Protobuf v3.12.0

------

## v0.9.15 (@2020-07-16)

- refactors Chromecast process
- implements heartbeat validation error on http 200 response

------

## v0.9.14 (@2020-06-29)

- renames Framework/Module from AVVPlayer to SRAVVPlayer
- deploys SRAVVPlayer as xcframework (requires cocoapods 1.9)

------

## v0.9.13 (@2020-06-24)

- new licence validation process (adds "domain" to AVVPlayerSetup for OTT customer)
- adds countdown view to Default Preview Layer

- moves AVVMetaData to AVVPlayerConfig (AVVPlayerConfig.MetaData)
- moves AVVPlayerConfig.autoplay  to AVVPlaybackOptions.autoplay
- adds scheduledDate to AVVPlayerConfig.status
- fixes AVVMediaSession issue (crash on access of streamdata)

------

## v0.9.12 (@2020-06-05)

- adds Watermark

- renames AVVLayerTypes

- AVVChromecast improvements/fixes
- fixes release issue of AVVPlayer
- fixes inline mode rotation issue (iPad)

------

## v0.9.11 (@2020-05-29)

- AVVPlayerControlLayerDefault: hides TimeLabels, Option Buttons and ProgressSlider on AVVSizeClass.SmartType.thumb sizeClass of AVVPlayer 
- AVVPlayerControlLayerDefault: adds Promotion Button (shows up as soon as one feature has access denied flag and isPremium == true), triggers feature layer

- fixes presentation of Presentation AVVPlayer on AppDelegate Window orientation restriction

------

## v0.9.10 (@2020-05-22)

- adds custom player messages
- implements AVVFeatureLayerDefault and grant/deny access to airplay and chromecast
- fixes Settings Overlay and Control Overlay constraint issues

------

## v0.9.9

- AVVEndscreen (if configured, shown after Media Session is completed)
- AVVSizeClass with Smart Types (provide responsive layers)
- AVVPlayerConfig properties isLivestream, isLive are moved to AVVPlayerConfig.Status
- SDK is now handling isDelivered status
- Stream status is updated in previewlayer if scheduled date is expired
