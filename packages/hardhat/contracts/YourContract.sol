//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

// Useful for debugging. Remove when deploying to a live network.
import "hardhat/console.sol";
import {ERC1155} from "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

// Use openzeppelin to inherit battle-tested implementations (ERC20, ERC721, etc)
// import "@openzeppelin/contracts/access/Ownable.sol";

contract CoffeeTracker is ERC1155 {
    uint public nextBatchId = 1;

    struct Batch {
        string farmName;
        string variety;
        string harvestDate;
    }

    mapping(uint256 => Batch) public batches;

    event CoffeeHarvested(uint256 indexed batchId, string farmName);

    constructor() ERC1155("https://gray-selected-condor-526.mypinata.cloud/ipfs/bafybeiegdmya23eog7v5kp2u5xfxmwolnh2n4r2zbbizqixfxrdkto7oge/{id}.json") {}

    function trackHarvest(string memory _farm, string memory _variety, string memory _date, uint256 _quantity) public {
        uint currentId = nextBatchId;

        batches[currentId] = Batch(_farm, _variety, _date);

        _mint(msg.sender, currentId, _quantity, "");

        emit CoffeeHarvested(currentId, _farm);

        nextBatchId++;
    }
}