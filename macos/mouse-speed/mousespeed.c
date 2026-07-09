// mousespeed — read/set the live macOS mouse tracking speed.
//
// macOS applies `com.apple.mouse.scaling` (the System Settings "Tracking speed"
// slider) only at login, so a plain `defaults write` does NOT change the pointer
// mid-session. The System Settings slider itself changes it live via the IOKit
// HID param connection — this helper does the same, so a toggle takes effect
// instantly with no re-login and no root.
//
// Build:
//   clang -Wno-deprecated-declarations -framework IOKit -framework CoreFoundation \
//         -o mousespeed mousespeed.c
//
// Usage:
//   mousespeed get          -> prints current acceleration (e.g. 3.0000)
//   mousespeed set <value>  -> sets it live (UI range is 0.0 .. 3.0)

#include <IOKit/IOKitLib.h>
#include <IOKit/hidsystem/IOHIDLib.h>
#include <IOKit/hidsystem/IOHIDParameter.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static io_connect_t open_hid(void) {
    io_service_t service =
        IOServiceGetMatchingService(kIOMainPortDefault, IOServiceMatching("IOHIDSystem"));
    if (!service) {
        fprintf(stderr, "mousespeed: IOHIDSystem not found\n");
        exit(1);
    }
    io_connect_t handle = 0;
    kern_return_t kr = IOServiceOpen(service, mach_task_self(), kIOHIDParamConnectType, &handle);
    IOObjectRelease(service);
    if (kr != KERN_SUCCESS) {
        fprintf(stderr, "mousespeed: IOServiceOpen failed (0x%x)\n", kr);
        exit(1);
    }
    return handle;
}

int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "usage: mousespeed get | set <value>\n");
        return 2;
    }

    io_connect_t handle = open_hid();
    int rc = 0;

    if (strcmp(argv[1], "get") == 0) {
        double accel = -1;
        if (IOHIDGetMouseAcceleration(handle, &accel) != KERN_SUCCESS) {
            fprintf(stderr, "mousespeed: read failed\n");
            rc = 1;
        } else {
            printf("%.4f\n", accel);
        }
    } else if (strcmp(argv[1], "set") == 0 && argc >= 3) {
        double value = atof(argv[2]);
        if (IOHIDSetMouseAcceleration(handle, value) != KERN_SUCCESS) {
            fprintf(stderr, "mousespeed: write failed\n");
            rc = 1;
        }
    } else {
        fprintf(stderr, "usage: mousespeed get | set <value>\n");
        rc = 2;
    }

    IOServiceClose(handle);
    return rc;
}
