import 'package:flutter/material.dart';
import 'package:flutter_ecatalog/bloc/products/product_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecatalog/data/datasource/local_datasource.dart';
import 'package:flutter_ecatalog/presentation/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(GetProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('homepage'),
        elevation: 5,
        actions: [
          IconButton(
            onPressed: () async {
              await LocalDataSource().removeToken();
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return const LoginPage();
              }));
            },
            icon: Icon(Icons.logout),
          ),
          SizedBox(
            width: 16,
          )
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductSuccess) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('${state.data[index].title}'),
                      subtitle: Text('${state.data[index].price}'),
                    ),
                  );
                },
                itemCount: state.data.length,
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
