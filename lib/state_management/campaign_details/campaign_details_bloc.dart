import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_comment.dart';
import 'package:crowdfunding_flutter/domain/usecases/campaign/campaign_comment/create_campaign_comment.dart';
import 'package:crowdfunding_flutter/domain/usecases/campaign/campaign_comment/create_campaign_reply.dart';
import 'package:crowdfunding_flutter/domain/usecases/campaign/fetch_campaign.dart';
import 'package:crowdfunding_flutter/state_management/campaign_details/campaign_details_event.dart';
import 'package:crowdfunding_flutter/state_management/campaign_details/campaign_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CampaignDetailsBloc
    extends Bloc<CampaignDetailsEvent, CampaignDetailsState> {
  final FetchCampaign _fetchCampaign;
  final CreateCampaignComment _createCampaignComment;
  final CreateCampaignReply _createCampaignReply;

  CampaignDetailsBloc({
    required FetchCampaign fetchCampaign,
    required CreateCampaignComment createCampaignComment,
    required CreateCampaignReply createCampaignReply,
  })  : _fetchCampaign = fetchCampaign,
        _createCampaignComment = createCampaignComment,
        _createCampaignReply = createCampaignReply,
        super(const CampaignDetailsState.initial()) {
    on<CampaignDetailsEvent>(_onEvent);
  }

  Future<void> _onEvent(
    CampaignDetailsEvent event,
    Emitter<CampaignDetailsState> emit,
  ) async {
    return switch (event) {
      final OnTabIndexChanged e => _onTabIndexChanged(e, emit),
      final OnFetchCampaign e => _onFetchCampaign(e, emit),
      final OnSubmitComment e => _onSubmitComment(e, emit),
      final OnSelectCommentToReply e => _onSelectCommentToReply(e, emit),
      final OnClearSelectedCommentToReply e =>
        _onClearSelectedCommentToReply(e, emit),
      final OnSubmitReply e => _onSubmitReply(e, emit),
      final OnToggleCommentBottomBar e => _onToggleCommentBottomBar(e, emit),
    };
  }

  void _onToggleCommentBottomBar(
    OnToggleCommentBottomBar event,
    Emitter emit,
  ) {
    emit(state.copyWith(isShowingCommentBottomBar: event.isShow));
  }

  Future<void> _onSubmitReply(
    OnSubmitReply event,
    Emitter emit,
  ) async {
    emit(state.copyWith(createReplyResult: const ApiResultLoading()));
    final payload = event.payload
        .copyWith(comment: _generateReplyContent(event.payload.comment));
    final res = await _createCampaignReply.call(payload);
    res.fold(
      (l) => emit(
          state.copyWith(createReplyResult: ApiResultFailure(l.errorMessage))),
      (r) {
        // Insert new reply to data
        final campaignResult =
            state.campaignResult as ApiResultSuccess<Campaign>;
        Campaign campaign = campaignResult.data;
        List<CampaignComment> updatedCampaignComments;
        updatedCampaignComments = campaign.comments.map((comment) {
          if (comment.id == event.payload.parentId) {
            comment.replies.add(r);
          }
          return comment;
        }).toList();

        emit(
          state.copyWith(
            createReplyResult: const ApiResultInitial(),
            campaignResult: ApiResultSuccess(
              campaign.copyWith(comments: updatedCampaignComments),
            ),
          ),
        );
      },
    );
  }

  void _onClearSelectedCommentToReply(
    OnClearSelectedCommentToReply event,
    Emitter emit,
  ) {
    emit(state.copyWith(selectedCommentToReply: null));
  }

  void _onSelectCommentToReply(
    OnSelectCommentToReply event,
    Emitter emit,
  ) {
    emit(state.copyWith(
      selectedCommentToReply: event.campaignComment,
      isShowingCommentBottomBar: true,
    ));
  }

  String _generateReplyContent(String commentText) {
    var replyContent = commentText;
    final selectedCommentToReply = state.selectedCommentToReply;
    if (selectedCommentToReply != null) {
      replyContent =
          "Reply to ${selectedCommentToReply.user.fullName}: $commentText";
    }
    return replyContent;
  }

  Future<void> _onSubmitComment(
    OnSubmitComment event,
    Emitter emit,
  ) async {
    emit(state.copyWith(createCommentResult: const ApiResultLoading()));
    final res = await _createCampaignComment.call(event.payload);
    res.fold(
      (l) => emit(state.copyWith(
          createCommentResult: ApiResultFailure(l.errorMessage))),
      (r) {
        Campaign campaign =
            (state.campaignResult as ApiResultSuccess<Campaign>).data;
        List<CampaignComment> updatedCampaignComments;
        final campaignResult = state.campaignResult;
        if (campaignResult is ApiResultSuccess<Campaign>) {
          updatedCampaignComments = [...campaignResult.data.comments, r];
          campaign =
              campaignResult.data.copyWith(comments: updatedCampaignComments);
        }
        emit(
          state.copyWith(
            createCommentResult: const ApiResultInitial(),
            campaignResult: ApiResultSuccess(campaign),
          ),
        );
      },
    );
  }

  Future<void> _onFetchCampaign(
    OnFetchCampaign event,
    Emitter emit,
  ) async {
    // emit(CampaignDetailsState.fetchCampaignSuccess(Campaign.sample));
    final res = await _fetchCampaign(event.campaignId);
    res.fold(
      (l) => emit(CampaignDetailsState.fetchCampaignFailed(l.errorMessage)),
      (r) => emit(CampaignDetailsState.fetchCampaignSuccess(r)),
    );
  }

  void _onTabIndexChanged(
    OnTabIndexChanged event,
    Emitter emit,
  ) {
    emit(state.copyWith(currentTabIndex: event.index));
  }
}
