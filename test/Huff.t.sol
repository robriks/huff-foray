// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import { HuffDeployer } from "foundry-huff/HuffDeployer.sol";

interface SingleAddFunc {
    // calls into the contract fallback, so function name is irrelevant
    function any(uint256 a, uint256 b) external returns (uint256);
}

interface HelloWorld {
    // calls into the contract fallback, so function name is irrelevant
    function any() external returns (string memory);
}

interface AddTwo {
    function addTwo(uint256 a, uint256 b) external returns (uint256);
}

interface SimpleStorage {
    function setValue(uint256 val) external;
    function getValue() external returns (uint256);
}

contract HuffTest is Test {
    SingleAddFunc public singleAddFunc;
    HelloWorld public helloWorld;
    AddTwo public addTwo;
    SimpleStorage public simpleStorage;

    function setUp() public {
        // use HuffDeployer plugin to deploy contracts
        singleAddFunc = SingleAddFunc(HuffDeployer.deploy('singleAddFunc'));
        helloWorld = HelloWorld(HuffDeployer.deploy('helloWorld'));
        addTwo = AddTwo(HuffDeployer.deploy('addTwo'));
        simpleStorage = SimpleStorage(HuffDeployer.deploy('simpleStorage'));
    }

    function testSingleAddFunc() public {
        uint256 _a = 420;
        uint256 _b = 69;
        uint256 ret = singleAddFunc.any(_a, _b);

        assertEq(ret, _a + _b);
    }

    function testHelloWorld() public {
        string memory ret = helloWorld.any();

        assertEq(ret, 'Hello, world!');
    }

    function testAddTwo() public {
        uint256 _a = 69;
        uint256 _b = 42;
        uint256 ret = addTwo.addTwo(_a, _b);

        assertEq(ret, _a + _b);
    }

    function testSimpleStorageSetValue() public {
        uint256 val = 69;
        assertEq(simpleStorage.getValue(), 0);

        simpleStorage.setValue(val);
        assertEq(simpleStorage.getValue(), val);
    }

    function testSimpleStorageGetValue() public {
        uint256 r = simpleStorage.getValue();
        assertEq(r, 0);
    }
}
