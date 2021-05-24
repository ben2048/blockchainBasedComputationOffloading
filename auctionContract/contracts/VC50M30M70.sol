pragma solidity ^0.5.0;

import { BN256G2 } from "./lib/BN256G2.sol";
import { Pairing } from "./lib/Pairing.sol";

contract IVC50M30M70 {
    function verifyTx(
            uint[2] memory a,
            uint[2][2] memory b,
            uint[2] memory c,
            uint[54] memory input
        ) public returns (bool r);
}

contract VC50M30M70 {
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
        vk.a = Pairing.G1Point(uint256(0x15a8db63b1852bcf8ace9bdf9cfa55e8572caac56d507119d08fe1d19cbefcbb), uint256(0x070322a94e609cb30998e728ca27b823a6f7ad62bd2159cd44406cbbb5c2b78f));
        vk.b = Pairing.G2Point([uint256(0x26c5396762aab2eadf0746c805907467171abe908e16526de76db930090c2f2e), uint256(0x0bbd989546e5777c020051f4bf4174b16e1390bd058278b5b4740ee0daa76c4b)], [uint256(0x01610062e3fae1a8532b68a605a510a8ca082a7ea5bd1da927e843439cbd7c71), uint256(0x2dcdf417974016cccda049319ccf77deaefd32cb54c081fd5ba8dcbf710ccbd3)]);
        vk.gamma = Pairing.G2Point([uint256(0x1adec71c11eeda064137e3b2eee6e1c8dc9a7ef9bf4c0e7d792dbdd74bdaaf1f), uint256(0x2db124bdfc0190e1bceb763514e9d81533d67ab07672a0c44f44e4e01561d39c)], [uint256(0x17bd1c02aa7ddb6c9a8967b33c89f3a2e8184a5154f653b674a12b2086c142d9), uint256(0x22b71f1186fc4c0d542d8f573920fecef7aa4870ce1e9504df108362038d91ef)]);
        vk.delta = Pairing.G2Point([uint256(0x05df2927eb64fd46576a05da8b52c2054c94417c21673f4d0a4a0bc6df70f103), uint256(0x28f0f872463d3c8cbf4117f0739ba37395531004832d7c67d35383710f5ae922)], [uint256(0x1f2a036028af0444cf85921d8a30205a256bf48365ae503bfab3518c352629c8), uint256(0x13e9c8dc95668471e4c008ad117abfe2a98846dab23311f16c08b70713dd5a76)]);
        vk.gamma_abc = new Pairing.G1Point[](55);
        vk.gamma_abc[0] = Pairing.G1Point(uint256(0x0b1357fc15da38a4b00d705b416ebee676d7adffe3cc2114401d40a33fa9935d), uint256(0x168208e79302bf6a9a476ef78febbb60a727208daeaca9b88b7327a0079cf591));
        vk.gamma_abc[1] = Pairing.G1Point(uint256(0x0ad2f96ce9481cab55bf886a034c0e5ce8ccd2f5e7f6b2599ae876f963cff4a8), uint256(0x1422e8de758cae628c06576b4266905eb7ed6bfa9744c47cb6c872db48c4b73f));
        vk.gamma_abc[2] = Pairing.G1Point(uint256(0x0bf425b0f4ac6bc454caa3521b651276df228aada1fc94f73c966aa0a412a81a), uint256(0x1df775397b0b9da70408621027ae26291c026ac9ebfe2de422b9e94f0f43627d));
        vk.gamma_abc[3] = Pairing.G1Point(uint256(0x2a24680ef422e44a8fca3bab6c37895de7c7ea4b692f2da1af42d9137bccc567), uint256(0x01f35c02af8661a767a4f4c2954c325d67bdf3ec02dd13377e33c7c08d7224ac));
        vk.gamma_abc[4] = Pairing.G1Point(uint256(0x169de69a1ce64ff71e94bd32cd16daf16ec4c889cc158b8e8c555b119edccb00), uint256(0x2706508be1fbf98005eac197f92302287c07a01f79171111c3059da627075821));
        vk.gamma_abc[5] = Pairing.G1Point(uint256(0x12453a7d4de542b7dc1a28a73e86b0821dfdf2e8ab5686b2411fa2835a8a3de0), uint256(0x1c3f7d7408cdc9ba3248b340b7d5130fb9aaf7cb32d5f5790181b186540dc8b0));
        vk.gamma_abc[6] = Pairing.G1Point(uint256(0x1498c3361727628563d47b83592b706d1d2322b06a6be415cc94257d490731f3), uint256(0x1fdf0fce857f1ef795b8070af8d7acebc50d323747434bce565b11e673f1b817));
        vk.gamma_abc[7] = Pairing.G1Point(uint256(0x19438609e83ff1c46c4642463643c4f5ac82354f95e4d209795a58c69c1b6c23), uint256(0x084ce0706b1a3d8574ab6c83e1b105e3075382ba718d951946b5a180c38d64e2));
        vk.gamma_abc[8] = Pairing.G1Point(uint256(0x064768ef22c5361e3d8978823690a46e25164e46ddd6d31732c371402dfcea71), uint256(0x304bda7ee570c8aabf172c63db9b84f6d8cb7cece453a859a728269824a4301f));
        vk.gamma_abc[9] = Pairing.G1Point(uint256(0x19be78f69282f5bc2d498a9076f1ce1b4d221302b07c9685efb4467fa5fe7822), uint256(0x24de0639fb93aefbb996e5c7034c4e861960215c3b65895307fd0bf0b8621169));
        vk.gamma_abc[10] = Pairing.G1Point(uint256(0x263e8354f42e96db820b1055de6f685d70f92e6ead13cbf2953b771e0f01a51f), uint256(0x1e084b7853cd42e31804accce28a2440b3bdf56f7729bbe5a4b0d73bc6536c3f));
        vk.gamma_abc[11] = Pairing.G1Point(uint256(0x27ae328991ad99ee03d9c0c423ce8da3bdc3b4e7f9fccc78363963b24f9cab46), uint256(0x24846b453c303beaa44e1604a347f2b1df4fdf9d6c21e84676839bc9e4da864f));
        vk.gamma_abc[12] = Pairing.G1Point(uint256(0x1decaa89f226e3e91e38e47b0e52519d92589f7e9875b18a6d99237776c81a38), uint256(0x219063950a301e3322efbb827056ab40d8fb8e15ba33266a674f63c1da90187b));
        vk.gamma_abc[13] = Pairing.G1Point(uint256(0x05a2a47adf285015e486db8d62d0de7cb54ca7cdd437a67bf4406efb12bda8f8), uint256(0x025f2cd611a3891a481b74d7ae23c9a5f08654c44fc2e02cc0d9c4033d564608));
        vk.gamma_abc[14] = Pairing.G1Point(uint256(0x06940adcfa747b579e7cfac606f2c1c521b2dd7bb9a3a3aabbea8d85763864b7), uint256(0x0f0641319de57c11d6eb5d066ee05a7e41320975c624f12ed51e865d0eaff6d7));
        vk.gamma_abc[15] = Pairing.G1Point(uint256(0x0a1ba1f8edf13a0d010c3d53d2b440dd4fa5c24142774276bc2de276d3eb6021), uint256(0x2a3e7501487df4a7873971381974b5c20b6d360352425131a2d8412a2d8fe948));
        vk.gamma_abc[16] = Pairing.G1Point(uint256(0x05b1d6efae8c1893509bedafbe686e6e0fdd3c4e19ba942f8b28de213a2964c8), uint256(0x19d3e11823c9518207154250de36798701c459b7739aa0749762ef77c910266c));
        vk.gamma_abc[17] = Pairing.G1Point(uint256(0x283618f9e756814c85a32c7a27265bf963c953c89f78d8636852f4d0986bcee9), uint256(0x2d7e783cb7877d7cfbe32bffbc94338f512490d66121f126a730bee676e23680));
        vk.gamma_abc[18] = Pairing.G1Point(uint256(0x255c054464356bd31dba52d1f7e5cf4828c946d22a35aeeb4fe800c7e8133258), uint256(0x2683c4d821e0cee6904a6cce4a92093292d8dce7aa788bf036a1b5c80bd3823f));
        vk.gamma_abc[19] = Pairing.G1Point(uint256(0x2e903fb1fd813432618b20a193429b5921ad899b65dc6cc2e4b95f32fb02cc6b), uint256(0x0083fc3fb348d9aae4ed444067acf064dae8fcf63a7733c208d3750b137b975a));
        vk.gamma_abc[20] = Pairing.G1Point(uint256(0x0b6031a382972f584f1dbfd2c03327e823e4212eb3c1017504a4ceb06ac450fe), uint256(0x1fb029f9624bed2db0d62b815d958cccfd220517e93c8d147c264a2813021a2b));
        vk.gamma_abc[21] = Pairing.G1Point(uint256(0x18aa4aa82f43988bf3de6abcff0fa2ddf2afe16ca201aa6b7ce9b1adf7e6fb69), uint256(0x1490e925a8b991b16b2f721a271a7c771ad43a9dd8db1b6f78acd076a7249f6d));
        vk.gamma_abc[22] = Pairing.G1Point(uint256(0x293ee1cf3200f747462d7521240148f3bfc327f2016385fd482c1620ac71976e), uint256(0x00acf829db79ea6efd3630fac4ca82f97c44d9903162e46bf326be51a127619a));
        vk.gamma_abc[23] = Pairing.G1Point(uint256(0x2af645ab2a7edcf1b13225fa1b8f9cd001c483ae6c1e5e5494d53b18391911a3), uint256(0x016625af4a8b84103d80e5cba791143ed4f235b94ebaa34c44ea23921b90f4cf));
        vk.gamma_abc[24] = Pairing.G1Point(uint256(0x01fa5fc2a55aa81d0ed675f769487ae287290cefa435286552a4eb6fc4c5e9e6), uint256(0x1637a94b5f2f0d200f99a9a36365a871cb9fd1d4cfa405ca0231bcd88aa26e54));
        vk.gamma_abc[25] = Pairing.G1Point(uint256(0x14b1c6e4c0ab9e1f5bd46f23b04dc0c2940660bf16dae4233ee401888f05bb41), uint256(0x13cebc4d8c2066a82ad31fad8c9db5c3372f97ec4184f2347352570230a7c2db));
        vk.gamma_abc[26] = Pairing.G1Point(uint256(0x17257633f561191d6440f0424a622d17a0b2ff632c91c38910edda1c778e7800), uint256(0x158d6d024ae65d18066fa1042a8bf3643d54d35c6093587200490cb64adb86bf));
        vk.gamma_abc[27] = Pairing.G1Point(uint256(0x00eda1defbd99b40b9f37b771186bb0b0b5a1064ed265cf67ffd0de05ea0ee2b), uint256(0x1eb457371079ec3083b63bdabef36571f55462d9ba245f6590b1a0fcd9c0dd6c));
        vk.gamma_abc[28] = Pairing.G1Point(uint256(0x12d7750623b20b36c082e4e2f429227b3ac4865f93eba6adf78526ba03991bd0), uint256(0x15b616baa6e2d134868dc801854e6095f7c98d5d5c543c23dad41c17162469d3));
        vk.gamma_abc[29] = Pairing.G1Point(uint256(0x01b1ac35177c399a959b3a8afad83b8ea61739b3e4794107876a4c538d26606b), uint256(0x14160e5e3779e98ae3d596a5355618d109666dfd2ba83ef3b5f23fe2af889c6e));
        vk.gamma_abc[30] = Pairing.G1Point(uint256(0x15ee73d262a28064fa00dfdb03441f425fa5609846bad5e0c9c4bf491031df59), uint256(0x1b6303b238465b4eda51587257148f6ca7c2458d34c059f0c9bbb6c7af391362));
        vk.gamma_abc[31] = Pairing.G1Point(uint256(0x25d46127fc6484465439b12244959b77206e82fac52d85721749586954892846), uint256(0x06e92ab44cb01c477dc31805aa03d4d1ba4c10e58447c6a0c1fd0a896cee110c));
        vk.gamma_abc[32] = Pairing.G1Point(uint256(0x16e145b8739845b798320b816f96501bf7372045a66a5e1a4d016e5c308a13d1), uint256(0x2a5d33c8d21eb64538c46d581e3b2a63eb4e3467d9a4ee6fa08c4de65e0e1491));
        vk.gamma_abc[33] = Pairing.G1Point(uint256(0x2ccd7b71cbdb43f4503d1e1ef774e53b93193f064c6962a206c6dcae0fbb975c), uint256(0x0586d60d2c5b304ef19d4b98dc5a65305474109ab203f7a02657204490a016be));
        vk.gamma_abc[34] = Pairing.G1Point(uint256(0x1616f6aaaa84ffe9a97ab4ada85707af19c931881afd7f94ffecf6b7e1dbe1b1), uint256(0x18e1a7b08547f93340c2f1471d80e8d992127e3ce4b44f877747d88169135b9d));
        vk.gamma_abc[35] = Pairing.G1Point(uint256(0x2c76a302519831216a386a7fe9cb74aa47ec27dc7559c2dbb6051b67eb77614e), uint256(0x30289d5699951b7971cc3b1bf3ad63cbc24a2874f1cf7281a75263f7b2fe138f));
        vk.gamma_abc[36] = Pairing.G1Point(uint256(0x1088dfaf1801232720cb30836ad13cab4717a100675227b7e8510405b5fe32ed), uint256(0x2c54e002796362d724f00acb136d48651943f45d7bd2553d474272fe9dcc8107));
        vk.gamma_abc[37] = Pairing.G1Point(uint256(0x2f25251c83eaf70d593428a460d8953c16783a708f183b84e03d439cd3fe6430), uint256(0x0f2692751a09179a11b435446d6937906e0db4f8d9fa79ec80554cfc00e466be));
        vk.gamma_abc[38] = Pairing.G1Point(uint256(0x0408a02cb1281f3f5935ec55d18d63c02fe1fe6426aac96121880b78b5155d73), uint256(0x02f4d87695798880ed17674d32d2c41a58b131b78b447337f142e12f9d7b5f56));
        vk.gamma_abc[39] = Pairing.G1Point(uint256(0x1939c37a7c5a78b3cc2055a56ad55d26d4943c99bceef45d745e333b3c78a9e0), uint256(0x17dc13347254e0f1d36d908b6e6c39f920a99ea5ad4a3e0c7e62de928cbc75c6));
        vk.gamma_abc[40] = Pairing.G1Point(uint256(0x263e585e3ebb68dfb423eebc3d02dd1aef1d0efe527bd827293442dc012b5e9b), uint256(0x1e5b458697a6cced6909dcf9b039b7660618ca989d22c0873b7fc964410df4a5));
        vk.gamma_abc[41] = Pairing.G1Point(uint256(0x27b2587f8d0771541b5799938257f50bcb2d004c34cdc4e48fa6d97a684e0ff3), uint256(0x183e794d45764d9cb0466d1084205cc73a8ae42f38ee533c7ceb5066468f5ee0));
        vk.gamma_abc[42] = Pairing.G1Point(uint256(0x2b42f2cd525e3c4921c1c343630999d6ec8a58080427ee5c5dddb23b89458450), uint256(0x0a7902466941cccd166badfe2a54b9424d138dab67fc620b853c0d94ee21e226));
        vk.gamma_abc[43] = Pairing.G1Point(uint256(0x031205e55bcd98948b0b65da248e44d8d6be472f4905d236ebff1402e8862fe2), uint256(0x2d38f5aebe63180d3d3d6b9757d45c477485325a47e7f59b2962b63b33a4fd9b));
        vk.gamma_abc[44] = Pairing.G1Point(uint256(0x1a27e6997e4a1535a7a789d47aaae4a02b9c047c173ef41e87412dc0d1abe7aa), uint256(0x275c759eabe6845ec4535ff02bfb0488e15625a024e87b92e21807c457dd5cf0));
        vk.gamma_abc[45] = Pairing.G1Point(uint256(0x20fab8f0a0c8841c524ac2cf19cd89479e3293ed6a75b283c28c8edec4a7fb4d), uint256(0x1171f1dcb804e9e7a59e5b35ea8f73d03f218cdf5733ec8e6939d8a052c19bc5));
        vk.gamma_abc[46] = Pairing.G1Point(uint256(0x1aee90d7cd2a7073e327dd7210ebc35e98ed132dd0bb51291f56ef5fe5f98051), uint256(0x0f39b2fe80dc12441b15903d4f305af68a7765e51227647ba74e309f3297cc35));
        vk.gamma_abc[47] = Pairing.G1Point(uint256(0x22b224569bf15ab2782d31c28a98d2969348b40366403bca3acb40e775e196c1), uint256(0x1bfbccfeb4195023116585940f1048fe8a33f197179a7a2e91ba7a8ace5b89df));
        vk.gamma_abc[48] = Pairing.G1Point(uint256(0x1e842c3840f8291f871198d85a4f8fe4b81c249a9ebcd3a74a1350ff4f7c48fb), uint256(0x081eecf4fa81c9614080d1add15acfe69770d40808a7a040844668944aa114af));
        vk.gamma_abc[49] = Pairing.G1Point(uint256(0x242fefdd7922191c9c321524ed9118f4054f6d72caf002e94c9adb2fede88bb4), uint256(0x19cf22e68b411201e289791f28db1ef644c87ee8f5fe550398a1dcff31279a2e));
        vk.gamma_abc[50] = Pairing.G1Point(uint256(0x0308296f2c2f778c81f103c05974552bf6d3322a87af213dc726ea2e0e498454), uint256(0x271f20eed208f55a521ae47f8391ffd796e7485ac89f6c0a1136f2aa22070eea));
        vk.gamma_abc[51] = Pairing.G1Point(uint256(0x216e3900edd1ae8d3c554b8e4339fdac295244aebc58881a72f1608eb544e88b), uint256(0x240e8312cc1be7ccafd1e8948bb5a7a589206f4ee273caad1d281930418ec145));
        vk.gamma_abc[52] = Pairing.G1Point(uint256(0x19ca8dc0157044756115c1510c56e4d83024674db4b7bf585b09407fcf73b3ab), uint256(0x1b5b416a37e6175038da77eae11062e59f638649c7414f3895cf33c0758258d6));
        vk.gamma_abc[53] = Pairing.G1Point(uint256(0x3010b006a0defb1f1464adc2acfaa20e492f61b91b78988d973031e0f4fd53b0), uint256(0x24bd08bf73caec5b5a979cecc9e7a83609b4f3a5e2fb3aa294250c49e689a20c));
        vk.gamma_abc[54] = Pairing.G1Point(uint256(0x113be65b04ddee1a618e438546f6c8d3a17663ab3c5f0645219f1605765943e6), uint256(0x07a6928faa42d12ae6ab3a65bf7ad51be0bec0eb6867cd7886662616fa22abbe));
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
            uint[54] memory input
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
