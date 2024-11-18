import 'package:intl/intl.dart';

class Session {
  String? sessionId;
  DateTime? expires;
  int? maxAge;
  bool? httpOnly;
  String? path;

  Session({
    this.sessionId,
    this.expires,
    this.maxAge,
    this.httpOnly,
    this.path,
  });

  factory Session.fromCookieString(String cookieString) {
    RegExp regExp = RegExp(
        r'session_id=([^;]+); Expires=([^;]+); Max-Age=([^;]+); HttpOnly; Path=/');

    RegExpMatch? match = regExp.firstMatch(cookieString);
    if (match != null && match.groupCount == 3) {
      String sessionId = match.group(1)!;
      String expiresString = match.group(2)!;
      String maxAgeString = match.group(3)!;

      DateFormat format =
          DateFormat("EEE, dd-MMM-yyyy HH:mm:ss 'GMT'", "en_US");
      DateTime expires = format.parseUtc(expiresString);

      int maxAge = int.parse(maxAgeString);

      return Session(
        sessionId: sessionId,
        expires: expires,
        maxAge: maxAge,
        httpOnly: true,
        path: '/',
      );
    } else {
      throw Exception('Invalid cookie string format');
    }
  }

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      sessionId: json['sessionId'],
      expires: DateTime.parse(json['expires']),
      maxAge: json['maxAge'],
      httpOnly: json['httpOnly'],
      path: json['path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sessionId': sessionId,
      'expires': expires?.toIso8601String(),
      'maxAge': maxAge,
      'httpOnly': httpOnly,
      'path': path,
    };
  }

  @override
  String toString() {
    return 'Session(sessionId: $sessionId, expires: $expires, maxAge: $maxAge, httpOnly: $httpOnly, path: $path)';
  }
}

class CustomOdooSession {
  Session? session;
  String? jsonrpc;
  int? id;
  Result? result;

  CustomOdooSession({this.jsonrpc, this.id, this.result, this.session});

  CustomOdooSession.fromJson(Map<String, dynamic> json) {
    if (json['session'] != null) {
      session = Session.fromJson(json['session']);
    }
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['session'] = session;
    data['jsonrpc'] = jsonrpc;
    data['id'] = id;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class Result {
  int? uid;
  bool? isSystem;
  bool? isAdmin;
  bool? isInternalUser;
  UserContext? userContext;
  String? db;
  UserSettings? userSettings;
  String? serverVersion;
  String? supportUrl;
  String? name;
  String? username;
  String? partnerDisplayName;
  int? partnerId;
  String? webBaseUrl;
  int? activeIdsLimit;
  Null profileSession;
  Null profileCollectors;
  Null profileParams;
  int? maxFileUploadSize;
  bool? homeActionId;
  CacheHashes? cacheHashes;
  Map<String, dynamic>? currencies;
  BundleParams? bundleParams;
  UserCompanies? userCompanies;
  bool? showEffect;
  bool? displaySwitchCompanyMenu;
  List<int>? userId;
  int? maxTimeBetweenKeysInMs;
  List<dynamic>? webTours;
  bool? tourDisable;
  String? notificationType;
  String? warning;
  bool? expirationDate;
  bool? expirationReason;
  bool? mapBoxToken;
  bool? odoobotInitialized;
  bool? iapCompanyEnrich;
  bool? ocnTokenKey;
  bool? fcmProjectId;
  int? inboxAction;
  bool? isQuickEditModeEnabled;

  Result(
      {uid,
      isSystem,
      isAdmin,
      isInternalUser,
      userContext,
      db,
      userSettings,
      serverVersion,
      supportUrl,
      name,
      username,
      partnerDisplayName,
      partnerId,
      webBaseUrl,
      activeIdsLimit,
      profileSession,
      profileCollectors,
      profileParams,
      maxFileUploadSize,
      homeActionId,
      cacheHashes,
      currencies,
      bundleParams,
      userCompanies,
      showEffect,
      displaySwitchCompanyMenu,
      userId,
      maxTimeBetweenKeysInMs,
      webTours,
      tourDisable,
      notificationType,
      warning,
      expirationDate,
      expirationReason,
      mapBoxToken,
      odoobotInitialized,
      iapCompanyEnrich,
      ocnTokenKey,
      fcmProjectId,
      inboxAction,
      isQuickEditModeEnabled});

  Result.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    isSystem = json['is_system'];
    isAdmin = json['is_admin'];
    isInternalUser = json['is_internal_user'];
    userContext = json['user_context'] != null
        ? UserContext.fromJson(json['user_context'])
        : null;
    db = json['db'];
    userSettings = json['user_settings'] != null
        ? UserSettings.fromJson(json['user_settings'])
        : null;
    serverVersion = json['server_version'];
    supportUrl = json['support_url'];
    name = json['name'];
    username = json['username'];
    partnerDisplayName = json['partner_display_name'];
    partnerId = json['partner_id'];
    webBaseUrl = json['web.base.url'];
    activeIdsLimit = json['active_ids_limit'];
    profileSession = json['profile_session'];
    profileCollectors = json['profile_collectors'];
    profileParams = json['profile_params'];
    maxFileUploadSize = json['max_file_upload_size'];
    homeActionId = json['home_action_id'];
    cacheHashes = json['cache_hashes'] != null
        ? CacheHashes.fromJson(json['cache_hashes'])
        : null;
    currencies = json['currencies'];
    bundleParams = json['bundle_params'] != null
        ? BundleParams.fromJson(json['bundle_params'])
        : null;
    userCompanies = json['user_companies'] != null
        ? UserCompanies.fromJson(json['user_companies'])
        : null;
    showEffect = json['show_effect'];
    displaySwitchCompanyMenu = json['display_switch_company_menu'];
    userId = json['user_id'].cast<int>();
    maxTimeBetweenKeysInMs = json['max_time_between_keys_in_ms'];
    webTours = json['web_tour'];
    tourDisable = json['tour_disable'];
    notificationType = json['notification_type'];
    warning = json['warning'];
    expirationDate = json['expiration_date'];
    expirationReason = json['expiration_reason'];
    mapBoxToken = json['map_box_token'];
    odoobotInitialized = json['odoobot_initialized'];
    iapCompanyEnrich = json['iap_company_enrich'];
    ocnTokenKey = json['ocn_token_key'];
    fcmProjectId = json['fcm_project_id'];
    inboxAction = json['inbox_action'];
    isQuickEditModeEnabled = json['is_quick_edit_mode_enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['uid'] = uid;
    data['is_system'] = isSystem;
    data['is_admin'] = isAdmin;
    data['is_internal_user'] = isInternalUser;
    if (userContext != null) {
      data['user_context'] = userContext!.toJson();
    }
    data['db'] = db;
    if (userSettings != null) {
      data['user_settings'] = userSettings!.toJson();
    }
    data['server_version'] = serverVersion;
    data['support_url'] = supportUrl;
    data['name'] = name;
    data['username'] = username;
    data['partner_display_name'] = partnerDisplayName;
    data['partner_id'] = partnerId;
    data['web.base.url'] = webBaseUrl;
    data['active_ids_limit'] = activeIdsLimit;
    data['profile_session'] = profileSession;
    data['profile_collectors'] = profileCollectors;
    data['profile_params'] = profileParams;
    data['max_file_upload_size'] = maxFileUploadSize;
    data['home_action_id'] = homeActionId;
    if (cacheHashes != null) {
      data['cache_hashes'] = cacheHashes!.toJson();
    }
    data['currencies'] = currencies;
    if (bundleParams != null) {
      data['bundle_params'] = bundleParams!.toJson();
    }
    if (userCompanies != null) {
      data['user_companies'] = userCompanies!.toJson();
    }
    data['show_effect'] = showEffect;
    data['display_switch_company_menu'] = displaySwitchCompanyMenu;
    data['user_id'] = userId;
    data['max_time_between_keys_in_ms'] = maxTimeBetweenKeysInMs;
    if (webTours != null) {
      data['web_tours'] = webTours!.map((v) => v.toJson()).toList();
    }
    data['tour_disable'] = tourDisable;
    data['notification_type'] = notificationType;
    data['warning'] = warning;
    data['expiration_date'] = expirationDate;
    data['expiration_reason'] = expirationReason;
    data['map_box_token'] = mapBoxToken;
    data['odoobot_initialized'] = odoobotInitialized;
    data['iap_company_enrich'] = iapCompanyEnrich;
    data['ocn_token_key'] = ocnTokenKey;
    data['fcm_project_id'] = fcmProjectId;
    data['inbox_action'] = inboxAction;
    data['is_quick_edit_mode_enabled'] = isQuickEditModeEnabled;
    return data;
  }
}

class UserContext {
  String? lang;
  String? tz;
  int? uid;

  UserContext({lang, tz, uid});

  UserContext.fromJson(Map<String, dynamic> json) {
    lang = json['lang'];
    tz = json['tz'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['lang'] = lang;
    data['tz'] = tz;
    data['uid'] = uid;
    return data;
  }
}

class UserSettings {
  int? id;
  UserId? userId;
  bool? isDiscussSidebarCategoryChannelOpen;
  bool? isDiscussSidebarCategoryChatOpen;
  bool? pushToTalkKey;
  bool? usePushToTalk;
  int? voiceActiveDuration;
  List<dynamic>? volumeSettingsIds;
  bool? homemenuConfig;

  UserSettings(
      {id,
      userId,
      isDiscussSidebarCategoryChannelOpen,
      isDiscussSidebarCategoryChatOpen,
      pushToTalkKey,
      usePushToTalk,
      voiceActiveDuration,
      volumeSettingsIds,
      homemenuConfig});

  UserSettings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'] != null ? UserId.fromJson(json['user_id']) : null;
    isDiscussSidebarCategoryChannelOpen =
        json['is_discuss_sidebar_category_channel_open'];
    isDiscussSidebarCategoryChatOpen =
        json['is_discuss_sidebar_category_chat_open'];
    pushToTalkKey = json['push_to_talk_key'];
    usePushToTalk = json['use_push_to_talk'];
    voiceActiveDuration = json['voice_active_duration'];
    volumeSettingsIds = json['volume_settings_ids'];
    homemenuConfig = json['homemenu_config'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    if (userId != null) {
      data['user_id'] = userId!.toJson();
    }
    data['is_discuss_sidebar_category_channel_open'] =
        isDiscussSidebarCategoryChannelOpen;
    data['is_discuss_sidebar_category_chat_open'] =
        isDiscussSidebarCategoryChatOpen;
    data['push_to_talk_key'] = pushToTalkKey;
    data['use_push_to_talk'] = usePushToTalk;
    data['voice_active_duration'] = voiceActiveDuration;
    data['volume_settings_ids'] = volumeSettingsIds;
    data['homemenu_config'] = homemenuConfig;
    return data;
  }
}

class UserId {
  int? id;

  UserId({id});

  UserId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    return data;
  }
}

class CacheHashes {
  String? translations;
  String? loadMenus;

  CacheHashes({translations, loadMenus});

  CacheHashes.fromJson(Map<String, dynamic> json) {
    translations = json['translations'];
    loadMenus = json['load_menus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['translations'] = translations;
    data['load_menus'] = loadMenus;
    return data;
  }
}

class BundleParams {
  String? lang;

  BundleParams({lang});

  BundleParams.fromJson(Map<String, dynamic> json) {
    lang = json['lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['lang'] = lang;
    return data;
  }
}

class UserCompanies {
  int? currentCompany;
  dynamic disallowedAncestorCompanies;
  Map<String, dynamic>? allowedCompanies;

  UserCompanies(
      {currentCompany, allowedCompanies, disallowedAncestorCompanies});

  UserCompanies.fromJson(Map<String, dynamic> json) {
    currentCompany = json['current_company'];
    allowedCompanies = json['allowed_companies'];
    disallowedAncestorCompanies = json['disallowed_ancestor_companies'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['current_company'] = currentCompany;
    if (allowedCompanies != null) {
      data['allowed_companies'] = allowedCompanies;
    }
    if (disallowedAncestorCompanies != null) {
      data['disallowed_ancestor_companies'] = disallowedAncestorCompanies;
    }
    return data;
  }
}
