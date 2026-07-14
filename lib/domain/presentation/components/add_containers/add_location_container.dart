import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:look_back/global.dart';

class AddLocationContainer extends StatefulWidget {
  const AddLocationContainer({
    super.key,
    this.onLocationSelected,
    this.initialLocation,
    this.label = 'Adicionar localização',
  });

  final ValueChanged<String?>? onLocationSelected;
  final String? initialLocation;
  final String label;

  @override
  State<AddLocationContainer> createState() => _AddLocationContainerState();
}

class _AddLocationContainerState extends State<AddLocationContainer> {
  String? _location;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _location = widget.initialLocation;
  }

  Future<void> _pickLocation() async {
    setState(() => _loading = true);

    try {
      final position = await locationService.getCurrentPosition();
      final address = await locationService.getAddressFromCoordinates(
        latitude: position.latitude,
        longitude: position.longitude,
      );

      if (!mounted) return;

      setState(() {
        _location = address;
        _loading = false;
      });
      widget.onLocationSelected?.call(_location);
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _location = 'Localização indisponível';
        _loading = false;
      });
      widget.onLocationSelected?.call(null);
    }
  }

  void _removeLocation() {
    setState(() => _location = null);
    widget.onLocationSelected?.call(null);
  }

  void _openSourceSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text('Adicionar localização'),
        message: const Text('Use a sua localização atual ou remova a seleção'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              _pickLocation();
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.location_fill),
                SizedBox(width: 8),
                Text('Usar localização atual'),
              ],
            ),
          ),
          if (_location != null)
            CupertinoActionSheetAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.pop(context);
                _removeLocation();
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.trash),
                  SizedBox(width: 8),
                  Text('Remover localização'),
                ],
              ),
            ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => _openSourceSheet(context),
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.colorScheme.onSecondary),
        ),
        child: Row(
          children: [
            Icon(
              CupertinoIcons.location_fill,
              color: theme.colorScheme.primary,
              size: 22,
            ),
            const SizedBox(width: 12),
            Text(
              widget.label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const Spacer(),
            if (_loading)
              SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: theme.colorScheme.primary,
                ),
              )
            else if (_location != null)
              Expanded(
                child: Text(
                  _location!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 14,
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              )
            else
              Text(
                'Localização',
                style: TextStyle(
                  fontSize: 14,
                  color: theme.colorScheme.onSurface.withOpacity(0.4),
                ),
              ),
            const SizedBox(width: 4),
            Icon(
              CupertinoIcons.chevron_right,
              color: theme.colorScheme.onSurface.withOpacity(0.4),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
