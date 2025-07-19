import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk_ui/widgets/n_picture.dart';
import 'package:mailstr/app_routes.dart';

class UserAvatar extends StatelessWidget {
  final double radius;
  final bool clickable;
  final String? pubkey;

  const UserAvatar({
    super.key,
    this.radius = 16,
    this.clickable = true,
    this.pubkey,
  });

  @override
  Widget build(BuildContext context) {
    final ndk = Get.find<Ndk>();
    final userPubkey = pubkey ?? ndk.accounts.getPublicKey();

    if (userPubkey == null) {
      return SizedBox.shrink();
    }

    final avatar = CircleAvatar(
      radius: radius,
      child: ClipOval(
        child: NPicture(
          ndk: ndk,
          pubKey: userPubkey,
        ),
      ),
    );

    if (!clickable) {
      return avatar;
    }

    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.user),
      child: avatar,
    );
  }
}