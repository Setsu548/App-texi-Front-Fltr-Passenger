import 'package:flutter/material.dart';

class ModalOptionsImagePicker extends StatelessWidget {
  final List<ModalOptionImage> options;
  const ModalOptionsImagePicker({super.key, required this.options});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Wrap(
        children: <Widget>[
          ...options.map(
            (option) => ListTile(
              leading: Icon(
                option.icon,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text(
                option.title,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              onTap: option.onTap,
            ),
          ),
        ],
      ),
    );
  }
}

class ModalOptionImage {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  ModalOptionImage({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}
