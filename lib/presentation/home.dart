import 'package:flutter/material.dart';
import 'package:flutter_ecatalog/bloc/add_product/add_product_bloc.dart';
import 'package:flutter_ecatalog/bloc/products/product_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecatalog/bloc/update_product/update_product_bloc.dart';
import 'package:flutter_ecatalog/data/datasource/local_datasource.dart';
import 'package:flutter_ecatalog/data/models/request/product_request_model.dart';
import 'package:flutter_ecatalog/presentation/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController? titleController;
  TextEditingController? priceController;
  TextEditingController? descriptionController;
  @override
  void initState() {
    titleController = TextEditingController();
    priceController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
    context.read<ProductBloc>().add(GetProductsEvent());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController!.dispose();
    priceController!.dispose();
    descriptionController!.dispose();
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
            icon: const Icon(Icons.logout),
          ),
          const SizedBox(
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
                // reverse: true,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('${state.data[index].title}'),
                      subtitle: Text('${state.data[index].price}'),
                      trailing:
                          BlocListener<UpdateProductBloc, UpdateProductState>(
                        listener: (context, state) {
                          if (state is UpdateProductSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Update Product success')));

                            context.read<ProductBloc>().add(GetProductsEvent());
                            titleController!.clear();
                            priceController!.clear();
                            descriptionController!.clear();
                            Navigator.pop(context);
                          }
                          if (state is AddProductError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Error')));
                          }
                        },
                        child: BlocBuilder<ProductBloc, ProductState>(
                          builder: (context, state) {
                            if (state is UpdateProductLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return ElevatedButton(
                              onPressed: () {
                                if (state is ProductSuccess) {
                                  titleController!.text =
                                      state.data[index].title!;
                                  priceController!.text =
                                      "${state.data[index].price!}";
                                  descriptionController!.text =
                                      state.data[index].description!;
                                }
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Update Product'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextField(
                                            controller: titleController,
                                            decoration: const InputDecoration(
                                                labelText: "Title"),
                                          ),
                                          TextField(
                                            controller: priceController,
                                            decoration: const InputDecoration(
                                                labelText: "Price"),
                                          ),
                                          TextField(
                                            controller: descriptionController,
                                            decoration: const InputDecoration(
                                                labelText: "Description"),
                                            maxLines: 3,
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                        const SizedBox(width: 2),
                                        ElevatedButton(
                                          onPressed: () {
                                            final model = ProductRequestModel(
                                              title: titleController!.text,
                                              price: int.parse(
                                                  priceController!.text),
                                              description:
                                                  descriptionController!.text,
                                            );

                                            if (state is ProductSuccess) {
                                              context
                                                  .read<UpdateProductBloc>()
                                                  .add(
                                                    DoUpdateProductEvent(
                                                      model: model,
                                                      id: state.data[index].id!,
                                                    ),
                                                  );
                                            }

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'Update Product success')));
                                            context
                                                .read<ProductBloc>()
                                                .add(GetProductsEvent());
                                            titleController!.clear();
                                            priceController!.clear();
                                            descriptionController!.clear();
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Update'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: const Text('Update edit'),
                            );
                          },
                        ),
                      ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          titleController!.text = '';
          priceController!.text = '';
          descriptionController!.text = '';
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Add Product'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: titleController,
                        decoration: const InputDecoration(labelText: "Title"),
                      ),
                      TextField(
                        controller: priceController,
                        decoration: const InputDecoration(labelText: "Price"),
                      ),
                      TextField(
                        controller: descriptionController,
                        decoration:
                            const InputDecoration(labelText: "Description"),
                        maxLines: 3,
                      )
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel')),
                    const SizedBox(
                      width: 8,
                    ),
                    BlocConsumer<AddProductBloc, AddProductState>(
                      listener: (context, state) {
                        if (state is AddProductSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Add Product success')));
                          context.read<ProductBloc>().add(GetProductsEvent());
                          titleController!.clear();
                          priceController!.clear();
                          descriptionController!.clear();
                          Navigator.pop(context);
                        }
                        if (state is AddProductError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('error')));
                        }
                      },
                      builder: (context, state) {
                        if (state is AddProductLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ElevatedButton(
                            onPressed: () {
                              final model = ProductRequestModel(
                                  title: titleController!.text,
                                  price: int.parse(priceController!.text),
                                  description: descriptionController!.text);

                              context
                                  .read<AddProductBloc>()
                                  .add(DoAddProductEvent(model: model));
                            },
                            child: const Text('Add'));
                      },
                    )
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
