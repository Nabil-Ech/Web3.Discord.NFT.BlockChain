// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Dappcord is ERC721 {
    uint256 public totalchannels;
    address public owner;
    
    mapping (uint256 => Channel) public channels;

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


    function creatChannel (string memory _name, uint256 _cost) public {
        totalchannels++;
        channels[totalchannels] = Channel(totalchannels, _name, _cost);

    }
}
