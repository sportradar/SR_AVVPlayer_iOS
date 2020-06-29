AVVPlayer-MARVIN-iOS
===================
#  Changelog
------

## v0.9.14 (@2020-06-29)

- renames Framework/Module from AVVPlayer to SRAVVPlayer
- deploys SRAVVPlayer as xcframework

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
