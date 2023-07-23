#!/bin/bash

# Below should be set before running Bash script

export SIGNER_ADDRESS=0x1dB47D1a06Df36f963af1b086B012bb278071372
export RPC_URL=https://goerli.infura.io/v3/ae3b481fe2c34ad9a2569ef2f28c29a6
export PRIVATE_KEY=5b22e742ecd2a9b9c67f357169019388af686b3d8d2e47c2778bc2c176575544
export CHAIN=goerli
export WALLET_TYPE=local
export ETHERSCAN_API_KEY=PPTQJ5AXIKQP5NNTTMTKER23NWP33AC36H

export TOKEN_ADDRESS=0xfc6f5280D28a2c9C03dbDa142d35bEb85C287050
export RECEIPENT_ADDRESS=0x355a27A5EfdC0e2eF182Fcc70f257256EdEae740
export AMOUNT=1000000000000000000

forge script script/safe/1_ERC20_Transfer.s.sol:TestAuthBatch \
  --sig "run(bool,address,address,uint256)()" \
  true $TOKEN_ADDRESS $RECEIPENT_ADDRESS $AMOUNT \
  --slow \
  -vvv \
  --sender $SIGNER_ADDRESS \
  --rpc-url $RPC_URL \
  --ffi
