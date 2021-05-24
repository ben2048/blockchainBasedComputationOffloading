pragma solidity ^0.5.8;

library UtilLight {

    function mergeArrays(uint[2] memory _b1, uint[2] memory _b2) internal pure returns (uint[2][2] memory) {
        uint[2][2] memory _b;
        _b[0][0] = _b1[0];
        _b[0][1] = _b1[1];
        _b[1][0] = _b2[0];
        _b[1][1] = _b2[1];
        return _b;
    }

    function getSlice(uint256 begin, uint256 end, uint[] memory array) internal pure returns (uint[] memory) {
        uint[] memory r = new uint[](end-begin+1);

        for(uint i = 0; i <= end - begin; i++){
            r[i] = array[i + begin - 1];
        }

        return r;
    }

    function concatBytes16(bytes16 a, bytes16 b) internal pure returns (bytes32) {
        return bytes32 (uint256 (uint128 (a)) << 128 | uint128 (b));
    }

        function compareHashes(uint[2] memory _hr, bytes memory toHash) internal pure returns(bool) {
        bytes32 hashresult = sha256(toHash);
        if(
            parseDecimal((hashresult >> 128)) != _hr[0] ||
            parseDecimal(((hashresult << 128) >> 128)) != _hr[1]
        ) {
            revert('hash of route does not match.');
        }

        return true;
    }

    function parseDecimal(bytes32 byteString) internal pure returns (uint) {
        return uint(byteString);
    }

    function concatenate(uint[] memory route) internal pure returns (uint256){
        uint256 result;
        uint unit = 1;

        uint[] memory _route = new uint[](route.length + 1);
        _route[0] = 1;

        for(uint i = 1; i < _route.length; i++){
            _route[i] = route[i - 1];
        }

        uint idx = _route.length - 1;

        for(uint i = 0; i < _route.length; i++){
            result += _route[idx] * unit;

            if(_route[idx] <= 9){
                unit *= 10;
            }else if(_route[idx] > 9 && _route[idx] <= 99){
                unit *= 100;
            }else{
                revert('error');
            }
            idx--;
        }

        return result;
    }

    function getBytes32(uint a, uint b, uint c, uint d, uint[] memory _route) internal pure returns(bytes32) {
        return concatBytes16(
                        bytes16(uint128(concatenate(getSlice(a, b, _route)))),
                        bytes16(uint128(concatenate(getSlice(c, d, _route))))
                    );
    }

    function verifyHashOf10Elements(uint[] memory _route, uint[2] memory _hr) internal pure {

        if(compareHashes(_hr, abi.encodePacked(concatenate(_route))) == false){
            revert('error. hashes does not match.');
        }
    }

    function verifyHashOf20Elements(uint[] memory _route, uint[2] memory _hr) internal pure {

        bytes32 b1 = getBytes32(1, 10, 11, 20, _route);
        bool result = compareHashes(_hr, abi.encodePacked(b1));

        if(result == false){
            revert('error. hashes does not match.');
        }
    }

    function verifyHashOf30Elements(uint[] memory _route, uint[2] memory _hr) internal pure {
        bytes32 b1 = getBytes32(1, 10, 11, 20, _route);
        bytes32 b2 = bytes32(uint256(concatenate(getSlice(21, 30, _route))));

        bool result = compareHashes(_hr, abi.encodePacked(b1, b2));

        if(result == false){
            revert('error. hashes does not match.');
        }
    }

    function verifyHashOf40Elements(uint[] memory _route, uint[2] memory _hr) internal pure {
        bytes32 b1 = getBytes32(1, 10, 11, 20, _route);
        bytes32 b2 = getBytes32(21, 30, 31, 40, _route);

        bool result = compareHashes(_hr, abi.encodePacked(b1, b2));

        if(result == false){
            revert('error. hashes does not match.');
        }
    }

    function verifyHashOf50Elements(uint[] memory _route, uint[2] memory _hr) internal pure {
        bytes32 b1 = getBytes32(1, 10, 11, 20, _route);
        bytes32 b2 = getBytes32(21, 30, 31, 40, _route);

        bytes32 b3 = bytes32(uint256(concatenate(getSlice(41, 50, _route))));
        bytes32 b4 = bytes32(uint256(0));

        bool result = compareHashes(_hr, abi.encodePacked(b1, b2, b3, b4));

        if(result == false){
            revert('error. hashes does not match.');
        }
    }

    function verifyHashOf60Elements(uint[] memory _route, uint[2] memory _hr) internal pure {
        bytes32 b1 = getBytes32(1, 10, 11, 20, _route);
        bytes32 b2 = getBytes32(21, 30, 31, 40, _route);
        bytes32 b3 = getBytes32(41, 50, 51, 60, _route);
        bytes32 b4 = bytes32(uint256(0));

        bool result = compareHashes(_hr, abi.encodePacked(b1, b2, b3, b4));

        if(result == false){
            revert('error. hashes does not match.');
        }
    }
}