// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

// public - all can access
// external - Cannot be accessed internally, only externally
// internal - only this contract and contracts deriving from it can access
// private - can be accessed only from this contract

// contract daughter_contract is ERC721 {

//     // using Counters for Counters.Counter;
//     // Roles is depreciated
//     // using Roles for Roles.Role;
//     // counter private _tokenIdCounter;

//     //Replaces Counter
//     struct Counter {
//         uint256 _value;
//     }
    
//      Counter counter;

//     function current(Counter storage) internal view returns (uint256) {
//         return counter._value;
//     }

//     function increment(Counter storage) internal {
//         unchecked {
//              counter._value += 1;
//         }
//     }

//     //TokenURI Handling 

//     using Strings for uint256;
//     mapping(uint256 => string) private _tokenURIs;

//     function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
//         require(_exists(tokenId), "ERC721URIStorage: URI query for nonexistent token");

//         string memory _tokenURI = _tokenURIs[tokenId];
//         string memory base = _baseURI();

//         // If there is no base URI, return the token URI.
//         if (bytes(base).length == 0) {
//             return _tokenURI;
//         }
//         // If both are set, concatenate the baseURI and tokenURI (via abi.encodePacked).
//         if (bytes(_tokenURI).length > 0) {
//             return string(abi.encodePacked(base, _tokenURI));
//         }

//         return super.tokenURI(tokenId);
//     }

//     function _setTokenURI(uint256 tokenId, string memory _tokenURI) internal virtual {
//         require(_exists(tokenId), "ERC721URIStorage: URI set of nonexistent token");
//         _tokenURIs[tokenId] = _tokenURI;
//     }
    
//     //The next chunk of code provides a struct to manage the payment and ownership of the NFT
//     struct NFT {
//         int minPayment;
//         address owner;
//     }
//     mapping (uint256 => NFT) public NFTs;
    
    
//     // Get
//     // do not need to create 
//     function getMinPayment(uint256 _tokenId) public view returns (int) {
//         NFT storage tokenId = NFTs[_tokenId];
//         return tokenId.minPayment;
//     }
//     function getOwner(uint256 _tokenId) public view returns (address) {
//         NFT storage tokenId = NFTs[_tokenId];
//         return tokenId.owner;
//     }
    
    
//     // Update
//     function updateMinPayment(uint256 _tokenId, int newMinPayment) internal {
//         NFTs[_tokenId].minPayment = newMinPayment;
//     }
//     function updateOwner(uint256 _tokenId, address _owner) internal  {
//         NFTs[_tokenId].owner = _owner ;
//     }
    
//     // Create
//     function addNFT(uint256 _tokenId, address owner) internal {
//         NFTs[_tokenId] = NFT({ minPayment : -1, owner: owner});
//     }
    
    
//     // Declerations to initalise
//     address oio_sc_address;
//     address Administrator;
//     address Artist; 
//     address current_baby_contract;
//     uint256 royalties_fee = 10;
//     uint256 platform_fee = 20;

//     constructor (address _oio ,address _Administrator, address _Artist) ERC721("OIONFT", "OIO") {
//         oio_sc_address = _oio;
//         Administrator = _Administrator;
//         Artist = _Artist;
//     }

    
//     modifier onlyAdmin {
//         require(
//             msg.sender == Administrator,
//             "Only admin can call this function."
//         );
//         _;
//     }

    
//     modifier onlyArtist {
//         require(
//             msg.sender == Artist,
//             "Only artist can call this function."
//         );
//         _;
//     }

//     // For SC to accept Ether
//         receive() external payable {
//     }


//     function allowTransfer(address buyer, uint256 tokenId, int256 newMinPayment) public onlyArtist {
//         // Allow a buyer to transfer token 
//         approve(buyer, tokenId);
//         // Allow transfer for a certain price
//         updateMinPayment(tokenId, newMinPayment);
//     }
    
//     function purchaseNFT(address owner, address buyer, uint256 _tokenId) public payable onlyAdmin {
//         // make payment to OIO 
//         payable(oio_sc_address).transfer((platform_fee/100)*msg.value);
//         safeTransferFrom(owner, buyer, _tokenId);
//         updateOwner(_tokenId, buyer);
//     }
    

//     // Do the dependent functions inherit payable descriptor
//     // Possibly remove salePrice
//     function makePayment(address owner, uint256 _tokenId) public payable  {
//         // price is as per expected
//         require(NFTs[_tokenId].minPayment >= 0 && msg.value >= 0);
        
//         // make payment to OIO
//         payable(oio_sc_address).transfer((platform_fee/100)*msg.value);    
        
//         // make payment to artist
//         payable(Artist).transfer((royalties_fee/100)*msg.value);
        
//         // makePaymentToOwner(owner, salePrice);
//         payable(owner).transfer((100 - royalties_fee - platform_fee)/100 * msg.value);
        
//         safeTransferFrom(owner, msg.sender, _tokenId);   
//         updateOwner(_tokenId, msg.sender);
//     }
    
//     // Change Platform fee
//     function changePlatformFee (uint256 newPlatformFee) public onlyAdmin {
//         require(newPlatformFee >= 0 && (newPlatformFee + royalties_fee ) <= 100 );
//         platform_fee = newPlatformFee;
//     }

//     // NEED A Seperate role to add both admin & artist if required. 
//     function changeRoyalties (uint256 newRoyalties) public onlyAdmin {
//         require(newRoyalties >= 0 && (newRoyalties + platform_fee) <=100 );
//         royalties_fee = newRoyalties;
//     }

//     // Artist creates NFT
//     function mintNFT(address nftOwner, string memory _tokenURI)
//         public onlyArtist
//     {
//         increment(counter);
//         uint256 tokenId = current(counter);
//         _mint(nftOwner, tokenId);
//         _setTokenURI(tokenId, _tokenURI);
//         addNFT(tokenId, nftOwner);
//     }

//     function safeMint(address to, string memory _tokenURI) internal {
//         _safeMint(to, current(counter));
//         _setTokenURI(current(counter), _tokenURI);
//         increment(counter);
//     }
// }



contract OIO_mother {

    constructor () {
        //default royalties value 
        royalties_fee = 10;
        // percentage 
        platform_fee = 50;
        owner = msg.sender;
    
    }

    // address payable public baby_contract;
    // owner allowed to withdraw
    address owner;
    uint256 amount_received; 
    uint256 public platform_fee;
    uint256 public royalties_fee;


    // Replaces Ownable, only owner can utilise function  
      modifier onlyOwner {
        require(
            msg.sender == owner,
            "Only owner can call this function."
        );
        _;
    }

    //Replaces Counter (if required)
    // struct counter {
    //     uint256 _value;
    // }

    // function current(Counter storage counter) internal view returns (uint256) {
    //     return counter._value;
    // }

    // function increment(Counter storage counter) internal {
    //     unchecked {
    //         counter._value += 1;
    //     }
    // }
    
    function withdraw_all() public onlyOwner {
        // HOW to contract amount amount?
        uint amount = address(this).balance;
        require (amount>0);
        payable(owner).transfer(amount);
    }

    // Working struct with getters and setters 
    struct artist {
        address artist_address;
        address minting_contract_address; 
    }

    mapping (uint256 => artist) public artist_infos;

    function getArtistAddress(uint256 _artistId) public view returns (address) {
        artist storage artist_info = artist_infos[_artistId];
        return artist_info.artist_address;
    }
    function getMintingContractAddress(uint256 _artistId) public view returns (address) {
        artist storage artist_info = artist_infos[_artistId];
        return artist_info.artist_address;
    }

    // Set
    function addArtistInfo(uint256 _artistId, address artist_address, address minting_contract_address) public{
        artist_infos[_artistId] = artist({ artist_address : artist_address, minting_contract_address: minting_contract_address});
    }

    
    receive() external payable {
    }
    
    function set_platform_fee (uint256 new_platform_fee) public onlyOwner returns (bool success){
        require(new_platform_fee>0);
        platform_fee = new_platform_fee;
        return true;
    }
    // Called by baby contract 
    function get_platform_fee() public view returns (uint256){
        return platform_fee;
    }

    //START OF COMMENT
    // function deployArtistContract(address _Administrator, address _artist_address, uint256 _artistId) public payable onlyOwner {

    //     // address daughter_address; 
    //     address daughter;
    //     address _OIO=address(this);
    //     // daughter_contract daughter = new daughter_contract(_OIO,_Administrator,_artist_address);
    //     // daughter_address = address(daughter_contract);
    //     daughter = address(new daughter_contract(_OIO,_Administrator,_artist_address));
        
    //     // once initialized, log data into mother contract
    //     addArtistInfo(_artistId, _artist_address, daughter);
    // }



}