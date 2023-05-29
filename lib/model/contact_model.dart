List<Contact> contacts = [
  Contact(
    username: 'Kevin Alvaro Adianto',
    email: 'kevin.alvaro@ti.ukdw.ac.id',
    avatar: 'assets/images/avatar1.png',
  ),
  Contact(
    username: 'William Suryadinata',
    email: 'william.suryadinata@ti.ukdw.ac.id',
    avatar: 'assets/images/avatar1.png',
  ),
  Contact(
    username: 'Richardo Chandra Hartono',
    email: 'richardo.chandra@ti.ukdw.ac.id',
    avatar: 'assets/images/avatar1.png',
  ),
  Contact(
    username: 'Haniif Ahmad Candraputra',
    email: 'haniif.ahmad@ti.ukdw.ac.id',
    avatar: 'assets/images/avatar1.png',
  ),
];

class Contact {
  final String username;
  final String email;
  final String avatar;

  Contact({
    required this.username,
    required this.email,
    required this.avatar,
  });
}