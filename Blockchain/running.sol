pragma solidity >=0.7.0 <0.9.0;

contract Running {

    mapping(address => bool) public allowedList;
    uint256 public currentNumber;
    string private flag;
    string private magicPhrase;

    modifier onlyAllowed () {
        require (allowedList[msg.sender]);
        _;
    }
    
    constructor() {
        currentNumber = 42;
        magicPhrase = "Give flag to me please.";

        flag = "secret"; // This is a temp data, the flag on the actual deployed contract was a different value.
    }

    function answer(uint256 number, string memory phrase) public {
        if (number == currentNumber + 9 && keccak256(bytes(phrase)) == keccak256(bytes(magicPhrase))) {
            if (!allowedList[msg.sender]) {
                currentNumber = number;
                allowedList[msg.sender] = true;
            }
            else revert("You are already allowed.");
        }
        else revert("Invalid Answer.");
    }

    function getFlag() public view onlyAllowed returns (string memory) {
        return flag;
    }
}
