pragma solidity ^0.5.8;

import './VC10M30M70.sol';
import './VC20M30M70.sol';
import './VC30M30M70.sol';
import './VC40M30M70.sol';
import './VC50M30M70.sol';
import './VC60M30M70.sol';
import { Util } from "./lib/Util.sol";

contract Auction {

    struct Solution {
        address payable worker;
        uint[] route;
        uint mapnumber;
        uint sum;
    }

    struct Task {
        address owner;
        bool verification;
        bytes32[] cities;
        uint deposit;
        Solution[] solutions;
        State state;
        uint auctionEnd;
    }
    event gasinfo(uint256 g);
    enum State {Ready, Running, Ended}
    address contractOwner;
    Task task;

    mapping(uint => address) verificationContracts;

    //modifiers
    modifier equalsAddress(address _address) {
        require (
            _address == msg.sender,
            "error: caller has no permission."
            );
        _;
    }

    modifier inState (State actual, State expected){
        require(
            actual == expected,
            'error: not possible in current state.'
            );
        _;
    }

    modifier orState (State actual, State option1, State option2){
        require(
            actual == option1 || actual == option2,
            'error: not possible in current state'
        );
        _;
    }

    modifier timeExceeded() {
        require(
            block.number > task.auctionEnd,
            'error: auction is not exceeded yet.'
        );
        _;
    }

    constructor () public {
        contractOwner = msg.sender;
    }

    //uint _contract == number of cities
    function setVerifyAddress(uint _contract, address _address) external equalsAddress(contractOwner) returns(bool) {
        verificationContracts[_contract] = _address;
    }

    function createAuction(
        bytes32[] calldata _cities,
        bool _verification
        ) external payable orState(task.state, State.Ready, State.Ended) returns(bool) {
        require(msg.value > 0, 'msg.value <= 0');
        require(_cities.length > 1, '_cities.length <= 1');

        task.owner = msg.sender;
        task.verification = _verification;
        task.cities = _cities;
        task.deposit = msg.value;
        task.solutions.length = 0;
        task.auctionEnd = block.number + 1;
        task.state = State.Running;
        return true;
    }

    function endAuction() external inState(task.state, State.Running) timeExceeded() returns(bool){

        if(task.solutions.length < 1){
            revert("no solutions submitted yet.");
        }

        Solution memory s = task.solutions[getBestSolutionIdx()];
        s.worker.transfer(task.deposit);
        task.state = State.Ended;

        return true;
    }

    function retrieveSolution() external view inState(task.state, State.Ended) equalsAddress(task.owner) returns(uint[] memory, uint){
        Solution memory s = task.solutions[getBestSolutionIdx()];
        return (s.route, s.mapnumber);
    }

    function getBestSolutionIdx() internal view returns(uint) {
        require(task.solutions.length > 0, 'no solutions submitted yet.');

        uint minSum = task.solutions[0].sum;
        uint bestSolutionIdx = 0;

        for(uint i = 1; i < task.solutions.length; i++) {
            if(task.solutions[i].sum < minSum) {
                minSum = task.solutions[i].sum;
                bestSolutionIdx = i;
            }
        }

        return bestSolutionIdx;
    }

    function verfiyTask10Cities(uint[2] memory a, uint[2][2] memory b, uint[2] memory c, uint[] memory i) internal returns (bool) {
        uint[14] memory input;

        for(uint j = 0; j < input.length; j++){
            input[j] = i[j];
        }

        IVC10M30M70 iv = IVC10M30M70(verificationContracts[10]);
        emit gasinfo(gasleft()); //2
        bool r = iv.verifyTx(a, b, c, input);
        emit gasinfo(gasleft()); //3
        return r;
    }

    function verfiyTask20Cities(uint[2] memory a, uint[2][2] memory b, uint[2] memory c, uint[] memory i) internal returns (bool) {
        uint[24] memory input;

        for(uint j = 0; j < input.length; j++){
            input[j] = i[j];
        }

        IVC20M30M70 iv = IVC20M30M70(verificationContracts[20]);
        emit gasinfo(gasleft());
        bool r = iv.verifyTx(a, b, c, input);
        emit gasinfo(gasleft());
        return r;
    }

    function verfiyTask30Cities(uint[2] memory a, uint[2][2] memory b, uint[2] memory c, uint[] memory i) internal returns (bool) {
        uint[34] memory input;

        for(uint j = 0; j < input.length; j++){
            input[j] = i[j];
        }

        IVC30M30M70 iv = IVC30M30M70(verificationContracts[30]);
        emit gasinfo(gasleft());
        bool r = iv.verifyTx(a, b, c, input);
        emit gasinfo(gasleft());
        return r;
    }

    function verfiyTask40Cities(uint[2] memory a, uint[2][2] memory b, uint[2] memory c, uint[] memory i) internal returns (bool) {
        uint[44] memory input;

        for(uint j = 0; j < input.length; j++){
            input[j] = i[j];
        }

        IVC40M30M70 iv = IVC40M30M70(verificationContracts[40]);
        emit gasinfo(gasleft());
        bool r = iv.verifyTx(a, b, c, input);
        emit gasinfo(gasleft());
        return r;
    }

    function verfiyTask50Cities(uint[2] memory a, uint[2][2] memory b, uint[2] memory c, uint[] memory i) internal returns (bool) {
        uint[54] memory input;

        for(uint j = 0; j < input.length; j++){
            input[j] = i[j];
        }

        IVC50M30M70 iv = IVC50M30M70(verificationContracts[50]);
        emit gasinfo(gasleft());
        bool r = iv.verifyTx(a, b, c, input);
        emit gasinfo(gasleft());
        return r;
    }

    function verfiyTask60Cities(uint[2] memory a, uint[2][2] memory b, uint[2] memory c, uint[] memory i) internal returns (bool) {
        uint[64] memory input;

        for(uint j = 0; j < input.length; j++){
            input[j] = i[j];
        }

        IVC60M30M70 iv = IVC60M30M70(verificationContracts[60]);
        emit gasinfo(gasleft());
        bool r = iv.verifyTx(a, b, c, input);
        emit gasinfo(gasleft());
        return r;
    }

    function composeVectorI(uint _mapnumber, uint _sum, uint[2] memory hr, uint _length) public view returns(uint[] memory) {

        uint[] memory cities = Util.getCitiesIdx(task.cities, _mapnumber);
        uint[] memory result = new uint[](_length);

        for(uint i = 1; i < _length; i++){
            result[i] = _mapnumber;
            if(i - 1 < task.cities.length) {
                result[i] = cities[i - 1];
            }
        }

        result[0] = _sum;
        result[_length - 3] = hr[0];
        result[_length - 2] = hr[1];
        result[_length - 1] = 1;

        //_sum, cities, padding, hr[0], hr[1], 1
        return result;
    }

    //verified solutions
    function submitSolutionVerifiable(
        uint[2] calldata _a,
        uint[2] calldata _b1,
        uint[2] calldata _b2,
        uint[2] calldata _c,
        uint[] calldata _route,
        uint _mapnumber,
        uint _sum,
        uint[2] calldata _hr
        ) external inState(task.state, State.Running) {
        require(task.verification == true, 'only verified solutions are permitted.');
        bool result;

        if(_route.length == 10) {
            emit gasinfo(gasleft()); //0
            Util.verifyHashOf10Elements(_route, _hr);
            emit gasinfo(gasleft()); //1
            result = verfiyTask10Cities(_a, Util.mergeArrays(_b1, _b2), _c, composeVectorI(_mapnumber, _sum, _hr, 14));
            emit gasinfo(gasleft()); //4
        }else if(_route.length == 20) {
            emit gasinfo(gasleft());
            Util.verifyHashOf20Elements(_route, _hr);
            emit gasinfo(gasleft());
            result = verfiyTask20Cities(_a, Util.mergeArrays(_b1, _b2), _c, composeVectorI(_mapnumber, _sum, _hr, 24));
            emit gasinfo(gasleft());
        }else if(_route.length == 30) {
            emit gasinfo(gasleft());
            Util.verifyHashOf30Elements(_route, _hr);
            emit gasinfo(gasleft());
            result = verfiyTask30Cities(_a, Util.mergeArrays(_b1, _b2), _c, composeVectorI(_mapnumber, _sum, _hr, 34));
            emit gasinfo(gasleft());
        }else if(_route.length == 40) {
            emit gasinfo(gasleft());
            Util.verifyHashOf40Elements(_route, _hr);
            emit gasinfo(gasleft());
            result = verfiyTask40Cities(_a, Util.mergeArrays(_b1, _b2), _c, composeVectorI(_mapnumber, _sum, _hr, 44));
            emit gasinfo(gasleft());
        }else if(_route.length == 50) {
            emit gasinfo(gasleft());
            Util.verifyHashOf50Elements(_route, _hr);
            emit gasinfo(gasleft());
            result = verfiyTask50Cities(_a, Util.mergeArrays(_b1, _b2), _c, composeVectorI(_mapnumber, _sum, _hr, 54));
            emit gasinfo(gasleft());
        }else if(_route.length == 60) {
            emit gasinfo(gasleft());
            Util.verifyHashOf60Elements(_route, _hr);
            emit gasinfo(gasleft());
            result = verfiyTask60Cities(_a, Util.mergeArrays(_b1, _b2), _c, composeVectorI(_mapnumber, _sum, _hr, 64));
            emit gasinfo(gasleft());
        }else{
            //not supported yet
            revert('not supported.');
        }
        
        emit gasinfo(gasleft()); //5
        if(result == true){
            task.solutions.push(Solution(msg.sender, _route, _mapnumber, _sum));
        }else{
            revert('verification failed.');
        }
        emit gasinfo(gasleft()); //6
    }

    //unverified solutions
    function submitSolution(uint[] calldata _route, uint _mapnumber, uint _sum) external inState(task.state, State.Running) returns(bool) {
        require(task.verification == false, 'only verified solutions are permitted.');

        task.solutions.push(Solution(msg.sender, _route, _mapnumber, _sum));
        return true;
    }

    function getTask() external view returns(bytes32[] memory){
        return task.cities;
    }

    function getShortestSolution() external view returns(uint){
        uint sidx = getBestSolutionIdx();
        return task.solutions[sidx].sum;
    }

    //debugging methods

    function getNumberOfCities() external view returns(uint) {
        return task.cities.length;
    }

    function getSolution(uint number) external view returns (uint[] memory) {
        return task.solutions[number].route;
    }
}