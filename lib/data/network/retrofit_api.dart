import 'package:crowdfunding_flutter/data/network/dto/sign_up_payload.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/domain/model/tokens_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'retrofit_api.g.dart';

@RestApi(baseUrl: 'https://crowdfunding-ngustudio-7cca7759.koyeb.app/')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("auth/signUp")
  Future<TokensResponse> signUp(@Body() SignUpPayload signUpDto);

  @POST("auth/login")
  Future<TokensResponse> signIn(@Body() String email);

  // Campaign
  @GET("campaigns")
  Future<List<Campaign>> getCampaigns();
}
