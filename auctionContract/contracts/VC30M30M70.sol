pragma solidity ^0.5.0;

import { BN256G2 } from "./lib/BN256G2.sol";
import { Pairing } from "./lib/Pairing.sol";

contract IVC30M30M70 {
    function verifyTx(
            uint[2] memory a,
            uint[2][2] memory b,
            uint[2] memory c,
            uint[34] memory input
        ) public returns (bool r);
}

contract VC30M30M70 {
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
        vk.a = Pairing.G1Point(uint256(0x0ef474bb055202507722de7be2f2a93434089b5f371de66c5865b41b0417130b), uint256(0x15730e4c8ed01549be1e0536b33441adddc95f46ec424e31a006998da32ffd97));
        vk.b = Pairing.G2Point([uint256(0x02dbe83e4dbbe96931ae437b779a392c7eed30a03bf55afa830726e29a6cd2d5), uint256(0x245401845b510f59048176b11ed633c37fd038fc4ddd4be39df167b0fbe0bbf8)], [uint256(0x2bdf1cd8e82d9dd07d78a7e17eececa5f60698c7cc92db0f0a4918e633a62eab), uint256(0x031d92fe6915dcc6b43cd4300c4f5f2e85d76b0380f12213459f854faf2897c4)]);
        vk.gamma = Pairing.G2Point([uint256(0x1c2f3dd45846975776a967154a507a74bbb70dea8257e890520f7bac9b29cb08), uint256(0x0e6915cc37df2100a922d350cd4cef4296559dcbeeb999e4b068aba358f07c63)], [uint256(0x21de23b125f0d557ed5bea03e3f42ab918c0ebeb859f65d661dbdcf137023ad0), uint256(0x1afd4ea00093af31ee1388be9a1242cf31f5a7bd15af186c9ed109e70edb9b42)]);
        vk.delta = Pairing.G2Point([uint256(0x15e744198017e5d9dc3e746fdad59cb5412e72ab388fa34f1633547d35a5c8e2), uint256(0x1cb73a9a1b5f5104597822a8b3b064ff7b7f60a1dd897bc75dbf3bc245832d9c)], [uint256(0x077f56a4ab4ca54e4c68fc9a9def39b6a32eb90c261d4e8b036c6578b4943e86), uint256(0x10eb1a9e9be24373b46f846d69efbc3919c61dbc97961868cfdfa14c3a3bbdb0)]);
        vk.gamma_abc = new Pairing.G1Point[](35);
        vk.gamma_abc[0] = Pairing.G1Point(uint256(0x2d1213ba27e2290a8f6e10f467788695d53508fb352a77c923bd3e456fb722c1), uint256(0x2704fb67311cecc0180d5bf709f142b52dd5832c4cb2137e341a70d2e0835b2f));
        vk.gamma_abc[1] = Pairing.G1Point(uint256(0x1ea4ccb335cdf18b026c51602d1aa2a12f2cef3518a982a0dd5a15b70e2e8c1b), uint256(0x006da9e68484d848690a8dafa58c8006ee1746086cc94ffd8637bd5970f6e37e));
        vk.gamma_abc[2] = Pairing.G1Point(uint256(0x232fec77330c8ba801152e7563cafde08fd60098541b92e2efc529310a734e64), uint256(0x24b98d3f4f1345a66506e4ff54a80fe3491d3a4488a8d057ae79a5be78b3f7fe));
        vk.gamma_abc[3] = Pairing.G1Point(uint256(0x15375d51cbfac03fa01634cb70c8d7571acb97ae2e3a91665b80e54f04225028), uint256(0x05dcef4c84980c94a12c6ba33c8bc973d308047f2ba15775597e6acee379041f));
        vk.gamma_abc[4] = Pairing.G1Point(uint256(0x2dd188f9d19eaa03fcc699e60dddd618ae1df5cfdba812a973d01fb0a29f2564), uint256(0x1e063ec4dea9f471dca7af972202e5fece87fd85d2256defffc10983fa13725e));
        vk.gamma_abc[5] = Pairing.G1Point(uint256(0x04b1f411d7b690b4e80d461d92fd72820a6920dcb9370b3d917815f712b47fdb), uint256(0x102845762f2c836395ebf68501c5f990d427b1a7badb44719fb4f2ae899cb0eb));
        vk.gamma_abc[6] = Pairing.G1Point(uint256(0x1b6168f435fcb2169b244f4d288eee38de59522078b084c7f09c9ce28e063e4e), uint256(0x1259526b961b1b59b23bc81424d23cd93726c6d26be649ffa8b99980f7f2970e));
        vk.gamma_abc[7] = Pairing.G1Point(uint256(0x1d1e3e4b111a3856ffc18a49848ae17623c5cc6b5e2595df7b21b4db84dfec4f), uint256(0x26ea1f3b5beef519b408c72247cbbdb698ac5474cfe480dda54e9f9b6077295e));
        vk.gamma_abc[8] = Pairing.G1Point(uint256(0x2edb20fb0a225a5127379b084fe741d1b9b2ff7faf4f8cbcb7ecdb50d7d07d92), uint256(0x200b9ee0732bd57abc11455db814644f51b4798799b65f4bd9fba20216f3f04a));
        vk.gamma_abc[9] = Pairing.G1Point(uint256(0x24bcc31a30fdfdfbbddf12e8aa037ee2414611dbaf304bfcc2d1016b60437c0f), uint256(0x1467880333c0069566a5854ef0fa03872fc876d7442933703a69ee920740256a));
        vk.gamma_abc[10] = Pairing.G1Point(uint256(0x11ad030a9fd974a840a52bb5fefacfb4f61aef32a034efddb924c6b6ca66cba9), uint256(0x12db949bb8e553fde154af7bac6b7d1ac29785406afb562dec42e1ad12ca1fcc));
        vk.gamma_abc[11] = Pairing.G1Point(uint256(0x033d674f90be57e22e37540acc9eaae17bb768302b5d41273ac73f6fb16aa88b), uint256(0x2a7e24a8b52e9f019ae9d57bbf87fb48bf0282b94898cb9c7df92e4c88a72907));
        vk.gamma_abc[12] = Pairing.G1Point(uint256(0x1767de310dd42170377118ec49bb515606d367b628bec3a5ecf3ddccd3306c14), uint256(0x213e32e0b14d6fb4ee35bd2e9b23d0aaa0918935e4d44ea5f50799b25e996864));
        vk.gamma_abc[13] = Pairing.G1Point(uint256(0x22491372ad8402af27d74c0ae27e42a98048ed55e980804233ef7557cd7eb5fe), uint256(0x044505cb022de0c8398ae2437e1e2c0a1c3ebf008d5120e73c0d7fff2f397194));
        vk.gamma_abc[14] = Pairing.G1Point(uint256(0x08ab5fc51ab546eff0e5deb437154aeb4f9fa624528253d561a85dcf576d9b05), uint256(0x0a12b3b05dca1d16bc772ab9c5dc3233ede8c61fbd84a66e81a4e2ec0e2660de));
        vk.gamma_abc[15] = Pairing.G1Point(uint256(0x01aa3ff71f79f4f34e48bdb53e97ea61533fba48b9e32491bf46ed21086cdb3f), uint256(0x29d0be4f53a764b0eeda365df2187c28ea40736f881f56b14af4f734680190fb));
        vk.gamma_abc[16] = Pairing.G1Point(uint256(0x0576cf5013ffd17e7a0f4a693aee9fb342238037c2d848773539c4f7ab198e78), uint256(0x28391690c42a61d881c31650e6c2935d441ebf3b43a1bd0064e7d58ff83a3ee9));
        vk.gamma_abc[17] = Pairing.G1Point(uint256(0x0bde761f07f8362952065deb3d864b9655863592ef3ca9847cf39695d55888df), uint256(0x2d9e9b757308874f56f491bdd8c36ded8c17c9fc416add35cfb0fbacf5295d15));
        vk.gamma_abc[18] = Pairing.G1Point(uint256(0x26106e1254c435f843f227bea558785c7128fff931e2c0608d4fb66eaf1d3e4e), uint256(0x14bb3ea70fd30934de437d0db9befd95b47c3c8477b3b6c6d5463a5205fe6b16));
        vk.gamma_abc[19] = Pairing.G1Point(uint256(0x11d1a35d08dab07244abb732ee60283e4523de5e257964d2da3383ced0bae6ce), uint256(0x09163a3589602cee1088267a92d214d2d0041d146137cf1f15a0370ddd5d7ed0));
        vk.gamma_abc[20] = Pairing.G1Point(uint256(0x1864d668c633dd349448747d1190585e52e9fa78f0a287c3d6b8db0357f1b2e4), uint256(0x1c3f21d8592b240f28e148f9f9aaca18f26f5d9c1f48f2eb726e42050ea9039b));
        vk.gamma_abc[21] = Pairing.G1Point(uint256(0x12447dc026b64499a23d80a793a3ebbd42602d08c2d085263fbb0da5807af538), uint256(0x1e746627f22a204437a181d80fc17313a111bf3b8440db9a4bbb0fc14a29d91c));
        vk.gamma_abc[22] = Pairing.G1Point(uint256(0x15a10180800b3efd1c3e3b2255e9decc879571822e6221b7979494a07515c3a8), uint256(0x0ba355093eea407ed67b8e5fb69e29e86d5509e1a13aaefc924b0d2046b6ee16));
        vk.gamma_abc[23] = Pairing.G1Point(uint256(0x14dd4d2ac07c2d07873dad4d81108b6e2686bd7517a3f1afbf03df8a3233d23d), uint256(0x0c3341eb3668d0ba7217cabaa0583bfb28e6bd8a76057797545a1fae8323564e));
        vk.gamma_abc[24] = Pairing.G1Point(uint256(0x0ab80818db986a075d9d49729a2ed3364cc3a7ff3a8a83e510adf848ce07e7a2), uint256(0x252987227f342fd6b44a37319e3b78001e73a74848b8977c81a9550d2807ed5b));
        vk.gamma_abc[25] = Pairing.G1Point(uint256(0x0f6570b0155ed1ac4501868603ad022cf38291cf76fe580995da18e1760cd3d9), uint256(0x20c99ae8272977ebb268338eb3e9bfbca131565d0f1b3e2c52cd04bc2b972b96));
        vk.gamma_abc[26] = Pairing.G1Point(uint256(0x0a02b9c0feb7d03a4323da9e50693b5a2f96cb912a2d7d9860a4342b0fce5509), uint256(0x2537562e0382ed2ffe8d04670e2d6e46a67f2939b94d83f8bcfbcab9eebec469));
        vk.gamma_abc[27] = Pairing.G1Point(uint256(0x2482988d2877efda1d6ffa92f5505872417f48436e783669125ddee2fbac8cc8), uint256(0x00503b2c5766f29da6c62f024884ce835cc3563069182b597ed68f8c41424a16));
        vk.gamma_abc[28] = Pairing.G1Point(uint256(0x20f80c885ea4ffe3ed4ef91dbad8a7b89b82f3b05d5076c4612633b4a34a28b6), uint256(0x180c7e703d1fe4af9d4ca1c78aa192ab5dd7cd1135cfa692a16a7bfe209392f7));
        vk.gamma_abc[29] = Pairing.G1Point(uint256(0x0b85f69cfb1cadf6936d2d77967bff84322a9552d96329f4e22abcfbac075252), uint256(0x1461cbb6e0d0783c72979957e011ba2bb59be82f6bc52f311857bc07dcb93459));
        vk.gamma_abc[30] = Pairing.G1Point(uint256(0x066a6f6d49b6c09191267d12294f4404561038da1fc27ebac51d621446995ee2), uint256(0x19100d2a45fd8bd4fc6bea5dd1cc04a2f310afc3cc867eea5915a20603234e0a));
        vk.gamma_abc[31] = Pairing.G1Point(uint256(0x1e6f56a7187da5cae318b28a61e63d71333756ff502511410bb4a65ea52a5d4e), uint256(0x162fd752e64b0ee974b9b992b630c994a6e2c60f527dca166576c52860da3b2d));
        vk.gamma_abc[32] = Pairing.G1Point(uint256(0x255ec1cc9a51df7ad4b3d6d97891e3e97b15e8594ff53573fe4dbd131038285b), uint256(0x16c84f3b237f7baecd48fd0211216df86d3357f8d986957501f2c9312c89fe1e));
        vk.gamma_abc[33] = Pairing.G1Point(uint256(0x28cfb18fb54484e06baecb648353aed61691f7ae3d04ceb4f027eb5c04d7ed54), uint256(0x1377cdfc6809228fcd1c7e2c5d82525547aaf82775d36fd3ec40a71a68d1306e));
        vk.gamma_abc[34] = Pairing.G1Point(uint256(0x1033818366af3b130ee4ee76aa00301aa689197969aa553e36b721a78e82a26e), uint256(0x225277328e4af1a4102f564be6b2a170f78bc2aeef8275bd4bfc2f3a0c7c48cc));
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
            uint[34] memory input
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
