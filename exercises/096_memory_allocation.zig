//
// In most of the examples so far, the inputs are known at compile
// time, thus the amount of memory used by the program is fixed.
// However, if responding to input whose size is not known at compile
// time, such as:
// 到目前为止，在大多数示例中，输入在编译时就已知，
// 因此程序使用的内存量是固定的。但是，如果响应编译时大小未知的输入，例如：
//  - user input via command-line arguments
//  - 通过命令行参数的用户输入
//  - inputs from another program
//  - 来自另一个程序的输入
//
// You'll need to request memory for your program to be allocated by
// your operating system at runtime.
// 您需要请求操作系统在运行时为您的程序分配内存。
//
// Zig provides several different allocators. In the Zig
// documentation, it recommends the Arena allocator for simple
// programs which allocate once and then exit:
// Zig 提供了几种不同的分配器。在 Zig 文档中，它建议对于简单的
// 一次分配然后退出的程序使用 Arena 分配器：
//
//     const std = @import("std");
//
//     // memory allocation can fail, so the return type is !void
//     pub fn main() !void {
//
//         var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
//         defer arena.deinit();
//
//         const allocator = arena.allocator();
//
//         const ptr = try allocator.create(i32);
//         std.debug.print("ptr={*}\n", .{ptr});
//
//         const slice_ptr = try allocator.alloc(f64, 5);
//         std.debug.print("slice_ptr={*}\n", .{slice_ptr});
//     }

// Instead of a simple integer or a slice with a constant size,
// this program requires allocating a slice that is the same size
// as an input array.
// 与简单整数或具有常量大小的切片不同，此程序需要分配与输入数组大小相同的切片。

// Given a series of numbers, take the running average. In other
// words, each item N should contain the average of the last N
// elements.
// 给定一系列数字，计算运行平均值。换句话说，每个项目 N 应包含最后 N 个元素的平均值。

const std = @import("std");

fn runningAverage(arr: []const f64, avg: []f64) void {
    var sum: f64 = 0;

    for (0.., arr) |index, val| {
        sum += val;
        const f_index: f64 = @floatFromInt(index + 1);
        avg[index] = sum / f_index;
    }
}

pub fn main() !void {
    // pretend this was defined by reading in user input
    // 假设这是通过读取用户输入定义的
    const arr: []const f64 = &[_]f64{ 0.3, 0.2, 0.1, 0.1, 0.4 };

    // initialize the allocator
    // 初始化分配器
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);

    // free the memory on exit
    // 退出时释放内存
    defer arena.deinit();

    // initialize the allocator
    // 初始化分配器
    const allocator = arena.allocator();

    // allocate memory for this array
    // 为此数组分配内存
    const avg: []f64 = ???;

    runningAverage(arr, avg);
    std.debug.print("Running Average: ", .{});
    for (avg) |val| {
        std.debug.print("{d:.2} ", .{val});
    }
    std.debug.print("\n", .{});
}

// For more details on memory allocation and the different types of
// memory allocators, see https://www.youtube.com/watch?v=vHWiDx_l4V0
// 有关内存分配和不同类型的内存分配器的更多详细信息，
// 请参阅 https://www.youtube.com/watch?v=vHWiDx_l4V0
