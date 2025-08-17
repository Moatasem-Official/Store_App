import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/business_logic/cubits/cubit/products_cubit.dart';
import 'package:store_app/data/models/product_model.dart';
import 'package:store_app/presentation/widgets/Edit_Screen/custom_edit_form.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key, required this.product});

  final ProductModel product;

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;
  late TextEditingController _categoryController;
  late TextEditingController _imageController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _imageController = TextEditingController(text: widget.product.image);
    _titleController = TextEditingController(text: widget.product.title);
    _priceController = TextEditingController(
      text: widget.product.price?.toString() ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.product.description,
    );
    _categoryController = TextEditingController(text: widget.product.category);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  void _saveChanges() async {
    if (_formKey.currentState!.validate()) {
      final updatedProduct = widget.product.copyWith(
        id: widget.product.id,
        title: _titleController.text,
        price: double.tryParse(_priceController.text),
        description: _descriptionController.text,
        image: _imageController.text,
        category: _categoryController.text,
      );

      await context.read<ProductsCubit>().updateProduct(
        updatedProduct,
        widget.product.id!,
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductsCubit, ProductsState>(
      listener: (context, state) {
        if (state is ProductsActionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              duration: Duration(seconds: 2),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              content: Text(
                'Product Updated Successfully',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          );
          setState(() {
            _isLoading = false;
          });
        } else if (state is ProductsError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
          setState(() {
            _isLoading = false;
          });
        } else if (state is ProductsActionLoading) {
          setState(() {
            _isLoading = true;
          });
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          title: const Text('Edit Product', style: TextStyle(fontSize: 24)),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: CustomEditForm(
            formKey: _formKey,
            titleController: _titleController,
            priceController: _priceController,
            descriptionController: _descriptionController,
            categoryController: _categoryController,
            imageController: _imageController,
            onSave: _saveChanges,
            isLoading: _isLoading,
          ),
        ),
      ),
    );
  }
}
