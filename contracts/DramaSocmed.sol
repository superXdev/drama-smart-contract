// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Ownable.sol";

contract DramaSocmed is Ownable {
    event DramaBaru(
        uint256 id,
        string kode,
        string deskripsi,
        address indexed pembuat
    );
    event TopikBaru(string link, uint256 idDrama, address indexed pembuat);
    event HapusTopik(string link, uint256 idDrama, address indexed pembuat);
    event HapusDrama(uint256 id, address indexed penghapus);

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

    function tambahDramaBaru(
        string memory kode,
        string memory deskripsi
    ) external returns (uint256) {
        Drama memory newDrama = Drama({
            kode: kode,
            deskripsi: deskripsi,
            pembuat: msg.sender,
            waktu: block.timestamp
        });

        lastId++;
        drama[lastId] = newDrama;

        emit DramaBaru(lastId, kode, deskripsi, msg.sender);

        return lastId;
    }

    function tambahTopikDrama(
        string memory link,
        uint256 idDrama
    ) external returns (uint256) {
        require(drama[idDrama].waktu > 0, "No drama");

        Topic memory newTopic = Topic({
            link: link,
            pembuat: msg.sender,
            waktu: block.timestamp
        });

        topics[idDrama].push(newTopic);

        emit TopikBaru(link, idDrama, msg.sender);

        return topics[idDrama].length - 1;
    }

    function hapusTopikDrama(
        uint256 idDrama,
        uint256 idTopik
    ) external returns (bool) {
        require(
            topics[idDrama][idTopik].pembuat == msg.sender,
            "You don't have permission"
        );

        string memory link = topics[idDrama][idTopik].link;
        delete topics[idDrama][idTopik];

        emit HapusTopik(link, idDrama, msg.sender);

        return true;
    }

    function hapusDrama(uint256 idDrama) external returns (bool) {
        Drama memory targetDrama = drama[idDrama];
        require(targetDrama.waktu > 0, "Drama not found");
        require(
            msg.sender == targetDrama.pembuat || msg.sender == _owner,
            "You don't have permission"
        );

        delete drama[idDrama];
        delete topics[idDrama];

        emit HapusDrama(idDrama, msg.sender);

        return true;
    }
}
