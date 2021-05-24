pragma solidity ^0.5.0;

import { BN256G2 } from "./lib/BN256G2.sol";
import { Pairing } from "./lib/Pairing.sol";

contract IVCC60M30M70 {
    function verifyTx(
            uint[2] memory a,
            uint[2][2] memory b,
            uint[2] memory c,
            uint[6] memory input
        ) public returns (bool r);
}

contract VCC60M30M70 {
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
        vk.a = Pairing.G1Point(uint256(0x190a42eae00aad9a38c6ab5f754cdcb9dee57d791aaf89abb8f9e0def9689c15), uint256(0x0779c3f8ccde607f42e1d60cfd5cc3e4fd101b0ca617333955b5cfff347e28ec));
        vk.b = Pairing.G2Point([uint256(0x25e7837e4ba43af33cbeaad00dacbaae14d61d4997faef4acc380af3fdef2e43), uint256(0x06087595c87597720a301da06bfa343bdf236b2231bd2ba6312c2468844d148b)], [uint256(0x28df174d1137693b4a1a6fa739d0d2cbb601a543c044c53aca9e9b57f326cdd6), uint256(0x23cc3658fa53ae024f34a24b4a09e408fe28025a01b9dd003eaec1e182ff1988)]);
        vk.gamma = Pairing.G2Point([uint256(0x162680be76e4ca9b076a6c0d336ef6ed0aea2e985c265db80b2197a668b6cc2d), uint256(0x02dd86fff495b344c7f5091c1159160b70e4359ec0534b9f6417675d19bad6bc)], [uint256(0x2774197050777eaa0e60d69f5c3e2f7a0f9ff3db0a1e87e3bdb65b38eaa83be1), uint256(0x1a3fca5a65a6440aaa4a3ca2a8014e2a2792252afe9eecc27809a0af3239d4d0)]);
        vk.delta = Pairing.G2Point([uint256(0x2b83725012dbe6f8331abf9b052dd838dbd766472116a399f90d6245dd7990b4), uint256(0x0ee53da9526d03db7ebc5ab5a9ff9b501e0fb149f73d0525cbb6fdcd05805324)], [uint256(0x29bcd4a1db8751605aa2482f98525567781710ad391c78b77971f5e7eaf96c4b), uint256(0x12b9d4b6fa90d997ed89d00aeea6b847004f21bdabd1bd5af1c6e504b9c634e3)]);
        vk.gamma_abc = new Pairing.G1Point[](7);
        vk.gamma_abc[0] = Pairing.G1Point(uint256(0x25ac4b518218a101b91bb7f34989d459f24a77b899bae737eecd074c9f2f331c), uint256(0x19dbebd7220f9d0d6c81cb35c19e82f09037f08a90527f8c475c149fc900c359));
        vk.gamma_abc[1] = Pairing.G1Point(uint256(0x19f275f067837820ec052d36dd6e2a7cc37636b48e693d6bfa9be397ae1ee876), uint256(0x0e297fb3c92dc9e47870e5010a5049320b66cf5fb1ec7bc97fc3e5186f28f3e6));
        vk.gamma_abc[2] = Pairing.G1Point(uint256(0x284eabe43a57c66ae36da9500df9417f3f37dad3084acb2915865e293b0cc239), uint256(0x10f3f8bc9c6b6e1b474668fca2adc3fc7c3fd60cc7c16a8a195d47fde820caa2));
        vk.gamma_abc[3] = Pairing.G1Point(uint256(0x188d323d507db439da9b6a64a77c496090761842648b86ae58fadcad6c428151), uint256(0x0ddde3b0d0c166bc2da56ad842503d19d96736ffc66f9219052bcf7c193b1f45));
        vk.gamma_abc[4] = Pairing.G1Point(uint256(0x257451f833be4be7db67ea2c77f92f99a9a384dc51bc9723a31adec2be943c5b), uint256(0x10777738aae1f76a91f3c387227f6cd8cb54f2804fcd783585b4e56415c8591a));
        vk.gamma_abc[5] = Pairing.G1Point(uint256(0x096e123d9aa44a4510d8806d1a5092c867e059aaa39be2b145eb764b615f03b1), uint256(0x203562929dd6138d832653666e318363ae65b99f79a3601521eb626bdba42703));
        vk.gamma_abc[6] = Pairing.G1Point(uint256(0x045f8499cd62bba6428565add2f873334ab2b87a56b2f2562f2cde48b4d0d54d), uint256(0x1d71f7155f6af9f005ad60658010489620241dd8d0d0259dd8e48080393ce289));
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
    //event Verified(string s);
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
            //emit Verified("Transaction successfully verified.");
            return true;
        } else {
            return false;
        }
    }
}
