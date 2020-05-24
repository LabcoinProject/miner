import 'dart:io';

import 'package:labcoin_sdk/labcoin_sdk.dart';
import 'package:labminer/labminer.dart';

void main(List<String> args) {
  var arguments = getArgParser().parse(args);

  if (arguments['help']) {
    print(getHelp());
    exit(0);
  }

  if (arguments['private-key'] == null) {
    print('You need a private key to create Blocks!');
    exit(1);
  }

  var miner = Miner(
      LabcoinClient(LabcoinUri(arguments['node'])), arguments['private-key']);
  miner.mineBlock(verbose: arguments['verbose']);
}
