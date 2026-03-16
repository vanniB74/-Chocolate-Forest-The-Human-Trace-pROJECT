// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HumanTraceFairy {
    address payable public momWallet;
    uint256 public fairyPremiumPercent = 30; // 30%
    
    event PaymentSent(address indexed to, uint256 amount);
    
    constructor(address payable _momWallet) {
        momWallet = _momWallet;
    }
    
    // Function to calculate Fairy Premium
    function calculateFairyPremium(uint256 beanValue) public view returns (uint256) {
        return (beanValue * fairyPremiumPercent) / 100;
    }
    
    // Function to make payment directly to mom's wallet
    function payMom(uint256 beanValue) public payable {
        require(msg.value == beanValue, "Incorrect payment amount.");
        
        uint256 fairyPremium = calculateFairyPremium(beanValue);
        payable(momWallet).transfer(fairyPremium);
        
        emit PaymentSent(momWallet, fairyPremium);
    }
    
    // Traceability function (QR linked to transaction hash or further data)
    function traceTransaction(uint256 transactionId) public view returns (bytes32) {
        return keccak256(abi.encodePacked(transactionId));
    }

    // Fallback function to accept ETH
    receive() external payable {}
}