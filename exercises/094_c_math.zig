//
// Often, C functions are used where no equivalent Zig function exists
// yet. Okay, that's getting less and less. ;-)
// 通常，在尚不存在等效 Zig 函数的地方使用 C 函数。
// 好的，这种情况越来越少了。;-)
//
// Since the integration of a C function is very simple, as already
// seen in the last exercise, it naturally offers itself to use the
// very large variety of C functions for our own programs.
// As an example:
// 由于 C 函数的集成非常简单，正如上一个练习中已经看到的，
// 它自然地提供了为我们自己的程序使用各种各样的 C 函数的机会。
// 作为示例：
//
// Let's say we have a given angle of 765.2 degrees. If we want to
// normalize that, it means that we have to subtract X * 360 degrees
// to get the correct angle.
// How could we do that? A good method is to use the modulo function.
// But if we write "765.2 % 360", it only works with float values
// that are known at compile time.
// In Zig, we would use @mod(a, b) instead.
// 假设我们有一个给定的 765.2 度角。如果我们想要将其标准化，
// 这意味着我们必须减去 X * 360 度来获得正确的角度。
// 我们该怎么做呢？一个好方法是使用模运算函数。
// 但如果我们写 "765.2 % 360"，它只对编译时已知的浮点值有效。
// 在 Zig 中，我们会使用 @mod(a, b) 代替。
//
// Let us now assume that we cannot do this in Zig, but only with
// a C function from the standard library. In the library "math",
// there is a function called "fmod"; the "f" stands for floating
// and means that we can solve modulo for real numbers. With this
// function, it should be possible to normalize our angle.
// Let's go.
// 现在让我们假设我们不能在 Zig 中做到这一点，而只能使用标准库中的 C 函数。
// 在库 "math" 中，有一个叫做 "fmod" 的函数；"f" 代表浮点，
// 意味着我们可以解决实数的模运算。使用这个函数，应该可以标准化我们的角度。
// 让我们开始吧。

const std = @import("std");

const c = @cImport({
    // What do we need here?
    // 我们这里需要什么？
    ???
});

pub fn main() !void {
    const angle = 765.2;
    const circle = 360;

    // Here we call the C function 'fmod' to get our normalized angle.
    // 这里我们调用 C 函数 'fmod' 来获取我们的标准化角度。
    const result = c.fmod(angle, circle);

    // We use formatters for the desired precision and to truncate the decimal places
    // 我们使用格式化器来设置所需的精度并截断小数位
    std.debug.print("The normalized angle of {d: >3.1} degrees is {d: >3.1} degrees.\n", .{ angle, result });
}
