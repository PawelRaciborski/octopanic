import 'package:octopanic/api/api_models.dart';

enum OctoprintCommandHandler {
  printer,
  job,
}

enum OctoprintCommand {
  emergencyStop,
  cancel,
}

extension CommandExtension on OctoprintCommand {
  get value {
    switch (this) {
      case OctoprintCommand.emergencyStop:
        return Command("M112");
      case OctoprintCommand.cancel:
        return Command("cancel");
    }
  }
}

class OctoprintInstruction {
  final OctoprintCommandHandler handler;
  final OctoprintCommand command;

  OctoprintInstruction(this.handler, this.command);
}
