// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter_crud/provider/users.dart';
// import 'package:flutter_crud/routes/app_routes.dart';
// import 'package:provider/provider.dart';

// import '../models/user.dart';

// class UserTile extends StatelessWidget {
//   final User? user;

//   const UserTile(
//     this.user, {
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // final Users users = Provider.of(context);
//     final avatar = user!.avatarUrl == null || user!.avatarUrl!.isEmpty
//         ? CircleAvatar(child: Icon(Icons.person))
//         : CircleAvatar(backgroundImage: NetworkImage(user!.avatarUrl!));
//     return ListTile(
//         leading: avatar,
//         title: Text(user!.nome),
//         subtitle: Text(user!.email),
//         trailing: SizedBox(
//           width: 100,
//           child: Row(children: [
//             IconButton(
//               onPressed: () {
//                 Navigator.of(context).pushNamed(
//                   AppRoutes.USER_FORM,
//                   arguments: user,
//                 );
//               },
//               color: Colors.orange,
//               icon: const Icon(Icons.edit),
//             ),
//             IconButton(
//               onPressed: () {
//                 showDialog(
//                   context: context,
//                   builder: (ctx) => AlertDialog(
//                     title: Text("Deseja Excluir Usuário?"),
//                     content: Text("Tem Certeza?"),
//                     actions: [
//                       TextButton(
//                           onPressed: () => Navigator.of(context).pop(false),
//                           child: Text('Não')),
//                       TextButton(
//                           onPressed: () => Navigator.of(context).pop(true),
//                           child: Text("Sim"))
//                     ],
//                   ),
//                 ).then((confirmed) {
//                   if (confirmed) {
//                     Provider.of<Users>(context, listen: false).remove(user!);
//                   }
//                 });
//               },
//               color: Colors.red,
//               icon: const Icon(Icons.delete),
//             )
//           ]),
//         ));
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {
  final User? user;

  const UserTile(
    this.user, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final avatar = user!.avatarUrl == null || user!.avatarUrl!.isEmpty
        ? const CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(user!.avatarUrl!));
    return ListTile(
      leading: avatar,
      title: Text(user!.nome),
      subtitle: Text(user!.email),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              color: Colors.orange,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.USER_FORM,
                  arguments: user,
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Excluir Usuário'),
                    content: Text('Tem certeza???'),
                    actions: [
                      TextButton(
                        child: Text('Não'),
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                      TextButton(
                        child: Text('Sim'),
                        onPressed: () => Navigator.of(context).pop(true),
                      ),
                    ],
                  ),
                ).then((confirmed) {
                  if (confirmed) {
                    Provider.of<Users>(context, listen: false).remove(user!);
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
