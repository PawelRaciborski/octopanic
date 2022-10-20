import 'package:json_annotation/json_annotation.dart';

part 'api_models.g.dart';

@JsonSerializable()
class Settings {
  final Webcam? webcam;

  Settings(this.webcam);

  factory Settings.fromJson(Map<String, dynamic> json) =>
      _$SettingsFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsToJson(this);
}

@JsonSerializable()
class Webcam {
  final String streamUrl;
  final String streamRatio;

  Webcam(
    this.streamUrl,
    this.streamRatio,
  );

  factory Webcam.fromJson(Map<String, dynamic> json) => _$WebcamFromJson(json);

  Map<String, dynamic> toJson() => _$WebcamToJson(this);
}

@JsonSerializable()
class Command {
  final String command;
  final String? action;

  Command(this.command, [this.action]);

  factory Command.fromJson(Map<String, dynamic> json) =>
      _$CommandFromJson(json);

  Map<String, dynamic> toJson() => _$CommandToJson(this);
}

@JsonSerializable()
class File {
  final int? date;
  final String? display;
  final String? name;
  final String? origin;
  final String? path;
  final int? size;

  File(this.date, this.display, this.name, this.origin, this.path, this.size);

  factory File.fromJson(Map<String, dynamic> json) => _$FileFromJson(json);

  Map<String, dynamic> toJson() => _$FileToJson(this);
}

@JsonSerializable()
class Progress {
  final double? completion;
  final int? filepos;
  final int? printTime;
  final int? printTimeLeft;
  final String? printTimeLeftOrigin;

  Progress(
    this.completion,
    this.filepos,
    this.printTime,
    this.printTimeLeft,
    this.printTimeLeftOrigin,
  );

  factory Progress.fromJson(Map<String, dynamic> json) =>
      _$ProgressFromJson(json);

  Map<String, dynamic> toJson() => _$ProgressToJson(this);
}

@JsonSerializable()
class Job {
  final File file;

  Job(this.file);

  factory Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);

  Map<String, dynamic> toJson() => _$JobToJson(this);
}

@JsonSerializable()
class JobInfo {
  final JobState state;
  final Progress progress;
  final Job job;

  JobInfo(
    this.state,
    this.progress,
    this.job,
  );

  factory JobInfo.fromJson(Map<String, dynamic> json) =>
      _$JobInfoFromJson(json);

  Map<String, dynamic> toJson() => _$JobInfoToJson(this);
}

enum JobState {
  @JsonValue('Operational')
  optional,
  @JsonValue('Printing')
  printing,
  @JsonValue('Pausing')
  pausing,
  @JsonValue('Paused')
  paused,
  @JsonValue('Cancelling')
  cancelling,
  @JsonValue('Error')
  error,
  @JsonValue('Offline')
  offline,
  @JsonValue('Offline after error')
  offlineAfterError,
  @JsonValue('Opening serial connection')
  openingSerialConnection,
}
