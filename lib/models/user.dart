class User {
  final String? id;
  final String nome;
  final String email;
  final String? avatarUrl;

  const User(
      {this.id, required this.email, required this.nome, this.avatarUrl});
}
