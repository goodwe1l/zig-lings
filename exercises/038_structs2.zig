//
// Grouping values in structs is not merely convenient. It also allows
// 在struct中分组值不仅仅是方便。它还允许
// us to treat the values as a single item when storing them, passing
// 我们在存储、传递给函数等时将值作为单个项目处理。
// them to functions, etc.
// 我们在存储、传递给函数等时将值作为单个项目处理。
//
// This exercise demonstrates how we can store structs in an array and
// 这个练习演示了我们如何将struct存储在数组中
// how doing so lets us print them using a loop.
// 以及这样做如何让我们使用循环打印它们。
//
const std = @import("std");

const Role = enum {
    wizard,
    thief,
    bard,
    warrior,
};

const Character = struct {
    role: Role,
    gold: u32,
    health: u8,
    experience: u32,
};

pub fn main() void {
    var chars: [2]Character = undefined;

    // Glorp the Wise
    chars[0] = Character{
        .role = Role.wizard,
        .gold = 20,
        .health = 100,
        .experience = 10,
    };

    // Please add "Zump the Loud" with the following properties:
    // 请添加具有以下属性的"Zump the Loud"：
    //
    //     role       bard
    //     gold       10
    //     health     100
    //     experience 20
    //
    // Feel free to run this program without adding Zump. What does
    // 可以在不添加Zump的情况下运行这个程序。它会做什么，
    // it do and why?
    // 为什么？

    // Printing all RPG characters in a loop:
    // 在循环中打印所有RPG角色：
    for (chars, 0..) |c, num| {
        std.debug.print("Character {} - G:{} H:{} XP:{}\n", .{
            num + 1, c.gold, c.health, c.experience,
        });
    }
}

// If you tried running the program without adding Zump as mentioned
// 如果你试图在不添加Zump的情况下运行程序，如上所述，
// above, you get what appear to be "garbage" values. In debug mode
// 你会得到看起来像"垃圾"值的东西。在调试模式下
// (which is the default), Zig writes the repeating pattern "10101010"
// （这是默认模式），Zig将重复模式"10101010"
// in binary (or 0xAA in hex) to all undefined locations to make them
// 以二进制（或十六进制0xAA）写入所有未定义的位置，使它们
// easier to spot when debugging.
// 在调试时更容易发现。
