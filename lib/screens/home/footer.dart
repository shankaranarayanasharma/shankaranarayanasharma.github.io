import 'package:flutter/material.dart';
import 'package:flutter_profile/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class DS8Footer extends StatelessWidget {
  const DS8Footer({Key? key}) : super(key: key);
  Widget getSourceCode(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          launchUrl(Constants.repoURL);
        },
        child: Tooltip(
          message: Constants.repoURL.toString(),
          child: Text(
            'Get Source Code',
            style: TextStyle(
              color: Color.fromRGBO(1, 159, 171, 1.0),
              fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
              fontWeight: Theme.of(context).textTheme.bodyMedium!.fontWeight,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: secondaryColor,
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          SelectableText(
            '${Constants.appName}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          // const SizedBox(
          //   height: 10,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     SelectableText(
          //       "2",
          //       style: Theme.of(context).textTheme.bodyMedium,
          //     ),
          //     const SizedBox(
          //       width: 5,
          //     ),
          //     getSourceCode(context),
          //   ],
          // ),
          const SizedBox(
            height: 10,
          ),
          SelectableText(
            Constants.copyright,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}