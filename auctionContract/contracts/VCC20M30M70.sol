pragma solidity ^0.5.0;

import { BN256G2 } from "./lib/BN256G2.sol";
import { Pairing } from "./lib/Pairing.sol";

contract IVCC20M30M70 {
    function verifyTx(
            uint[2] memory a,
            uint[2][2] memory b,
            uint[2] memory c,
            uint[6] memory input
        ) public returns (bool r);
}

contract VCC20M30M70 {
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
        vk.a = Pairing.G1Point(uint256(0x0fe0409d18a6d838ee9f0acb8498418cb0fc65ee570d6474c17b27bfab0e27a0), uint256(0x168552bfc8d3248ccd5fde4bf417a4a654d012fba6a7020557ecafa5d8159b24));
        vk.b = Pairing.G2Point([uint256(0x07b373cbf9aa38de98bbf4e9d5ac150fa3658b00195fcec7af2cb8fe3cc9d98f), uint256(0x1301849e9ecd5b72b53fbd9a09f692cccdafa02d9ffe8d43d89996359a0c13bd)], [uint256(0x1441cb26395e5c39daaaee6590bd23f470aa22499e23e27ce3bb341e49e11660), uint256(0x0224d5905e1846ed48bf03e485216bcf8830e140360a705382bd76a0e2985fe5)]);
        vk.gamma = Pairing.G2Point([uint256(0x20dee6fd3007d65d106f1369b560deffe32242eb5c8df47251aa9d131fc734eb), uint256(0x20037d672bfcb706e2d8bdf313543873bcbb6741a94e13f1140891f85e57aef4)], [uint256(0x17b4ada4fff2f648223ebd36fe2861bedf8373840330b61c3cecf1378caae568), uint256(0x2bc3979cc880467bb4197d94fd056c7ec5c45a65ad668f0d47eeba8e5f9d1aaa)]);
        vk.delta = Pairing.G2Point([uint256(0x169210cbbcf8553380a0ce5850d4afc551cd37c61ca8ee1312999aca9b9ae311), uint256(0x0f06b4a290c050f70699b28e44b85e1db4e1b8038c5ccbaa3a4b868809d152c4)], [uint256(0x07322bf10d5f114bd1bfbd23899cc7c184d3dceceaae8aaa7f2bf309e28b00fd), uint256(0x2c11db4fb1d682cbbcc0dc42fb1a20720efdfc23ded9b1c24069906d0cffb506)]);
        vk.gamma_abc = new Pairing.G1Point[](7);
        vk.gamma_abc[0] = Pairing.G1Point(uint256(0x2a54085e73f11cd3d8be3948ace28f7e15e1d94c239f0226b28474315661c58a), uint256(0x2817ecfb7e6d9bd0f5b9fe1977c60cafddfa372be0a3f6f273004c7974a76db4));
        vk.gamma_abc[1] = Pairing.G1Point(uint256(0x28a6866f7afaef09b463ebe24026c9b9de726fd7f5b7ce19472f31cd1afa928a), uint256(0x0ca288715ed80c926b8af3931b120852428171f13ad0faddc4002e842b427e57));
        vk.gamma_abc[2] = Pairing.G1Point(uint256(0x0d67be87dea587b9480eac239d631ed8e168f4f48a183d463e367f6fd9f2f166), uint256(0x1fb7deb7ffa16143ed3683747b0d59486d459197e96eb250cca1fadf123f1707));
        vk.gamma_abc[3] = Pairing.G1Point(uint256(0x28b1919626d6f1de7380d56453986a204f496241cd1cfd4a37375223bbd0f9d0), uint256(0x297310765fbf0822d0d6513fddc3e9c548af992403e222ad92879ff2f954c41f));
        vk.gamma_abc[4] = Pairing.G1Point(uint256(0x2878a039392630cce17ee3e5ca1fcaa0d03b257c6bc3bf2f4e914bc3c9892390), uint256(0x02f22d8ede4be2720fd655590c8d4849b6c4215f2cc1a70b6ef96b8fcf0bd681));
        vk.gamma_abc[5] = Pairing.G1Point(uint256(0x2edf019ee11c8619e1e1690dde48a77f5610265ad734c826dc90131a5f94c45d), uint256(0x1b305d5055954768a05dd06fef39c3ef96b4e5cfde4dffbfb39ed16aea535162));
        vk.gamma_abc[6] = Pairing.G1Point(uint256(0x1413ac9594222270f91dc035b47bbc1a2984e1ea00bba74cfe9f9a2ec9619088), uint256(0x02c55495e14ee65a41f3c922dc0b094c50244060b6ffdfb32b55f3ce7e098cee));
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