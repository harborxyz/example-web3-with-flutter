import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

Future<void> main() async {
  var apiUrl =
      "https://polygon-mumbai.g.alchemy.com/v2/<API_KEY>"; //Replace with your API

  var httpClient = Client();
  var web3 = Web3Client(apiUrl, httpClient);

  var credentials = EthPrivateKey.fromHex("<PRIVATE_KEY>");
  var address = credentials.address;

  // You can now call rpc methods. This one will query the amount of Ether you own
  // EtherAmount balance = await web3.getBalance(address);
  // print("$address => ${balance.getValueInUnit(EtherUnit.ether)}");

  final txHash = await web3.sendTransaction(
      credentials,
      Transaction(
          maxPriorityFeePerGas: EtherAmount.fromInt(EtherUnit.gwei, 1),
          maxFeePerGas: EtherAmount.fromInt(EtherUnit.gwei, 2),
          from: address,
          to: EthereumAddress.fromHex(
              '0xA55E69BDB2CAec260e5D12903415a787fA2d7c01'),
          value: EtherAmount.fromInt(EtherUnit.gwei, 1)),
      chainId: 80001);

  /*
   * getTransactionReceipt when block generated, wait-block-max = 5
  */
  for (var i = 0; i < 5; i++) {
    var receipt = await web3
        .addedBlocks()
        .asyncMap((_) => web3.getTransactionReceipt(txHash))
        .where((receipt) => receipt != null)
        .first;
    if (receipt != null) {
      print('included => https://mumbai.polygonscan.com/tx/$txHash');
      break;
    } else {
      print('not included');
      continue;
    }
  }
}
