//
// Now that we have optional types, we can apply them to structs.
// 现在我们有了可选类型，我们可以将它们应用到结构体中。
// The last time we checked in with our elephants, we had to link
// 上次我们检查大象时，我们必须将
// all three of them together in a "circle" so that the last tail
// 三只大象连接成一个"圆圈"，这样最后的尾巴
// linked to the first elephant. This is because we had NO CONCEPT
// 连接到第一只大象。这是因为我们没有
// of a tail that didn't point to another elephant!
// 不指向另一只大象的尾巴的概念！
//
// We also introduce the handy `.?` shortcut:
// 我们还介绍了方便的`.?`快捷方式：
//
//     const foo = bar.?;
//
// is the same as
// 等同于
//
//     const foo = bar orelse unreachable;
//
// Check out where we use this shortcut below to change control flow
// 看看我们在下面使用这个快捷方式来改变控制流，
// based on if an optional value exists.
// 基于可选值是否存在。
//
// Now let's make those elephant tails optional!
// 现在让我们让这些大象尾巴变成可选的！
//
const std = @import("std");

const Elephant = struct {
    letter: u8,
    tail: *Elephant = null, // Hmm... tail needs something...
    tail: *Elephant = null, // 嗯...尾巴需要一些东西...
    visited: bool = false,
};

pub fn main() void {
    var elephantA = Elephant{ .letter = 'A' };
    var elephantB = Elephant{ .letter = 'B' };
    var elephantC = Elephant{ .letter = 'C' };

    // Link the elephants so that each tail "points" to the next.
    // 连接大象，使每个尾巴"指向"下一个。
    linkElephants(&elephantA, &elephantB);
    linkElephants(&elephantB, &elephantC);

    // `linkElephants` will stop the program if you try and link an
    // `linkElephants`如果你尝试连接一个
    // elephant that doesn't exist! Uncomment and see what happens.
    // 不存在的大象会停止程序！取消注释看看会发生什么。
    // const missingElephant: ?*Elephant = null;
    // linkElephants(&elephantC, missingElephant);

    visitElephants(&elephantA);

    std.debug.print("\n", .{});
}

// If e1 and e2 are valid pointers to elephants,
// 如果e1和e2是指向大象的有效指针，
// this function links the elephants so that e1's tail "points" to e2.
// 这个函数连接大象，使e1的尾巴"指向"e2。
fn linkElephants(e1: ?*Elephant, e2: ?*Elephant) void {
    e1.?.tail = e2.?;
}

// This function visits all elephants once, starting with the
// 这个函数访问所有大象一次，从
// first elephant and following the tails to the next elephant.
// 第一只大象开始，沿着尾巴到下一只大象。
fn visitElephants(first_elephant: *Elephant) void {
    var e = first_elephant;

    while (!e.visited) {
        std.debug.print("Elephant {u}. ", .{e.letter});
        e.visited = true;

        // We should stop once we encounter a tail that
        // 一旦我们遇到一个不指向另一个元素的
        // does NOT point to another element. What can
        // 尾巴就应该停止。我们可以在这里放什么
        // we put here to make that happen?
        // 来实现这一点？

        // HINT: We want something similar to what `.?` does,
        // 提示：我们想要类似于`.?`所做的事情，
        // but instead of ending the program, we want to exit the loop...
        // 但不是结束程序，我们想要退出循环...
        e = e.tail ???
    }
}
