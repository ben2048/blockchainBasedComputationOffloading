pragma solidity ^0.5.0;

import { BN256G2 } from "./lib/BN256G2.sol";
import { Pairing } from "./lib/Pairing.sol";

contract IVC40M30M70 {
    function verifyTx(
            uint[2] memory a,
            uint[2][2] memory b,
            uint[2] memory c,
            uint[44] memory input
        ) public returns (bool r);
}

contract VC40M30M70 {
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
        vk.a = Pairing.G1Point(uint256(0x0ab92a33a04f094062a9663de7f21ec3d5e16b8cd1e6f37ad0444e68ae1d3c83), uint256(0x0f566c645729876f090b7e024fb8044b035aecbf60a5ea7a4bd2ed59810054b1));
        vk.b = Pairing.G2Point([uint256(0x298a134469c73a4249897081be4fdc9b6e3f031eb539e112ef516b5fa8172fed), uint256(0x19ef4f85e82b94db6f56e9c047265bea9e860202a87a3c49891b1a8b4007d016)], [uint256(0x0bd3569368ebddc4c7f5d97f7bb45e59e64cb98ec9f35d7a56d2492fc0b614f2), uint256(0x1613d10807a7957e31774b295e70a70298ccbbb51c78dd27c8017701502b01fe)]);
        vk.gamma = Pairing.G2Point([uint256(0x2418d75d3984c93c27d4902dfc3e18a1bca64e04d1419ce921d2361ba2484451), uint256(0x24029408df02b6542079a1f8a9e0447759256734f3b1a577246a0435a88144d5)], [uint256(0x233611fa0a3efce9e7235a246492da5d474ae2309271f8e36a8103fcc06c9b94), uint256(0x1437aa3d2057ac9381e8fcf4dd570e6754061165e0aef842d4064201d842c7ae)]);
        vk.delta = Pairing.G2Point([uint256(0x1f9301f74e40948578b6dea47f6392137df1c160238176fa2cd59e82240b6b1e), uint256(0x128fc8e6230c53e6d8568d3841d3144e2ce7236d18a1bbbad691c8ff9ae97d8e)], [uint256(0x25e2fc7d0c36eb74e0761fefde7621b2881ca1db05c37df8dedf7a705c77703c), uint256(0x193b468dc30bf0f5347f6eb6fbd5030fd3ce59a38b4d7824606fa0f88ef482e4)]);
        vk.gamma_abc = new Pairing.G1Point[](45);
        vk.gamma_abc[0] = Pairing.G1Point(uint256(0x208576c910da915d3315358b738954610bdb48c425825401560501947a2250a5), uint256(0x01f9fb0b3fa662ab7cd0c912adf0f1168f616d90f3f159de705ac9715cc354d4));
        vk.gamma_abc[1] = Pairing.G1Point(uint256(0x2a065c0f138b6de413047a8b32d197efb0c19f7ecd5d6c1dbe8e4b6e67e8d6b0), uint256(0x1b296824ef0db39eb3ce9c46257fdc3c85094c60221ac50dcd2351a0a47e18b3));
        vk.gamma_abc[2] = Pairing.G1Point(uint256(0x26625f5b922e1466fcf9ee4da10cc77e27a0b701b0cf781c9a83830f7dd88000), uint256(0x2e0369d34521e512b54570ec1cfee52a402a7a8c660fda6d804e425b01904a7c));
        vk.gamma_abc[3] = Pairing.G1Point(uint256(0x054c647867cbdad8fdd3807bffa023889d7c75c5ad248653c3c6c35b57aa331a), uint256(0x1b9f8c2cb67e7fdc82ca89eb31829d0786f8ab3137fb9cb924b11a03d71f0d89));
        vk.gamma_abc[4] = Pairing.G1Point(uint256(0x075d0105be763d9e10be35c781b9e1b547f3557a2bdc91e4a266e86cf94db7a0), uint256(0x0dd7f386ec857f9d0a518bee91a770e06f60162a26a7279d23838115f9479ee7));
        vk.gamma_abc[5] = Pairing.G1Point(uint256(0x16766ffd4c7491f0be5acfe9f8c86cb8ef5803884a591f69a409bb84d83db1e9), uint256(0x074a141ba95ad33d61223ba83afcb2bf9db65fc7a7d68001ac33cca1df1622dd));
        vk.gamma_abc[6] = Pairing.G1Point(uint256(0x06156a6db7df53bd27e37b2bffa4dfcdc684d4d8ea6331b5274d45dc3eb339b8), uint256(0x227e5fd0ddc9ac2ee17a0c9cc2cf9508fbae6c6ba7be3a3ad03f2ab568ea0fcb));
        vk.gamma_abc[7] = Pairing.G1Point(uint256(0x049eef8a65692099b70e68eb95e15f97ee99a4f8960977003bcfdfdae4caa485), uint256(0x1fbe63301f04261fa0e62eb84a5a931473829cb4b1a843df522c93ebde0cf500));
        vk.gamma_abc[8] = Pairing.G1Point(uint256(0x05425d9b326aba85760cd8f91e103d79ad6176bb53f72075f64b053485234cdf), uint256(0x050ac18c8d8d4c879a6803a3d34ebdb40551604629b6b132079c57dd4b45d4c8));
        vk.gamma_abc[9] = Pairing.G1Point(uint256(0x24d4f5d3beffcf76619b147c9ce638ff9bdb1ad2c28b756116d0b0d7eb7932a9), uint256(0x08f46f22ce2a8a509deddf4b861c82d0eb1a6ebf3cf0d40eccc0093cc9e74ac8));
        vk.gamma_abc[10] = Pairing.G1Point(uint256(0x24efe230984814d23ef7aa1daa0b41dfbcf7a84f2031ed452d711eaccaeb2ec9), uint256(0x2950afb792f1e2445d3bb8d20e388e8fbea80bd887128e3a1ece114bc660bc0d));
        vk.gamma_abc[11] = Pairing.G1Point(uint256(0x01105be444b75c1a1e85f237ed7009ecdfbded06befcd284849f92bdb1951429), uint256(0x05aa4a2b6fd5b591b48efd94a78bcdcb33f5f561dde5ff66b461898c554a70eb));
        vk.gamma_abc[12] = Pairing.G1Point(uint256(0x06ae2e4e6b7fb995e524888a46637d91bf81e5f60b8a302ee93c4c81fae74e22), uint256(0x057a01f68be20a4212ca4ccf397f60bdc1fc7c2f1304dedba49e25a81009c98e));
        vk.gamma_abc[13] = Pairing.G1Point(uint256(0x233bd50e5b4fe71568e73ac279d4fcc6fc3b982cbf110c83e42224287a2b6d35), uint256(0x02d1f9f17a08b3fed7f5fa07924ae138e4aabe518c6ebf08ecf624086a9fc0cd));
        vk.gamma_abc[14] = Pairing.G1Point(uint256(0x1df3b53d3a4bd73ae495020cc5bf5059569cdbb044a57851f6b5ef7b36070d32), uint256(0x1f8e73d1fc3cf3d99297989d3d6a452cd49ff3a116fa0093f47322d650f13c7b));
        vk.gamma_abc[15] = Pairing.G1Point(uint256(0x2347297d7ba1c793566e223d79ea9620db762fb1642be023f0e1ead4813dc349), uint256(0x1d9d41d40117f3e362e757b0cdba1d4e279c88152142f9e179d66c3442dfa87c));
        vk.gamma_abc[16] = Pairing.G1Point(uint256(0x2c7d6e73fd1761ed30218e2a7743abfbb40fcbcda99f97be64d2d20c3f2f4d16), uint256(0x02a8b8df69b879e76b11f6406661247989b8558f93db70176106bffc03bcea01));
        vk.gamma_abc[17] = Pairing.G1Point(uint256(0x19f07e536d515d029742b2ed8d22693f5f915ff3f385c60d57ac0c502175bf2c), uint256(0x2a4f2460580ce0713beca230a784796cd9b1d851cf9a16b752943058bfc3c57c));
        vk.gamma_abc[18] = Pairing.G1Point(uint256(0x2e57ee5eea868fd12301db1ecade22b67f2dc91cadbba8e0e5c2f46ceac53ccd), uint256(0x23ce092e8936e5d1586106bf3f44a6ac3fab67b004950e623eb8da667baacea2));
        vk.gamma_abc[19] = Pairing.G1Point(uint256(0x13fdf3e97fd89105f889698248a89838d80a5e987839be6d592fcf5bd037b3e0), uint256(0x2098bec3688dbbc2985772a18de95a0e50a3d75c4faf319aad9c89cc694b54e2));
        vk.gamma_abc[20] = Pairing.G1Point(uint256(0x11aa94a8ce24673b349a09b2bf1838409ef43df19ffded3b60849f84021a31e7), uint256(0x26513ded5bd65beb1b706782b5abbeb924e99643149757a436491c465ba3b2eb));
        vk.gamma_abc[21] = Pairing.G1Point(uint256(0x11ec5caa883868f535477bc03147c3670586bf0b5a737e14f0d737a2feab2ef5), uint256(0x1df0ba46f426528db84a16d5549212f82f2095f4ecad44a9fbcbf435d0937397));
        vk.gamma_abc[22] = Pairing.G1Point(uint256(0x2e272b756e723353ee8ae74b13039ec5c8ae2faac3d0a53f1c39c9d380c97198), uint256(0x2fb49d2ec81f19776437db88193de3dab15cb00693fc0c38a8ace1ee95a7ebd5));
        vk.gamma_abc[23] = Pairing.G1Point(uint256(0x25aeca980aef6e893c2722a59c7fecf49cd85e50b1c797b4fbffbd97a1e05b06), uint256(0x083a460f0f3cc34a52476cef729eed6c87e6e9d2befdafc5a425cabbb41fdd4c));
        vk.gamma_abc[24] = Pairing.G1Point(uint256(0x1cbb61bb4d5adcb9760bd9d3fe8536383ca9f73c93008985acc65868b73df247), uint256(0x1c3f5eaa3538644bf230f1cc17fdc648186cddf003b384322aa2b0e5ba90bb7e));
        vk.gamma_abc[25] = Pairing.G1Point(uint256(0x2f74171091bfdc2b7a57359d9621460489e4c644f8be9573913e2b1bcfb12262), uint256(0x0223d97c938ff30d8bb112957d9e3ce582fe77c371bec2ca14e3bfd1ccea129f));
        vk.gamma_abc[26] = Pairing.G1Point(uint256(0x23dcec9fc0a8d575e31099c659f317c73aba23d0ddd7d5d03aac6bef7a3e09f0), uint256(0x10700a63e072d43605b0257a229da31bd89b666d4fe2e8f1919dd568c28d6f72));
        vk.gamma_abc[27] = Pairing.G1Point(uint256(0x0957476aedc035e3ecca9e9babae3a342c59e5b0aa5268cfe616efd18d9d7c3b), uint256(0x1c819f38bfe16beaeb2f968d5134b8477a20198fa973d14c44572891ce1f366f));
        vk.gamma_abc[28] = Pairing.G1Point(uint256(0x0ccc51f292941fc6392f8b16ac2ae22d425c54e7cafe3178c91bc3117f912e68), uint256(0x11891f888d8525b802d4732b3d3118d83482677b2796ad89957114d532b10ed9));
        vk.gamma_abc[29] = Pairing.G1Point(uint256(0x2f62a90c12c38e843a1d8b4a35645d878a834c605a94a02866f30734d17f4b49), uint256(0x0646ba0d874c0e5da431757e5a7ddfd4d0656a0a0378d543a05259bb50afd416));
        vk.gamma_abc[30] = Pairing.G1Point(uint256(0x12e43295a1b1918b59121ea3f76e1995006bd8b7be15c8e496c138a625044c0c), uint256(0x10897cb6723b55d337a636ec4a3ec9b3361f0bc0a72129cc04672049b4985dae));
        vk.gamma_abc[31] = Pairing.G1Point(uint256(0x07f3ba8c008bf068500faf8db763d622f9ce118f093ee38bac59f1854bbd3ddc), uint256(0x14d197580964f61cacac02ff5803cc99d06ef2e17492a8a84e74169c479df14f));
        vk.gamma_abc[32] = Pairing.G1Point(uint256(0x232bb96c55caadc47a0a8889822b9a346c2a527bf1e2bdca163b8ad4f170038e), uint256(0x1bff16cbe89e8bb3bd27394fa687fc27b967f559b3082c6b8c93df45ef319914));
        vk.gamma_abc[33] = Pairing.G1Point(uint256(0x07a67d5203ed07006efdd3e537579ecef6aa3794056d311e969cab1ffd05719b), uint256(0x141fd6f679b43f60b8147c8e31e6c8a90208ad46e2b74dc363e336c4bd51c85a));
        vk.gamma_abc[34] = Pairing.G1Point(uint256(0x2b9b9ce019e3cf33e501daffb95b8918e9ec53925a8163760ea6051dc0e86738), uint256(0x0076276dfbdd064cdcc69228da2e0be8d659f20cca08e4fe0be9968a6b2122d8));
        vk.gamma_abc[35] = Pairing.G1Point(uint256(0x1c0037a1c35fd5ec9f1a53951d73945ca76cb12345cb7c3c666311833054db25), uint256(0x234268a79f06e9884bf7cc79d4009069d5045c34494a1cd979ebac98b5df701a));
        vk.gamma_abc[36] = Pairing.G1Point(uint256(0x0cf9f835f41645f40fa05f5fe3783a6d224f18ded725b342339c788ddea169c1), uint256(0x0b24d9d855c0baa671bced445b07ff3640a33fb9af363ffbd97570dcce7bb8b3));
        vk.gamma_abc[37] = Pairing.G1Point(uint256(0x2a846341f04ac562417780774695a74b193f3cdef9863fb24d4f37319d53e687), uint256(0x2011b80436fe14b984023ce3063f0524c2704b3bc23aaff9c6cd264a484024a2));
        vk.gamma_abc[38] = Pairing.G1Point(uint256(0x23ccc05fcbcf17f03dd6c0b8cb78b6638f4be3266c9d6ea524feb63eee2a5b8e), uint256(0x0515efc302c640ce0fea64655e4707a6f8ecd9d31f458d2b8455598d374a2a78));
        vk.gamma_abc[39] = Pairing.G1Point(uint256(0x08dd3d33fe9879b9212551720e8db55aae6a6a41375bc34485b961d93b5d6a7c), uint256(0x0106a71790a18684d41c9f3eefb23e4c3c122077cb1ee1aa7bae6eac1d59f5d6));
        vk.gamma_abc[40] = Pairing.G1Point(uint256(0x2bc493edf41b69e65b4c883faca20d4b728953c041dcaa57e9d3a950c3546295), uint256(0x0d1bed5f11c62fa6370b1e63580b67282b777763406ef02f7c243f52be74fbcd));
        vk.gamma_abc[41] = Pairing.G1Point(uint256(0x20452c6681be0f32bc0a69d2df129c4533b7bd99c8624915d8f2a563beebd890), uint256(0x0e617416b7557db54cec650f177997bd34a46ad6d809099d8ecbafaa840bfcf8));
        vk.gamma_abc[42] = Pairing.G1Point(uint256(0x2fa479d64259cf5241b3cdd0d4a5a5a74517cfc96150a1646d222581ef02aad4), uint256(0x056229cc24170ece4eb1b2cbadd7fe88b79e633351d1952286443bdcd0c9f70f));
        vk.gamma_abc[43] = Pairing.G1Point(uint256(0x1849d405a648d5477e207d1dd51c15eff85184b3dff4ad33894266962595f222), uint256(0x23c43945e12d82094b45eda7411a8fdefe5629080e8a94f9181427b6d36164d7));
        vk.gamma_abc[44] = Pairing.G1Point(uint256(0x1a4368e51c7be66c4367e95a7c28a271ec72f32b87b20590b2a515f78f57daee), uint256(0x0e8d8c839dd8e4a15170ce5a5545833be1b79f0730da923b07e80ca2c26dce84));
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
            uint[44] memory input
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
