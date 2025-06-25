//
// The tricky part is that the pointer's mutability (var vs const) refers
// 棘手的部分是指针的可变性(var vs const)指的是
// to the ability to change what the pointer POINTS TO, not the ability
// 改变指针所指向内容的能力，而不是改变
// to change the VALUE at that location!
// 该位置的值的能力！
//
//     const locked: u8 = 5;
//     var unlocked: u8 = 10;
//
//     const p1: *const u8 = &locked;
//     var   p2: *const u8 = &locked;
//
// Both p1 and p2 point to constant values which cannot change. However,
// p1和p2都指向不能改变的常量值。然而，
// p2 can be changed to point to something else and p1 cannot!
// p2可以被改变指向其他东西，而p1不能！
//
//     const p3: *u8 = &unlocked;
//     var   p4: *u8 = &unlocked;
//     const p5: *const u8 = &unlocked;
//     var   p6: *const u8 = &unlocked;
//
// Here p3 and p4 can both be used to change the value they point to but
// 这里p3和p4都可以用来改变它们指向的值，但
// p3 cannot point at anything else.
// p3不能指向其他任何东西。
// What's interesting is that p5 and p6 act like p1 and p2, but point to
// 有趣的是p5和p6的行为像p1和p2，但指向
// the value at "unlocked". This is what we mean when we say that we can
// "unlocked"处的值。这就是我们说可以
// make a constant reference to any value!
// 创建对任何值的常量引用的意思！
//
const std = @import("std");

pub fn main() void {
    var foo: u8 = 5;
    var bar: u8 = 10;

    // Please define pointer "p" so that it can point to EITHER foo or
    // 请定义指针"p"，使其可以指向foo或
    // bar AND change the value it points to!
    // bar并且可以改变它指向的值！
    ??? p: ??? = undefined;

    p = &foo;
    p.* += 1;
    p = &bar;
    p.* += 1;
    std.debug.print("foo={}, bar={}\n", .{ foo, bar });
}
