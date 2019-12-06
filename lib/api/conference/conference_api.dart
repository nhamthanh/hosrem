import 'package:dio/dio.dart';
import 'package:hosrem_app/api/conference/public_registration_pagination.dart';
import 'package:hosrem_app/api/document/document_pagination.dart';
import 'package:retrofit/retrofit.dart';

import 'conference.dart';
import 'conference_fees.dart';
import 'conference_member_pagination.dart';
import 'conference_pagination.dart';
import 'conference_registration.dart';
import 'update_registration_status.dart';

part 'conference_api.g.dart';

/// Conference Api.
@RestApi()
abstract class ConferenceApi {
  factory ConferenceApi(Dio dio) = _ConferenceApi;

  /// Get all conferences.
  @GET('conferences')
  Future<ConferencePagination> getAll(@Queries() Map<String, dynamic> query);

  /// Get all conference fees.
  @GET('conferences/{id}/fees')
  Future<ConferenceFees> getConferenceFees(@Path() String id);

  /// Get all conference fees.
  @GET('conferences/{id}/members')
  Future<ConferenceMemberPagination> getConferenceMembers(@Path() String id, @Queries() Map<String, dynamic> query);

  /// Get all conference documents.
  @GET('conferences/{id}/documents')
  Future<DocumentPagination> getConferenceDocuments(@Path() String id, @Queries() Map<String, dynamic> query);

  /// Get conference by id.
  @GET('conferences/{id}')
  Future<Conference> getConferenceById(@Path() String id);

  /// Register to join the conference [id].
  @POST('conferences/{id}/registrations')
  Future<ConferenceRegistration> registerConferenceById(@Path() String id, @Body() ConferenceRegistration user);

  /// Check if user [userId] has registered the conference [id].
  @GET('conferences/{id}/registrations/{userId}')
  Future<bool> checkRegistrationStatusOfMember(@Path() String id, @Path() String userId);

  /// Get registration inform from registration code [regCode].
  @GET('conferences/{id}/registration-codes/{regCode}')
  Future<ConferenceRegistration> getRegistrationInfoFromRegCode(@Path() String id, @Path() String regCode);

  /// Get registrated user of conference from id [id].
  @GET('conferences/{id}/registrations/public')
  Future<PublicRegistrationPagination> getParticipates(@Path() String id, @Queries() Map<String, dynamic> query);

  /// Update conference registration status.
  @PUT('conferences/{id}/registrations/{userId}/status')
  Future<ConferenceRegistration> updateConferenceRegistrationStatus(@Path() String id, @Path() String userId,
      @Body() UpdateRegistrationStatus updateRegistrationStatus);
}

