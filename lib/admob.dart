library ads;

///
/// Copyright (C) 2019 Andrious Solutions
///
/// This program is free software; you can redistribute it and/or
/// modify it under the terms of the GNU General Public License
/// as published by the Free Software Foundation; either version 3
/// of the License, or any later version.
///
/// You may obtain a copy of the License at
///
///  http://www.apache.org/licenses/LICENSE-2.0
///
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
///          Created  04 Aug 2019
///
///

import 'package:flutter/widgets.dart' show State;

import 'dart:async' show Future;

import 'package:flutter/foundation.dart';

import 'package:firebase_admob/firebase_admob.dart';

typedef void RewardListener(String rewardType, int rewardAmount);

class Banner extends MobileAds {
  factory Banner({MobileAdListener listener}) {
    _this ??= Banner._(listener);
    return _this;
  }
  static Banner _this;
  Banner._(MobileAdListener listener) : super(listener: listener);

  AdSize _size = AdSize.banner;

  /// Set options to the Banner Ad.
  @override
  Future<bool> set({
    String adUnitId,
    MobileAdTargetingInfo targetInfo,
    List<String> keywords,
    String contentUrl,
    bool childDirected,
    List<String> testDevices,
    bool testing,
    AdSize size,
    double anchorOffset,
    AnchorType anchorType,
  }) {
    super.set(
      adUnitId: adUnitId,
      targetInfo: targetInfo,
      keywords: keywords,
      contentUrl: contentUrl,
      childDirected: childDirected,
      testDevices: testDevices,
      testing: testing,
      anchorOffset: anchorOffset,
      anchorType: anchorType,
    );
    _size = size ?? _size;
    return load(
      show: false,
      adUnitId: adUnitId,
      targetInfo: targetInfo,
      keywords: keywords,
      contentUrl: contentUrl,
      childDirected: childDirected,
      testDevices: testDevices,
      testing: testing,
      anchorOffset: anchorOffset,
      anchorType: anchorType,
    );
  }

  /// Show the Banner Ad.
  @override
  Future<bool> show({
    String adUnitId,
    MobileAdTargetingInfo targetInfo,
    List<String> keywords,
    String contentUrl,
    bool childDirected,
    List<String> testDevices,
    bool testing,
    AdSize size,
    double anchorOffset,
    AnchorType anchorType,
    State state,
  }) {
    if (state != null && !state.mounted) return Future.value(false);

    // Load a new ad if a parameter is passed.
    if ((adUnitId != null && adUnitId.isNotEmpty) ||
        targetInfo != null ||
        (keywords != null && keywords.isNotEmpty) ||
        (contentUrl != null && contentUrl.isNotEmpty) ||
        childDirected != null ||
        (testDevices != null && testDevices.isNotEmpty) ||
        testing != null ||
        size != null ||
        anchorOffset != null ||
        anchorType != null) {
      dispose();
    }
    _size = size ?? _size;

    // The ad is already loaded. Show it now.
    if (_ad != null) {
      _ad.show(
          anchorOffset: anchorOffset ?? _anchorOffset ?? 0.0,
          anchorType: anchorType ?? _anchorType ?? AnchorType.bottom);
      return Future.value(false);
    }

    // Load the ad and show it when loaded.
    return load(
      show: true,
      adUnitId: adUnitId,
      targetInfo: targetInfo,
      keywords: keywords,
      contentUrl: contentUrl,
      childDirected: childDirected,
      testDevices: testDevices,
      testing: testing,
      anchorOffset: anchorOffset,
      anchorType: anchorType,
    );
  }

  @override
  _createAd({bool testing, String adUnitId, MobileAdTargetingInfo targetInfo}) {
    return BannerAd(
      adUnitId: testing
          ? BannerAd.testAdUnitId
          : adUnitId.isEmpty ? BannerAd.testAdUnitId : adUnitId.trim(),
      size: _size,
      targetingInfo: targetInfo,
    );
  }
}

class FullScreenAd extends MobileAds {
  factory FullScreenAd({MobileAdListener listener}) {
    _this ??= FullScreenAd._(listener);
    return _this;
  }
  static FullScreenAd _this;
  FullScreenAd._(MobileAdListener listener) : super(listener: listener);

  /// Set options for the Interstitial Ad
  // Uses super.set();
  @override
  Future<bool> set({
    String adUnitId,
    MobileAdTargetingInfo targetInfo,
    List<String> keywords,
    String contentUrl,
    bool childDirected,
    List<String> testDevices,
    bool testing,
    double anchorOffset,
    AnchorType anchorType,
  }) {
    super.set(
      adUnitId: adUnitId,
      targetInfo: targetInfo,
      keywords: keywords,
      contentUrl: contentUrl,
      childDirected: childDirected,
      testDevices: testDevices,
      testing: testing,
      anchorOffset: anchorOffset,
      anchorType: anchorType,
    );
    return load(
      show: false,
      adUnitId: adUnitId,
      targetInfo: targetInfo,
      keywords: keywords,
      contentUrl: contentUrl,
      childDirected: childDirected,
      testDevices: testDevices,
      testing: testing,
      anchorOffset: anchorOffset,
      anchorType: anchorType,
    );
  }

  /// Display the Interstitial Ad.
  @override
  Future<bool> show({
    String adUnitId,
    MobileAdTargetingInfo targetInfo,
    List<String> keywords,
    String contentUrl,
    bool childDirected,
    List<String> testDevices,
    bool testing,
    double anchorOffset,
    AnchorType anchorType,
    State state,
  }) {
    // Don't bother if the app is terminating.
    if (state != null && !state.mounted) return Future.value(false);

    // Load a new ad if a parameter is passed.
    if ((adUnitId != null && adUnitId.isNotEmpty) ||
        targetInfo != null ||
        (keywords != null && keywords.isNotEmpty) ||
        (contentUrl != null && contentUrl.isNotEmpty) ||
        childDirected != null ||
        (testDevices != null && testDevices.isNotEmpty) ||
        testing != null ||
        anchorOffset != null ||
        anchorType != null) {
      dispose();
    }

    // The ad is already loaded. Show it now.
    if (_ad != null) {
      _ad.show(
          anchorOffset: anchorOffset ?? _anchorOffset ?? 0.0,
          anchorType: anchorType ?? _anchorType ?? AnchorType.bottom);
      return Future.value(false);
    }

    // Load the ad and show it when loaded.
    return load(
      show: true,
      adUnitId: adUnitId,
      targetInfo: targetInfo,
      keywords: keywords,
      contentUrl: contentUrl,
      childDirected: childDirected,
      testDevices: testDevices,
      testing: testing,
      anchorOffset: anchorOffset,
      anchorType: anchorType,
    );
  }

  _createAd({bool testing, String adUnitId, MobileAdTargetingInfo targetInfo}) {
    return InterstitialAd(
      adUnitId: testing
          ? InterstitialAd.testAdUnitId
          : adUnitId.isEmpty ? InterstitialAd.testAdUnitId : adUnitId.trim(),
      targetingInfo: targetInfo,
    );
  }
}

abstract class MobileAds extends AdMob {
  MobileAds({this.listener});
  MobileAd _ad;
  final MobileAdListener listener;
  double _anchorOffset;
  AnchorType _anchorType;

  Future<bool> load({
    @required bool show,
    String adUnitId,
    MobileAdTargetingInfo targetInfo,
    List<String> keywords,
    String contentUrl,
    bool childDirected,
    List<String> testDevices,
    bool testing,
    double anchorOffset,
    AnchorType anchorType,
  }) {
    // Are we testing?
    testing = testing ?? _testing;

    // Supply a valid unit id.
    if (adUnitId == null || adUnitId.isEmpty || adUnitId.length < 30) {
      adUnitId = _adUnitId;
    }

    if (_info != null) {
      targetInfo = _info;
    } else {
      targetInfo ??= _targetInfo(
        keywords: keywords,
        contentUrl: contentUrl,
        childDirected: childDirected,
        testDevices: testDevices,
      );
    }

    // Get rid of the ad if already created.
    dispose();

    // Create the ad.
    _ad =
        _createAd(testing: testing, adUnitId: adUnitId, targetInfo: targetInfo);

    // Assign the ad's listener
    _ad?.listener = (MobileAdEvent event) {
      if (show && event == MobileAdEvent.loaded) {
        _ad.show(
            anchorOffset: anchorOffset ?? _anchorOffset ?? 0.0,
            anchorType: anchorType ?? _anchorType ?? AnchorType.bottom);
      }

      if (listener != null) {
        listener(event);
      }

      // Dispose and load the ad again.
      if (event == MobileAdEvent.closed) {
        dispose().then((_) {
          load(
            show: false,
            adUnitId: adUnitId,
            targetInfo: targetInfo,
            keywords: keywords,
            contentUrl: contentUrl,
            childDirected: childDirected,
            testDevices: testDevices,
            testing: testing,
            anchorOffset: anchorOffset,
            anchorType: anchorType,
          );
        });
      }
    };
    // Load the ad in memory.
    return _ad?.load();
  }

  MobileAd _createAd(
      {bool testing, String adUnitId, MobileAdTargetingInfo targetInfo});

  /// Set the MobileAd's options.
  @override
  void set({
    String adUnitId,
    MobileAdTargetingInfo targetInfo,
    List<String> keywords,
    String contentUrl,
    bool childDirected,
    List<String> testDevices,
    bool testing,
    double anchorOffset,
    AnchorType anchorType,
  }) {
    super.set(
      adUnitId: adUnitId,
      targetInfo: targetInfo,
      keywords: keywords,
      contentUrl: contentUrl,
      childDirected: childDirected,
      testDevices: testDevices,
      testing: testing,
    );
    _anchorOffset = anchorOffset ?? _anchorOffset ?? 0.0;
    _anchorType = anchorType ?? _anchorType ?? AnchorType.bottom;
  }

  /// Display the MobileAd
  void show({
    double anchorOffset,
    AnchorType anchorType,
  }) async {
    anchorOffset = anchorOffset ?? _anchorOffset;
    anchorType = anchorType ?? _anchorType;

    _ad?.listener = (MobileAdEvent event) {
      if (event == MobileAdEvent.loaded) {
        _ad?.show(anchorOffset: anchorOffset, anchorType: anchorType);
      }
      if (listener != null) listener(event);
    };

    _ad?.load();
  }

  /// Clear the MobileAd reference.
  Future<void> dispose() async {
    if (_ad != null) {
      try {
        await _ad?.dispose();
      } catch (ex) {
        _setError(ex);
      }
      _ad = null;
    }
  }

  Future<bool> isLoaded() async {
    bool loaded = false;
    if (_ad != null) {
      try {
        loaded = await _ad?.isLoaded();
      } catch (ex) {
        loaded = false;
        _setError(ex);
      }
    }
    return loaded;
  }
}

class VideoAd extends AdMob {
  factory VideoAd({RewardedVideoAdListener listener}) {
    _this ??= VideoAd._(listener);
    return _this;
  }

  static VideoAd _this;

  VideoAd._(RewardedVideoAdListener listener) : super() {
    this.listener = listener;
  }

  RewardedVideoAdListener listener;
  RewardedVideoAd _rewardedVideoAd;

  /// Set the Video Ad's options.
  @override
  Future<bool> set({
    String adUnitId,
    MobileAdTargetingInfo targetInfo,
    List<String> keywords,
    String contentUrl,
    bool childDirected,
    List<String> testDevices,
    bool testing,
  }) {
    super.set(
      adUnitId: adUnitId,
      targetInfo: targetInfo,
      keywords: keywords,
      contentUrl: contentUrl,
      childDirected: childDirected,
      testDevices: testDevices,
      testing: testing,
    );
    // Load into memory.
    return _loadVideo(
      show: false,
      adUnitId: adUnitId,
      targetInfo: targetInfo,
      keywords: keywords,
      contentUrl: contentUrl,
      childDirected: childDirected,
      testDevices: testDevices,
      testing: testing,
    );
  }

  /// Show the Video Ad.
  @override
  Future<bool> show({
    String adUnitId,
    MobileAdTargetingInfo targetInfo,
    List<String> keywords,
    String contentUrl,
    bool childDirected,
    List<String> testDevices,
    bool testing,
    State state,
  }) {
    // Don't bother if the app is terminating.
    if (state != null && !state.mounted) return Future.value(false);

    // Load a new ad if a parameter is passed.
    if ((adUnitId != null && adUnitId.isNotEmpty) ||
        targetInfo != null ||
        (keywords != null && keywords.isNotEmpty) ||
        (contentUrl != null && contentUrl.isNotEmpty) ||
        childDirected != null ||
        (testDevices != null && testDevices.isNotEmpty) ||
        testing != null) {
      _rewardedVideoAd = null;
    }

    // Show if already loaded.
    if (_rewardedVideoAd != null) {
      return _rewardedVideoAd.show();
    }

    // Show the ad when loaded.
    return _loadVideo(
      show: true,
      adUnitId: adUnitId,
      targetInfo: targetInfo,
      keywords: keywords,
      contentUrl: contentUrl,
      childDirected: childDirected,
      testDevices: testDevices,
      testing: testing,
    );
  }

  Future<bool> _loadVideo({
    @required bool show,
    String adUnitId,
    MobileAdTargetingInfo targetInfo,
    List<String> keywords,
    String contentUrl,
    bool childDirected,
    List<String> testDevices,
    bool testing,
  }) {
    // Acquire an instance of the Video Ad.
    _rewardedVideoAd ??= RewardedVideoAd.instance;

    // Assign its listener.
    _rewardedVideoAd.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      if (show && event == RewardedVideoAdEvent.loaded) {
        _rewardedVideoAd.show();
      }

      // Call any listeners.
      if (this.listener != null)
        this.listener(event,
            rewardType: rewardType, rewardAmount: rewardAmount);

      // Dispose of the ad and recreate it.
      if (event == RewardedVideoAdEvent.closed) {
        dispose();
        _loadVideo(
          show: false,
          adUnitId: adUnitId,
          targetInfo: targetInfo,
          keywords: keywords,
          contentUrl: contentUrl,
          childDirected: childDirected,
          testDevices: testDevices,
          testing: testing,
        );
      }
    };

    // Assign a valid unit id.
    if (adUnitId == null || adUnitId.isEmpty || adUnitId.length < 30) {
      adUnitId = _adUnitId;
    }

    // Is this a test?
    testing = testing ?? _testing;

    // If testing, assign a 'test' unit id.
    String adModId = testing
        ? RewardedVideoAd.testAdUnitId
        : adUnitId.isEmpty ? RewardedVideoAd.testAdUnitId : adUnitId.trim();

    MobileAdTargetingInfo info;
    // Retrieve the target info.
    if (targetInfo != null) {
      info = targetInfo;
    } else if (_info != null) {
      info = _info;
    } else {
      info = _targetInfo(
        keywords: keywords,
        contentUrl: contentUrl,
        childDirected: childDirected,
        testDevices: testDevices,
      );
    }
    // Load the ad into memory.
    return _rewardedVideoAd.load(adUnitId: adModId, targetingInfo: info);
  }

  /// Clear the video ad plugin.
  @override
  void dispose() {
    _rewardedVideoAd = null;
  }
}

abstract class AdMob {
  String _adUnitId = "";

  MobileAdTargetingInfo _info;
  List<String> _keywords = ["the"];
  String _contentUrl; // Can be null
  bool _childDirected; // Can be null
  List<String> _testDevices; // Can be null

  bool _testing = false;

  Exception _ex;

  /// Return any exception
  Exception getError() {
    Exception ex = _ex;
    _ex = null;
    return ex;
  }

  /// Indicate there was an error.
  bool get inError => _ex != null;

  /// Displays an error message if any.
  String get message => _ex?.toString() ?? "";

  void set({
    String adUnitId,
    MobileAdTargetingInfo targetInfo,
    List<String> keywords,
    String contentUrl,
    bool childDirected,
    List<String> testDevices,
    bool testing,
  }) {
    if (adUnitId != null && adUnitId.isNotEmpty && adUnitId.length > 30) {
      _adUnitId = adUnitId;
    }

    _info = targetInfo ?? _info;

    _keywords = keywords ?? _keywords;

    _contentUrl = contentUrl ?? _contentUrl;

    _childDirected = childDirected ?? _childDirected;

    if (testDevices != null &&
        testDevices.every((String s) => s == null || s.isNotEmpty))
      testDevices = null;

    _testDevices = testDevices ?? _testDevices;

    _testing = testing ?? _testing;
  }

  // Must show the AdMob ad.
  void show();

  // Must dispose the object properly.
  void dispose();

  /// Return the target audience information
  MobileAdTargetingInfo _targetInfo({
    List<String> keywords,
    String contentUrl,
    bool childDirected,
    List<String> testDevices,
  }) {
    keywords ??= _keywords;
    if (keywords != null && keywords.isEmpty) keywords = _keywords;

    if (contentUrl == null || contentUrl.isEmpty) contentUrl = _contentUrl;

    // If it's true, it has to be passed.
    if (_childDirected != null && _childDirected)
      childDirected ??= _childDirected;

    if (testDevices == null || testDevices.isEmpty) testDevices = _testDevices;

    return MobileAdTargetingInfo(
      keywords: keywords,
      contentUrl: contentUrl,
      childDirected: childDirected,
      testDevices: testDevices,
    );
  }

  void _setError(Object ex) {
    if (ex is! Exception) {
      _ex = Exception(ex.toString());
    } else {
      _ex = ex;
    }
  }
}