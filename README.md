# Simple true/false quiz dApp contract deployable on c10l EVM chains

## Features

- Stores the questions/statements on-chain and, if they are true or false.
- When a user submits the answers, returns a vector of correct/wrong answers. 

## Usage

To test it locally:

```shell
yarn
yarn test
```

To deploy it on the Oasis Sapphire Testnet, run:

```shell
export PRIVATE_KEY=<YOUR_HEX_ENCODED_PRIVATE_KEY>
npx hardhat deploy --network sapphire-testnet
```
