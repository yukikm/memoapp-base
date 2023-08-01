// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract MemoApp {

    uint num = 0;

    struct Memo {
        uint taskid;
        string task;
        bool flag;
    }

    Memo[] public memoList;

    mapping (uint => address) public memoToOwner;
    mapping (address => uint) public ownerMemoCount;

    function createMemo(string memory _task) public {  
        memoList.push(Memo(num,_task,true));
        uint id = memoList.length - 1;
        memoToOwner[id] = msg.sender;
        ownerMemoCount[msg.sender]++;
        num++;
    }

    function getMemoListByOwner(address owner) external view returns(uint[] memory) {
        uint[] memory result = new uint[](ownerMemoCount[owner]);
        uint counter = 0;
        for (uint i = 0; i < memoList.length; i++) {
            if (memoToOwner[i] == owner){
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }
}
