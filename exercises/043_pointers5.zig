//
// As with integers, you can pass a pointer to a struct when you
// 与整数一样，当你希望修改结构体时，
// will wish to modify that struct. Pointers are also useful when
// 你可以传递指向结构体的指针。指针在你需要
// you need to store a reference to a struct (a "link" to it).
// 存储对结构体的引用（到它的"链接"）时也很有用。
//
//     const Vertex = struct{ x: u32, y: u32, z: u32 };
//
//     var v1 = Vertex{ .x=3, .y=2, .z=5 };
//
//     var pv: *Vertex = &v1;   // <-- a pointer to our struct
//     var pv: *Vertex = &v1;   // <-- 指向我们结构体的指针
//
// Note that you don't need to dereference the "pv" pointer to access
// 注意你不需要解引用"pv"指针来访问
// the struct's fields:
// 结构体的字段：
//
//     YES: pv.x
//     YES: pv.x（是的）
//     NO:  pv.*.x
//     NO:  pv.*.x（不是）
//
// We can write functions that take pointers to structs as
// 我们可以编写接受指向结构体的指针作为
// arguments. This foo() function modifies struct v:
// 参数的函数。这个foo()函数修改结构体v：
//
//     fn foo(v: *Vertex) void {
//         v.x += 2;
//         v.y += 3;
//         v.z += 7;
//     }
//
// And call them like so:
// 然后这样调用它们：
//
//     foo(&v1);
//
// Let's revisit our RPG example and make a printCharacter() function
// 让我们重新审视我们的RPG例子，制作一个printCharacter()函数
// that takes a Character by reference and prints it...*and*
// 它通过引用接受一个Character并打印它...*并且*
// prints a linked "mentor" Character, if there is one.
// 如果有的话，打印一个链接的"mentor"Character。
//
const std = @import("std");

const Class = enum {
    wizard,
    thief,
    bard,
    warrior,
};

const Character = struct {
    class: Class,
    gold: u32,
    health: u8 = 100, // You can provide default values
    experience: u32,

    // I need to use the '?' here to allow for a null value. But
    // 我需要在这里使用'?'来允许null值。但
    // I don't explain it until later. Please don't tell anyone.
    // 我直到后面才解释它。请不要告诉任何人。
    mentor: ?*Character = null,
};

pub fn main() void {
    var mighty_krodor = Character{
        .class = Class.wizard,
        .gold = 10000,
        .experience = 2340,
    };

    var glorp = Character{ // Glorp!
        .class = Class.wizard,
        .gold = 10,
        .experience = 20,
        .mentor = &mighty_krodor, // Glorp's mentor is the Mighty Krodor
                                  // Glorp的导师是强大的Krodor
    };

    // FIX ME!
    // 修复我！
    // Please pass Glorp to printCharacter():
    // 请将Glorp传递给printCharacter()：
    printCharacter(???);
}

// Note how this function's "c" parameter is a pointer to a Character struct.
// 注意这个函数的"c"参数是指向Character结构体的指针。
fn printCharacter(c: *Character) void {
    // Here's something you haven't seen before: when switching an enum, you
    // 这里有你之前没见过的东西：当切换枚举时，你
    // don't have to write the full enum name. Zig understands that ".wizard"
    // 不必写完整的枚举名称。Zig理解".wizard"
    // means "Class.wizard" when we switch on a Class enum value:
    // 在我们切换Class枚举值时意味着"Class.wizard"：
    const class_name = switch (c.class) {
        .wizard => "Wizard",
        .thief => "Thief",
        .bard => "Bard",
        .warrior => "Warrior",
    };

    std.debug.print("{s} (G:{} H:{} XP:{})\n", .{
        class_name,
        c.gold,
        c.health,
        c.experience,
    });

    // Checking an "optional" value and capturing it will be
    // 检查"可选"值并捕获它将在
    // explained later (this pairs with the '?' mentioned above.)
    // 后面解释（这与上面提到的'?'配对。）
    if (c.mentor) |mentor| {
        std.debug.print("  Mentor: ", .{});
        printCharacter(mentor);
    }
}
