//
// The functionality of the standard library is becoming increasingly
// important in Zig. First of all, it is helpful to take a look at how
// the individual functions are implemented. Because this is wonderfully
// suitable as a template for your own functions. In addition these
// standard functions are part of the basic configuration of Zig.
// 标准库的功能在 Zig 中变得越来越重要。首先，查看各个函数是如何实现的很有帮助。
// 因为这非常适合作为您自己函数的模板。此外，这些标准函数是 Zig 基本配置的一部分。
//
// This means that they are always available on every system.
// Therefore it is worthwhile to deal with them also in Ziglings.
// It's a great way to learn important skills. For example, it is
// often necessary to process large amounts of data from files.
// And for this sequential reading and processing, Zig provides some
// useful functions, which we will take a closer look at in the coming
// exercises.
// 这意味着它们在每个系统上都始终可用。因此，在 Ziglings 中处理它们也是值得的。
// 这是学习重要技能的好方法。例如，经常需要处理文件中的大量数据。
// 对于这种顺序读取和处理，Zig 提供了一些有用的函数，
// 我们将在接下来的练习中仔细研究。
//
// A nice example of this has been published on the Zig homepage,
// replacing the somewhat dusty 'Hello world!
// 在 Zig 主页上发布了一个很好的例子，取代了有些陈旧的 'Hello world!'
//
// Nothing against 'Hello world!', but it just doesn't do justice
// to the elegance of Zig and that's a pity, if someone takes a short,
// first look at the homepage and doesn't get 'enchanted'. And for that
// the present example is simply better suited and we will therefore
// use it as an introduction to tokenizing, because it is wonderfully
// suited to understand the basic principles.
// 对 'Hello world!' 没有什么意见，但它只是没有体现出 Zig 的优雅，
// 这很遗憾，如果有人简短地第一次浏览主页却没有被"迷住"。
// 为此，当前的例子更适合，因此我们将使用它作为标记化的介绍，
// 因为它非常适合理解基本原理。
//
// In the following exercises we will also read and process data from
// large files and at the latest then it will be clear to everyone how
// useful all this is.
// 在接下来的练习中，我们也将从大文件中读取和处理数据，
// 最迟到那时每个人都会清楚这一切有多么有用。
//
// Let's start with the analysis of the example from the Zig homepage
// and explain the most important things.
// 让我们从分析 Zig 主页上的示例开始，解释最重要的事情。
//
//    const std = @import("std");
//
//    // Here a function from the Standard library is defined,
//    // which transfers numbers from a string into the respective
//    // integer values.
//    // 这里定义了一个来自标准库的函数，它将字符串中的数字转换为相应的整数值。
//    const parseInt = std.fmt.parseInt;
//
//    // Defining a test case
//    test "parse integers" {
//
//        // Four numbers are passed in a string.
//        // Please note that the individual values are separated
//        // either by a space or a comma.
//        const input = "123 67 89,99";
//
//        // In order to be able to process the input values,
//        // memory is required. An allocator is defined here for
//        // this purpose.
//        const ally = std.testing.allocator;
//
//        // The allocator is used to initialize an array into which
//        // the numbers are stored.
//        var list = std.ArrayList(u32).init(ally);
//
//        // This way you can never forget what is urgently needed
//        // and the compiler doesn't grumble either.
//        defer list.deinit();
//
//        // Now it gets exciting:
//        // A standard tokenizer is called (Zig has several) and
//        // used to locate the positions of the respective separators
//        // (we remember, space and comma) and pass them to an iterator.
//        var it = std.mem.tokenizeAny(u8, input, " ,");
//
//        // The iterator can now be processed in a loop and the
//        // individual numbers can be transferred.
//        while (it.next()) |num| {
//            // But be careful: The numbers are still only available
//            // as strings. This is where the integer parser comes
//            // into play, converting them into real integer values.
//            const n = try parseInt(u32, num, 10);
//
//            // Finally the individual values are stored in the array.
//            try list.append(n);
//        }
//
//        // For the subsequent test, a second static array is created,
//        // which is directly filled with the expected values.
//        const expected = [_]u32{ 123, 67, 89, 99 };
//
//        // Now the numbers converted from the string can be compared
//        // with the expected ones, so that the test is completed
//        // successfully.
//        for (expected, list.items) |exp, actual| {
//            try std.testing.expectEqual(exp, actual);
//        }
//    }
//
// So much for the example from the homepage.
// Let's summarize the basic steps again:
//
// - We have a set of data in sequential order, separated from each other
//   by means of various characters.
//
// - For further processing, for example in an array, this data must be
//   read in, separated and, if necessary, converted into the target format.
//
// - We need a buffer that is large enough to hold the data.
//
// - This buffer can be created either statically at compile time, if the
//   amount of data is already known, or dynamically at runtime by using
//   a memory allocator.
//
// - The data are divided by means of Tokenizer at the respective
//   separators and stored in the reserved memory. This usually also
//   includes conversion to the target format.
//
// - Now the data can be conveniently processed further in the correct format.
//
// These steps are basically always the same.
// Whether the data is read from a file or entered by the user via the
// keyboard, for example, is irrelevant. Only subtleties are distinguished
// and that's why Zig has different tokenizers. But more about this in
// later exercises.
//
// Now we also want to write a small program to tokenize some data,
// after all we need some practice. Suppose we want to count the words
// of this little poem:
// 现在我们也想编写一个小程序来标记化一些数据，毕竟我们需要一些练习。
// 假设我们想计算这首小诗的单词数：
//
//      My name is Ozymandias, King of Kings;
//      Look on my Works, ye Mighty, and despair!
//            by Percy Bysshe Shelley
//
//
const std = @import("std");
const print = std.debug.print;

pub fn main() !void {

    // our input
    // 我们的输入
    const poem =
        \\My name is Ozymandias, King of Kings;
        \\Look on my Works, ye Mighty, and despair!
    ;

    // now the tokenizer, but what do we need here?
    // 现在是标记器，但我们这里需要什么？
    var it = std.mem.tokenizeAny(u8, poem, ???);

    // print all words and count them
    // 打印所有单词并计数
    var cnt: usize = 0;
    while (it.next()) |word| {
        cnt += 1;
        print("{s}\n", .{word});
    }

    // print the result
    // 打印结果
    print("This little poem has {d} words!\n", .{cnt});
}
