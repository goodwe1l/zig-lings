//
// It's important to note that variable pointers and constant pointers
// 重要的是要注意变量指针和常量指针
// are different types.
// 是不同的类型。
//
// Given:
// 给定：
//
//     var foo: u8 = 5;
//     const bar: u8 = 5;
//
// Then:
// 那么：
//
//     &foo is of type "*u8"
//     &foo是"*u8"类型
//     &bar is of type "*const u8"
//     &bar是"*const u8"类型
//
// You can always make a const pointer to a mutable value (var), but
// 你总是可以创建指向可变值(var)的const指针，但
// you cannot make a var pointer to an immutable value (const).
// 你不能创建指向不可变值(const)的var指针。
// This sounds like a logic puzzle, but it just means that once data
// 这听起来像逻辑谜题，但它只是意味着一旦数据
// is declared immutable, you can't coerce it to a mutable type.
// 被声明为不可变的，你就不能将其强制转换为可变类型。
// Think of mutable data as being volatile or even dangerous. Zig
// 把可变数据想象成易变的甚至是危险的。Zig
// always lets you be "more safe" and never "less safe."
// 总是让你"更安全"而不是"不太安全"。
//
const std = @import("std");

pub fn main() void {
    const a: u8 = 12;
    const b: *u8 = &a; // fix this!
    // 修复这个！

    std.debug.print("a: {}, b: {}\n", .{ a, b.* });
}
