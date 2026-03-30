import 'package:flutter/material.dart';
import 'package:fluttr/shared/data.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool showAge = true;
  bool showPosition = true;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    aboutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color sectionColor = Color(0xFF1F1F20);
    final Color dividerColor = Color(0xFF434343);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _buildPhotoGrid(),
          Container(
            color: sectionColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextFieldTile(
                  label: 'Display Name',
                  controller: nameController,
                  maxLength: 15,
                  hintText: 'Other will see this on the grid',
                ),
                Divider(color: dividerColor, height: 1, indent: 16),
                _buildTextFieldTile(
                  label: 'About Me',
                  controller: aboutController,
                  maxLength: 255,
                  maxLines: 4,
                  hintText:
                      'Tell people who you are and what you\'re looking for (not what you\'re not looking for)',
                ),
                Divider(color: dividerColor, height: 1, indent: 16),
                _buildTagTile(),
              ],
            ),
          ),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              children: [
                Icon(Icons.straighten, color: Colors.grey[400], size: 18),
                const SizedBox(width: 8),
                Text(
                  'STATS',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          Container(
            color: sectionColor,
            child: Column(
              children: [
                _buildSwitchTile(
                  'Show Age',
                  showAge,
                  (val) => setState(() => showAge = val),
                ),
                Divider(color: dividerColor, height: 1, indent: 16),
                _buildValueTile('Age', '24'),
                Divider(color: dividerColor, height: 1, indent: 16),
                _buildValueTile('Height', '176 cm'),
                Divider(color: dividerColor, height: 1, indent: 16),
                _buildValueTile('Weight', '72 kg'),
                Divider(color: dividerColor, height: 1, indent: 16),
                _buildValueTile('Body Type', 'Average'),
                Divider(color: dividerColor, height: 1, indent: 16),
                _buildSwitchTile(
                  'Show Position',
                  showPosition,
                  (val) => setState(() => showPosition = val),
                ),
                Divider(color: dividerColor, height: 1, indent: 16),
                _buildValueTile('Position', 'Versatile'),
                Divider(color: dividerColor, height: 1, indent: 16),
                _buildValueTile('Ethnicity', ''),
                Divider(color: dividerColor, height: 1, indent: 16),
                _buildValueTile('Relationship Status', ''),
              ],
            ),
          ),

          SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildPhotoGrid() {
    return Container(
      color: Colors.black,
      height: 350, // Set cứng height hoặc dùng AspectRatio tùy m
      child: Row(
        spacing: 1,
        children: [
          Expanded(
            flex: 1,
            child: _buildImageSlot(imageUrl: mockUser.photoUrl, isMain: true),
          ),

          Expanded(
            flex: 1,
            child: Column(
              spacing: 1,
              children: [
                Expanded(
                  child: Row(
                    spacing: 1,
                    children: [
                      Expanded(
                        child: _buildImageSlot(imageUrl: mockUser.photoUrl),
                      ),
                      Expanded(child: _buildImageSlot()),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    spacing: 1,
                    children: [
                      Expanded(child: _buildImageSlot()),
                      Expanded(child: _buildImageSlot()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Từng ô ảnh trong lưới
  Widget _buildImageSlot({String? imageUrl, bool isMain = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[800], // Màu nền của ô trống
        borderRadius: .circular(2),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (imageUrl != null) Image.network(imageUrl, fit: BoxFit.cover),
          if (isMain)
            Positioned(
              bottom: 8,
              left: 8,
              child: Icon(Icons.image_outlined, color: Colors.white, size: 28),
            ),
        ],
      ),
    );
  }

  Widget _buildTextFieldTile({
    required String label,
    required TextEditingController controller,
    required int maxLength,
    int maxLines = 1,
    String? hintText,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${controller.text.length}/$maxLength',
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            maxLines: maxLines,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey[500], fontSize: 16),
            ),
            onChanged: (text) => setState(() {}), // Cập nhật lại số đếm ký tự
          ),
        ],
      ),
    );
  }

  Widget _buildTagTile() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Tags',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add keywords to get found easier',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
        ],
      ),
    );
  }

  // Widget cho mấy hàng thông số (Age, Height...)
  Widget _buildValueTile(String title, String value) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      trailing: Text(
        value,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      onTap: () {
        // M code logic mở BottomSheet chọn thông số ở đây
      },
    );
  }

  // Widget cho Switch (Show Age, Show Position)
  Widget _buildSwitchTile(
    String title,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return SwitchListTile.adaptive(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      value: value,
      onChanged: onChanged,
      activeTrackColor: Colors.amber, // Màu vàng cam giống trong ảnh
    );
  }
}
