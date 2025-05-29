//import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:trackwise/features/mapping_service/service/mapping_service.dart';
import 'package:trackwise/features/programs/provider/program_provider.dart';
import '../../features/auth/auth_library.dart';

class DependencyInjection {
  static Future<List<SingleChildWidget>> initialize() async {
    
    final prefs = await SharedPreferences.getInstance();
    //final client = http.Client();

    final localDataSource = AuthLocalDataSourceImpl(prefs);
    final remoteDataSource = AuthRemoteDataSourceImpl();
    final authRepository = AuthRepositoryImpl(remoteDataSource: remoteDataSource, localDataSource: localDataSource);
    final loginViewModel = LoginViewModel(authRepository);

    final logoutUseCase = LogoutUseCase(authRepository);
    final logoutViewModel = LogoutViewModel(logoutUseCase);
    final programProvider = ProgramProvider();
    //final mappingService = MappingService(client: client);

    return [
      ChangeNotifierProvider(create: (_) => loginViewModel),
      ChangeNotifierProvider(create: (_) => logoutViewModel),
      ChangeNotifierProvider(create: (_) => programProvider),
      //mappingService,
    ];
  }
}
