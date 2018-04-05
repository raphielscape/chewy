#!/bin/bash
message="Semaphore CI build completed with the latest commit -"

curl -s -X POST https://api.telegram.org/bot$BOT_API_KEY/sendMessage -d text="$message $(git log --pretty=format:'%h : %s' -1)" -d chat_id=@raphiel_ci

#curl -s -X POST https://api.telegram.org/bot$BOT_API_KEY/sendMessage -d text="$(git log --pretty=format:'%h : %s' -1)" -d chat_id=$CHAT_ID

curl -F chat_id="-1001153251064" -F document=@"${ZIP_DIR}/$ZIPNAME" https://api.telegram.org/bot$BOT_API_KEY/sendDocument

#curl -s -X POST https://api.telegram.org/bot$BOT_API_KEY/sendMessage -d text="================================" -d chat_id=$CHAT_ID

rm -rf ${ZIP_DIR}/${ZIPNAME}
