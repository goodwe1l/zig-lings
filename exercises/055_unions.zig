//
// A union lets you store different types and sizes of data at
// 联合（union）允许你在同一个内存地址存储不同类型和大小的数据。
// the same memory address. How is this possible? The compiler
// 这是如何可能的？编译器为你可能想要存储的最大内容
// sets aside enough memory for the largest thing you might want
// 预留足够的内存。
// to store.
//
// In this example, an instance of Foo always takes up u64 of
// 在这个例子中，Foo的实例总是占用u64大小的
// space in memory even if you're currently storing a u8.
// 内存空间，即使你当前存储的是u8。
//
//     const Foo = union {
//         small: u8,
//         medium: u32,
//         large: u64,
//     };
//
// The syntax looks just like a struct, but a Foo can only hold a
// 语法看起来就像结构体，但是Foo只能持有一个
// small OR a medium OR a large value. Once a field becomes
// small或medium或large值。一旦一个字段变为
// active, the other inactive fields cannot be accessed. To
// 活跃状态，其他非活跃字段就不能被访问。要
// change active fields, assign a whole new instance:
// 改变活跃字段，需要赋值一个全新的实例：
//
//     var f = Foo{ .small = 5 };
//     f.small += 5;                  // OKAY
//     f.medium = 5432;               // ERROR!
//     f = Foo{ .medium = 5432 };     // OKAY
//
// Unions can save space in memory because they let you "re-use"
// 联合可以节省内存空间，因为它们让你"重用"
// a space in memory. They also provide a sort of primitive
// 内存中的空间。它们还提供了一种原始的
// polymorphism. Here fooBar() can take a Foo no matter what size
// 多态性。这里fooBar()可以接受Foo，无论它持有什么大小
// of unsigned integer it holds:
// 的无符号整数：
//
//     fn fooBar(f: Foo) void { ... }
//
// Oh, but how does fooBar() know which field is active? Zig has
// 哦，但是fooBar()如何知道哪个字段是活跃的？Zig有
// a neat way of keeping track, but for now, we'll just have to
// 一个巧妙的跟踪方式，但现在，我们只能
// do it manually.
// 手动处理。
//
// Let's see if we can get this program working!
// 让我们看看能否让这个程序工作！
//
const std = @import("std");

// We've just started writing a simple ecosystem simulation.
// 我们刚刚开始编写一个简单的生态系统模拟。
// Insects will be represented by either bees or ants. Bees store
// 昆虫将由蜜蜂或蚂蚁表示。蜜蜂存储
// the number of flowers they've visited that day and ants just
// 它们当天访问的花朵数量，而蚂蚁只是
// store whether or not they're still alive.
// 存储它们是否还活着。
const Insect = union {
    flowers_visited: u16,
    still_alive: bool,
};

// Since we need to specify the type of insect, we'll use an
// 因为我们需要指定昆虫的类型，我们将使用
// enum (remember those?).
// 枚举（还记得吗？）。
const AntOrBee = enum { a, b };

pub fn main() void {
    // We'll just make one bee and one ant to test them out:
    // 我们将只制作一只蜜蜂和一只蚂蚁来测试它们：
    const ant = Insect{ .still_alive = true };
    const bee = Insect{ .flowers_visited = 15 };

    std.debug.print("Insect report! ", .{});

    // Oops! We've made a mistake here.
    // 哎呀！我们在这里犯了一个错误。
    printInsect(ant, AntOrBee.c);
    printInsect(bee, AntOrBee.c);

    std.debug.print("\n", .{});
}

// Eccentric Doctor Zoraptera says that we can only use one
// 古怪的Zoraptera博士说我们只能使用一个
// function to print our insects. Doctor Z is small and sometimes
// 函数来打印我们的昆虫。Z博士很小，有时
// inscrutable but we do not question her.
// 令人费解，但我们不质疑她。
fn printInsect(insect: Insect, what_it_is: AntOrBee) void {
    switch (what_it_is) {
        .a => std.debug.print("Ant alive is: {}. ", .{insect.still_alive}),
        .b => std.debug.print("Bee visited {} flowers. ", .{insect.flowers_visited}),
    }
}
