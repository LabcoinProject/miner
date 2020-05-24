import 'package:args/args.dart';

ArgParser getArgParser() {
  var parser = ArgParser();
  parser.addOption('node',
      abbr: 'n',
      defaultsTo: 'konstantinullrich.de:8081',
      help: 'Set a node to get the memPool from and push mined blocks to');
  parser.addOption('private-key',
      abbr: 'p', defaultsTo: null, help: 'Set a private key to sign blocks');
  parser.addFlag('verbose',
      abbr: 'v', help: 'Shows the current state of the mining proccess');

  return parser;
}

String getHelp() {
  return 'Labcoin Miner Help\n\$ labminer\n\nOptions:\n${getArgParser().usage}';
}
