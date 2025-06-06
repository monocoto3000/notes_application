import 'package:flutter/material.dart';
import 'package:notes_application/features/category/data/models/category.model.dart';
import 'package:notes_application/features/category/domain/usecases/createCategory.usecase.dart';
import 'package:notes_application/injection.container.dart';

class NewCategoryModal extends StatefulWidget {
  final void Function(Category)? onCategoryCreated;
  const NewCategoryModal({super.key, this.onCategoryCreated});

  @override
  State<NewCategoryModal> createState() => _NewCategoryModalState();
}

class _NewCategoryModalState extends State<NewCategoryModal> {
  final _nameController = TextEditingController();
  String? _selectedColor = "#FF3B30"; 
  bool _loading = false;

  final List<Map<String, dynamic>> _colors = [
    {"name": "Rojo", "color": "#FF3B30"},
    {"name": "Naranja", "color": "#FF9500"},
    {"name": "Amarillo", "color": "#FFCC00"},
    {"name": "Verde", "color": "#34C759"},
    {"name": "Turquesa", "color": "#00C7BE"},
    {"name": "Cian", "color": "#32ADE6"},
    {"name": "Azul", "color": "#007AFF"},
    {"name": "Indigo", "color": "#5856D6"},
    {"name": "Morado", "color": "#AF52DE"},
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(0),
      child: Container(
        width: 375,
        height: 480,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 20,
              top: 20,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: const ShapeDecoration(
                    color: Colors.black,
                    shape: OvalBorder(),
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 18),
                ),
              ),
            ),
            const Positioned(
              left: 20,
              top: 60,
              child: Text(
                'Nueva categoría',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontFamily: 'Karla',
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const Positioned(
              left: 22,
              top: 110,
              child: Text(
                'Nombre',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontFamily: 'Karla',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Positioned(
              left: 22,
              top: 140,
              right: 22,
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: "Nombre",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
              ),
            ),
            const Positioned(
              left: 22,
              top: 200,
              child: Text(
                'Color',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontFamily: 'Karla',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Positioned(
              left: 22,
              top: 230,
              right: 22,
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _colors.map((c) {
                  final isSelected = _selectedColor == c["color"];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedColor = c["color"];
                      });
                    },
                    child: Container(
                      width: 96,
                      height: 36,
                      decoration: ShapeDecoration(
                        color: isSelected ? _parseColor(c["color"]) : Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            color: _parseColor(c["color"]),
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          c["name"],
                          style: TextStyle(
                            color: isSelected ? Colors.white : _parseColor(c["color"]),
                            fontSize: 12,
                            fontFamily: 'Karla',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Positioned(
              left: 122,
              top: 400,
              child: GestureDetector(
                onTap: _loading ? null : () async {
                  final name = _nameController.text.trim();
                  if (name.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Ingresa un nombre')),
                    );
                    return;
                  }
                  setState(() => _loading = true);
                  final usecase = sl<CreateCategoryUseCase>();
                  final result = await usecase(Category.create(
                    name: name,
                    color: _selectedColor!,
                  ));
                  setState(() => _loading = false);
                  result.fold(
                    (error) => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: $error')),
                    ),
                    (category) {
                      widget.onCategoryCreated?.call(category);
                      Navigator.of(context).pop(true);
                    },
                  );
                },
                child: Container(
                  width: 132,
                  height: 36,
                  decoration: ShapeDecoration(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Center(
                    child: _loading
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : const Text(
                            'Guardar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'Karla',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _parseColor(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    return Color(int.parse("0xFF$hexColor"));
  }
}