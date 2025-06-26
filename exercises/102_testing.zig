//
// A big advantage of Zig is the integration of its own test system.
// This allows the philosophy of Test Driven Development (TDD) to be
// implemented perfectly. Zig even goes one step further than other
// languages, the tests can be included directly in the source file.
// Zig 的一个大优势是集成了自己的测试系统。这允许完美地实现
// 测试驱动开发 (TDD) 的理念。Zig 甚至比其他语言更进一步，
// 测试可以直接包含在源文件中。
//
// This has several advantages. On the one hand it is much clearer to
// have everything in one file, both the source code and the associated
// test code. On the other hand, it is much easier for third parties
// to understand what exactly a function is supposed to do if they can
// simply look at the test inside the source and compare both.
// 这有几个优势。一方面，将所有内容（源代码和相关测试代码）
// 放在一个文件中更清晰。另一方面，如果第三方可以简单地查看源文件中的测试
// 并比较两者，他们更容易理解函数到底应该做什么。
//
// Especially if you want to understand how e.g. the standard library
// of Zig works, this approach is very helpful. Furthermore it is very
// practical, if you want to report a bug to the Zig community, to
// illustrate it with a small example including a test.
// 特别是如果您想了解 Zig 标准库是如何工作的，这种方法非常有帮助。
// 此外，如果您想向 Zig 社区报告错误，用包含测试的小示例来说明它是非常实用的。
//
// Therefore, in this exercise we will deal with the basics of testing
// in Zig. Basically, tests work as follows: you pass certain parameters
// to a function, for which you get a return - the result. This is then
// compared with the EXPECTED value. If both values match, the test is
// passed, otherwise an error message is displayed.
// 因此，在这个练习中我们将处理 Zig 中测试的基础知识。
// 基本上，测试的工作原理如下：您将某些参数传递给函数，从中得到返回值——结果。
// 然后将其与期望值进行比较。如果两个值匹配，测试通过，否则显示错误消息。
//
//          testing.expect(foo(param1, param2) == expected);
//
// Also other comparisons are possible, deviations or also errors can
// be provoked, which must lead to an appropriate behavior of the
// function, so that the test is passed.
// 其他比较也是可能的，可以引发偏差或错误，这必须导致函数的适当行为，
// 以便测试通过。
//
// Tests can be run via Zig build system or applied directly to
// individual modules using "zig test xyz.zig".
// 测试可以通过 Zig 构建系统运行，或使用 "zig test xyz.zig" 直接应用于单个模块。
//
// Both can be used script-driven to execute tests automatically, e.g.
// after checking into a Git repository. Something we also make extensive
// use of here at Ziglings.
// 两者都可以用脚本驱动来自动执行测试，例如在检入 Git 存储库后。
// 这也是我们在 Ziglings 中广泛使用的东西。
//
const std = @import("std");
const testing = std.testing;

// This is a simple function
// that builds a sum from the
// passed parameters and returns.
// 这是一个简单的函数，从传递的参数构建和并返回。
fn add(a: f16, b: f16) f16 {
    return a + b;
}

// The associated test.
// It always starts with the keyword "test",
// followed by a description of the tasks
// of the test. This is followed by the
// test cases in curly brackets.
// 相关的测试。它总是以关键字 "test" 开始，
// 后跟测试任务的描述。然后是大括号中的测试用例。
test "add" {

    // The first test checks if the sum
    // of '41' and '1' gives '42', which
    // is correct.
    // 第一个测试检查 '41' 和 '1' 的和是否给出 '42'，这是正确的。
    try testing.expect(add(41, 1) == 42);

    // Another way to perform this test
    // is as follows:
    // 执行此测试的另一种方法如下：
    try testing.expectEqual(add(41, 1), 42);

    // This time a test with the addition
    // of a negative number:
    // 这次是加负数的测试：
    try testing.expect(add(5, -4) == 1);

    // And a floating point operation:
    // 还有一个浮点运算：
    try testing.expect(add(1.5, 1.5) == 3);
}

// Another simple function
// that returns the result
// of subtracting the two
// parameters.
// 另一个简单的函数，返回两个参数相减的结果。
fn sub(a: f16, b: f16) f16 {
    return a - b;
}

// The corresponding test
// is not much different
// from the previous one.
// Except that it contains
// an error that you need
// to correct.
// 相应的测试与前一个没有太大不同。
// 除了它包含一个您需要纠正的错误。
test "sub" {
    try testing.expect(sub(10, 5) == 6);

    try testing.expect(sub(3, 1.5) == 1.5);
}

// This function divides the
// numerator by the denominator.
// Here it is important that the
// denominator must not be zero.
// This is checked and if it
// occurs an error is returned.
// 此函数将分子除以分母。这里重要的是分母不能为零。
// 检查这一点，如果发生这种情况就返回错误。
fn divide(a: f16, b: f16) !f16 {
    if (b == 0) return error.DivisionByZero;
    return a / b;
}

test "divide" {
    try testing.expect(divide(2, 2) catch unreachable == 1);
    try testing.expect(divide(-1, -1) catch unreachable == 1);
    try testing.expect(divide(10, 2) catch unreachable == 5);
    try testing.expect(divide(1, 3) catch unreachable == 0.3333333333333333);

    // Now we test if the function returns an error
    // if we pass a zero as denominator.
    // But which error needs to be tested?
    // 现在我们测试如果我们传递零作为分母，函数是否返回错误。
    // 但需要测试哪个错误？
    try testing.expectError(error.???, divide(15, 0));
}
