// mousespeed — read/set the live macOS pointer tracking speed.
//
// macOS applies `com.apple.mouse.scaling` / `com.apple.trackpad.scaling` (the
// System Settings "Tracking speed" sliders) only at login, so a plain
// `defaults write` does NOT move the pointer mid-session. This helper writes the
// live acceleration curves directly in IOHIDSystem's HIDParameters via
// IOHIDSetParameter — the same store the driver reads — so a toggle takes effect
// instantly with no re-login and no root.
//
// It sets the trackpad, mouse, and generic pointer curves together so the change
// applies whether you're on a laptop trackpad or an external mouse. Values are
// stored as fixed-point (value * 65536).
//
// Build:
//   clang -Wno-deprecated-declarations -framework IOKit -framework CoreFoundation \
//         -o mousespeed mousespeed.c
//
// Usage:
//   mousespeed get          -> prints current acceleration (e.g. 3.0000)
//   mousespeed set <value>  -> sets it live (UI range is 0.0 .. 3.0)

#include <CoreFoundation/CoreFoundation.h>
#include <IOKit/IOKitLib.h>
#include <IOKit/hidsystem/IOHIDLib.h>
#include <IOKit/hidsystem/IOHIDParameter.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static const char *ACCEL_KEYS[] = {
    "HIDTrackpadAcceleration",
    "HIDMouseAcceleration",
    "HIDPointerAcceleration",
};
static const int ACCEL_KEY_COUNT = 3;

static io_service_t g_service;
static io_connect_t g_handle;

static CFStringRef cfstr(const char *s) {
    return CFStringCreateWithCString(NULL, s, kCFStringEncodingUTF8);
}

static void open_hid(void) {
    g_service = IOServiceGetMatchingService(kIOMainPortDefault, IOServiceMatching("IOHIDSystem"));
    if (!g_service) {
        fprintf(stderr, "mousespeed: IOHIDSystem not found\n");
        exit(1);
    }
    kern_return_t kr = IOServiceOpen(g_service, mach_task_self(), kIOHIDParamConnectType, &g_handle);
    if (kr != KERN_SUCCESS) {
        fprintf(stderr, "mousespeed: IOServiceOpen failed (0x%x)\n", kr);
        exit(1);
    }
}

// Read the current pointer acceleration from the live driver parameters.
static double get_accel(void) {
    CFMutableDictionaryRef props = NULL;
    if (IORegistryEntryCreateCFProperties(g_service, &props, kCFAllocatorDefault, 0) != KERN_SUCCESS || !props)
        return -1;
    double out = -1;
    CFDictionaryRef params = CFDictionaryGetValue(props, CFSTR("HIDParameters"));
    if (params) {
        CFStringRef key = cfstr("HIDPointerAcceleration");
        CFNumberRef num = CFDictionaryGetValue(params, key);
        if (num) {
            SInt32 fixed;
            CFNumberGetValue(num, kCFNumberSInt32Type, &fixed);
            out = fixed / 65536.0;
        }
        CFRelease(key);
    }
    CFRelease(props);
    return out;
}

static int set_accel(double value) {
    SInt32 fixed = (SInt32)(value * 65536.0);
    int rc = 0;
    for (int i = 0; i < ACCEL_KEY_COUNT; i++) {
        CFStringRef key = cfstr(ACCEL_KEYS[i]);
        kern_return_t kr = IOHIDSetParameter(g_handle, key, &fixed, sizeof(fixed));
        CFRelease(key);
        if (kr != KERN_SUCCESS) {
            fprintf(stderr, "mousespeed: set %s failed (0x%x)\n", ACCEL_KEYS[i], kr);
            rc = 1;
        }
    }
    return rc;
}

int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "usage: mousespeed get | set <value>\n");
        return 2;
    }

    open_hid();
    int rc = 0;

    if (strcmp(argv[1], "get") == 0) {
        double accel = get_accel();
        if (accel < 0) {
            fprintf(stderr, "mousespeed: read failed\n");
            rc = 1;
        } else {
            printf("%.4f\n", accel);
        }
    } else if (strcmp(argv[1], "set") == 0 && argc >= 3) {
        rc = set_accel(atof(argv[2]));
    } else {
        fprintf(stderr, "usage: mousespeed get | set <value>\n");
        rc = 2;
    }

    IOServiceClose(g_handle);
    return rc;
}
