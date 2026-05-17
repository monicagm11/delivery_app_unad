import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FcmService {
  FcmService._();
  static final FcmService instance = FcmService._();

  final _messaging = FirebaseMessaging.instance;

  // Clave global para mostrar overlays sin contexto
  static final overlayKey = GlobalKey<_FcmOverlayHostState>();

  Future<void> init() async {
    // Solicitar permisos
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((message) {
      final title = message.notification?.title ?? '';
      final body = message.notification?.body ?? '';
      if (title.isEmpty && body.isEmpty) return;

      if (kIsWeb) {
        overlayKey.currentState?.show(title: title, body: body);
      }
      // En móvil puedes usar flutter_local_notifications aquí
    });
  }

  Future<String?> getToken() => _messaging.getToken(
        vapidKey: 'BCc73qYUFXjn6YUc-i7M3k85wFHUYYkegOrtWortizutXBIBLvM2Q3x1SqCAXH1kYpw2JCzHcOKEX5OCX276POs', // reemplaza con tu VAPID key de Firebase Console
      );
}

class FcmOverlayHost extends StatefulWidget {
  final Widget child;
  const FcmOverlayHost({super.key, required this.child});

  @override
  State<FcmOverlayHost> createState() => _FcmOverlayHostState();
}

class _FcmOverlayHostState extends State<FcmOverlayHost> {
  final List<_NotifData> _notifications = [];

  void show({required String title, required String body}) {
    final id = DateTime.now().millisecondsSinceEpoch;
    setState(() => _notifications.add(_NotifData(id: id, title: title, body: body)));
    Future.delayed(const Duration(seconds: 5), () => _dismiss(id));
  }

  void _dismiss(int id) {
    if (mounted) setState(() => _notifications.removeWhere((n) => n.id == id));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: FcmService.overlayKey,
      children: [
        widget.child,
        Positioned(
          top: 16,
          right: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: _notifications
                .map((n) => _NotifToast(
                      data: n,
                      onDismiss: () => _dismiss(n.id),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _NotifData {
  final int id;
  final String title;
  final String body;
  const _NotifData({required this.id, required this.title, required this.body});
}

class _NotifToast extends StatefulWidget {
  final _NotifData data;
  final VoidCallback onDismiss;
  const _NotifToast({required this.data, required this.onDismiss});

  @override
  State<_NotifToast> createState() => _NotifToastState();
}

class _NotifToastState extends State<_NotifToast>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _opacity = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        width: 320,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 4,
              height: 72,
              decoration: const BoxDecoration(
                color: Color(0xFF1565C0),
                borderRadius:
                    BorderRadius.horizontal(left: Radius.circular(12)),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 8, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.data.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 4),
                    Text(widget.data.body,
                        style: TextStyle(
                            fontSize: 13, color: Colors.grey.shade600),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, size: 16),
              onPressed: widget.onDismiss,
              padding: const EdgeInsets.all(8),
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ),
    );
  }
}
