import 'package:envied/envied.dart';

//run "make generate_env" from the command line on first run or on modification of this file or .env to generate the latest .env variables.
//Generated code is output to the part file shown on the next line.
part '../generated/env/env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'MY_ENVIRONMENT_VARIABLE', obfuscate: true)
  static final String myEnvironmentVariable = _Env.myEnvironmentVariable;
}
