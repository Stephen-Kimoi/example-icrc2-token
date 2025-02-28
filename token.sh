# #!/bin/bash

# # Step 1: Set up identities
# dfx identity new minter
# dfx identity use minter
# export MINTER=$(dfx identity get-principal)

# export TOKEN_NAME="DUST"
# export TOKEN_SYMBOL="DSTC"
# export TOKEN_IMAGE_URL="https://github.com/amschel99/DSTC/blob/master/src/DSTC_frontend/public/logo.jpeg"  # Replace with actual image URL

# dfx identity use default
# export DEFAULT=$(dfx identity get-principal)

# export PRE_MINTED_TOKENS=1_000_000_000_000  # Set pre-minted token amount
# export TRANSFER_FEE=1_000  # Set transfer fee

# dfx identity new archive_controller
# dfx identity use archive_controller
# export ARCHIVE_CONTROLLER=$(dfx identity get-principal)
# export TRIGGER_THRESHOLD=10000
# export NUM_OF_BLOCK_TO_ARCHIVE=5000
# export CYCLE_FOR_ARCHIVE_CREATION=1000000000000

# export FEATURE_FLAGS=true  # Enable feature flags


# # Step 2: Deploy the canister with automated arguments
# dfx deploy icrc1_ledger_canister --network ic  --argument "(variant { Init = record {
#      token_symbol = \"${TOKEN_SYMBOL}\";
#      token_name = \"${TOKEN_NAME}\";
#      minting_account = record { owner = principal \"${MINTER}\" };
#      transfer_fee = ${TRANSFER_FEE};
#      metadata = vec {
#          record { key = \"description\"; value = \"This is the DUST token.\" };
#          record { key = \"image\"; value = \"${TOKEN_IMAGE_URL}\" }
#      };
#      feature_flags = opt record { icrc2 = ${FEATURE_FLAGS} };
#      initial_balances = vec { record { record { owner = principal \"${DEFAULT}\" }; ${PRE_MINTED_TOKENS} } };
#      archive_options = record {
#          num_blocks_to_archive = ${NUM_OF_BLOCK_TO_ARCHIVE};
#          trigger_threshold = ${TRIGGER_THRESHOLD};
#          controller_id = principal \"${ARCHIVE_CONTROLLER}\";
#          cycles_for_archive_creation = opt ${CYCLE_FOR_ARCHIVE_CREATION};
#      };
#  }})"

# # Step 3: Verify deployment (optional)
# # You can add verification commands here if necessary

# echo "Deployment to mainnet complete."
#!/bin/bash

 
dfx identity use livr
export MINTER=$(dfx identity get-principal)  

export TOKEN_NAME=""  # Change the token name here 
export TOKEN_SYMBOL=""  # Change token symbol here 
export TOKEN_IMAGE_URL="" 
dfx identity use default  
export DEFAULT=$(dfx identity get-principal)  

export PRE_MINTED_TOKENS=50_000_000_000_000_000  # 5 million tokens in e8s
export TRANSFER_FEE=10_000  # Same as that for the ICP token

dfx identity new archive_controller  
dfx identity use archive_controller  
export ARCHIVE_CONTROLLER=$(dfx identity get-principal)  
export TRIGGER_THRESHOLD=10000  
export NUM_OF_BLOCK_TO_ARCHIVE=5000  
export CYCLE_FOR_ARCHIVE_CREATION=1000000000000

export FEATURE_FLAGS=true # Set the feature flags to true
## remeber to remove --mode reinstall when deploying to mainnet

dfx deploy icrc1_ledger_canister --network ic  --argument "(variant {Init =
record {
     token_symbol = \"${TOKEN_SYMBOL}\";
     token_name = \"${TOKEN_NAME}\";
     minting_account = record { owner = principal \"${MINTER}\" };
     transfer_fee = ${TRANSFER_FEE};
      metadata = vec {};
     feature_flags = opt record{icrc2 = ${FEATURE_FLAGS}};
     initial_balances = vec { record { record { owner = principal \"${MINTER}\"; }; ${PRE_MINTED_TOKENS}; }; };
     archive_options = record {
         num_blocks_to_archive = ${NUM_OF_BLOCK_TO_ARCHIVE};
         trigger_threshold = ${TRIGGER_THRESHOLD};
         controller_id = principal \"${ARCHIVE_CONTROLLER}\";
         cycles_for_archive_creation = opt ${CYCLE_FOR_ARCHIVE_CREATION};
     };
 }
})"

# ./did.sh && dfx generate test_token_1_backend && dfx deploy test_token_1_backend  # Command for deploying canister one locally