// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/patient_features/consultation/2_views/bloc/consultation_bloc.dart';
import 'package:flutter/material.dart';

class ChatInputMessageField extends StatelessWidget {
  const ChatInputMessageField({
    super.key,
    required this.messageFN,
    required this.messageController,
    required this.context,
    required this.send,
  });

  final FocusNode messageFN;
  final TextEditingController messageController;
  final BuildContext context;
  final Function send;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 15,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: 285,
              height: 70,
              decoration: BoxDecoration(
                color: GinaAppTheme.appbarColorLight,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: TextFormField(
                  readOnly: isChatWaiting,
                  focusNode: messageFN,
                  controller: messageController,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: IconButton(
                        icon: Image.asset(
                          Images.consultationAttachButtonIcon,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    hintText: 'Type your message',
                    hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: GinaAppTheme.lightOutline,
                          fontSize: 15,
                        ),
                    isDense: true,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding:
                        const EdgeInsets.only(bottom: 12, top: 10, right: 12),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 60,
            height: 70,
            decoration: BoxDecoration(
                color: isChatWaiting
                    ? GinaAppTheme.lightOutline
                    : GinaAppTheme.lightSecondary,
                borderRadius: BorderRadius.circular(10)),
            child: IconButton(
                icon: Image.asset(
                  Images.consultationSendButtonIcon,
                  width: 30,
                  height: 30,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                ),
                onPressed: () {
                  isChatWaiting ? null : send();
                }),
          )
        ],
      ),
    );
  }
}
