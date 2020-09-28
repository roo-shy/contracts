// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;
pragma experimental ABIEncoderV2;

/* Library Imports */
import { Lib_OVMCodec } from "../../libraries/codec/Lib_OVMCodec.sol";

/**
 * @title iOVM_StateManager
 */
interface iOVM_StateManager {

    /*******************
     * Data Structures *
     *******************/

    enum ItemState {
        ITEM_UNTOUCHED,
        ITEM_LOADED,
        ITEM_CHANGED,
        ITEM_COMMITTED
    }


    /***************************
     * Public Functions: Setup *
     ***************************/
    
    function setExecutionManager(address _ovmExecutionManager) external;


    /************************************
     * Public Functions: Account Access *
     ************************************/

    function putAccount(address _address, Lib_OVMCodec.Account memory _account) external;
    function getAccount(address _address) external view returns (Lib_OVMCodec.Account memory _account);
    function hasAccount(address _address) external view returns (bool _exists);
    function hasEmptyAccount(address _address) external view returns (bool _exists);
    function setAccountNonce(address _address, uint256 _nonce) external;
    function getAccountNonce(address _address) external view returns (uint256 _nonce);
    function getAccountEthAddress(address _address) external view returns (address _ethAddress);
    function initPendingAccount(address _address) external;
    function commitPendingAccount(address _address, address _ethAddress, bytes32 _codeHash) external;
    function testAndSetAccountLoaded(address _address) external returns (bool _wasAccountAlreadyLoaded);
    function testAndSetAccountChanged(address _address) external returns (bool _wasAccountAlreadyChanged);
    function commitAccount(address _address) external returns (bool _wasAccountCommitted);
    function incrementTotalUncommittedAccounts() external;
    function getTotalUncommittedAccounts() external view returns (uint256 _total);

    
    /************************************
     * Public Functions: Storage Access *
     ************************************/

    function putContractStorage(address _contract, bytes32 _key, bytes32 _value) external;
    function getContractStorage(address _contract, bytes32 _key) external view returns (bytes32 _value);
    function hasContractStorage(address _contract, bytes32 _key) external returns (bool _exists);
    function testAndSetContractStorageLoaded(address _contract, bytes32 _key) external returns (bool _wasContractStorageAlreadyLoaded);
    function testAndSetContractStorageChanged(address _contract, bytes32 _key) external returns (bool _wasContractStorageAlreadyChanged);
    function commitContractStorage(address _contract, bytes32 _key) external returns (bool _wasContractStorageCommitted);
    function incrementTotalUncommittedContractStorage() external;
    function getTotalUncommittedContractStorage() external view returns (uint256 _total);
}