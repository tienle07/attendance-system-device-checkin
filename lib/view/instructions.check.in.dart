import 'package:flutter/material.dart';
import 'package:staras_checkin/constants/constant.dart';

class InstructionsCheckInPage extends StatefulWidget {
  const InstructionsCheckInPage({Key? key}) : super(key: key);

  @override
  State<InstructionsCheckInPage> createState() =>
      _InstructionsCheckInPageState();
}

class _InstructionsCheckInPageState extends State<InstructionsCheckInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Instructions Page",
          // You can customize the style based on your design
          style: kTextStyle.copyWith(
              fontWeight: FontWeight.bold, fontSize: 20, color: kDarkWhite),
        ),
        centerTitle: true,
        backgroundColor: kMainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildInstructionStep(
              title: 'CheckIn and CheckOut Device',
              description:
                  'CheckIn and CheckOut can only be done at the store\'s devices.',
            ),
            _buildInstructionStep(
              title: 'Single Face Verification',
              description:
                  'CheckIn and CheckOut are only performed for 1 face.',
            ),
            _buildInstructionStep(
              title: 'Face Clarity Check',
              description: 'Check if the face is blurred or unclear.',
            ),
            _buildInstructionStep(
              title: 'Choose Well-Lit Area',
              description:
                  'To perform CheckIn and CheckOut, choose a place in the store with enough light to clearly see your face.',
            ),
            _buildInstructionStep(
              title: 'Click CheckIn or CheckOut',
              description:
                  'Click CheckIn or CheckOut, and the system sends a Success notification. You have completed the process.',
            ),
            _buildInstructionStep(
              title: 'Retry on Failure',
              description:
                  'If you fail, please try again 1 to 3 times. If it still fails, please take a screenshot of the error and send help. We will assist you immediately.',
            ),
            _buildInstructionStep(
              title: 'Check Attendance',
              description:
                  'After CheckIn and CheckOut, check attendance at your Employee App.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructionStep({
    required String title,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.arrow_forward,
              color: kMainColor,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              title,
              style: kTextStyle.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            description,
            maxLines: 3,
            style: kTextStyle.copyWith(fontSize: 15),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:staras_checkin/constants/constant.dart';

// class InstructionsCheckInPage extends StatefulWidget {
//   const InstructionsCheckInPage({Key? key}) : super(key: key);

//   @override
//   State<InstructionsCheckInPage> createState() =>
//       _InstructionsCheckInPageState();
// }

// class _InstructionsCheckInPageState extends State<InstructionsCheckInPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Instructions Page",
//           style: kTextStyle.copyWith(
//               fontWeight: FontWeight.bold, fontSize: 20, color: kDarkWhite),
//         ),
//         centerTitle: true,
//         backgroundColor: kMainColor,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             InstructionItem(
//               text:
//                   "CheckIn and CheckOut with your face. Note that CheckIn/CheckOut can only be done at the store's devices.",
//             ),
//             InstructionItem(
//               text: "CheckIn and CheckOut are only performed for 1 face.",
//             ),
//             InstructionItem(
//               text: "Check if the face is blurred or unclear.",
//             ),
//             InstructionItem(
//               text:
//                   "To perform CheckIn and CheckOut, you need to choose a place in the store with enough light to clearly see your face.",
//             ),
//             InstructionItem(
//               text:
//                   "Click CheckIn and CheckOut, the system sends a Success notification. You have completed the process.",
//             ),
//             InstructionItem(
//               text:
//                   "If you fail, please try again 1 to 3 times. If it still fails, please take a screenshot of the error and send help. We will assist you immediately.",
//             ),
//             InstructionItem(
//               text:
//                   "After CheckIn and CheckOut, check attendance at your Employee App.",
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class InstructionItem extends StatelessWidget {
//   final String text;

//   const InstructionItem({Key? key, required this.text}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(
//             Icons.arrow_forward,
//             color: kMainColor,
//           ),
//           SizedBox(width: 8),
//           Expanded(
//             child: Text(
//               text,
//               style: kTextStyle.copyWith(fontSize: 16),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
