//
// You can also put 'comptime' before a function parameter to
// enforce that the argument passed to the function must be known
// at compile time. We've actually been using a function like
// this the entire time, std.debug.print():
// 您也可以在函数参数前放置 'comptime' 来强制传递给函数的参数必须在编译时已知。
// 实际上我们一直在使用这样的函数，std.debug.print()：
//
//     fn print(comptime fmt: []const u8, args: anytype) void
//
// Notice that the format string parameter 'fmt' is marked as
// 'comptime'.  One of the neat benefits of this is that the
// format string can be checked for errors at compile time rather
// than crashing at runtime.
// 注意格式字符串参数 'fmt' 被标记为 'comptime'。其中一个好处是格式字符串
// 可以在编译时检查错误，而不是在运行时崩溃。
//
// (The actual formatting is done by std.fmt.format() and it
// contains a complete format string parser that runs entirely at
// compile time!)
// （实际的格式化由 std.fmt.format() 完成，它包含一个完全在编译时运行的
// 完整格式字符串解析器！）
//
const print = @import("std").debug.print;

// This struct is the model of a model boat. We can transform it
// to any scale we would like: 1:2 is half-size, 1:32 is
// thirty-two times smaller than the real thing, and so forth.
// 这个结构体是模型船的模型。我们可以将其转换为任何我们想要的比例：
// 1:2 是一半大小，1:32 是比真实船只小三十二倍，等等。
const Schooner = struct {
    name: []const u8,
    scale: u32 = 1,
    hull_length: u32 = 143,
    bowsprit_length: u32 = 34,
    mainmast_height: u32 = 95,

    fn scaleMe(self: *Schooner, comptime scale: u32) void {
        comptime var my_scale = scale;

        // We did something neat here: we've anticipated the
        // possibility of accidentally attempting to create a
        // scale of 1:0. Rather than having this result in a
        // divide-by-zero error at runtime, we've turned this
        // into a compile error.
        // 我们在这里做了一些巧妙的事情：我们预料到了意外尝试创建 1:0 比例的可能性。
        // 我们没有让这导致运行时的除零错误，而是将其转换为编译错误。
        //
        // This is probably the correct solution most of the
        // time. But our model boat model program is very casual
        // and we just want it to "do what I mean" and keep
        // working.
        // 在大多数情况下，这可能是正确的解决方案。但我们的模型船模型程序非常随意，
        // 我们只是希望它"按我的意思做"并继续工作。
        //
        // Please change this so that it sets a 0 scale to 1
        // instead.
        // 请修改这个，使其将 0 比例设置为 1。
        if (my_scale == 0) @compileError("Scale 1:0 is not valid!");

        self.scale = my_scale;
        self.hull_length /= my_scale;
        self.bowsprit_length /= my_scale;
        self.mainmast_height /= my_scale;
    }

    fn printMe(self: Schooner) void {
        print("{s} (1:{}, {} x {})\n", .{
            self.name,
            self.scale,
            self.hull_length,
            self.mainmast_height,
        });
    }
};

pub fn main() void {
    var whale = Schooner{ .name = "Whale" };
    var shark = Schooner{ .name = "Shark" };
    var minnow = Schooner{ .name = "Minnow" };

    // Hey, we can't just pass this runtime variable as an
    // argument to the scaleMe() method. What would let us do
    // that?
    // 嘿，我们不能直接将这个运行时变量作为参数传递给 scaleMe() 方法。
    // 什么能让我们做到这一点？
    var scale: u32 = undefined;

    scale = 32; // 1:32 scale

    minnow.scaleMe(scale);
    minnow.printMe();

    scale -= 16; // 1:16 scale

    shark.scaleMe(scale);
    shark.printMe();

    scale -= 16; // 1:0 scale (oops, but DON'T FIX THIS!)
    // 比例减去 16；// 1:0 比例（哎呀，但不要修复这个！）

    whale.scaleMe(scale);
    whale.printMe();
}
//
// Going deeper:
// 深入探讨：
//
// What would happen if you DID attempt to build a model in the
// scale of 1:0?
// 如果您确实尝试以 1:0 的比例建造模型会发生什么？
//
//    A) You're already done!
//    A) 您已经完成了！
//    B) You would suffer a mental divide-by-zero error.
//    B) 您会遭受心理上的除零错误。
//    C) You would construct a singularity and destroy the
//       planet.
//    C) 您会构造一个奇点并摧毁地球。
//
// And how about a model in the scale of 0:1?
// 那么以 0:1 的比例建造模型会如何？
//
//    A) You're already done!
//    A) 您已经完成了！
//    B) You'd arrange nothing carefully into the form of the
//       original nothing but infinitely larger.
//    B) 您会小心地将虚无排列成原始虚无的形式，但无限大。
//    C) You would construct a singularity and destroy the
//       planet.
//    C) 您会构造一个奇点并摧毁地球。
//
// Answers can be found on the back of the Ziglings packaging.
// 答案可以在 Ziglings 包装的背面找到。
