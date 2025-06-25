//
// As a matter of fact, you can put 'comptime' in front of any
// expression to force it to be run at compile time.
// 事实上，您可以在任何表达式前面放置 'comptime' 来强制它在编译时运行。
//
// Execute a function:
// 执行一个函数：
//
//     comptime llama();
//
// Get a value:
// 获取一个值：
//
//     bar = comptime baz();
//
// Execute a whole block:
// 执行整个块：
//
//     comptime {
//         bar = baz + biff();
//         llama(bar);
//     }
//
// Get a value from a block:
// 从块中获取一个值：
//
//     var llama = comptime bar: {
//         const baz = biff() + bonk();
//         break :bar baz;
//     }
//
const print = @import("std").debug.print;

const llama_count = 5;
const llamas = [llama_count]u32{ 5, 10, 15, 20, 25 };

pub fn main() void {
    // We meant to fetch the last llama. Please fix this simple
    // mistake so the assertion no longer fails.
    // 我们本来想获取最后一只羊驼。请修复这个简单的错误，使断言不再失败。
    const my_llama = getLlama(5);

    print("My llama value is {}.\n", .{my_llama});
}

fn getLlama(i: usize) u32 {
    // We've put a guard assert() at the top of this function to
    // prevent mistakes. The 'comptime' keyword here means that
    // the mistake will be caught when we compile!
    // 我们在这个函数的顶部放置了一个保护断言来防止错误。
    // 这里的 'comptime' 关键字意味着错误将在编译时被捕获！
    //
    // Without 'comptime', this would still work, but the
    // assertion would fail at runtime with a PANIC, and that's
    // not as nice.
    // 没有 'comptime'，这仍然可以工作，但断言会在运行时因恐慌而失败，这并不好。
    //
    // Unfortunately, we're going to get an error right now
    // because the 'i' parameter needs to be guaranteed to be
    // known at compile time. What can you do with the 'i'
    // parameter above to make this so?
    // 不幸的是，我们现在会得到一个错误，因为 'i' 参数需要保证在编译时已知。
    // 您可以对上面的 'i' 参数做什么来实现这一点？
    comptime assert(i < llama_count);

    return llamas[i];
}

// Fun fact: this assert() function is identical to
// std.debug.assert() from the Zig Standard Library.
// 有趣的事实：这个 assert() 函数与 Zig 标准库中的 std.debug.assert() 相同。
fn assert(ok: bool) void {
    if (!ok) unreachable;
}
//
// Bonus fun fact: I accidentally replaced all instances of 'foo'
// with 'llama' in this exercise and I have no regrets!
//
// 奖励有趣的事实：我意外地在这个练习中将所有的 'foo' 替换为 'llama'，我毫不后悔！
