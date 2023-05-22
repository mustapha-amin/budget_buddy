import 'package:flutter/material.dart';
import '../screens/add_account.dart';

class AddAccountButton extends StatelessWidget {
  const AddAccountButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton.outlined(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const AddAccount();
              }));
            },
            icon: const Icon(Icons.add),
          ),
          const Text("Add account"),
        ],
      ),
    );
  }
}
