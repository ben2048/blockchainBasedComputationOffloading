pragma solidity ^0.5.0;

import { BN256G2 } from "./lib/BN256G2.sol";
import { Pairing } from "./lib/Pairing.sol";

contract IVCC10M30M70 {
    function verifyTx(
            uint[2] memory a,
            uint[2][2] memory b,
            uint[2] memory c,
            uint[6] memory input
        ) public returns (bool r);
}

contract VCC10M30M70 {
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
        vk.a = Pairing.G1Point(uint256(0x23e0b06aca1e4693522d38cacefe8a8a229f3a6257c85521a461be5e5e7ce36e), uint256(0x2d64db1e90e85128d641fadf7d3c60d466e57313c6cdddb718907206bbdf3b2e));
        vk.b = Pairing.G2Point([uint256(0x14b39d8dc8896728171d0bdca0888204566b744adc9456522cd4038f7c8415bc), uint256(0x22d06b824ba3a0ee5806659ec8bb604308c65b27c27a3b100849e9d5a6a2ab31)], [uint256(0x0d28de843651417d6874b6452250267f4d44629703f547b7ab44661000199339), uint256(0x1fec339367d993e541b2f4d1cc3e17800c22660a3ca56efca82ecdd04639548b)]);
        vk.gamma = Pairing.G2Point([uint256(0x163bfb2743e58192a2a48e0efedd6fa1923bc1ffa6f0af9c5fe428c45b032a89), uint256(0x277a3ce42b8306f787df8ea76f54b48d5dab6679d234fdc2413743d0e4b6123f)], [uint256(0x17838aae2652161c5eebe083974322fef111b3def573a7471dbd9481148344b3), uint256(0x1d4504f7442c795732d9a7996889b8d2836442b5331f9096c7cea96d8227c527)]);
        vk.delta = Pairing.G2Point([uint256(0x19f16cea1a7de3afc9a6d496e5e07b7a4599d57d89c041a8ca0ca47366f6580f), uint256(0x0c9138887bc0ca99509e165d598fe81d5081c57f0928a614579e6f8f23fac63a)], [uint256(0x1ab6fa6477fa35e62ce82e67e44e95405b7815d4805123387b9e61af3f544227), uint256(0x21ca72f41fe97d39c992751ff21c27d0fadcec221dc6444ec0a578b5e16cd379)]);
        vk.gamma_abc = new Pairing.G1Point[](7);
        vk.gamma_abc[0] = Pairing.G1Point(uint256(0x0e41ad676855993b58fbd48061451ec4c15a6fc1b0ae97d8a932025a470e9f8d), uint256(0x201f348eca44afef2ce84fcf3461acc22f312b68aa9df23a11534d564a3b3b6e));
        vk.gamma_abc[1] = Pairing.G1Point(uint256(0x2ef49d6c90409adacb00e06137d804b0982e820ab2d61090df4188095f649a48), uint256(0x118816563c6e2dab9336b2ebe6c1014fc3c481f96cd2932045caa7ca904bd8b5));
        vk.gamma_abc[2] = Pairing.G1Point(uint256(0x13fc16c95abb5f802d02e4406f1c7bd23e452300f091ca56a0d71e07e1f46f19), uint256(0x287519d32976eceed6420b3bc91061863fad8de8c7d5ef9dcadb9e6d94f8ec41));
        vk.gamma_abc[3] = Pairing.G1Point(uint256(0x1aede634add2839139e1322244fdc8afefc9cc014774b846a8c1995bfa4070d4), uint256(0x2957dc102fde4d037a08ec031765d853382dec5c5ee93ee6205852662bd10108));
        vk.gamma_abc[4] = Pairing.G1Point(uint256(0x19482e2b935f2dbe92a7d79e0bf219eae81379b8bf8cbffe44b6ad01aa51ed9b), uint256(0x08a4aa963eda845bcc6c18e904e4379abb2c03498906f0c02e44032f37f2301f));
        vk.gamma_abc[5] = Pairing.G1Point(uint256(0x2f5b569b288bca3fbfdd5d705ff97c705160e3e7da9bd8fbcf42fb42a2b2bb7d), uint256(0x08ebaedddaebce3ab59bed7564ef6cd187f86f6950b01b07133b7e6076c7be27));
        vk.gamma_abc[6] = Pairing.G1Point(uint256(0x073e6ea5ad6358601f5ba8b403227d035f2522070043e2d40063161daa93fd3a), uint256(0x01788ae5433c4696adeabb37f9f12939092255a9c0beb6e1de6c134c4a56e4d1));
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
