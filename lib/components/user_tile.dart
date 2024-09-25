import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String name;
  final void Function()? onTap;
  const UserTile({
    super.key,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 30),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            const Icon(Icons.person),
            const SizedBox(
              width: 50,
            ),
            Text(name),
          ],
        ),
      ),
    );
  }
}
