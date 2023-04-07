import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:octopanic/api/api_instruciton.dart';
import 'package:octopanic/api/api_models.dart';
import 'package:octopanic/control/get_jobinfo_usecase.dart';
import 'package:octopanic/control/get_stream_url_usecase.dart';
import 'package:octopanic/control/send_command_usecase.dart';

part 'print_control_store.g.dart';

// ignore: library_private_types_in_public_api
class PrintControlStore = _PrintControlStore with _$PrintControlStore;

abstract class _PrintControlStore with Store {
  final GetStreamUrlUseCase _getStreamUrlUseCase;
  final SendCommandUseCase _sendCommandUseCase;
  final GetJobInfoUseCase _getJobInfoUseCase;

  _PrintControlStore(
    this._getStreamUrlUseCase,
    this._sendCommandUseCase,
    this._getJobInfoUseCase,
  );

  @observable
  String? _streamUrl;

  @observable
  bool showLoading = true;

  String? get streamUrl => _streamUrl;

  @observable
  double _completion = 0.0;

  double get completion => _completion;

  @observable
  String? _fileName;

  String? get fileName => _fileName;

  @observable
  JobState _jobState = JobState.offline;

  JobState get jobState => _jobState;

  StreamSubscription<JobInfo>? _subscription;

  @action
  Future loadData() async {
    _streamUrl = await _getStreamUrlUseCase.execute();
    _updatePrintDetails();
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

  Future _updatePrintDetails() async {
    _subscription?.cancel();
    _subscription = _getJobInfoUseCase.execute().listen((jobInfo) {
      _completion = jobInfo.progress.completion ?? 0.0;
      _fileName = jobInfo.job.file.display;
      _jobState = jobInfo.state;
    });
  }
}
