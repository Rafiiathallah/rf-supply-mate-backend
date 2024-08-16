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

    function transferNFT(address _to, uint256 _tokenId) public {
        require(_ownerOf(_tokenId) != address(0), "NFT does not exist");
        require(ownerOf(_tokenId) == msg.sender, "Only the current owner can transfer this NFT");

        _transfer(msg.sender, _to, _tokenId);
        _nftDetails[_tokenId].currentOwner = _to;
        _nftDetails[_tokenId].nextOwner = address(0); // Resetting next owner

        emit NFTTransferred(_tokenId, msg.sender, _to);
    }

    function burnNFT(uint256 _tokenId) public {
        require(ownerOf(_tokenId) == msg.sender, "Only the owner can burn this NFT");
        _burn(_tokenId);
        delete _nftDetails[_tokenId];

        emit NFTBurned(_tokenId);
    }

    function updateNFTDetails(
        uint256 _tokenId,
        string memory _newDescription,
        string memory _newLocation,
        address _newNextOwner
    ) public {
        require(ownerOf(_tokenId) == msg.sender, "Only the owner can update NFT details");
        NFTDetails storage details = _nftDetails[_tokenId];
        details.description = _newDescription;
        details.location = _newLocation;
        details.nextOwner = _newNextOwner;

        emit NFTDetailsUpdated(_tokenId);
    }
}
