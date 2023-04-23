import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/member.dart';
import 'package:mylis/domain/repository/member.dart';
import 'package:mylis/infrastructure/firestore/firestore.dart';
import 'package:mylis/infrastructure/mapper/member_mapper.dart';

class IMemberRepository extends MemberRepository {
  IMemberRepository();

  final firestore = FirebaseFirestore.instance;
  final usersDB = Firestore.users;

  @override
  Future<Member> get(String uuid) async {
    return await usersDB.doc(uuid).get().then(
      (value) {
        final doc = value.data();
        return MemberMapper.fromJSON(doc!, uuid);
      },
    );
  }

  @override
  Future<Member> update(Member member) async {
    final postData = {
      "email": member.email,
      "password": member.password,
      "text_color": member.textColor,
      "button_color": member.buttonColor,
      "icon_color": member.iconColor,
      "is_removed_ads": member.isRemovedAds,
      "is_hidden_save_memo_notice_dialog": member.isHiddenSaveMemoNoticeDialog,
      "registered_article_count": member.registeredArticleCount,
      "created_at": member.createdAt,
      "updated_at": DateTime.now(),
    };

    await usersDB.doc(member.uuid).update(postData);

    return await get(member.uuid);
  }

  @override
  Future<void> delete({required String currentMemberId}) async {
    final postData = {
      "deleted_at": DateTime.now(),
    };

    await usersDB.doc(currentMemberId).update(postData);

    await get(currentMemberId);
  }
}

final memberRepositoryProvider =
    Provider<IMemberRepository>((ref) => IMemberRepository());
