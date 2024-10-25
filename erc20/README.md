## ERC20 Smart Contract [[BeeToken](https://testnet.bscscan.com/address/0x290d2190a03bfd538c8f35404dce2a09f0f5668a)]

1. **Configure `.env` file within the directory**

- PRIVATE_KEY=XXXXXX
- BSC_RPC_URL=XXXXXX
- BSCSCAN_API_KEY=XXXXXX

    **Source the `.env` file**

    ```shell
    source .env
    ``` 

2. **Deploy and Verify the ERC20 Smart Contract**
    Run the container for deploying and verifying the `BatchTransfer` smart contract:

    ```shell
    forge create --rpc-url $BSC_RPC_URL --private-key $PRIVATE_KEY --contracts ./src/BeeToken.sol:BeeToken --verify --etherscan-api-key $BSCSCAN_API_KEY BeeToken
    ```

    **Notes :**

    ****The PRIVATE_KEY is included in the .env file for development purposes only. For production environments, it is recommended to use secure methods to manage sensitive information.****