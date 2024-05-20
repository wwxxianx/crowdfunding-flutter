// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retrofit_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _RestClient implements RestClient {
  _RestClient(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://crowdfunding-ngustudio-7cca7759.koyeb.app/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<StateAndRegion>> getStateAndRegions() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<StateAndRegion>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'state-and-regions',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) => StateAndRegion.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<TokensResponse> signUp(SignUpPayload signUpDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(signUpDto.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<TokensResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'auth/sign-up',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = TokensResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UserModelWithAccessToken> signIn(String userId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = userId;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UserModelWithAccessToken>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'auth/sign-in',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = UserModelWithAccessToken.fromJson(_result.data!);
    return value;
  }

  @override
  Future<List<Campaign>> getCampaigns() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result =
        await _dio.fetch<List<dynamic>>(_setStreamType<List<Campaign>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'campaigns',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) => Campaign.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<void> createCampaign({
    required String title,
    required String description,
    required int targetAmount,
    required String categoryId,
    required String phoneNumber,
    required String stateId,
    required String beneficiaryName,
    required List<File> campaignImageFiles,
    File? campaignVideoFile,
    File? beneficiaryImageFile,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry(
      'title',
      title,
    ));
    _data.fields.add(MapEntry(
      'description',
      description,
    ));
    _data.fields.add(MapEntry(
      'targetAmount',
      targetAmount.toString(),
    ));
    _data.fields.add(MapEntry(
      'titcategoryIdle',
      categoryId,
    ));
    _data.fields.add(MapEntry(
      'contactPhoneNumber',
      phoneNumber,
    ));
    _data.fields.add(MapEntry(
      'stateId',
      stateId,
    ));
    _data.fields.add(MapEntry(
      'beneficiaryName',
      beneficiaryName,
    ));
    _data.files.addAll(campaignImageFiles.map((i) => MapEntry(
        'campaignImages',
        MultipartFile.fromFileSync(
          i.path,
          filename: i.path.split(Platform.pathSeparator).last,
        ))));
    if (campaignVideoFile != null) {
      _data.files.add(MapEntry(
        'campaignVideo',
        MultipartFile.fromFileSync(
          campaignVideoFile.path,
          filename: campaignVideoFile.path.split(Platform.pathSeparator).last,
        ),
      ));
    }
    if (beneficiaryImageFile != null) {
      _data.files.add(MapEntry(
        'beneficiaryImage',
        MultipartFile.fromFileSync(
          beneficiaryImageFile.path,
          filename:
              beneficiaryImageFile.path.split(Platform.pathSeparator).last,
        ),
      ));
    }
    await _dio.fetch<void>(_setStreamType<void>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
        .compose(
          _dio.options,
          'campaigns',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
  }

  @override
  Future<List<CampaignCategory>> getCampaignCategories() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<CampaignCategory>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'campaign-categories',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map(
            (dynamic i) => CampaignCategory.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<UserModel> updateUserProfile({
    String? fullName,
    File? profileImageFile,
    List<String>? favouriteCategoriesId,
    String phoneNumber = "112901029",
    bool? isOnboardingCompleted,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = FormData();
    if (fullName != null) {
      _data.fields.add(MapEntry(
        'fullName',
        fullName,
      ));
    }
    if (profileImageFile != null) {
      _data.files.add(MapEntry(
        'profileImageFile',
        MultipartFile.fromFileSync(
          profileImageFile.path,
          filename: profileImageFile.path.split(Platform.pathSeparator).last,
        ),
      ));
    }
    favouriteCategoriesId?.forEach((i) {
      _data.fields.add(MapEntry('favouriteCategoriesId', i));
    });
    _data.fields.add(MapEntry(
      'phoneNumber',
      phoneNumber,
    ));
    if (isOnboardingCompleted != null) {
      _data.fields.add(MapEntry(
        'isOnboardingCompleted',
        isOnboardingCompleted.toString(),
      ));
    }
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<UserModel>(Options(
      method: 'PATCH',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              'users',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = UserModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UserModel> getUserProfile() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<UserModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'users',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = UserModel.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
