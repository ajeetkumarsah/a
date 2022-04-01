import 'package:flutter/material.dart';

class ActivityIconsHelper extends StatelessWidget {
  final String activityType;
  final bool? overDue;
  const ActivityIconsHelper(
      {Key? key, required this.activityType, this.overDue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        activityType == "Call"
            ? Icons.call
            : activityType == "Follow-up"
                ? Icons.event_note_outlined
                : activityType == "Task"
                    ? Icons.domain_verification_outlined
                    : activityType == "Email"
                        ? Icons.email
                        : activityType == "Clock"
                            ? Icons.alarm
                            : activityType == "Meeting"
                                ? Icons.calendar_today
                                : activityType == "Person"
                                    ? Icons.person
                                    : activityType == "Gaming"
                                        ? Icons.sports_esports
                                        : activityType == "checking"
                                            ? Icons.construction
                                            : activityType == "group call"
                                                ? Icons.group
                                                : Icons.alarm,
        color: overDue! ? Colors.red[400] : Colors.blue,
      ),
    );
  }
}
