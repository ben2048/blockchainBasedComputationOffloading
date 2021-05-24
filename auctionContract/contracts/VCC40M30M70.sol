pragma solidity ^0.5.0;

import { BN256G2 } from "./lib/BN256G2.sol";
import { Pairing } from "./lib/Pairing.sol";

contract IVCC40M30M70 {
    function verifyTx(
            uint[2] memory a,
            uint[2][2] memory b,
            uint[2] memory c,
            uint[6] memory input
        ) public returns (bool r);
}

contract VCC40M30M70 {
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
        vk.a = Pairing.G1Point(uint256(0x1899e6b815fb7ca148fddc8245aca431a399e38a7c37ab5544d79bfc7476e457), uint256(0x11bedbd7e57f62781f5315ffa251d5e7b09099f24daf4bebc7c1061eced76b59));
        vk.b = Pairing.G2Point([uint256(0x08333d3cfb3fc23299e976ac29485a84f6bc56ad24d0d43636c6e0eb64d96285), uint256(0x12a9914d099d23d7314568a4f7e5fd7f73e0bcc2274a80c81ac979ae452efeed)], [uint256(0x2665f8716bad7c8cba41c6bda6aacc7bc9826a9b94c250e0ee1162289dbecde2), uint256(0x0ed0e5205092889076f006d8af18c8a68e0877d1f5a3e360c02c7e121f666992)]);
        vk.gamma = Pairing.G2Point([uint256(0x20fd16b857e3afabf5e2d83d8e445260a41f5cf6369d559e8c0903e40bf77c04), uint256(0x21dc93a32be360f742fe9a1da2e6b854d079f36193f84d7fcf9aa4c2f96bac1a)], [uint256(0x1c7e0cde4fb087664a6e0dda6cddcfcbce660bb5a1ec99dd52584b1d8b43a342), uint256(0x262011deac3123c778f9a9935f3ebb2742e30716f5a2e328a1e888e410275f46)]);
        vk.delta = Pairing.G2Point([uint256(0x0cb54be3620c1509195b1ae7f9b94aa5101905afdf437202244fd1e9e5ac063b), uint256(0x274421d6ea5a0f30c51d433f36139ba10bbd7906a31fdcd28bc1119dd7ea365e)], [uint256(0x2da2cb82427ab7618b2279746029e434ab317f2f5e71144f32ab16410f9c1bd9), uint256(0x17492c689943fcce24d9622b8b5ebcd24d6a3bcd73529e60599b6afd6fc86ae8)]);
        vk.gamma_abc = new Pairing.G1Point[](7);
        vk.gamma_abc[0] = Pairing.G1Point(uint256(0x03214768b562a563c420a065a43d76296bbd5e3e6120b4b62ceb30f7bdbc5efd), uint256(0x2eb9d1fbfa997906d1b3cb5a4abfb22360e137f98deef455d4ae24952d0c4ea9));
        vk.gamma_abc[1] = Pairing.G1Point(uint256(0x1cd2c9887baf4b03d850912680e8684c7a7ce8cd3cb06602807aa475b886ece5), uint256(0x148aabc2bf33e200812237a23fd5030186227331127ae63e4d4e6fd1fce48f17));
        vk.gamma_abc[2] = Pairing.G1Point(uint256(0x124e3f1355cb8328c4d74b85bc9d3312fc32ad730d5b3507a5521b3443b8181c), uint256(0x026305874f61a02abda40493e2e25dc423639f8ba5c0da8466fb4a53343087a2));
        vk.gamma_abc[3] = Pairing.G1Point(uint256(0x0f733451adbc65828da17bbac28c128d24a31241f725f3f2e3e80a317a8f664d), uint256(0x0dfb4264b475dcc48b07280d86471506831f3621278eed562e67446ffa012ff8));
        vk.gamma_abc[4] = Pairing.G1Point(uint256(0x245512481a8bfddb20c5291176e1f1cba4f48b016d2e3438c6ea741f0115a63b), uint256(0x0d1fdcfc1e116d8718822738a70ca8dbb705fb77b8c825e9e279cfc54ee0aaf0));
        vk.gamma_abc[5] = Pairing.G1Point(uint256(0x2904f85e0743de4ffeb1a9b377942bab62db0fbd1926498d7c914a9dc1be6675), uint256(0x0db5f0cf06a877d851b1b993d6b930c5a3f8b02b0de93fba825a35614da9794e));
        vk.gamma_abc[6] = Pairing.G1Point(uint256(0x2919e34fea3afe1da217a33645bffe6fdb744bc1fcd63f22ede6b2d9abfd7b8b), uint256(0x22cb8fab8a8b2c2dfcd9118a1276eeae1149aac7f92042e13eb30d1fab13e8c4));
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