// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

contract Ownable {
    address public _owner;

    constructor() {
        _owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == _owner, "You don't have access to do this");
        _;
    }
}

contract DramaSocmed is Ownable {
    struct Drama {
        string kode;
        string deskripsi;
        address pembuat;
        uint256 waktu;
    }

    struct Topic {
        string link;
        address pembuat;
        uint256 waktu;
    }

    uint256 public lastId;
    mapping(uint256 => Drama) public drama;
    mapping(uint256 => Topic[]) public topics;

    function tambahDramaBaru(string memory kode, string memory deskripsi) external returns (uint256) {
        Drama memory newDrama = Drama({
            kode: kode,
            deskripsi: deskripsi,
            pembuat: msg.sender,
            waktu: block.timestamp
        });

        lastId++;
        drama[lastId] = newDrama;

        return lastId;
    }

    function tambahTopikDrama(string memory link, uint256 idDrama) external returns (uint256) {
        require(drama[idDrama].waktu > 0, "No drama");
        
        Topic memory newTopic = Topic({
            link: link,
            pembuat: msg.sender,
            waktu: block.timestamp
        });

        topics[idDrama].push(newTopic);

        return topics[idDrama].length - 1;
    }

    function hapusTopikDrama(uint256 idDrama, uint256 idTopik) external returns (bool) {
        require(topics[idDrama][idTopik].pembuat == msg.sender, "You don't have permission");

        delete topics[idDrama][idTopik];

        return true;
    }

    function destroyContract() public onlyOwner {
        selfdestruct(msg.sender);
    }
}