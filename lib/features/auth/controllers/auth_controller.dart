import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttr/models/user_model.dart';
import 'package:fluttr/features/auth/services/auth_service.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();

  final Rx<User?> _user = Rxn<User>();
  final Rx<UserModel?> _userModel = Rxn<UserModel>();
  final RxBool _isLoading = true.obs;
  final RxBool _isAuthenticated = false.obs;
  final RxBool _isInitialized = false.obs;

  User? get user => _user.value;
  UserModel? get userModel => _userModel.value;
  bool get isLoading => _isLoading.value;
  bool get isAuthenticated => _isAuthenticated.value;
  bool get isInitialized => _isInitialized.value;

  @override
  void onInit() {
    super.onInit();
    _user.bindStream(_authService.firebaseAuth.authStateChanges());
    ever(_user, onAuthStateChanges);
  }

  void onAuthStateChanges(User? user) async {
    if (user != null) {
      _userModel.value = await _authService.firestoreService.getUser(user.uid);
      _isAuthenticated.value = true;
    }

    if (!_isInitialized.value) _isInitialized.value = true;
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      _isLoading.value = true;

      UserModel? user = await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (user != null) {
        _userModel.value = user;
      }
    } catch (e) {
      Get.snackbar('Login error', e.toString());
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      _isLoading.value = true;

      UserModel? user = await _authService.signInWithGoogle();

      if (user != null) {
        _userModel.value = user;
      }
    } catch (e) {
      Get.snackbar('Login error', e.toString());
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      _isLoading.value = true;

      UserCredential userCredential = await _authService.firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user == null) {
        throw Exception('Failed to create user');
      }

      UserModel user = UserModel(
        uid: userCredential.user!.uid,
        email: email,
        displayName: userCredential.user!.displayName,
        photoUrl: userCredential.user!.photoURL,
        isOnline: true,
        lastSeen: DateTime.now(),
        createdAt: DateTime.now(),
      );

      await _authService.firestoreService.createUser(user);

      _userModel.value = user;
    } catch (e) {
      Get.snackbar('Sign-up error', e.toString());
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    try {
      _isLoading.value = true;
      await _authService.signOut();
      _userModel.value = null;
    } catch (e) {
      Get.snackbar('Logout error', e.toString());
    } finally {
      _isLoading.value = false;
    }
  }

  void updateUserModel(UserModel user) {
    _userModel.value = user;
  }
}
