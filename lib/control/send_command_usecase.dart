import 'package:octopanic/api/api.dart';
import 'package:octopanic/api/api_instruciton.dart';

class SendCommandUseCase {
  final RestClientInteractor _restClientInteractor;

  late OctoprintCommandHandler octoprintCommandHandler;
  late OctoprintCommand octoprintCommand;

  SendCommandUseCase(this._restClientInteractor,);

  Future<bool> execute() async {
    try {
      await _restClientInteractor.postPrinterCommand(
          OctoprintInstruction(octoprintCommandHandler, octoprintCommand));
      return true;
    } catch (exception) {
      return false;
    }
  }
}
