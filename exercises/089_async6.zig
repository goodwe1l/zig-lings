//
// The power and purpose of async/await becomes more apparent
// when we do multiple things concurrently. Foo and Bar do not
// depend on each other and can happen at the same time, but End
// requires that they both be finished.
// 当我们同时做多件事时，async/await 的力量和目的变得更加明显。
// Foo 和 Bar 不相互依赖，可以同时发生，但 End 要求它们都完成。
//
//               +---------+
//               |  Start  |
//               +---------+
//                  /    \
//                 /      \
//        +---------+    +---------+
//        |   Foo   |    |   Bar   |
//        +---------+    +---------+
//                 \      /
//                  \    /
//               +---------+
//               |   End   |
//               +---------+
//
// We can express this in Zig like so:
// 我们可以在 Zig 中这样表达：
//
//     fn foo() u32 { ... }
//     fn bar() u32 { ... }
//
//     // Start
//
//     var foo_frame = async foo();
//     var bar_frame = async bar();
//
//     var foo_value = await foo_frame;
//     var bar_value = await bar_frame;
//
//     // End
//
// Please await TWO page titles!
// 请等待两个页面标题！
//
const print = @import("std").debug.print;

pub fn main() void {
    var com_frame = async getPageTitle("http://example.com");
    var org_frame = async getPageTitle("http://example.org");

    var com_title = com_frame;
    var org_title = org_frame;

    print(".com: {s}, .org: {s}.\n", .{ com_title, org_title });
}

fn getPageTitle(url: []const u8) []const u8 {
    // Please PRETEND this is actually making a network request.
    // 请假设这实际上正在发出网络请求。
    _ = url;
    return "Example Title";
}
