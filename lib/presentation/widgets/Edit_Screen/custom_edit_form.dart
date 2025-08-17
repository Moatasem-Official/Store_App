import 'package:flutter/material.dart';

class CustomEditForm extends StatelessWidget {
  const CustomEditForm({
    super.key,
    required this.formKey,
    required this.imageController,
    required this.titleController,
    required this.priceController,
    required this.descriptionController,
    required this.categoryController,
    required this.isLoading,
    required this.onSave,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController imageController;
  final TextEditingController titleController;
  final TextEditingController priceController;
  final TextEditingController descriptionController;
  final TextEditingController categoryController;
  final bool isLoading;
  final Function() onSave;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: imageController,
            decoration: const InputDecoration(
              labelText: 'Image URL',
              border: OutlineInputBorder(),
            ),
            validator: (value) => value == null || value.isEmpty
                ? 'Please enter an image URL'
                : null,
          ),
          const SizedBox(height: 20),

          // Title
          TextFormField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Product Title',
              border: OutlineInputBorder(),
            ),
            validator: (value) =>
                value == null || value.isEmpty ? 'Please enter a title' : null,
          ),
          const SizedBox(height: 16),

          // Price
          TextFormField(
            controller: priceController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Price',
              border: OutlineInputBorder(),
            ),
            validator: (value) =>
                value == null || value.isEmpty ? 'Please enter a price' : null,
          ),
          const SizedBox(height: 16),

          // Description
          TextFormField(
            controller: descriptionController,
            decoration: const InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
            validator: (value) => value == null || value.isEmpty
                ? 'Please enter a description'
                : null,
          ),
          const SizedBox(height: 16),

          // Category
          TextFormField(
            controller: categoryController,
            decoration: const InputDecoration(
              labelText: 'Category',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),

          // Save button
          SizedBox(
            width: double.infinity,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: onSave,
              color: Colors.teal,
              textColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: isLoading
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      ),
                    )
                  : const Text('Save Changes', style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}
