import 'package:json_annotation/json_annotation.dart';

part 'api_models.g.dart';

@JsonSerializable()
class Settings {
  final Webcam? webcam;

  Settings(this.webcam);

  factory Settings.fromJson(Map<String, dynamic> json) => _$SettingsFromJson(json);
  Map<String,dynamic>toJson() => _$SettingsToJson(this);

}


@JsonSerializable()
class Webcam {
  // final Url streamUrl;
  final String streamRatio;

  Webcam(
    // this.streamUrl,
    this.streamRatio,
  );

  factory Webcam.fromJson(Map<String, dynamic> json) => _$WebcamFromJson(json);
  Map<String,dynamic>toJson() => _$WebcamToJson(this);
}
//
// class Printer {
//   final State state;
//
//   Printer(this.state);
// }
//
// class State {
//   final String error;
//   final Flags flags;
//
//   State(this.error, this.flags);
// }

// class Flags {
//   final bool cancelling;
//   final bool closedOrError;
//   final bool error;
//   final bool finishing;
//   final bool operational;
//   final bool paused;
//   final bool pausing;
//   final bool printing;
//   final bool ready;
//   final bool resuming;
//   final bool sdReady;
//
//   Flags(
//     this.cancelling,
//     this.closedOrError,
//     this.error,
//     this.finishing,
//     this.operational,
//     this.paused,
//     this.pausing,
//     this.printing,
//     this.ready,
//     this.resuming,
//     this.sdReady,
//   );
// }
