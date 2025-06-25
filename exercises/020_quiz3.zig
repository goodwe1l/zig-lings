//
// Let's see if we can make use of some of the things we've learned so far.
// We'll create two functions: one that contains a "for" loop and one
// that contains a "while" loop.
//
// Both of these are simply labeled "loop" below.
// 让我们看看能否利用一些迄今为止学到的东西。
// 我们将创建两个函数：一个包含 "for" 循环，另一个包含 "while" 循环。
//
// 下面这两个都简单地标记为 "loop"。
//
const std = @import("std");

pub fn main() void {
    const my_numbers = [4]u16{ 5, 6, 7, 8 };

    printPowersOfTwo(my_numbers);
    std.debug.print("\n", .{});
}

// You won't see this every day: a function that takes an array with
// exactly four u16 numbers. This is not how you would normally pass
// an array to a function. We'll learn about slices and pointers in
// a little while. For now, we're using what we know.
//
// This function prints, but does not return anything.
//
// 你不会每天都看到这样的函数：一个接受恰好四个 u16 数字数组的函数。
// 这不是你通常将数组传递给函数的方式。我们稍后会学习切片和指针。
// 现在，我们使用我们知道的。
//
// 这个函数打印，但不返回任何东西。
//
fn printPowersOfTwo(numbers: [4]u16) ??? {
    loop (numbers) |n| {
        std.debug.print("{} ", .{twoToThe(n)});
    }
}

// This function bears a striking resemblance to twoToThe() in the last
// exercise. But don't be fooled! This one does the math without the aid
// of the standard library!
//
// 这个函数与上一个练习中的 twoToThe() 惊人地相似。
// 但不要被愚弄了！这个函数在没有标准库帮助的情况下进行数学运算！
//
fn twoToThe(number: u16) ??? {
    var n: u16 = 0;
    var total: u16 = 1;

    loop (n < number) : (n += 1) {
        total *= 2;
    }

    return ???;
}
