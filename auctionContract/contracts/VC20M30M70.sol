pragma solidity ^0.5.0;

import { BN256G2 } from "./lib/BN256G2.sol";
import { Pairing } from "./lib/Pairing.sol";

contract IVC20M30M70 {
    function verifyTx(
            uint[2] memory a,
            uint[2][2] memory b,
            uint[2] memory c,
            uint[24] memory input
        ) public returns (bool r);
}

contract VC20M30M70 {
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
        vk.a = Pairing.G1Point(uint256(0x26661516e407dca6b461a6ee7102f37a89d1454ee21360fe29cc83a1806581d1), uint256(0x0a0ad9b4af7aeec7444a09392d1742030734ce55462651f0210e7c55e6501042));
        vk.b = Pairing.G2Point([uint256(0x0c76fb0aa55322b016b357fd718ecfe36ecd127f507d47943ba6295f7c95ae3d), uint256(0x040ff663288ce0deb5f74083245477acf1dd098acb566e22b9d9d48f49451021)], [uint256(0x08a44d5ca36b429010828a5125052bf934f0fb133976d471384e76d6c281aaf4), uint256(0x0e24a5e4930471e34558e1535bbb2e2d9e90741e3e6b42f094914b03c42a89be)]);
        vk.gamma = Pairing.G2Point([uint256(0x1e6319d70e05ddeb5bb5456156e97b077b7f97547e863be6a31f691e796901f7), uint256(0x266ca6904ccb12edc86a292ec74edbd9fc6f1dba33a6ea741c6597a466204c41)], [uint256(0x1875a2fca9e6a6e54d6f4de8fa52211cfaa57103d2fa4c06d733421adcc0bb61), uint256(0x0dbc090b084052852886604654adc63cfc12e25bbc65ce3b94fa49bc34ea88cd)]);
        vk.delta = Pairing.G2Point([uint256(0x0d02754db0a06770fe0755fe256fbc07435b428e27ebedb77014e44e8ef366ea), uint256(0x0bc8ac5aca013b691efcd94f3b87b4d1bb34dd61737b4a012bba130a0a1c4e99)], [uint256(0x305833abe9dedbfca66b23d139d29efa1528368c09830c517bb707e4675b1bb8), uint256(0x18f23cae9496dd2b0ce7af9d836124aecdd77c880addad7e4ea19b97704f7e84)]);
        vk.gamma_abc = new Pairing.G1Point[](25);
        vk.gamma_abc[0] = Pairing.G1Point(uint256(0x13ee0eee4d5c7c2319e1d5c24e227f20471f687c746673babde75e79d13994f4), uint256(0x2891f7fa6d9e586ec64c5583fcea06f5670b983cc2c219786f5323be0b92cce6));
        vk.gamma_abc[1] = Pairing.G1Point(uint256(0x1d3f447f92faba0c0350d98704f2fea18eee434cf481fb3639e6ddb3d4bcfefa), uint256(0x0225b332eae28cb46626fc8a79f9626c52fb0edfd86e16e2371eb7ed4551bf80));
        vk.gamma_abc[2] = Pairing.G1Point(uint256(0x16cfbc7b4ed74e739ed71d0f7c825bc794aee912af6e4436f1064ddce498abe6), uint256(0x16c6b47c1209ab32c660b778ebf4a756e3a5f3552e8c5ec0d76a595862829735));
        vk.gamma_abc[3] = Pairing.G1Point(uint256(0x2e1e1393d837aab01ca5ada4c0a4ca817ef4a03f20e0d89697f1a7b8d5d692a8), uint256(0x0558da4fa104969c0aa67c82d0dedc0aba006ca96b921aca4a776d633e69af99));
        vk.gamma_abc[4] = Pairing.G1Point(uint256(0x04a5b92969e1c7fc0588d36612104919f5bb4b641067723100580ac0d4365fbb), uint256(0x2821e8d60c15026603149c91d3b90eb5e671084ae707f1ecc51c23b5ebebdb8e));
        vk.gamma_abc[5] = Pairing.G1Point(uint256(0x177dcc193dfb4e45ced8f87457cce0220979ed3b027ebc4c9ddffc569633c4d3), uint256(0x1ba97d622475a51e1dba489de3a2ff82f9a8a3b122909427f6323281bcb57bc9));
        vk.gamma_abc[6] = Pairing.G1Point(uint256(0x0b05a0aff927e3fc9b75ecdaabdc970511676f6e7205a059a758a081199eec09), uint256(0x05fbc672b90dc8543679929eec828a1c14d0cfce0ce86157d12c019bbd0fd863));
        vk.gamma_abc[7] = Pairing.G1Point(uint256(0x0f1e6e4d3c694f01e1ce972b74a6bd2b2b7323bba86985b3b909e440a5784e17), uint256(0x11058a91ed058433cc829175deba39db2cd94435b1e6104010eeffa7497b6fb5));
        vk.gamma_abc[8] = Pairing.G1Point(uint256(0x29f31907bfae72187b053f74175aea05b58ec811714c2833e6035f29c46fcb63), uint256(0x0764fee4fddc1314464f364eb890aa32509d075d607dd52f46ad61a4b7a9f29a));
        vk.gamma_abc[9] = Pairing.G1Point(uint256(0x019a7aae71f1dbe8dbd5a0d5cbeea059d15b41d10311625e8e091789a3938eeb), uint256(0x04a8414e1ec0322279201757320a90417af264b21ca4ac08e31c29940a8d9db6));
        vk.gamma_abc[10] = Pairing.G1Point(uint256(0x105c7632a0e51ceb4c2b727ce96776e61e5c5c106a893896e57f9357726b9931), uint256(0x118bfc7944f9c962392277f79e4f2748ec4bdf9b0cba6c0d2cfee8889c487b21));
        vk.gamma_abc[11] = Pairing.G1Point(uint256(0x16b8d474bb8a38a31b8cf23501fb4bc967ca2827ea81279e472bde0382f6bb38), uint256(0x15fe361eea3bd47b6460b29748d4f7b6b6fee923c3cd495866903282dcda4642));
        vk.gamma_abc[12] = Pairing.G1Point(uint256(0x1ba19a3b98ebc951a77e5f3e421c2af90c326a39aa0a2e7fc1ceca8b55d82c36), uint256(0x281a85b87a5025353f226794af95c5bd02c4f5940f05c535909e11c6094f281b));
        vk.gamma_abc[13] = Pairing.G1Point(uint256(0x231c8beac2064a96d8da49886eda8ccb05e3031007453a3a8bfed9d13c5628af), uint256(0x23265a764a6713c43ef3ec98cfb1dd81f21c44f7659df7d04d0263d8d00fb404));
        vk.gamma_abc[14] = Pairing.G1Point(uint256(0x193e760d8f944c552baeb792dcc17dfacf6226ca635cdb698672b98ebdf2ecd2), uint256(0x01b65c0662541e031e91ef594ae30a862a1a555d434186f2b04598444e69b34d));
        vk.gamma_abc[15] = Pairing.G1Point(uint256(0x039e9ae1424c8bfd7e07a4aaf680c664242df2372ae3a9d806debb75fa53f8ae), uint256(0x2dd0ba1e62a7d14225f48d2d9264da4e5be053fc4f42f67a9d6f01d4b982ad69));
        vk.gamma_abc[16] = Pairing.G1Point(uint256(0x228eb1198ccd191550f8e9d0c5f282bf13910a2262418265154662bea8df4a7c), uint256(0x0beacae064e28f0dbc364803e712fae024caed06182d6a0a9b28dd0b9fe3a2e4));
        vk.gamma_abc[17] = Pairing.G1Point(uint256(0x29de27fd4c4bb3d1f3dc3cd24213612d5ed7d911a9ff414c54347c696d430e90), uint256(0x0526e412c4942ac9e5c8c69e7090b3bd96db53aa2e70f1cb44489cbd7cb7f823));
        vk.gamma_abc[18] = Pairing.G1Point(uint256(0x093d9c0b569b05f0eeb6458ab4bbc0383ef453dd12c3da69fd5fc5cb4121f609), uint256(0x25ba0156a0b6e9c84cc557b699a28c771c1b6d0725ea29b06abfd5d94e406dba));
        vk.gamma_abc[19] = Pairing.G1Point(uint256(0x095bcd9240de6e5f24128fdfa3c324ed39329789c9e9952e350230f393f34dab), uint256(0x1c3609a0af68ad9bd0b2b57a709cb331df7535a1aa75ec6bf4bdcff460ed85e8));
        vk.gamma_abc[20] = Pairing.G1Point(uint256(0x1af92718ec4e1860ddac829c03a581aeac6b9a5f172715adb117d14c5a78bd97), uint256(0x193c7e398dc70d220077b0796509f1cd4b4460d564f2b27d7de6da69db72d45b));
        vk.gamma_abc[21] = Pairing.G1Point(uint256(0x14768b24fb5295131da865073f979856ab580e75412ac3ff9ae12286c0b851e8), uint256(0x0f36662960c637fbb2885861e4a1821a5cc7eb594f9d3b43bf58863a55801c03));
        vk.gamma_abc[22] = Pairing.G1Point(uint256(0x11339f783cdee6d700918bd3e26be3b3be7b5ce35c613bc82fbe92770dcd4396), uint256(0x2e70d0cbb6fea864f60ee3540eb74b78e54342b9c857adc78d24e789ed2b627c));
        vk.gamma_abc[23] = Pairing.G1Point(uint256(0x125084d814bcbf5591c05f542e31ed370557125454486c0ae429103d6d7e7e5f), uint256(0x00de2f3909054510fadebaaec357427992a88a33f7bddb75d468663d09776b5d));
        vk.gamma_abc[24] = Pairing.G1Point(uint256(0x1fc9b1b30b83e6c4bb72dda85d223384e17b57858027a127a3dc84ac36e39256), uint256(0x1cdfa5aa6825e5f6805696eb82a0a538f290fc522a2815a11aeb881d16cdaa21));
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
            uint[24] memory input
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
