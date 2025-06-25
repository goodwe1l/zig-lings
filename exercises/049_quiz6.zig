//
//    "Trunks and tails
//     "象鼻和尾巴
//     Are handy things"
//     是方便的东西"

//     from Holding Hands
//     来自《手牵手》
//       by Lenore M. Link
//       作者：Lenore M. Link
//
// Now that we have tails all figured out, can you implement trunks?
// 现在我们把尾巴都搞清楚了，你能实现象鼻吗？
//
const std = @import("std");

const Elephant = struct {
    letter: u8,
    tail: ?*Elephant = null,
    trunk: ?*Elephant = null,
    visited: bool = false,

    // Elephant tail methods!
    // 大象尾巴方法！
    pub fn getTail(self: *Elephant) *Elephant {
        return self.tail.?; // Remember, this means "orelse unreachable"
                            // 记住，这意味着"orelse unreachable"
    }

    pub fn hasTail(self: *Elephant) bool {
        return (self.tail != null);
    }

    // Your Elephant trunk methods go here!
    // 你的大象象鼻方法在这里！
    // ---------------------------------------------------

    ???

    // ---------------------------------------------------

    pub fn visit(self: *Elephant) void {
        self.visited = true;
    }

    pub fn print(self: *Elephant) void {
        // Prints elephant letter and [v]isited
        // 打印大象字母和[v]已访问
        const v: u8 = if (self.visited) 'v' else ' ';
        std.debug.print("{u}{u} ", .{ self.letter, v });
    }
};

pub fn main() void {
    var elephantA = Elephant{ .letter = 'A' };
    var elephantB = Elephant{ .letter = 'B' };
    var elephantC = Elephant{ .letter = 'C' };

    // We link the elephants so that each tail "points" to the next.
    // 我们连接大象，使每个尾巴"指向"下一个。
    elephantA.tail = &elephantB;
    elephantB.tail = &elephantC;

    // And link the elephants so that each trunk "points" to the previous.
    // 并连接大象，使每个象鼻"指向"前一个。
    elephantB.trunk = &elephantA;
    elephantC.trunk = &elephantB;

    visitElephants(&elephantA);

    std.debug.print("\n", .{});
}

// This function visits all elephants twice, tails to trunks.
// 这个函数访问所有大象两次，从尾巴到象鼻。
fn visitElephants(first_elephant: *Elephant) void {
    var e = first_elephant;

    // We follow the tails!
    // 我们跟随尾巴！
    while (true) {
        e.print();
        e.visit();

        // This gets the next elephant or stops.
        // 这获取下一只大象或停止。
        if (e.hasTail()) {
            e = e.getTail();
        } else {
            break;
        }
    }

    // We follow the trunks!
    // 我们跟随象鼻！
    while (true) {
        e.print();

        // This gets the previous elephant or stops.
        // 这获取前一只大象或停止。
        if (e.hasTrunk()) {
            e = e.getTrunk();
        } else {
            break;
        }
    }
}
