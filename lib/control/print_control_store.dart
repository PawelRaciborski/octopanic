import 'package:mobx/mobx.dart';
import 'package:octopanic/control/get_stream_url_usecase.dart';

part 'print_control_store.g.dart';

class PrintControlStore = _PrintControlStore with _$PrintControlStore;

abstract class _PrintControlStore with Store {
  final GetStreamUrlUseCase _getStreamUrlUseCase;

  _PrintControlStore(this._getStreamUrlUseCase);

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
}
 
