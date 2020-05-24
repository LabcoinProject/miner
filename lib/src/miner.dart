import 'package:crypton/crypton.dart';
import 'package:labcoin_sdk/labcoin_sdk.dart';

class Miner {
  final LabcoinClient node;
  final PrivateKey privateKey;

  Miner(this.node, String privateKeyString)
      : privateKey = ECPrivateKey.fromString(privateKeyString);

  Future<bool> mineBlock({bool verbose = false}) async {
    var memPoolTransactions = await node.getMemPoolTransactions();
    var blockData = BlockData();

    if (memPoolTransactions.isEmpty) {
      if (verbose) print('No new transactions. Will not mine!');
      return false;
    }

    for (var trx in memPoolTransactions) {
      blockData.add(trx);
    }

    var blockchainInfo = await node.getBlockchainInfo();

    var block = Block(blockData, privateKey.publicKey.toString());
    block.height = blockchainInfo.lastBlock.height + 1;
    block.previousHash = blockchainInfo.lastBlock.toHash();

    if (verbose) print('Starting minig Proccess for ${memPoolTransactions.length} new transactions with a difficulty of ${blockchainInfo.difficulty}');

    while (!block.toHash().startsWith(blockchainInfo.workRequirement)) {
      block.nonce += 1;
      block.signBlock(privateKey);

      if (verbose) print('Current Hash: ${block.toHash()}');
    }

    if (verbose) print('Sucessfully mined hash: ${block.toHash()}');

    node.sendBlock(block);
    return true;
  }
}
