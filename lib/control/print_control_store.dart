import 'package:mobx/mobx.dart';
import 'package:octopanic/api/api_instruciton.dart';
import 'package:octopanic/control/get_stream_url_usecase.dart';
import 'package:octopanic/control/send_command_usecase.dart';

part 'print_control_store.g.dart';

class PrintControlStore = _PrintControlStore with _$PrintControlStore;

abstract class _PrintControlStore with Store {
  final GetStreamUrlUseCase _getStreamUrlUseCase;
  final SendCommandUseCase _sendCommandUseCase;

  _PrintControlStore(
    this._getStreamUrlUseCase,
    this._sendCommandUseCase,
  );

  @observable
  String? _streamUrl;

  @observable
  bool showLoading = true;

  String? get streamUrl => _streamUrl;

  @action
  Future loadData() async {
    _streamUrl = await _getStreamUrlUseCase.execute();
    showLoading = false;
  }

  @action
  Future sendStopInstruction() async {
    _sendCommandUseCase.octoprintCommand = OctoprintCommand.emergencyStop;
    _sendCommandUseCase.octoprintCommandHandler = OctoprintCommandHandler.printer;
    _sendCommandUseCase.execute();
  }

  @action
  Future sendCancelInstruction() async {
    _sendCommandUseCase.octoprintCommand = OctoprintCommand.cancel;
    _sendCommandUseCase.octoprintCommandHandler = OctoprintCommandHandler.job;
    _sendCommandUseCase.execute();
  }
}
