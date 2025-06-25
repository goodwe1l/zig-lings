//
// We've seen that passing arrays around can be awkward. Perhaps you
// 我们已经看到传递数组可能很麻烦。也许你
// remember a particularly horrendous function definition from quiz3?
// 还记得quiz3中一个特别可怕的函数定义？
// This function can only take arrays that are exactly 4 items long!
// 这个函数只能接受正好4个项目长的数组！
//
//     fn printPowersOfTwo(numbers: [4]u16) void { ... }
//
// That's the trouble with arrays - their size is part of the data
// 这就是数组的问题——它们的大小是数据类型的一部分，
// type and must be hard-coded into every usage of that type. This
// 必须硬编码到该类型的每次使用中。这个
// digits array is a [10]u8 forever and ever:
// digits数组永远都是[10]u8：
//
//     var digits = [10]u8{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
//
// Thankfully, Zig has slices, which let you dynamically point to a
// 幸运的是，Zig有切片，它让你动态地指向
// start item and provide a length. Here are slices of our digit
// 起始项目并提供长度。这里是我们digit数组的切片：
// array:
// 起始项目并提供长度。这里是我们digit数组的切片：
//
//     const foo = digits[0..1];  // 0
//     const bar = digits[3..9];  // 3 4 5 6 7 8
//     const baz = digits[5..9];  // 5 6 7 8
//     const all = digits[0..];   // 0 1 2 3 4 5 6 7 8 9
//
// As you can see, a slice [x..y] starts with the index of the
// 如你所见，切片[x..y]从索引x的
// first item at x and the last item at y-1. You can leave the y
// 第一个项目开始，到y-1的最后一个项目。你可以省略y
// off to get "the rest of the items".
// 来获取"其余的项目"。
//
// The type of a slice on an array of u8 items is []u8.
// u8项目数组的切片类型是[]u8。
//
const std = @import("std");

pub fn main() void {
    var cards = [8]u8{ 'A', '4', 'K', '8', '5', '2', 'Q', 'J' };

    // Please put the first 4 cards in hand1 and the rest in hand2.
    // 请将前4张牌放入hand1，其余的放入hand2。
    const hand1: []u8 = cards[???];
    const hand2: []u8 = cards[???];

    std.debug.print("Hand1: ", .{});
    printHand(hand1);

    std.debug.print("Hand2: ", .{});
    printHand(hand2);
}

// Please lend this function a hand. A u8 slice hand, that is.
// 请帮助这个函数。具体来说是一个u8切片hand。
fn printHand(hand: ???) void {
    for (hand) |h| {
        std.debug.print("{u} ", .{h});
    }
    std.debug.print("\n", .{});
}
//
// Fun fact: Under the hood, slices are stored as a pointer to
// 有趣的事实：在底层，切片被存储为指向
// the first item and a length.
// 第一个项目的指针和一个长度。
