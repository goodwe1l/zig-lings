//
// Check this out:
// 看看这个：
//
//     var foo: u8 = 5;      // foo is 5
//     var foo: u8 = 5;      // foo是5
//     var bar: *u8 = &foo;  // bar is a pointer
//     var bar: *u8 = &foo;  // bar是一个指针
//
// What is a pointer? It's a reference to a value. In this example
// 什么是指针？它是对值的引用。在这个例子中
// bar is a reference to the memory space that currently contains the
// bar是对当前包含值5的内存空间的引用。
// value 5.
// 值5的内存空间的引用。
//
// A cheatsheet given the above declarations:
// 根据上述声明的备忘单：
//
//     u8         the type of a u8 value
//     u8         u8值的类型
//     foo        the value 5
//     foo        值5
//     *u8        the type of a pointer to a u8 value
//     *u8        指向u8值的指针类型
//     &foo       a reference to foo
//     &foo       对foo的引用
//     bar        a pointer to the value at foo
//     bar        指向foo处的值的指针
//     bar.*      the value 5 (the dereferenced value "at" bar)
//     bar.*      值5（在bar处的解引用值）
//
// We'll see why pointers are useful in a moment. For now, see if you
// 我们稍后会看到为什么指针有用。现在，看看你
// can make this example work!
// 能否让这个例子工作！
//
const std = @import("std");

pub fn main() void {
    var num1: u8 = 5;
    const num1_pointer: *u8 = &num1;

    var num2: u8 = undefined;

    // Please make num2 equal 5 using num1_pointer!
    // 请使用num1_pointer让num2等于5！
    // (See the "cheatsheet" above for ideas.)
    // （参考上面的"备忘单"获取想法。）
    num2 = ???;

    std.debug.print("num1: {}, num2: {}\n", .{ num1, num2 });
}
