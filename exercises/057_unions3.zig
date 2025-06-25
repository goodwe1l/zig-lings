//
// With tagged unions, it gets EVEN BETTER! If you don't have a
// 有了标记联合，情况变得更好！如果你不需要
// need for a separate enum, you can define an inferred enum with
// 单独的枚举，你可以在一个地方用你的联合
// your union all in one place. Just use the 'enum' keyword in
// 定义一个推断的枚举。只需在标记类型位置
// place of the tag type:
// 使用'enum'关键字：
//
//     const Foo = union(enum) {
//         small: u8,
//         medium: u32,
//         large: u64,
//     };
//
// Let's convert Insect. Doctor Zoraptera has already deleted the
// 让我们转换Insect。Zoraptera博士已经为你删除了
// explicit InsectStat enum for you!
// 显式的InsectStat枚举！
//
const std = @import("std");

const Insect = union(InsectStat) {
    flowers_visited: u16,
    still_alive: bool,
};

pub fn main() void {
    const ant = Insect{ .still_alive = true };
    const bee = Insect{ .flowers_visited = 17 };

    std.debug.print("Insect report! ", .{});

    printInsect(ant);
    printInsect(bee);

    std.debug.print("\n", .{});
}

fn printInsect(insect: Insect) void {
    switch (insect) {
        .still_alive => |a| std.debug.print("Ant alive is: {}. ", .{a}),
        .flowers_visited => |f| std.debug.print("Bee visited {} flowers. ", .{f}),
    }
}

// Inferred enums are neat, representing the tip of the iceberg
// 推断枚举很巧妙，代表了枚举和联合关系中的
// in the relationship between enums and unions. You can actually
// 冰山一角。实际上你可以将联合强制转换为枚举
// coerce a union TO an enum (which gives you the active field
// （这给你联合中的活跃字段作为枚举）。
// from the union as an enum). What's even wilder is that you can
// 更疯狂的是你可以将枚举强制转换为联合！
// coerce an enum to a union! But don't get too excited, that
// 但别太兴奋，这只在联合类型是那些奇怪的零位
// only works when the union type is one of those weird zero-bit
// 类型如void时才有效！
// types like void!
//
// Tagged unions, as with most ideas in computer science, have a
// 标记联合，就像计算机科学中的大多数想法一样，有着
// long history going back to the 1960s. However, they're only
// 可以追溯到1960年代的悠久历史。然而，它们只是
// recently becoming mainstream, particularly in system-level
// 最近才成为主流，特别是在系统级
// programming languages. You might have also seen them called
// 编程语言中。你可能也见过它们被称为
// "variants", "sum types", or even "enums"!
// "变体"、"和类型"或甚至"枚举"！
