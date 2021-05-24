pragma solidity ^0.5.0;

import { BN256G2 } from "./lib/BN256G2.sol";
import { Pairing } from "./lib/Pairing.sol";

contract IVCC50M30M70 {
    function verifyTx(
            uint[2] memory a,
            uint[2][2] memory b,
            uint[2] memory c,
            uint[6] memory input
        ) public returns (bool r);
}

contract VCC50M30M70 {
    using Pairing for *;
    struct VerifyingKey {
        Pairing.G1Point a;
        Pairing.G2Point b;
        Pairing.G2Point gamma;
        Pairing.G2Point delta;
        Pairing.G1Point[] gamma_abc;
    }
    struct Proof {
        Pairing.G1Point a;
        Pairing.G2Point b;
        Pairing.G1Point c;
    }
    function verifyingKey() pure internal returns (VerifyingKey memory vk) {
        vk.a = Pairing.G1Point(uint256(0x1ec0e28604e24647fee7053b7bcdc1fd20f3917a0ad601fdc634be756d0d6038), uint256(0x0541cbb6df12c6b8506d548294be38684930d2bd262833efbff6bfd37d9a5fae));
        vk.b = Pairing.G2Point([uint256(0x1ed7aac362851504ed9e1d099a1e08fe1d427abcf2442a7e76d464c70f17517e), uint256(0x15b29a6760566b75070a77d32dfb96c3c1aa9eed8ce770d5bfaef24cb1270000)], [uint256(0x1e27881b3bdb4110795353c2563aa3cfcb4472f1bfeeafdc6efa0bf210bd586c), uint256(0x2778bbd5551e44a01410983ee10dab1b5c2036fa7f95e543fc8a4b1e6add8b6e)]);
        vk.gamma = Pairing.G2Point([uint256(0x0c89cc4eadcbf5e5f23eb6ce478986309ed4e74fc165ac6dcab318eb9f4ebe62), uint256(0x102ea26af122eed61844f3f3399df6989bfbd687f41f0f665e4d6e6ddcaf052d)], [uint256(0x00a91eeb4acbab3d5b0dcd42897211ffd6006a8656b40c1307e82187ed7dfa8a), uint256(0x2be70e27ddbe749ad9bf82c7188d2d4e66f23e0939e8a3fab7296d613e5dca13)]);
        vk.delta = Pairing.G2Point([uint256(0x1d4aba30778841332d53aa79ddeab2210a1a6dac6fcc5a25312d96c63dd5957f), uint256(0x19358b1bb49b11b84806c8d4413f02fea86f06b43cbe02c008695014984ace7a)], [uint256(0x19fe145377ee537a4293783577cf2f73c2ddeb301bc83949dfbe2c3ffaf204c9), uint256(0x0eac97dfe6b2ad736a7f9f22ae76d0cac569ba746fc303446da7f6794b2d2f8d)]);
        vk.gamma_abc = new Pairing.G1Point[](7);
        vk.gamma_abc[0] = Pairing.G1Point(uint256(0x0b717f7246e471ccd65001a05152b16ef3aa93a81cd50f99c22ae8732183cccf), uint256(0x0311a7fb73140d162eef01041574ebefe705622564058ca777bd4d15a1fb9b1a));
        vk.gamma_abc[1] = Pairing.G1Point(uint256(0x0a20f0454625a7d81902710ef676a02229626738db24f21cd58c0d30761b6ef8), uint256(0x2b65e5b69a853bcb8c1b680782888cc0f85ff61b4e29a95e32fa9a275f11c7c5));
        vk.gamma_abc[2] = Pairing.G1Point(uint256(0x29143dc0ff117b6630466bfdfdd1ebdab655a5b71c64388ddf9516df325fdb64), uint256(0x1d9eaaddd8f5d2e8362f6f55b660bf2d261aa1c5f47f6ced4d38af5f8ab36e6b));
        vk.gamma_abc[3] = Pairing.G1Point(uint256(0x0620d2a747925e7ebec65d4438320b71d5114fd225e701349feb93abcbd4ef83), uint256(0x03f34b81b6611984dd9dfc47c130c092c536e285ba01cf46cbf297a5aac03f30));
        vk.gamma_abc[4] = Pairing.G1Point(uint256(0x198bdd66dcb5c52519d4c7d99c8d23b085be5ef2c99f047b9d3ead4daab80768), uint256(0x2e177d389d542db428bb3840e819aa35ad14c445e404478f44548c03ac7c6661));
        vk.gamma_abc[5] = Pairing.G1Point(uint256(0x0f11beb2364c51e7cfb4e3398229a67580d49bfd02bb818b9bf60f6c994be4ac), uint256(0x0b115e45904cc88ca962968973d2dcac6c895e9a3b560b26681ca72b2d2c854f));
        vk.gamma_abc[6] = Pairing.G1Point(uint256(0x1b7c999744bf305815ece42bcec88e236cbea59d717129a586786accc46dc287), uint256(0x23397f53d71798a028628c72776c19b1701c68ba0f6181e58ccf577844d8fe92));
    }
    function verify(uint[] memory input, Proof memory proof) internal returns (uint) {
        uint256 snark_scalar_field = 21888242871839275222246405745257275088548364400416034343698204186575808495617;
        VerifyingKey memory vk = verifyingKey();
        require(input.length + 1 == vk.gamma_abc.length);
        // Compute the linear combination vk_x
        Pairing.G1Point memory vk_x = Pairing.G1Point(0, 0);
        for (uint i = 0; i < input.length; i++) {
            require(input[i] < snark_scalar_field);
            vk_x = Pairing.addition(vk_x, Pairing.scalar_mul(vk.gamma_abc[i + 1], input[i]));
        }
        vk_x = Pairing.addition(vk_x, vk.gamma_abc[0]);
        if(!Pairing.pairingProd4(
             proof.a, proof.b,
             Pairing.negate(vk_x), vk.gamma,
             Pairing.negate(proof.c), vk.delta,
             Pairing.negate(vk.a), vk.b)) return 1;
        return 0;
    }
    event Verified(string s);
    function verifyTx(
            uint[2] memory a,
            uint[2][2] memory b,
            uint[2] memory c,
            uint[6] memory input
        ) public returns (bool r) {
        Proof memory proof;
        proof.a = Pairing.G1Point(a[0], a[1]);
        proof.b = Pairing.G2Point([b[0][0], b[0][1]], [b[1][0], b[1][1]]);
        proof.c = Pairing.G1Point(c[0], c[1]);
        uint[] memory inputValues = new uint[](input.length);
        for(uint i = 0; i < input.length; i++){
            inputValues[i] = input[i];
        }
        if (verify(inputValues, proof) == 0) {
            emit Verified("Transaction successfully verified.");
            return true;
        } else {
            return false;
        }
    }
}