pragma solidity ^0.5.0;

import { BN256G2 } from "./lib/BN256G2.sol";
import { Pairing } from "./lib/Pairing.sol";

contract IVC60M30M70 {
    function verifyTx(
            uint[2] memory a,
            uint[2][2] memory b,
            uint[2] memory c,
            uint[64] memory input
        ) public returns (bool r);
}

contract VC60M30M70 {
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
        vk.a = Pairing.G1Point(uint256(0x246a687adbc6c5d0428a21bb28c5ba936191f43ba3452d309479a61beeb5493c), uint256(0x181ff7315f74b28cb1088ba06afd2d37a024e5dcbfbeac0449c04fcfb9a94710));
        vk.b = Pairing.G2Point([uint256(0x2fc5b7ec25e406677672c03d23be0b5d16554496c3ee1d4f44d9ad159e958752), uint256(0x0e4a1186375c0b62bcd9f5ebf77df35bfd8668afe6a3603d6ac754e26ec3b7f8)], [uint256(0x081b24270d2003a58fbbb53faf693fd7ae30f9a1387192a3ae86721fe447041c), uint256(0x043db9f52fb67df2ef3909e47be6f7bca9022927c802d6f8066e2986f7f20ce6)]);
        vk.gamma = Pairing.G2Point([uint256(0x11f642724f660824f61d8809397dec084f6ab303f196a7b6ae9968319c7ec726), uint256(0x29b0164f0de04a7c58afe8070b15e78c7330b83087465b94bc94bbab13ab4c95)], [uint256(0x04bd793fe43eb547f83ad325057ed76994164280a0401fa5c4825fe3af7fa5d8), uint256(0x0f0b357478a983e789eec6d122c49e435a66773bac0cdbaa541416432666b7f7)]);
        vk.delta = Pairing.G2Point([uint256(0x18010a114119ee920aea61017562cb9486e8881603dc5e79f009336fb20b9cf9), uint256(0x1540c0086954b0d4f7b600801d44baee6eb9ccd9dbd9d73789efa624dad75830)], [uint256(0x215736482f9ff92b012386691d26ff39bcd3620a3917ed7b3928befe0f9ac410), uint256(0x29d9f5e9e8c8529c4b0ffb8614cff1184959b84544891e2452343b5d11f50c94)]);
        vk.gamma_abc = new Pairing.G1Point[](65);
        vk.gamma_abc[0] = Pairing.G1Point(uint256(0x07bbdc11164ce9919e75af7e9c546f65127d424eb36a0f373321dc14c70f57e6), uint256(0x128c0abe3ec81dabc9d000d748b33304714e530a016a3a02279a63be9a8ecb0b));
        vk.gamma_abc[1] = Pairing.G1Point(uint256(0x160d4337339cf5ac275956223ebd36deafe3dfaba5d947e49cf1686186491201), uint256(0x1c2f46c236a4c62d5098393494fbe711daf2a7e7bca7dbac0120c56b3d8cabb1));
        vk.gamma_abc[2] = Pairing.G1Point(uint256(0x231725233d75bbabd1d8b4d041b4456ede1e5dc1a0c8c57d90783c31377ea43a), uint256(0x22a15154e64b413a5d0e922538121f6147b18cf6df04958be585c04825813c17));
        vk.gamma_abc[3] = Pairing.G1Point(uint256(0x067740c724bf9f8a4212f47ad83189763fdc334d8f326a64eb093ba354a6d6f1), uint256(0x221eba30feced4b2ae980c74c7a1c037c566b863067b77e6bdb02450fe77132f));
        vk.gamma_abc[4] = Pairing.G1Point(uint256(0x19e027588d43f3a1e13362378884385ecdfd668aebca5854dbc25c59d27d119d), uint256(0x1908658df9a9387fa47cfabe7a243ee970697161d1ad4fbfb3ba10614eca3603));
        vk.gamma_abc[5] = Pairing.G1Point(uint256(0x0bb6e100f81ab0d569e707a0ee67c9ae3eb2af7d3244faea9595e260b06550e5), uint256(0x0c42d574a48468ee0b6db0fb5dadaf2850a18fe2372cb1c8070e1b5a4a734cd5));
        vk.gamma_abc[6] = Pairing.G1Point(uint256(0x2aeeb110ea7e96426e9b0516698b0a959010cb4876d779fc546710204025ce33), uint256(0x2d889e97a422f845daa764521f3b4e51114773ce926dfc52cd2a04ce0b62b539));
        vk.gamma_abc[7] = Pairing.G1Point(uint256(0x04802c4ddc01817015d310c2a7148307fe39242b3d75f2489f1bf793ed67edf2), uint256(0x1e0676d7558b6262a42c2c897d5124948746050718675cc01e3798544f896d2d));
        vk.gamma_abc[8] = Pairing.G1Point(uint256(0x17905a6e7274a62a1973928c780ea1a7ff1d25a33df4d640c0f4c5ae2d8d0b08), uint256(0x1c678993993c50157b5d671205971641cf05bc123ad4dd767ae1e117998babe2));
        vk.gamma_abc[9] = Pairing.G1Point(uint256(0x271e0dd91e6fb58be5a64faf983e0290ba49ebcd9b8f9daaa3d781bc6013fd33), uint256(0x101530ce895adc43a1db00b28211b27600485279e6bb033fb3ba6721e2206a47));
        vk.gamma_abc[10] = Pairing.G1Point(uint256(0x15c7a1d4b42f15aa5fc96f6ff3f0d5eaef872308965316af79e55e72835100a8), uint256(0x26c040f1c562bfed8c9e53e94fc5ddb0fc61ec11816ad2acb6df09393cc5b280));
        vk.gamma_abc[11] = Pairing.G1Point(uint256(0x221b151b8dd22c9a92c8c65279ea2e42c5dbc5563322e70797f200a4472c68af), uint256(0x201f2999aff3cb0b551c34794d6ab968b8aa6398180cd5939334c48ceb4736e8));
        vk.gamma_abc[12] = Pairing.G1Point(uint256(0x1d076a5d07e436ad9752867315d38be2a18af5e213124ea83552dd7a2bb9d914), uint256(0x13ac462ab7f21298c4d091e88097cda47d44119a1c8c8da15c65ad4e1ffaddcb));
        vk.gamma_abc[13] = Pairing.G1Point(uint256(0x224ebbc83b097fc4694a0cd004e531c6b02caa7d2a00c83c0bbc0306dcbdece3), uint256(0x1d2723157579dd8b854876e90421c509f6c18cdc466314029fddaf2bb182c82c));
        vk.gamma_abc[14] = Pairing.G1Point(uint256(0x0e6f3cc9244d2000457e3871077567e9634d72ce1f9c8a39ee506cf801f67bb2), uint256(0x147cfe111528ce7d1a91e21de6c89f6c1527effb11c4fadad66d22862e854fb9));
        vk.gamma_abc[15] = Pairing.G1Point(uint256(0x01b7c592609152299e4d302f6c39eaae55d58c18f1d90f1ba2a18454d33c8e0b), uint256(0x21fa0d67feb98e70e25b65a6856b4c4b3637e958cf194152f97294496ceb1532));
        vk.gamma_abc[16] = Pairing.G1Point(uint256(0x257d13b07c136f9339c8c67d492f87845f43051457a66012d9425f97debf8982), uint256(0x122e0abee9edad1d104e32774ad310d5872e8eb02f321e79d0f506a4759e040b));
        vk.gamma_abc[17] = Pairing.G1Point(uint256(0x10fc8069ead5687bad364fc5ecd5950f192c07cc952c51b46d51ca8a0df3d7fa), uint256(0x2b0069491dffe5183d83b9cc30c2d929a583266ecd6612049877b524b74d152f));
        vk.gamma_abc[18] = Pairing.G1Point(uint256(0x2e9283e284f4c6bea3c99d969840e715015ade22a07bebc959eacf9caaf110cc), uint256(0x0eb6598bbc000cd00079da06486eea3e82b7c04c36734b7d897b5a7fc177534e));
        vk.gamma_abc[19] = Pairing.G1Point(uint256(0x2df35f7bbd93d33562d2723ca549466b0319715dcbc418ec3bcff2d39d13dd75), uint256(0x07d422535c7b2703bb201e9dcd1df4a677f2ce90a5bb9e704cc7bd7af4f25c76));
        vk.gamma_abc[20] = Pairing.G1Point(uint256(0x22d9c770d79818e581fa657770a7d04252a2e0bb81740279fc7e711b76a1195d), uint256(0x198dc76565aeb79f7648b5a5323cc12c72368cc54a7e0b04d2ec2a0f4ba16991));
        vk.gamma_abc[21] = Pairing.G1Point(uint256(0x29ef0dd683e4202d50d0f1ff0f7212393cac6549a741f5d4453cc0f245ddc8f7), uint256(0x0ef23a9fc3affe0bfaccf4ebbfa59df6f4e3c25e437ffa7762a3115fe59159d9));
        vk.gamma_abc[22] = Pairing.G1Point(uint256(0x20f741e31e4c457a77f1b01ccce5116701cefe0ecc8f2b5f76affd956d2ff221), uint256(0x00f5a76ad196533ed0eff7078451e56fb172aa236770abda6c95473b80bb4eab));
        vk.gamma_abc[23] = Pairing.G1Point(uint256(0x2ec11f8ab900e065d673b38b355e50c9ef48f82eaf0c5d2a1fd009297e084e6d), uint256(0x16ecaedbe15ad517b7dc512f4c51fca2b22503bb748df34140e375378c13058e));
        vk.gamma_abc[24] = Pairing.G1Point(uint256(0x0c705ec5e967a68744cee9021ff7188b64b91ba8dfcbf2a186bb86d8187b24ad), uint256(0x29c877e7a2fccafc15866ba3c3c30bb5470225fb3d3e4fe93e5bab4e9a0d4c38));
        vk.gamma_abc[25] = Pairing.G1Point(uint256(0x01a08bd7ff7470019006a9ceb338303e8b90ba3f17513adf77ebbe95f29eb2ce), uint256(0x1e24ce4b5ad6356b7ae67c6f6102ee46f4e813efff7a2ea177921f4679cb50df));
        vk.gamma_abc[26] = Pairing.G1Point(uint256(0x27db3e7f00f5955b505c58fb52d724740dcc0e371b0b25e964e126f0acffb221), uint256(0x11d02ad36bb233ebff441ce481148e03b8837adc91fc30b4b5708366af60f4de));
        vk.gamma_abc[27] = Pairing.G1Point(uint256(0x2fc65c70e65d5a9b4b198f82e8d21f1acd016cb06d32230f6422ab603c6d3f31), uint256(0x25309cd50f370943ec02b975602daa559a8a78d680f81d9594dee6ba295ef478));
        vk.gamma_abc[28] = Pairing.G1Point(uint256(0x2b11309deb6586cb8753dcb2033e2a2b7aeea4a34f205d87f89890ccca74244c), uint256(0x03f313a2436d1be1cbde3390e5ac6cdee7429f399cd23c6e2263aef3c0780739));
        vk.gamma_abc[29] = Pairing.G1Point(uint256(0x1d991922fbcc318324c25bc9d84351cfe7f8ea3cd1a9b113fa67d470ed65a796), uint256(0x043eb0222e26b8a9cbb5ddf79d39394c97b21996066fbb4869d8abd8f46f2f42));
        vk.gamma_abc[30] = Pairing.G1Point(uint256(0x301ae4def3a90c6fabe3dba7588a46a27187007a119a577840d21e0ff93f88d4), uint256(0x1b215a23a36076a0fd4c61716f37eb2f1e4e6257ebfd4c6283920e119fc10c43));
        vk.gamma_abc[31] = Pairing.G1Point(uint256(0x1893e71f60bd00be23ee9583700a7e98370445e76c74c06c95eddb088e460003), uint256(0x06c4992a714173af52dc139a620f78c4a4303ad92e33ef78852eb5030743ca70));
        vk.gamma_abc[32] = Pairing.G1Point(uint256(0x10ff6252f7bdb0a24d4b45e6c04f2c91b992ca9f9b70d2b9b523b0c3b827687d), uint256(0x170acbe983f2bfb80dfc444e02ea6baad300e91c37095d8658804ecf7ab58961));
        vk.gamma_abc[33] = Pairing.G1Point(uint256(0x30542f73ffff1713a656e17bd9bd07afcf7853a48f008074f687b20d154e9b70), uint256(0x1389a36aa84bddfb5f1dc29df1236ded18ed246bfd9b7a04d0bcdbf1f2c6edb6));
        vk.gamma_abc[34] = Pairing.G1Point(uint256(0x2388a5a592359fae399df468915a1d249700c30d2135c74e941c8469076ab33c), uint256(0x1e9fd948f37a31fe0bc0ec29de02a881ac4c535553c43b8c9a81d056ba0a329f));
        vk.gamma_abc[35] = Pairing.G1Point(uint256(0x10484bf60a562880d0059faf0050e508ee0f704424ba1973972f0e0af39dcc90), uint256(0x08c6a6bfd5909250b991a032cc36f4ee0840854aca745f442b3e073f93eea4da));
        vk.gamma_abc[36] = Pairing.G1Point(uint256(0x1683d3a05663fff2de98e6bdea2f47f8f991f07dbbd9ee5c5a6758eeb2d2c7ff), uint256(0x1edaff04dd37aa6c3173a567b6b9a1de733d04ce397697950d9528dfb1f5abcd));
        vk.gamma_abc[37] = Pairing.G1Point(uint256(0x06ec6d00a6641fcb430bc6dcda08c2e0f6aa0c3756b4e5c2bd9f45d371a0fbb0), uint256(0x05c100872a43027e59023d3cbe5171cff8cf3d12e45a27c86b50d638092baa9e));
        vk.gamma_abc[38] = Pairing.G1Point(uint256(0x29f3c27e4722a1b7aa23f0754b23b25080f1c5a6d12aaac2ec748f3c21274d4f), uint256(0x01c5234b704ecd2f3ffeb5636448c7d974b580bfc593c1f694ad92a252315ce1));
        vk.gamma_abc[39] = Pairing.G1Point(uint256(0x05da43ad3ff833083493fc92151d5328f515b2fa286008e7edc11b59e20134a9), uint256(0x0136155a7805818d1082fa7a7a1f04685df8fc57228a2eed235a2030522f0577));
        vk.gamma_abc[40] = Pairing.G1Point(uint256(0x09f218e2557e1f24824fed244771a77c2fb7a2280a6d5166a1f3db7d18495f62), uint256(0x1efa911a010a4c78041b5ce6a9819e16d72be5edd344e09895afa3c91ecf5f2c));
        vk.gamma_abc[41] = Pairing.G1Point(uint256(0x041a80fb59781fd5748280097d49362e06f77aa1d616c662e607066bef5a9174), uint256(0x12e3a7fffcda799654927742278f2bf690a1e77741805651d8dba2bbd8bb65f2));
        vk.gamma_abc[42] = Pairing.G1Point(uint256(0x19c45b16eafa25a5af28bfb53469c5d8e88ce2f8953e86851424dc5e86909e47), uint256(0x01bfdb3cb464bd4720d927d529a8a1c3e9497593af015ca08cfd735cffa37ac1));
        vk.gamma_abc[43] = Pairing.G1Point(uint256(0x14a7a84363b25975a9468b8d9a9648b891cd7e8b4f90333c6eb3463559867d3f), uint256(0x1fed26976fd586ac41bc52e11da33eed2c71c925fa1da8e332918046a66c6126));
        vk.gamma_abc[44] = Pairing.G1Point(uint256(0x2c29cd22357bcd03ae16ebecd1da3c94b5e41330ee005fbe41815c756cfc9d64), uint256(0x16967b2855cd8ea636d2f21cc91e776323ef729fe7d23ff45146dd23e49c9b15));
        vk.gamma_abc[45] = Pairing.G1Point(uint256(0x1478ed1708676381e0a1e9f39d6e58a0a255af82a001d842cec0e9d963376fa2), uint256(0x083919bc60650933ce78150b9e3d10adc254661aa8392040318262da9fd11920));
        vk.gamma_abc[46] = Pairing.G1Point(uint256(0x2332dc7301a19546d5df286e8fa18b8e51544565d19d0afceaef8a03c510986d), uint256(0x0af80f0487854e7c8e2b4f4484a924911d8fbf2daa17cc1f2b332d7cb84774ee));
        vk.gamma_abc[47] = Pairing.G1Point(uint256(0x1552790def6e4a69f80924392585fca558d2f50d7be3e6644c9163a53489644b), uint256(0x09f3529386069d905491d656e6ffe0dbcf65c3bb2df7dcab841e664d32dde92c));
        vk.gamma_abc[48] = Pairing.G1Point(uint256(0x0105d690ea7b0cabb8e3a380d3f33cb131bd158241eb1550dceaedb9525b555c), uint256(0x0297c4068b98403742facd558b80e45d7f5e8aa8d00f7244683ca919477222ec));
        vk.gamma_abc[49] = Pairing.G1Point(uint256(0x28a654dce42fb7248f68f1935a45c5e74331c9616d3fe484a03f2401f3826430), uint256(0x034883987d9ed8e8c3cd68f895444c5b4e29a0f430d9b0d4d293828156c76e00));
        vk.gamma_abc[50] = Pairing.G1Point(uint256(0x02af726809091406c560ee774f597c04ee477539045a9005e1eada8787edc202), uint256(0x2ecb43dfc9983cb119cfe985dc5bb75116882869e2b34320d1fe7da1daff3339));
        vk.gamma_abc[51] = Pairing.G1Point(uint256(0x11e10a01fea4a2642fcf03e39c67a5f67938a377d1585fadfa2b59271e390d14), uint256(0x2ade9c4a4ad621576c4e62688182719e3bcd7bef3beaf6afe5cce3573c487715));
        vk.gamma_abc[52] = Pairing.G1Point(uint256(0x25644e16325f56361ee2fd7edd25299da7556f3ab707f82444e45e7de46ebe71), uint256(0x1abdd0844c723037b4cda444b43562b6bff0203a9d1b764935ff4d2ae94fbb61));
        vk.gamma_abc[53] = Pairing.G1Point(uint256(0x27fffa9b08e5a6ebde9ce8314792d9182bd187cbbf5347fa5378104762d41f00), uint256(0x1b455b78cd7858dc7cee5d71c13e211a605cf4ee6489b5bc8301e4279dea705b));
        vk.gamma_abc[54] = Pairing.G1Point(uint256(0x16b1dd1d263c164e1d3c4decda591aac3cabb2cca05e58f79808af7d3b717166), uint256(0x02eadcdf459cc2522e5bf5e78adfcaa74adaeb95a1ac4bbdc86906aedc41aae3));
        vk.gamma_abc[55] = Pairing.G1Point(uint256(0x0f69cdba835660aa9ff6bb7e08ca0ea65df27d5ad5838d11a86ebff6979053f8), uint256(0x2bfa2c6c0e42f09bf335049093803ad74d6c47f425d5fd887e5cabf761b65cfc));
        vk.gamma_abc[56] = Pairing.G1Point(uint256(0x29da8ebb3f88676c93c4b28f9e996ec3c38759c12ce3b29f12ddce6dc049b4b6), uint256(0x302077c8a547a042ffc679dae526a566e8eef3bc6ed9686da14dadd46551d409));
        vk.gamma_abc[57] = Pairing.G1Point(uint256(0x1d0057f3dfae228344726d4babe9c67f4d067dc455df152b926aef5cca655b44), uint256(0x2416459f5783f4d3f12b3a976b0b3865b5392acf203447ce21ec8f9635e055a1));
        vk.gamma_abc[58] = Pairing.G1Point(uint256(0x2958fb4ea70e34a4d1c2e25983e763843a647178ca47050f37f0ac851143c5c4), uint256(0x3032b390ded0b5436f434da0ada851a087a233f9d8408fc84a289e8a317b2820));
        vk.gamma_abc[59] = Pairing.G1Point(uint256(0x103c7d7daa218a1be964bac913118577661b8f6575f3f9d360698a95f9583c0f), uint256(0x1a020fd3aaa8bb8fc417188b5c0d3c4f094e32c12ef97bff857b0ef10754d7d7));
        vk.gamma_abc[60] = Pairing.G1Point(uint256(0x0fed6db8e09ce066ec496dbb5f077b7d2a09d385fe767c803cdbbef4c8b53fe5), uint256(0x1a59c1b6412939f99a73c5c002fac2cdb131a020650ec6b4b46cbab6a968ca90));
        vk.gamma_abc[61] = Pairing.G1Point(uint256(0x188dea17d99e567d1b8c018da5630b7f2d36949ccc048694a7870df707cb5183), uint256(0x25c016ac444cc48433ce42ab6d9debca3b737fd2ffb23089bc8128c6699644a8));
        vk.gamma_abc[62] = Pairing.G1Point(uint256(0x029af472a070cbbf4074baeb76eca6b61064a6bcb8efebb90041b969ff949831), uint256(0x2ee6d8ac94aea91480f092dce313855aa8dda2cece9b32a716561fdc4d7ae3ac));
        vk.gamma_abc[63] = Pairing.G1Point(uint256(0x2251f17cc80046029eda912eadfa44d10bf6b7fd3e30f8520898d9600dd6d3c6), uint256(0x1e4f779637b3be7092e5506a6e997c3c69eeb1a85064215054d400a286901430));
        vk.gamma_abc[64] = Pairing.G1Point(uint256(0x0f832e495a66162f2e5a81f9360e31b79a07b0b63e76f6801e3ccea0d10df337), uint256(0x18f27f4efe41cf5e3788532e6a20e0685cc3e5062c57e533d7ebfdf02cba10d1));
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
            uint[64] memory input
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
