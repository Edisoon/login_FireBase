import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/ui/global_controllers/session_controller.dart';
import 'package:flutter_application_1/app/ui/global_controllers/theme_controller.dart';
import 'package:flutter_application_1/app/ui/global_widgets/dialogs/dialogs.dart';
import 'package:flutter_application_1/app/ui/global_widgets/dialogs/progress_dialog.dart';
import 'package:flutter_application_1/app/ui/global_widgets/dialogs/show_input_dialog.dart';
import 'package:flutter_application_1/app/ui/pages/home/tabs/profile/widgets/label_button.dart';
import 'package:flutter_application_1/app/ui/routes/routes.dart';
import 'package:flutter_application_1/app/ui/utils/colors.dart';
import 'package:flutter_application_1/app/ui/utils/dark_mode_extensions.dart';
import 'package:flutter_meedu/state.dart';
import 'package:flutter_meedu/router.dart' as router;

class ProfileTab extends ConsumerWidget {
  const ProfileTab({Key? key}) : super(key: key);

  void _updateDisplayname(BuildContext context) async {
    final sessionController = sessionProvider.read;
    final value = await showInputDialog(
      context,
      initialValue: sessionController.user!.displayName ?? "",
    );

    if (value != null) {
      ProgressDialog.show(context);
      final user = await sessionController.updateDisplayName(value);
      Navigator.pop(context);
      if (user == null) {
        Dialogs.alert(context,
            title: "ERROR", content: "Verifica tu conexion a internet");
      }
    }
  }

  @override
  Widget build(BuildContext context, ref) {
    final isDark = context.isDarkMode;
    final sessionController = ref.watch(sessionProvider);
    final theme = ref.watch(themeProvider);
    final user = sessionController.user!;
    final displayName = user.displayName ?? "";
    final letter = displayName.isNotEmpty ? displayName[0] : "";
    // print(user);
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: 15, vertical: 25
      ),
      children: [
        CircleAvatar(
          radius: 60,
          child: user.photoURL == null
              ? Text(
                  letter,
                  style: const TextStyle(fontSize: 65, color: Colors.black54),
                )
              : null,
          backgroundImage:
              user.photoURL != null ? NetworkImage(user.photoURL!) : null,
        ),
        const SizedBox(
          height: 5,
        ),
        Center(
          child: Text(
            displayName,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        Center(
          child: Text(user.email ?? ""),
        ),
        const SizedBox(
          height: 30,
        ),
        const Text("Data de Usuario"),

        LabelButton(
          label: "Nombre de Usuario:",
          value: displayName,
          iconData: Icons.edit_sharp,
          onPressed: () => _updateDisplayname(context),
        ),
        LabelButton(
          label: "Email:",
          value: user.email!,
        ),
        LabelButton(
          label: "Email Verificado:",
          value: user.emailVerified ? "Si" : "NO",
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Dark Mode:",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              CupertinoSwitch(
                value: theme.isDark,
                onChanged: (_) {
                  themeProvider.read.toggle();
                },
                activeColor: isDark? primaryDarkColor : primaryLigthColor,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 60,
        ),
        LabelButton(
          label: "Cerrar Session",
          value: "",
          onPressed: () async {
           await sessionProvider.read.singOut();
           router.pushNamedAndRemoveUntil(Routes.LOGIN);
          },
          iconData: Icons.exit_to_app,
        ),
      ],
    );
  }
}
