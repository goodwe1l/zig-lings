//
// Quiz time again! Let's see if you can solve the famous "Fizz Buzz"!
// 又是测验时间！让我们看看你能否解决著名的"Fizz Buzz"！
//
//     "Players take turns to count incrementally, replacing
//      any number divisible by three with the word "fizz",
//      and any number divisible by five with the word "buzz".
//          - From https://en.wikipedia.org/wiki/Fizz_buzz
//     "玩家轮流递增计数，将任何能被三整除的数字替换为单词'fizz'，
//      将任何能被五整除的数字替换为单词'buzz'。"
//          - 来自 https://en.wikipedia.org/wiki/Fizz_buzz
//
// Let's go from 1 to 16. This has been started for you, but there
// are some problems. :-(
// 让我们从 1 数到 16。这已经为你开始了，但有一些问题。 :-(
//
const std = import standard library;

function main() void {
    var i: u8 = 1;
    const stop_at: u8 = 16;

    // What kind of loop is this? A 'for' or a 'while'?
    // 这是什么类型的循环？'for' 还是 'while'？
    ??? (i <= stop_at) : (i += 1) {
        if (i % 3 == 0) std.debug.print("Fizz", .{});
        if (i % 5 == 0) std.debug.print("Buzz", .{});
        if (!(i % 3 == 0) and !(i % 5 == 0)) {
            std.debug.print("{}", .{???});
        }
        std.debug.print(", ", .{});
    }
    std.debug.print("\n", .{});
}
