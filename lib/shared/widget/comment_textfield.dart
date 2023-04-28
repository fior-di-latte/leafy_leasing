// Project imports:
import 'package:leafy_leasing/shared/base.dart';

class CommentTextField extends StatelessWidget {
  const CommentTextField(
    this.commentTextController, {
    super.key,
  });

  final TextEditingController commentTextController;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: commentTextController,
      maxLines: 4,
      decoration: InputDecoration(
        labelText: 'Comment (optional)',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
