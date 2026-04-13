import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttr/features/auth/controllers/auth_controller.dart';
import 'package:fluttr/theme/color.dart';
import 'package:fluttr/features/profile/controllers/profile_controller.dart';
import 'package:fluttr/models/user_model.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

final List<String> heightOptions = [
  'Do not show',
  ...List.generate(81, (i) => '${140 + i} cm'),
];
final List<String> weightOptions = [
  'Do not show',
  ...List.generate(101, (i) => '${40 + i} kg'),
];
final List<String> bodyTypeOptions = [
  'Do not show',
  'Average',
  'Slim',
  'Athletic',
  'Muscular',
  'Large',
];
final List<String> positionOptions = [
  'Do not show',
  'Top',
  'Versatile',
  'Bottom',
];
final List<String> ethnicityOptions = [
  'Do not show',
  'Asian',
  'Black',
  'Mixed',
  'White',
  'Other',
];
final List<String> relationshipStatusOptions = [
  'Do not show',
  'Single',
  'Dating',
  'Married',
  'Open Relationship',
];

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late UserModel _user;
  bool _isLoading = false;
  bool showAge = true;
  bool showPosition = true;

  String? height;
  String? weight;
  String? bodyType;
  String? position;
  String? ethnicity;
  String? relationshipStatus;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  final AuthController _authController = Get.put(AuthController());
  final ProfileController _profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    _user = _authController.userModel!;
    nameController.text = _user.displayName ?? '';
    aboutController.text = _user.bio ?? '';
    ageController.text = _user.age ?? '';

    showAge = _user.showAge ?? true;
    showPosition = _user.showPosition ?? true;

    height = _user.height;
    weight = _user.weight;
    bodyType = _user.bodyType;
    position = _user.position;
    ethnicity = _user.ethnicity;
    relationshipStatus = _user.relationshipStatus;
  }

  @override
  void dispose() {
    nameController.dispose();
    aboutController.dispose();
    ageController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    setState(() => _isLoading = true);

    final data = {
      'displayName': nameController.text.trim(),
      'bio': aboutController.text.trim(),
      'showAge': showAge,
      'showPosition': showPosition,
      'age': ageController.text.trim().isEmpty
          ? null
          : ageController.text.trim(),
      'height': height,
      'weight': weight,
      'bodyType': bodyType,
      'position': position,
      'ethnicity': ethnicity,
      'relationshipStatus': relationshipStatus,
    };

    try {
      await _profileController.updateUserProfile(_user.uid, data);

      Get.back();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to update profile')));
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
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
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          _isLoading
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                )
              : TextButton(
                  onPressed: _saveProfile,
                  child: Text(
                    'Save',
                    style: TextStyle(color: AppColors.primary),
                  ),
                ),
        ],
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

          SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              children: [
                Icon(Icons.straighten, color: Colors.grey[400], size: 18),
                SizedBox(width: 8),
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
                _buildInlineTextFieldTile(
                  'Age',
                  ageController,
                  'None',
                  TextInputType.number,
                ),
                Divider(color: dividerColor, height: 1, indent: 16),
                _buildValueTile('Height', height, () {
                  _showPicker(
                    'Height',
                    heightOptions,
                    height,
                    (val) => setState(() => height = val),
                  );
                }),
                Divider(color: dividerColor, height: 1, indent: 16),
                _buildValueTile('Weight', weight, () {
                  _showPicker(
                    'Weight',
                    weightOptions,
                    weight,
                    (val) => setState(() => weight = val),
                  );
                }),
                Divider(color: dividerColor, height: 1, indent: 16),
                _buildValueTile('Body Type', bodyType, () {
                  _showPicker(
                    'Body Type',
                    bodyTypeOptions,
                    bodyType,
                    (val) => setState(() => bodyType = val),
                  );
                }),
                Divider(color: dividerColor, height: 1, indent: 16),
                _buildSwitchTile(
                  'Show Position',
                  showPosition,
                  (val) => setState(() => showPosition = val),
                ),
                Divider(color: dividerColor, height: 1, indent: 16),
                _buildValueTile('Position', position, () {
                  _showPicker(
                    'Position',
                    positionOptions,
                    position,
                    (val) => setState(() => position = val),
                  );
                }),
                Divider(color: dividerColor, height: 1, indent: 16),
                _buildValueTile('Ethnicity', ethnicity, () {
                  _showPicker(
                    'Ethnicity',
                    ethnicityOptions,
                    ethnicity,
                    (val) => setState(() => ethnicity = val),
                  );
                }),
                Divider(color: dividerColor, height: 1, indent: 16),
                _buildValueTile('Relationship Status', relationshipStatus, () {
                  _showPicker(
                    'Relationship Status',
                    relationshipStatusOptions,
                    relationshipStatus,
                    (val) => setState(() => relationshipStatus = val),
                  );
                }),
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
            child: _buildImageSlot(imageUrl: _user.photoUrl, isMain: true),
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
                        child: _buildImageSlot(imageUrl: _user.photoUrl),
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
        borderRadius: BorderRadius.circular(2),
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
          SizedBox(height: 8),
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
          Text(
            'My Tags',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Add keywords to get found easier',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildInlineTextFieldTile(
    String title,
    TextEditingController controller,
    String hint, [
    TextInputType? keyboardType,
  ]) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      trailing: SizedBox(
        width: 150,
        child: TextField(
          controller: controller,
          textAlign: TextAlign.right,
          keyboardType: keyboardType ?? TextInputType.text,
          style: const TextStyle(color: Colors.white, fontSize: 16),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[600], fontSize: 16),
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.zero,
          ),
          onChanged: (text) => setState(() {}),
        ),
      ),
    );
  }

  // Widget cho mấy hàng thông số (Age, Height...)
  Widget _buildValueTile(String title, String? value, VoidCallback onTap) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      trailing: Text(
        value ?? '',
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      onTap: onTap,
    );
  }

  void _showPicker(
    String title,
    List<String> options,
    String? currentValue,
    ValueChanged<String?> onSelected,
  ) {
    int selectedIndex = currentValue != null
        ? options.indexOf(currentValue)
        : 0;
    if (selectedIndex == -1) selectedIndex = 0;

    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          height: 360,
          color: const Color(0xFF1F1F20),
          child: SafeArea(
            top: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  color: AppColors.primary,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.ibmPlexSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            if (selectedIndex == 0) {
                              onSelected(null);
                            } else {
                              onSelected(options[selectedIndex]);
                            }
                            Get.back();
                          },
                          child: const Text(
                            'Done',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: CupertinoPicker(
                    itemExtent: 52.0,
                    scrollController: FixedExtentScrollController(
                      initialItem: selectedIndex,
                    ),
                    onSelectedItemChanged: (index) {
                      selectedIndex = index;
                    },
                    children: options.map((option) {
                      return Center(
                        child: Text(
                          option,
                          style: GoogleFonts.ibmPlexSans(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
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
