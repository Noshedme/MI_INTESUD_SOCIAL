import 'package:flutter/material.dart';
import 'package:mi_intesud_social/screens/store_screen.dart';
import 'package:mi_intesud_social/screens/profile_screen.dart';
import 'package:mi_intesud_social/pages/eventos_screen.dart';

class Post {
  int id;
  String name;
  String avatar;
  String role;
  String content;
  String time;
  int likes;
  int comments;
  bool liked;

  Post({
    required this.id,
    required this.name,
    required this.avatar,
    required this.role,
    required this.content,
    required this.time,
    required this.likes,
    required this.comments,
    this.liked = false,
  });
}

class HomeScreen extends StatefulWidget {
  final String username;

  const HomeScreen({
    super.key,
    required this.username,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final List<Post> posts = [
    Post(
      id: 1,
      name: "Juan Pérez",
      avatar: "https://i.pravatar.cc/150?img=1",
      role: "AVISO OFICIAL • DOCENTE",
      content:
          "Eventos de Base de Datos implementarán Teoría de Base de Datos y eventos de modo.",
      time: "Hace 2 horas",
      likes: 150,
      comments: 23,
    ),
    Post(
      id: 2,
      name: "María García",
      avatar: "https://i.pravatar.cc/150?img=5",
      role: "Estudiante",
      content: "¡Increíble conferencia sobre Inteligencia Artificial hoy!",
      time: "Hace 5 horas",
      likes: 230,
      comments: 45,
    ),
  ];

  void toggleLike(Post post) {
    setState(() {
      post.liked = !post.liked;

      if (post.liked) {
        post.likes++;
      } else {
        post.likes--;
      }
    });
  }

  void navigate(int index) {
    if (index == selectedIndex) return;

    setState(() {
      selectedIndex = index;
    });

    if (index == 0) return;

    if (index == 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Mensajes próximamente")),
      );
      return;
    }

    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const EventosScreen()),
      );
      return;
    }

    if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => StoreScreen(username: widget.username),
        ),
      );
      return;
    }

    if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProfileScreen(username: widget.username),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xff2DA679),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => StoreScreen(username: widget.username),
            ),
          );
        },
        icon: const Icon(Icons.store),
        label: const Text("¡Tienda!"),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff103B40),
                  Color(0xff0F5944),
                  Color(0xff2DA679),
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.school, color: Color(0xff2DA679)),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "MI INTESUD SOCIAL",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              "Comunidad Institucional",
                              style: TextStyle(
                                color: Color(0xff96D9C0),
                                fontSize: 12,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.search, color: Colors.white),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.notifications, color: Colors.white),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 15),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Buscar publicaciones, personas, eventos...",
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(15),
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            backgroundImage:
                                NetworkImage("https://i.pravatar.cc/150?img=10"),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "¿Qué está pasando en la universidad?",
                                filled: true,
                                fillColor: const Color(0xffF2F2F2),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        children: [
                          TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.trending_up),
                            label: const Text("Tendencias"),
                            style: TextButton.styleFrom(
                              foregroundColor: const Color(0xff103B40),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.add),
                            label: const Text("Multimedia"),
                            style: TextButton.styleFrom(
                              foregroundColor: const Color(0xff103B40),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff2DA679),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text("Publicar"),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                ...posts.map((post) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(post.avatar),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    post.name,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    post.role,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    post.time,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Icon(Icons.more_horiz)
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(post.content),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.favorite, size: 16, color: Colors.green),
                            const SizedBox(width: 4),
                            Text("${post.likes}"),
                            const SizedBox(width: 15),
                            Text("${post.comments} comentarios"),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton.icon(
                              onPressed: () => toggleLike(post),
                              icon: Icon(
                                Icons.favorite,
                                color: post.liked ? Colors.green : Colors.grey,
                              ),
                              label: const Text("Me gusta"),
                            ),
                            TextButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.comment),
                              label: const Text("Comentar"),
                            ),
                            TextButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.share),
                              label: const Text("Compartir"),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                }).toList()
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: const Color(0xff2DA679),
        unselectedItemColor: Colors.grey,
        onTap: navigate,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Mensajes"),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: "Eventos"),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: "Tienda"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],
      ),
    );
  }
}