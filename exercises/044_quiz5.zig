//
//    "Elephants walking
//     "大象行走
//     Along the trails
//     沿着小径
//
//     Are holding hands
//     正手牵着手
//     By holding tails."
//     通过拉着尾巴。"
//
//     from Holding Hands
//     来自《手牵手》
//       by Lenore M. Link
//       作者：Lenore M. Link
//
const std = @import("std");

const Elephant = struct {
    letter: u8,
    tail: *Elephant = undefined,
    visited: bool = false,
};

pub fn main() void {
    var elephantA = Elephant{ .letter = 'A' };
    // (Please add Elephant B here!)
    // (请在这里添加大象B！)
    var elephantC = Elephant{ .letter = 'C' };

    // Link the elephants so that each tail "points" to the next elephant.
    // 连接大象，使每个尾巴"指向"下一个大象。
    // They make a circle: A->B->C->A...
    // 它们形成一个圆圈：A->B->C->A...
    elephantA.tail = &elephantB;
    // (Please link Elephant B's tail to Elephant C here!)
    // (请在这里将大象B的尾巴连接到大象C！)
    elephantC.tail = &elephantA;

    visitElephants(&elephantA);

    std.debug.print("\n", .{});
}

// This function visits all elephants once, starting with the
// 这个函数访问所有大象一次，从
// first elephant and following the tails to the next elephant.
// 第一只大象开始，沿着尾巴到下一只大象。
// If we did not "mark" the elephants as visited (by setting
// 如果我们没有"标记"大象为已访问（通过设置
// visited=true), then this would loop infinitely!
// visited=true），那么这将无限循环！
fn visitElephants(first_elephant: *Elephant) void {
    var e = first_elephant;

    while (!e.visited) {
        std.debug.print("Elephant {u}. ", .{e.letter});
        e.visited = true;
        e = e.tail;
    }
}
