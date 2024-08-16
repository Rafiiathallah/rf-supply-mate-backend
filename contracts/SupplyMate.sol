// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SupplyMateNFT is ERC721, Ownable {
    uint256 private _tokenIds;

    struct NFTDetails {
        string title;
        string description;
        uint256 quantity;
        string location;
        address currentOwner;
        address nextOwner;
    }

    mapping(uint256 => NFTDetails) private _nftDetails;

    event NFTMinted(uint256 indexed tokenId, address indexed owner);
    event NFTBurned(uint256 indexed tokenId);
    event NFTDetailsUpdated(uint256 indexed tokenId);
    event NFTTransferred(uint256 indexed tokenId, address indexed from, address indexed to);

    constructor(address initialOwner) ERC721("SupplyMateNFT", "SMN") Ownable(initialOwner) {
        _tokenIds = 0; // Initialize the token ID counter
    }

    function mintNFT(
        string memory _title,
        string memory _description,
        uint256 _quantity,
        string memory _location,
        address _nextOwner
    ) public returns (uint256) {
        _tokenIds += 1; // Increment the token ID counter
        uint256 newItemId = _tokenIds;
        _mint(msg.sender, newItemId);

        _nftDetails[newItemId] = NFTDetails({
            title: _title,
            description: _description,
            quantity: _quantity,
            location: _location,
            currentOwner: msg.sender,
            nextOwner: _nextOwner
        });

        emit NFTMinted(newItemId, msg.sender);

        return newItemId;
    }

    function viewNFT(uint256 _tokenId) public view returns (NFTDetails memory) {
        require(_ownerOf(_tokenId) != address(0), "NFT does not exist");
        return _nftDetails[_tokenId];
    }

    function viewNFTsByOwner(address _owner) public view returns (NFTDetails[] memory) {
        uint256 totalNFTs = _tokenIds;
        uint256 ownedNFTCount = 0;
        uint256 currentIndex = 0;

        // First, count the number of NFTs owned by the owner
        for (uint256 i = 1; i <= totalNFTs; i++) {
            if (_ownerOf(i) == _owner) {
                ownedNFTCount += 1;
            }
        }

        // Initialize an array to hold the owner's NFTs
        NFTDetails[] memory ownedNFTs = new NFTDetails[](ownedNFTCount);

        // Populate the array with the owner's NFTs
        for (uint256 i = 1; i <= totalNFTs; i++) {
            if (_ownerOf(i) == _owner) {
                ownedNFTs[currentIndex] = _nftDetails[i];
                currentIndex += 1;
            }
        }

        return ownedNFTs;
    }

function transferNFT(uint256 _tokenId, address _newNextOwner) public {
    require(_ownerOf(_tokenId) != address(0), "NFT does not exist");
    require(ownerOf(_tokenId) == msg.sender, "Only the current owner can transfer this NFT");
    require(_newNextOwner != address(0), "Next owner must be a valid address");

    // Update the currentOwner to the previous nextOwner
    address previousNextOwner = _nftDetails[_tokenId].nextOwner;
    _nftDetails[_tokenId].currentOwner = previousNextOwner;

    // Update the next owner to the new next owner
    _nftDetails[_tokenId].nextOwner = _newNextOwner;

    // Transfer the NFT to the previous next owner
    _transfer(msg.sender, previousNextOwner, _tokenId);

    emit NFTTransferred(_tokenId, msg.sender, _newNextOwner);
}


    function burnNFT(uint256 _tokenId) public {
        require(ownerOf(_tokenId) == msg.sender, "Only the owner can burn this NFT");
        _burn(_tokenId);
        delete _nftDetails[_tokenId];

        emit NFTBurned(_tokenId);
    }
}
