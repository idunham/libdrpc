/* Copyright (c) 2009-2011, Code Aurora Forum. 
 * Split off from clnt.c 2012, Isaac Dunham. 
 * No change in copyright status claimed. */


#include <hardware_legacy/power.h>
#define ANDROID_WAKE_LOCK_NAME "rpc-interface"

void
grabPartialWakeLock() {
    acquire_wake_lock(PARTIAL_WAKE_LOCK, ANDROID_WAKE_LOCK_NAME);
}

void
releaseWakeLock() {
    release_wake_lock(ANDROID_WAKE_LOCK_NAME);
}
