pragma solidity ^0.5.8;

import './VCC10M30M70.sol';
import './VCC20M30M70.sol';
import './VCC30M30M70.sol';
import './VCC40M30M70.sol';
import './VCC50M30M70.sol';
import './VCC60M30M70.sol';
import { Util } from "./lib/Util.sol";

contract AuctionConstant {

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
            return false;
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

    //unverified solutions
    function submitSolution(uint[] calldata _route, uint _mapnumber, uint _sum) external inState(task.state, State.Running) returns(bool) {
        require(task.verification == false, 'only verified solutions are permitted.');

        task.solutions.push(Solution(msg.sender, _route, _mapnumber, _sum));
        return true;
    }

    function submitSolutionVerifiable(
        uint[2] calldata _a,
        uint[2] calldata _b1,
        uint[2] calldata _b2,
        uint[2] calldata _c,
        uint[] calldata _route,
        uint _mapnumber,
        uint _sum,
        uint[2] calldata _hc,
        uint[2] calldata _hr
        ) external inState(task.state, State.Running) {
        require(task.verification == true, 'only verified solutions are permitted.');

        emit gasinfo(gasleft()); //0
        checkHashes(_hr, _route, _hc, _mapnumber);
        emit gasinfo(gasleft()); //1
        bool r = verify(_a, Util.mergeArrays(_b1, _b2), _c, _sum, _hc, _hr);
        
        emit gasinfo(gasleft()); //4
        if(r == true){
            task.solutions.push(Solution(msg.sender, _route, _mapnumber, _sum));
        }else{
            revert('verification failed.');
        }
        emit gasinfo(gasleft()); //5
    }

    function checkHashes(uint[2] memory _hr, uint[] memory _route, uint[2] memory _hc, uint _map) internal view {

        uint[] memory citiesIdx = Util.getCitiesIdx(task.cities, _map);
        uint[] memory cities = new uint[](_route.length);

        for(uint i = 0; i < cities.length; i++) {
            cities[i] = _map;
            if(i < task.cities.length){
                cities[i] = citiesIdx[i];
            }
        }

        if(_route.length == 10){
            Util.verifyHashOf10Elements(_route, _hr);
            Util.verifyHashOf10Elements(cities, _hc);
        }else if(_route.length == 20){
            Util.verifyHashOf20Elements(_route, _hr);
            Util.verifyHashOf20Elements(cities, _hc);
        }else if(_route.length == 30){
            Util.verifyHashOf30Elements(_route, _hr);
            Util.verifyHashOf30Elements(cities, _hc);
        }else if(_route.length == 40){
            Util.verifyHashOf40Elements(_route, _hr);
            Util.verifyHashOf40Elements(cities, _hc);
        }else if(_route.length == 50){
            Util.verifyHashOf50Elements(_route, _hr);
            Util.verifyHashOf50Elements(cities, _hc);
        }else if(_route.length == 60){
            Util.verifyHashOf60Elements(_route, _hr);
            Util.verifyHashOf60Elements(cities, _hc);
        }else{
            revert('not supported.');
        }
    }

    function verify(
        uint[2] memory _a,
        uint[2][2] memory _b,
        uint[2] memory _c,
        uint _sum,
        uint[2] memory _hc,
        uint[2] memory _hr ) internal returns (bool) {

        uint[6] memory input;
        input[0] = _sum;
        input[1] = _hc[0];
        input[2] = _hc[1];
        input[3] = _hr[0];
        input[4] = _hr[1];
        input[5] = 1;

        bool result;
        if(task.cities.length <= 10) {
            IVCC10M30M70 iv = IVCC10M30M70(verificationContracts[10]);
            emit gasinfo(gasleft()); //2
            result = iv.verifyTx(_a, _b, _c, input);
            emit gasinfo(gasleft()); //3
        }else if(task.cities.length <= 20) {
            IVCC20M30M70 iv = IVCC20M30M70(verificationContracts[20]);
            emit gasinfo(gasleft());
            result = iv.verifyTx(_a, _b, _c, input);
            emit gasinfo(gasleft());
        }else if(task.cities.length <= 30) {
            IVCC30M30M70 iv = IVCC30M30M70(verificationContracts[30]);
            emit gasinfo(gasleft());
            result = iv.verifyTx(_a, _b, _c, input);
            emit gasinfo(gasleft());
        }else if(task.cities.length <= 40) {
            IVCC40M30M70 iv = IVCC40M30M70(verificationContracts[40]);
            emit gasinfo(gasleft());
            result = iv.verifyTx(_a, _b, _c, input);
            emit gasinfo(gasleft());
        }else if(task.cities.length <= 50) {
            IVCC50M30M70 iv = IVCC50M30M70(verificationContracts[50]);
            emit gasinfo(gasleft());
            result = iv.verifyTx(_a, _b, _c, input);
            emit gasinfo(gasleft());
        }else if(task.cities.length <= 60) {
            IVCC60M30M70 iv = IVCC60M30M70(verificationContracts[60]);
            emit gasinfo(gasleft());
            result = iv.verifyTx(_a, _b, _c, input);
            emit gasinfo(gasleft());
        }else {
            revert('not supported.');
        }

        return result;
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