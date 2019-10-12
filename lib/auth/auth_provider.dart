import 'package:flutter/material.dart';
import 'package:hosrem_app/network/api_provider.dart';

/// Auth provider widget.
///
/// This widget is used to handle 401 response from backend and redirect to login page automatically.
@immutable
class AuthProvider extends StatefulWidget {
  const AuthProvider({
    Key key,
    this.child,
    this.apiProvider,
    this.handleUnauthorized
  }) : super(key: key);

  final Widget child;
  final ApiProvider apiProvider;
  final Function(BuildContext) handleUnauthorized;

  @override
  State<AuthProvider> createState() => _AuthProviderState();
}

class _AuthProviderState extends State<AuthProvider> {
  bool _handleUnauthorized = false;

  @override
  void initState() {
    widget.apiProvider.registerUnauthorizedEvent(_onUnauthorized);
    super.initState();
  }

  void _onUnauthorized() {
    if (!_handleUnauthorized) {
      _handleUnauthorized = true;
      widget.handleUnauthorized(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: widget.child);
  }
}
