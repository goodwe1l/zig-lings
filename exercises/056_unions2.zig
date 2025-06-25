//
// It is really quite inconvenient having to manually keep track
// 必须手动跟踪联合中的活跃字段
// of the active field in our union, isn't it?
// 真的很不方便，不是吗？
//
// Thankfully, Zig also has "tagged unions", which allow us to
// 幸好，Zig还有"标记联合"，它允许我们
// store an enum value within our union representing which field
// 在联合中存储一个枚举值，代表哪个字段
// is active.
// 是活跃的。
//
//     const FooTag = enum{ small, medium, large };
//
//     const Foo = union(FooTag) {
//         small: u8,
//         medium: u32,
//         large: u64,
//     };
//
// Now we can use a switch directly on the union to act on the
// 现在我们可以直接对联合使用switch来操作
// active field:
// 活跃字段：
//
//     var f = Foo{ .small = 10 };
//
//     switch (f) {
//         .small => |my_small| do_something(my_small),
//         .medium => |my_medium| do_something(my_medium),
//         .large => |my_large| do_something(my_large),
//     }
//
// Let's make our Insects use a tagged union (Doctor Zoraptera
// 让我们让昆虫使用标记联合（Zoraptera博士
// approves).
// 同意）。
//
const std = @import("std");

const InsectStat = enum { flowers_visited, still_alive };

const Insect = union(InsectStat) {
    flowers_visited: u16,
    still_alive: bool,
};

pub fn main() void {
    const ant = Insect{ .still_alive = true };
    const bee = Insect{ .flowers_visited = 16 };

    std.debug.print("Insect report! ", .{});

    // Could it really be as simple as just passing the union?
    // 真的可以简单到只需传递联合吗？
    printInsect(???);
    printInsect(???);

    std.debug.print("\n", .{});
}

fn printInsect(insect: Insect) void {
    switch (???) {
        .still_alive => |a| std.debug.print("Ant alive is: {}. ", .{a}),
        .flowers_visited => |f| std.debug.print("Bee visited {} flowers. ", .{f}),
    }
}

// By the way, did unions remind you of optional values and errors?
// 顺便说一下，联合让你想起了可选值和错误吗？
// Optional values are basically "null unions" and errors use "error
// 可选值基本上是"null联合"，错误使用"错误
// union types". Now we can add our own unions to the mix to handle
// 联合类型"。现在我们可以将自己的联合添加到混合中来处理
// whatever situations we might encounter:
// 我们可能遇到的任何情况：
//          union(Tag) { value: u32, toxic_ooze: void }
