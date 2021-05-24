pragma solidity ^0.5.0;

import { BN256G2 } from "./lib/BN256G2.sol";
import { Pairing } from "./lib/Pairing.sol";

contract IVC10M30M70 {
    function verifyTx(
            uint[2] memory a,
            uint[2][2] memory b,
            uint[2] memory c,
            uint[14] memory input
        ) public returns (bool r);
}

contract VC10M30M70 {
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
        vk.a = Pairing.G1Point(uint256(0x2ac2f7cfd951cade1aa71233faa64d4bf9d1b2fc75c3684776a83ee735fd9af9), uint256(0x17d5aa2499e81671683a77e01f4121f43f3db34c64dd1b322eb5d7ddd746e1ed));
        vk.b = Pairing.G2Point([uint256(0x0137e07cdc7667748873513c6440cd06597e865375e439dbf8b920726c8e8981), uint256(0x16c187c3a6b2898d90562b3b398da60ae7f93c1aa971d46d2f296c2f4c1556eb)], [uint256(0x272575de8774f18337ab9dd677fb94e9a470b32144a4f8f52800509ccaa94237), uint256(0x22c918efc528bb48e1d0414f925660d5eb1132ff0a93bb785c9aad2cd28b802f)]);
        vk.gamma = Pairing.G2Point([uint256(0x0be6ead7c39d764fc74c6712dd0dae3ee539a6854dc22095b4729a0d5c3b86dc), uint256(0x062189dc22925307ea449cd499a070be125511ab2f3a56f1ce92ad66bedf8c52)], [uint256(0x1163e9bc938ded8568e2dbb1b6cd05dd0814fd2de565959a444e5ccd9f50fa79), uint256(0x2873037efcc851e4fe49a7c61092887b81701272fb0e204b37011c5f4fe515bf)]);
        vk.delta = Pairing.G2Point([uint256(0x025eab8726484cae92e74224411faf64db35221e4b2843b87a0e1c82c556f948), uint256(0x16b1d5eae1983223de9cbb0a249c21424c6f6e197c11f31d893919097717a92f)], [uint256(0x1b0fa417e52a20659d18c98cf95eeacef6340023cac9a2a1ed302b50746cbe05), uint256(0x23e05719657d5408eef864c0f22f85823224fd681547e846dad9edffffd53a5d)]);
        vk.gamma_abc = new Pairing.G1Point[](15);
        vk.gamma_abc[0] = Pairing.G1Point(uint256(0x2a1565ad582ce49b940b5f23d17c2ce3d2cd3bc5a93fb9a1863efc67877dc604), uint256(0x2f8d0b6baaee9dbfa7ab490675cc133498a0abd7997812f66c00f7558b927a6e));
        vk.gamma_abc[1] = Pairing.G1Point(uint256(0x219be03da61dccc4e7089990d7e0d9eb54677aef0840659c044a345590a5a742), uint256(0x2540c74bb4070c87e82f4db1c4badf1c6a99cac09285153c5f138a9cd35405db));
        vk.gamma_abc[2] = Pairing.G1Point(uint256(0x16f240b3af2acc6e2308d6e2b1518525711403699d4fe5dcff8133279e5d1d39), uint256(0x11b1c94d4e1b5f63315cf74c2f38bb97fc1a81ccfdeb776eeac196622f9c2c82));
        vk.gamma_abc[3] = Pairing.G1Point(uint256(0x00eea60ac2974fa1a004448881bea851ff5011e194ddabf12472ed65f84129c8), uint256(0x2d006a7bd5c7bb141b060fac8bb236df253e4d665269b6433886c7bbbc6fd511));
        vk.gamma_abc[4] = Pairing.G1Point(uint256(0x13edc59a0deaeb35969b7207f1f1e21729ac501b746099dc4d28da920a0598f7), uint256(0x2497acf2c5315818725791aac18399ec5fbd6af92314317ae5e4a144586ee922));
        vk.gamma_abc[5] = Pairing.G1Point(uint256(0x215118704c19649f83ef944f110b5572be3326eead11f62a1a5af97de4f469af), uint256(0x2743d3d324841d641a105d35b0f041de0d55f605f8ad7fa5f1cf4d42be382497));
        vk.gamma_abc[6] = Pairing.G1Point(uint256(0x190b20a612cf208f43630ce1edf5801e553335166f20c3ed16b1c10f4119d641), uint256(0x28a56ac309b9662febc2ca2ee3941ad3001e4a5916fa7ade68869ead3b3c7e85));
        vk.gamma_abc[7] = Pairing.G1Point(uint256(0x0612ae01fe48e17fde64cf15cab5231b8977a5c0c0a24170258edc2a59774b9e), uint256(0x1fc5473ba4899c3a9329e342b7d587db9be594b0d0946407059e1ad5935cdd3d));
        vk.gamma_abc[8] = Pairing.G1Point(uint256(0x20eefbb3dddd50bf897ee089293ad8a518638cf7d15d02d77c0983047dcf4ac2), uint256(0x029f0189c80aec992e1d62a390acd51ae67168510d643063dd1a6bc54ed7647d));
        vk.gamma_abc[9] = Pairing.G1Point(uint256(0x2eee47ce8bd24f40b92508661293ff1aa332811217a69a4792e195696c164f7d), uint256(0x0733b0aa9246962f77b16a9ae3127a1d3e97bd4c91bb63556c409773c9a2fb18));
        vk.gamma_abc[10] = Pairing.G1Point(uint256(0x29541957f8c724d42adb905660eb1b4111e4e9daa9b24a319156f6e73bca2293), uint256(0x2580d62979e4758fa26fb6a523ce46dcf57cd20eedac253f4652bf235f82b647));
        vk.gamma_abc[11] = Pairing.G1Point(uint256(0x052e32bb94f064de4b43dc76995cd0c2c847d968748217298e94e45d08e6a4cc), uint256(0x0bd787a0428ce17c786569b9bb03d323502bd0c182b25e3f04ffd579aafc45a6));
        vk.gamma_abc[12] = Pairing.G1Point(uint256(0x251fcb3f6a9e356232a8efc8b53e83facdba55bed45f316aaad7872638e00bca), uint256(0x2333055a862a58b979e230838f36525ab7764a96106c9070484e748b802b3a74));
        vk.gamma_abc[13] = Pairing.G1Point(uint256(0x256fc431cdf1fffb54788f01d8db9a514c8d3f4fe562e9f2f10624b5a713b7e7), uint256(0x047fc7848a68c91909b0538a816d2ab5c5b389a46be83cdba08c3b6b7409fc22));
        vk.gamma_abc[14] = Pairing.G1Point(uint256(0x0db1e017a35d050fd4efe7319c19aeec111d8945e0b97737cd8192e2bed8c146), uint256(0x0855fce116c02e2f6521517827c882856038743e73a6b8c89f83528c32865b06));
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
            uint[14] memory input
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
