//
// Using `catch` to replace an error with a default value is a bit
// of a blunt instrument since it doesn't matter what the error is.
//
// Catch lets us capture the error value and perform additional
// actions with this form:
//
//     canFail() catch |err| {
//         if (err == FishError.TunaMalfunction) {
//             ...
//         }
//     };
//
// 使用 `catch` 用默认值替换错误有点粗暴，因为错误是什么并不重要。
//
// Catch 允许我们捕获错误值并使用这种形式执行额外的操作：
//
//     canFail() catch |err| {
//         if (err == FishError.TunaMalfunction) {
//             ...
//         }
//     };
//
const std = @import("std");

const MyNumberError = error{
    TooSmall,
    TooBig,
};

pub fn main() void {
    // The "catch 0" below is a temporary hack to deal with
    // makeJustRight()'s returned error union (for now).
    // 下面的 "catch 0" 是一个临时的技巧，用来处理
    // makeJustRight() 返回的错误联合（目前）。
    const a: u32 = makeJustRight(44) catch 0;
    const b: u32 = makeJustRight(14) catch 0;
    const c: u32 = makeJustRight(4) catch 0;

    std.debug.print("a={}, b={}, c={}\n", .{ a, b, c });
}

// In this silly example we've split the responsibility of making
// a number just right into four (!) functions:
//
//     makeJustRight()   Calls fixTooBig(), cannot fix any errors.
//     fixTooBig()       Calls fixTooSmall(), fixes TooBig errors.
//     fixTooSmall()     Calls detectProblems(), fixes TooSmall errors.
//     detectProblems()  Returns the number or an error.
//
// 在这个愚蠢的例子中，我们将使数字恰好正确的责任分成了四个（！）函数：
//
//     makeJustRight()   调用 fixTooBig()，不能修复任何错误。
//     fixTooBig()       调用 fixTooSmall()，修复 TooBig 错误。
//     fixTooSmall()     调用 detectProblems()，修复 TooSmall 错误。
//     detectProblems()  返回数字或错误。
//
fn makeJustRight(n: u32) MyNumberError!u32 {
    return fixTooBig(n) catch |err| {
        return err;
    };
}

fn fixTooBig(n: u32) MyNumberError!u32 {
    return fixTooSmall(n) catch |err| {
        if (err == MyNumberError.TooBig) {
            return 20;
        }

        return err;
    };
}

fn fixTooSmall(n: u32) MyNumberError!u32 {
    // Oh dear, this is missing a lot! But don't worry, it's nearly
    // identical to fixTooBig() above.
    //
    // If we get a TooSmall error, we should return 10.
    // If we get any other error, we should return that error.
    // Otherwise, we return the u32 number.
    // 哦不，这里缺少很多！但别担心，它几乎与上面的 fixTooBig() 相同。
    //
    // 如果我们得到 TooSmall 错误，我们应该返回 10。
    // 如果我们得到任何其他错误，我们应该返回那个错误。
    // 否则，我们返回 u32 数字。
    return detectProblems(n) ???;
}

fn detectProblems(n: u32) MyNumberError!u32 {
    if (n < 10) return MyNumberError.TooSmall;
    if (n > 20) return MyNumberError.TooBig;
    return n;
}
