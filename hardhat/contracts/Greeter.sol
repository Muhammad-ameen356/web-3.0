// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Greeter {
    string private greeting;

    constructor() {
        greeting = "hello";
    }

    function getGreeting() public view returns (string memory) {
        return greeting;
    }
}
