import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ImageCubit extends Cubit<String> {
  ImageCubit() : super('');

  void removeImage() => emit('');

  void updateImage(String path) => emit(path);

  Future<void> getImage(ImageSource source) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: source);
    final path = image != null ? image.path : '';
    emit(path);
  }
}
