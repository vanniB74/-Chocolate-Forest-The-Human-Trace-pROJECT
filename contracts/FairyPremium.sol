// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FairyPremiumDistributor {
    address public owner;
    
    // 30% goes to the Mom, 70% to the production cost
    uint256 public constant FAIRY_PREMIUM_PERCENT = 30;

    event PaymentSent(address indexed momWallet, uint256 amount, string traceId);

    constructor() {
        owner = msg.sender;
    }

    function processSale(address payable _momWallet, string memory _traceId) public payable {
        uint256 momAmount = (msg.value * FAIRY_PREMIUM_PERCENT) / 100;
        
        // Execute the direct payment to the Mom's wallet
        _momWallet.transfer(momAmount);
        
        emit PaymentSent(_momWallet, momAmount, _traceId);
    }
}
