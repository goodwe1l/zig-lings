//
// Being able to group values together lets us turn this:
// 能够将值组合在一起让我们把这个：
//
//     point1_x = 3;
//     point1_y = 16;
//     point1_z = 27;
//     point2_x = 7;
//     point2_y = 13;
//     point2_z = 34;
//
// into this:
// 变成这个：
//
//     point1 = Point{ .x=3, .y=16, .z=27 };
//     point2 = Point{ .x=7, .y=13, .z=34 };
//
// The Point above is an example of a "struct" (short for "structure").
// 上面的Point是"struct"（"structure"的缩写）的一个例子。
// Here's how that struct type could have been defined:
// 以下是如何定义这个struct类型：
//
//     const Point = struct{ x: u32, y: u32, z: u32 };
//
// Let's store something fun with a struct: a roleplaying character!
// 让我们用struct存储一些有趣的东西：一个角色扮演游戏角色！
//
const std = @import("std");

// We'll use an enum to specify the character role.
// 我们将使用enum来指定角色职业。
const Role = enum {
    wizard,
    thief,
    bard,
    warrior,
};

// Please add a new property to this struct called "health" and make
// 请向这个struct添加一个名为"health"的新属性，并将
// it a u8 integer type.
// 它设为u8整数类型。
const Character = struct {
    role: Role,
    gold: u32,
    experience: u32,
};

pub fn main() void {
    // Please initialize Glorp with 100 health.
    // 请用100健康值初始化Glorp。
    var glorp_the_wise = Character{
        .role = Role.wizard,
        .gold = 20,
        .experience = 10,
    };

    // Glorp gains some gold.
    // Glorp获得了一些金币。
    glorp_the_wise.gold += 5;

    // Ouch! Glorp takes a punch!
    // 哎哟！Glorp挨了一拳！
    glorp_the_wise.health -= 10;

    std.debug.print("Your wizard has {} health and {} gold.\n", .{
        glorp_the_wise.health,
        glorp_the_wise.gold,
    });
}
