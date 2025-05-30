

 #!/bin/bash

# Bash script to transfer a file from source VM to target VMs

# Input parameters
SOURCE_USER="cdudi"
SOURCE_HOST="10.128.0.29"
DESTINATION_USER="cdudi"
DESTINATION_HOSTS="10.128.0.24,10.128.0.28"  # Comma-separated IPs
CSV_FILE_PATH="/home/cdudi/sfile.csv"
TARGET_PATH="/home/cdudi/"

# Convert comma-separated list to array
IFS=',' read -r -a HOST_ARRAY <<< "$DESTINATION_HOSTS"

# Loop over each host and perform transfer
for HOST_IP in "${HOST_ARRAY[@]}"; do
    echo "➡️  Starting transfer from $SOURCE_HOST to $HOST_IP..."

    # Prepare scp command
    SCP_COMMAND="scp -o StrictHostKeyChecking=no $CSV_FILE_PATH ${DESTINATION_USER}@${HOST_IP}:${TARGET_PATH}"
    
    # Run command on the source host via SSH
    SSH_COMMAND="ssh -o StrictHostKeyChecking=no ${SOURCE_USER}@${SOURCE_HOST} \"$SCP_COMMAND\""

    echo "Executing: $SSH_COMMAND"

    if eval "$SSH_COMMAND"; then
        echo "✅ Transfer to $HOST_IP completed."
    else
        echo "❌ Error occurred while transferring to $HOST_IP"
    fi
done