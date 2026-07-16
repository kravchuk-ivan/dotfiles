// scrollslow — slow scrolling by scaling scroll-wheel event deltas.
//
// The macOS HID scroll-acceleration curve only affects some devices: the
// trackpad honours it, but hi-res mice (e.g. Logitech MX) emit their own
// pixel-scroll that ignores it. The reliable, device-agnostic way to slow
// scrolling is to intercept the events themselves. This installs a CGEventTap
// on scroll-wheel events and multiplies every delta field by a fixed factor
// (0 <= f <= 1), so scroll slows uniformly for trackpad and mouse alike.
//
// It runs until killed: the mouse-speed toggle starts it for demo mode and
// kills it to restore full speed, so nothing runs during normal use.
//
// Event taps are gated, so this needs Accessibility permission. On first run
// macOS adds the binary to System Settings > Privacy & Security > Accessibility
// (toggle it on); until it is granted, CGEventTapCreate returns NULL and the
// process exits non-zero.
//
// Build:
//   clang -framework ApplicationServices -framework CoreFoundation \
//         -o scrollslow scrollslow.c
//
// Usage:
//   scrollslow <factor>    e.g. scrollslow 0.3  (0 = frozen, 1 = unchanged)

#include <ApplicationServices/ApplicationServices.h>
#include <stdio.h>
#include <stdlib.h>

static double g_factor = 1.0;
static CFMachPortRef g_tap;

// Integer delta fields round toward zero when scaled by a factor < 1, which
// would drop small scrolls to 0 and freeze scrolling. Carry the remainder
// across events per axis so slow scrolling still advances.
static double g_acc_line1, g_acc_line2, g_acc_pt1, g_acc_pt2;

static int64_t scale_int(int64_t v, double *acc) {
    double scaled = v * g_factor + *acc;
    int64_t out = (int64_t)scaled;  // truncates toward zero
    *acc = scaled - out;            // keep the fraction for next time
    return out;
}

static CGEventRef on_event(CGEventTapProxy proxy, CGEventType type, CGEventRef ev, void *ctx) {
    if (type == kCGEventScrollWheel) {
        // Continuous (pixel) deltas — the path trackpads and hi-res mice use.
        double f1 = CGEventGetDoubleValueField(ev, kCGScrollWheelEventFixedPtDeltaAxis1);
        double f2 = CGEventGetDoubleValueField(ev, kCGScrollWheelEventFixedPtDeltaAxis2);
        CGEventSetDoubleValueField(ev, kCGScrollWheelEventFixedPtDeltaAxis1, f1 * g_factor);
        CGEventSetDoubleValueField(ev, kCGScrollWheelEventFixedPtDeltaAxis2, f2 * g_factor);

        int64_t p1 = CGEventGetIntegerValueField(ev, kCGScrollWheelEventPointDeltaAxis1);
        int64_t p2 = CGEventGetIntegerValueField(ev, kCGScrollWheelEventPointDeltaAxis2);
        CGEventSetIntegerValueField(ev, kCGScrollWheelEventPointDeltaAxis1, scale_int(p1, &g_acc_pt1));
        CGEventSetIntegerValueField(ev, kCGScrollWheelEventPointDeltaAxis2, scale_int(p2, &g_acc_pt2));

        // Line deltas — classic notched wheels.
        int64_t l1 = CGEventGetIntegerValueField(ev, kCGScrollWheelEventDeltaAxis1);
        int64_t l2 = CGEventGetIntegerValueField(ev, kCGScrollWheelEventDeltaAxis2);
        CGEventSetIntegerValueField(ev, kCGScrollWheelEventDeltaAxis1, scale_int(l1, &g_acc_line1));
        CGEventSetIntegerValueField(ev, kCGScrollWheelEventDeltaAxis2, scale_int(l2, &g_acc_line2));
    } else if (type == kCGEventTapDisabledByTimeout || type == kCGEventTapDisabledByUserInput) {
        // macOS disables a tap that stalls (or on some input); just re-arm it.
        CGEventTapEnable(g_tap, true);
    }
    return ev;
}

int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "usage: scrollslow <factor>\n");
        return 2;
    }
    g_factor = atof(argv[1]);
    if (g_factor < 0) g_factor = 0;

    g_tap = CGEventTapCreate(kCGHIDEventTap, kCGHeadInsertEventTap, kCGEventTapOptionDefault,
                             CGEventMaskBit(kCGEventScrollWheel), on_event, NULL);
    if (!g_tap) {
        fprintf(stderr, "scrollslow: could not create event tap "
                        "(grant Accessibility permission in System Settings)\n");
        return 1;
    }

    CFRunLoopSourceRef src = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, g_tap, 0);
    CFRunLoopAddSource(CFRunLoopGetCurrent(), src, kCFRunLoopCommonModes);
    CGEventTapEnable(g_tap, true);
    CFRunLoopRun();

    CFRelease(src);
    CFRelease(g_tap);
    return 0;
}
