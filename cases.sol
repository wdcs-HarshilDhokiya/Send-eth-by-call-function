// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

//CASE-1 
contract Target {
    uint value;

    fallback() external payable {}

    // function setValue(uint _value) public returns (uint256) {
    //     value = _value;
    //     return value;
    // }

    function getBalance() external view returns(uint){
        return address(this).balance;
    }
} 


contract Caller {

    function saveValueByCall(address targetcontract) public payable returns (bool) {
        (bool success,) = targetcontract.call{value:msg.value}("");
        return success;
    }

}



//CASE-2
contract _Target {
    uint value;

    // fallback() external payable {}

    function setValue(uint _value) public payable returns (uint256) {
        value = _value;
        return value;
    }

    function getBalance() external view returns(uint){
        return address(this).balance;
    }
} 


contract _Caller {


    function saveValueByCall(uint _value, address targetContract) public payable returns (bool,uint) {
        (bool success,bytes memory data) = targetContract.call{value:msg.value}(abi.encodeWithSignature("setValue(uint256)", _value));
        return (success,abi.decode(data,(uint)));
    }

}