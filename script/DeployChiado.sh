#!/bin/bash

# export CHAIN_ID=44787
export RPC_URL="https://rpc.chiadochain.net"
# export VERIFIER_URL=""
# export ETHERSCAN_API_KEY=
export PRIVATE_KEY=0xa93abd947bbc5c79f7c75dab6f0a3ef30478295d93fc4f5cbdfe3d4b56ac5066

forge script script/DeployNFT.s.sol \
  --rpc-url=$RPC_URL \
  --broadcast \
  --sender=0xF16Aa7E201651e7eAd5fDd010a5a14589E220826 \
  --private-key=$PRIVATE_KEY \
  --verify