// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Dappcord is ERC721 {
    uint256 public totalchannels;
    uint256 public totalSupply;
    address public owner;
    
    mapping (uint256 => Channel) public channels;
    mapping (uint256 => mapping (address => bool)) public hasJoined;

    modifier Onlyowner () {
        require(msg.sender == owner);
        _;
    }
    // structur for a channel, to call it each time we want to creat a channel
    struct Channel {
        uint256 id;
        string name;
        uint256 cost;
    }

    // We are inheriting from ERC721 which itself has a consstructor, we need to feed it
    constructor (string memory _name, string memory _symbol) 
        ERC721 (_name, _symbol) {
        owner = msg.sender;
    }


    function creatChannel (string memory _name, uint256 _cost) public Onlyowner {
        totalchannels++;
        channels[totalchannels] = Channel(totalchannels, _name, _cost);

    }

   
    function getChannel (uint256 _id) public view returns (Channel memory) {
        return channels[_id];
    }

    function joinchannel (uint256 _id) public payable {
        require (_id != 0);
        require(_id <= totalchannels);
        require(msg.value >= channels[_id].cost);
        require(hasJoined[_id][msg.sender] == false);
        // first we need to create/mint a NFT (a sort of a ticket to be part of the channel)
        // we will use a function from the ERC721.symbol() 
        totalSupply ++;
        _safeMint(msg.sender, totalSupply);

        // joining the channel
        hasJoined[_id][msg.sender] = true;

    }

    function widraw() public Onlyowner {
        (bool success, ) = owner.call{value : address(this).balance}("");
        require(success);
    }
}
