SupplyMate NFT DApp

Overview

SupplyMate is a decentralized application (DApp) built on the Ethereum blockchain. It allows users to mint, view, and transfer Non-Fungible Tokens (NFTs) representing various items with associated metadata such as title, description, quantity, location, current owner, and next owner. The DApp provides an intuitive interface for interacting with the underlying smart contract deployed on the blockchain.

Project Structure
The project consists of three main front-end pages and a Solidity smart contract:

1. Smart Contract (SupplyMate.sol)

Minting NFTs: Users can mint new NFTs with specific details such as title, description, quantity, location, and next owner.
Viewing NFTs: Users can view the details of specific NFTs by entering their ID.
Transferring NFTs: Owners of NFTs can transfer their tokens to another address, updating the location and next owner in the process.
Burning NFTs: Owners can permanently remove their NFTs from the blockchain.


2. ViewNFTPage (/src/app/viewNFTPage/page.tsx)

Allows users to view details of a specific NFT by entering its ID.
Fetches and displays the NFT's title, description, quantity, location, current owner, and next owner.
Notifies users of the success or failure of the operation.

3. ViewAllOwnedNFTPage (/src/app/transferNFTPage/page.tsx)

Displays all NFTs owned by the connected user.


4. MintNFTPage (/src/app/mintNFTPage/page.tsx)

Allows users to mint a new NFT by providing details like title, description, quantity, location, and next owner.
Notifies users of the success or failure of the minting operation.

Requirements
Node.js: v16.x or higher
NPM or Yarn: Package manager to install dependencies
Hardhat: Development environment for Ethereum software
MetaMask: Browser extension for managing Ethereum accounts
Solidity Compiler: Compatible with Solidity v0.8.20

	

Getting Started

1. Installing Dependencies 

npm install
# or
yarn install

Run these commands on both the backend and frontend terminal

2. Compile the Smart Contract

npx hardhat compile or npm run compile

- In the backend folder of the project, open up the terminal and run npx hardhat compile or npm run compile

3. Deploy the Smart Contract

npx hardhat node 
npm run deploy

In the backend folder of the project, initialize hardhat node with npx hardhat node then deploy the smart contract via npm run deploy

4. Running the Front-End

npm run dev
# or
yarn dev

Run either commands in the front end folder via the terminal to initialize the NextJS local frontend