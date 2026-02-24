//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

// Useful for debugging. Remove when deploying to a live network.
import "hardhat/console.sol";
import {ERC1155} from "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

// Use openzeppelin to inherit battle-tested implementations (ERC20, ERC721, etc)
// import "@openzeppelin/contracts/access/Ownable.sol";

contract CoffeeTracker is ERC1155 {
    uint public currentBatchId = 1;

    struct CoffeeBatch {
        string farmName;
        string region;
        string variety;
        uint256 harvestDate;
    }

    mapping(uint256 => CoffeeBatch) public batches;

    constructor() ERC1155("https://gray-selected-condor-526.mypinata.cloud/ipfs/bafybeihm357xwzj5casusvs4qaxxxnl2jjlnxmnvczfrdwi75vu7nkfqru/{id}.json") {}

    event Harvested(uint256 indexed batchId, string farmName, string region, string variety, uint256 harvestDate);

    function harvestBatch(string memory _farm, string memory _region, string memory _variety, uint256 _quantity) public {
        uint batchId = currentBatchId;

        batches[batchId] = CoffeeBatch({
            farmName: _farm,
            region: _region,
            variety: _variety,
            harvestDate: block.timestamp
        });

        _mint(msg.sender, batchId, _quantity, "");

        emit Harvested(batchId, _farm, _region, _variety, block.timestamp);

        currentBatchId++;
    }
}