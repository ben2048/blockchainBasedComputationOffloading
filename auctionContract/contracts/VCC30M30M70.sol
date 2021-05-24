pragma solidity ^0.5.0;

import { BN256G2 } from "./lib/BN256G2.sol";
import { Pairing } from "./lib/Pairing.sol";

contract IVCC30M30M70 {
    function verifyTx(
            uint[2] memory a,
            uint[2][2] memory b,
            uint[2] memory c,
            uint[6] memory input
        ) public returns (bool r);
}

contract VCC30M30M70 {
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
        vk.a = Pairing.G1Point(uint256(0x0d6d6ff7db1022186c92e29ee9b8eccf1d4c77f38f1c685e6a5e020846cdc461), uint256(0x00d47c59df3b84c08f13ed715023a5dd5118699e5b3f2b422e46e4fd437898f4));
        vk.b = Pairing.G2Point([uint256(0x037414150b207d90aeba91575ed5b319fdec4ec76cd01149d9cc5fee2e8c7b2e), uint256(0x02a1069bc93b6937d0801a86f584eadcae1062e5414ce615b5698b5a81b1ae91)], [uint256(0x0ce503bdb41a3af43997d8d35eae5fcea15c1d6a80363590b1c417ec2227ef4a), uint256(0x05f6f60187571a1f2f389bc0fecd131fe220c69eed3ae8e41981eee32c1bab26)]);
        vk.gamma = Pairing.G2Point([uint256(0x1ab7f4110b7282c323d61de4eaa8ad480defe4e98449d052851d6420b184f7eb), uint256(0x24980946d4ea691cc0b384d522f0685b30f17f2cb3c8d00a001ae111df69e03e)], [uint256(0x1f1cebff323544503162833171134abaebe8a3d8eae6bc6e5d6eda462a5447a9), uint256(0x28b8721aecf5c13598caecc2a3dc884a6c78ecb3632c2533949850e49b13369d)]);
        vk.delta = Pairing.G2Point([uint256(0x2fc6d31d8fce3da406b89a37d6d518638c204f3995dbb1f54af9641488a0602d), uint256(0x17941e595ae6ec465bbaef8bc37879172ae5f33223eed4a4049e5bc2ae8720f0)], [uint256(0x044b3b8300c98ef0c0f9bbb01f1e4f4c72abe333cb9b88716bfc37718e5cdc6d), uint256(0x01b68ed3f0b2483d46e55ff55a89c67711a7d0d688d17e62b21d30b8d076a950)]);
        vk.gamma_abc = new Pairing.G1Point[](7);
        vk.gamma_abc[0] = Pairing.G1Point(uint256(0x03c40106ed94e676f91e0a70d8adb2d30c978e2ec52c712445b95f35fc2e2b48), uint256(0x280f6d06a94de894a346dd335dcfbefd5e11681ee680c2be5e50a55ca18de30a));
        vk.gamma_abc[1] = Pairing.G1Point(uint256(0x29acc64e965b07b9fb803d50329ee24b69578a437b33b8d743d74f4ce3af4d46), uint256(0x28019b03c8ef217e86e64d91e5d25b540ab88eb79196ecba5f6d446d0ce3f4a8));
        vk.gamma_abc[2] = Pairing.G1Point(uint256(0x1f4d65ecfeb3aa9d1b8027267f8d7500062de662adf6c13bd13d30a7e29bf1d0), uint256(0x247808beb3d5171f7929e726b441beb23025557b1e64a427c9dfe09d5ded3363));
        vk.gamma_abc[3] = Pairing.G1Point(uint256(0x0ba6592ceab035226688fc6fe3e558ddd7cff6a74962508a7a2105844bdb1ec3), uint256(0x20b38e63c8d40db0a37a8d1136436d7384e0048405ad961fec763b812c6bf58e));
        vk.gamma_abc[4] = Pairing.G1Point(uint256(0x2a83b62e996601f5d9872acd52b725cf53e1f109c940e3de4d8b4bc0a8ca131d), uint256(0x0138371053030c5daf7f22ac8df30a0c643b4df0e49629343f4450b78d9b8344));
        vk.gamma_abc[5] = Pairing.G1Point(uint256(0x11323b57920c4149943e47af4fcfa253fa7eeca82ac5cedabc452ea52b07f5d4), uint256(0x2454d3a0a81b41ef906141fbd655cef5e80ffd09d2822a858427554c56927937));
        vk.gamma_abc[6] = Pairing.G1Point(uint256(0x18e57d5f3f93e3e0f0e38afd9d73bbd6d8b06fda9c29c54aba1686885096f426), uint256(0x0c2c238e50daf1e4cdddbbbd950cdfd3dce031aed0d47f80d97783fc94ccbec4));
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