# web3dart, sendTransaction, waitAccepted(with addedBlocks event listen)

## Environments

- network: polygonMumbai

## Test

- edit `API_KEY` and `PRIVATE_KEY`
- and run command below

```sh
dart lib/cli.dart
```

**Maybe you need to modify gas configuration in `Transaction`.**

## Optimize gas

- just edit [maxFeePerGas, maxPriorityFeePerGas]

```dart
//example pseudo-code
lastBlock = web3client.getBlock('latest');

maxPriorityFeePerGas = 2gwei
maxFeePerGas = lastBlock.baseFeePerGas * 2 + maxPriorityFeePerGas
```
