import 'package:dawn/models/model_story.dart';
import 'package:get_it/get_it.dart';
import 'api_manager.dart';

final getIt = GetIt.instance;

void setUpServiceLocators(){
  getIt.registerSingleton<ApiService>(ApiService());
}