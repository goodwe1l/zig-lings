//
// Whenever there is a lot to calculate, the question arises as to how
// tasks can be carried out simultaneously. We have already learned about
// one possibility, namely asynchronous processes, in Exercises 84-91.
// 每当有很多要计算的内容时，就会出现如何同时执行任务的问题。
// 我们已经在练习 84-91 中学习了一种可能性，即异步进程。
//
// However, the computing power of the processor is only distributed to
// the started and running tasks, which always reaches its limits when
// pure computing power is called up.
// 然而，处理器的计算能力只分配给已启动和正在运行的任务，
// 当需要纯计算能力时总是达到其极限。
//
// For example, in blockchains based on proof of work, the miners have
// to find a nonce for a certain character string so that the first m bits
// in the hash of the character string and the nonce are zeros.
// As the miner who can solve the task first receives the reward, everyone
// tries to complete the calculations as quickly as possible.
// 例如，在基于工作量证明的区块链中，矿工必须为某个字符串找到一个 nonce，
// 使得字符串和 nonce 的哈希值的前 m 位为零。
// 由于能够首先解决任务的矿工获得奖励，每个人都试图尽快完成计算。
//
// This is where multithreading comes into play, where tasks are actually
// distributed across several cores of the CPU or GPU, which then really
// means a multiplication of performance.
// 这就是多线程发挥作用的地方，任务实际上分布在 CPU 或 GPU 的多个核心上，
// 这真正意味着性能的倍增。
//
// The following diagram roughly illustrates the difference between the
// various types of process execution.
// The 'Overall Time' column is intended to illustrate how the time is
// affected if, instead of one core as in synchronous and asynchronous
// processing, a second core now helps to complete the work in multithreading.
// 下图大致说明了各种类型进程执行之间的差异。
// "总时间"列旨在说明如果不像同步和异步处理中的一个核心，
// 而是第二个核心现在帮助完成多线程中的工作，时间如何受到影响。
//
// In the ideal case shown, execution takes only half the time compared
// to the synchronous single thread. And even asynchronous processing
// is only slightly faster in comparison.
// 在所示的理想情况下，与同步单线程相比，执行时间仅为一半。
// 甚至异步处理相比之下也只是稍微快一些。
//
//
// Synchronous  Asynchronous
// Processing   Processing        Multithreading
// ┌──────────┐ ┌──────────┐  ┌──────────┐ ┌──────────┐
// │ Thread 1 │ │ Thread 1 │  │ Thread 1 │ │ Thread 2 │
// ├──────────┤ ├──────────┤  ├──────────┤ ├──────────┤    Overall Time
// └──┼┼┼┼┼───┴─┴──┼┼┼┼┼───┴──┴──┼┼┼┼┼───┴─┴──┼┼┼┼┼───┴──┬───────┬───────┬──
//    ├───┤        ├───┤         ├───┤        ├───┤      │       │       │
//    │ T │        │ T │         │ T │        │ T │      │       │       │
//    │ a │        │ a │         │ a │        │ a │      │       │       │
//    │ s │        │ s │         │ s │        │ s │      │       │       │
//    │ k │        │ k │         │ k │        │ k │      │       │       │
//    │   │        │   │         │   │        │   │      │       │       │
//    │ 1 │        │ 1 │         │ 1 │        │ 3 │      │       │       │
//    └─┬─┘        └─┬─┘         └─┬─┘        └─┬─┘      │       │       │
//      │            │             │            │      5 Sec     │       │
// ┌────┴───┐      ┌─┴─┐         ┌─┴─┐        ┌─┴─┐      │       │       │
// │Blocking│      │ T │         │ T │        │ T │      │       │       │
// └────┬───┘      │ a │         │ a │        │ a │      │       │       │
//      │          │ s │         │ s │        │ s │      │     8 Sec     │
//    ┌─┴─┐        │ k │         │ k │        │ k │      │       │       │
//    │ T │        │   │         │   │        │   │      │       │       │
//    │ a │        │ 2 │         │ 2 │        │ 4 │      │       │       │
//    │ s │        └─┬─┘         ├───┤        ├───┤      │       │       │
//    │ k │          │           │┼┼┼│        │┼┼┼│      ▼       │    10 Sec
//    │   │        ┌─┴─┐         └───┴────────┴───┴─────────     │       │
//    │ 1 │        │ T │                                         │       │
//    └─┬─┘        │ a │                                         │       │
//      │          │ s │                                         │       │
//    ┌─┴─┐        │ k │                                         │       │
//    │ T │        │   │                                         │       │
//    │ a │        │ 1 │                                         │       │
//    │ s │        ├───┤                                         │       │
//    │ k │        │┼┼┼│                                         ▼       │
//    │   │        └───┴────────────────────────────────────────────     │
//    │ 2 │                                                              │
//    ├───┤                                                              │
//    │┼┼┼│                                                              ▼
//    └───┴────────────────────────────────────────────────────────────────
//
//
// The diagram was modeled on the one in a blog in which the differences
// between asynchronous processing and multithreading are explained in detail:
// https://blog.devgenius.io/multi-threading-vs-asynchronous-programming-what-is-the-difference-3ebfe1179a5
// 该图表是根据一篇博客中的图表建模的，其中详细解释了异步处理和多线程之间的差异：
// https://blog.devgenius.io/multi-threading-vs-asynchronous-programming-what-is-the-difference-3ebfe1179a5
//
// Our exercise is essentially about clarifying the approach in Zig and
// therefore we try to keep it as simple as possible.
// Multithreading in itself is already difficult enough. ;-)
// 我们的练习本质上是关于澄清 Zig 中的方法，因此我们尽量保持简单。
// 多线程本身已经足够困难了。;-)
//
const std = @import("std");

pub fn main() !void {
    // This is where the preparatory work takes place
    // before the parallel processing begins.
    // 这是在并行处理开始之前进行准备工作的地方。
    std.debug.print("Starting work...\n", .{});

    // These curly brackets are very important, they are necessary
    // to enclose the area where the threads are called.
    // Without these brackets, the program would not wait for the
    // end of the threads and they would continue to run beyond the
    // end of the program.
    // 这些大括号非常重要，它们对于包围调用线程的区域是必要的。
    // 没有这些括号，程序不会等待线程结束，它们会在程序结束后继续运行。
    {
        // Now we start the first thread, with the number as parameter
        // 现在我们启动第一个线程，以数字作为参数
        const handle = try std.Thread.spawn(.{}, thread_function, .{1});

        // Waits for the thread to complete,
        // then deallocates any resources created on `spawn()`.
        // 等待线程完成，然后释放在 `spawn()` 上创建的任何资源。
        defer handle.join();

        // Second thread
        // 第二个线程
        const handle2 = try std.Thread.spawn(.{}, thread_function, .{-4}); // that can't be right?
        defer handle2.join();

        // Third thread
        // 第三个线程
        const handle3 = try std.Thread.spawn(.{}, thread_function, .{3});
        defer ??? // <-- something is missing

        // After the threads have been started,
        // they run in parallel and we can still do some work in between.
        // 线程启动后，它们并行运行，我们仍然可以在其间做一些工作。
        std.time.sleep(1500 * std.time.ns_per_ms);
        std.debug.print("Some weird stuff, after starting the threads.\n", .{});
    }
    // After we have left the closed area, we wait until
    // the threads have run through, if this has not yet been the case.
    // 在我们离开封闭区域后，我们等待直到线程运行完毕，如果还没有的话。
    std.debug.print("Zig is cool!\n", .{});
}

// This function is started with every thread that we set up.
// In our example, we pass the number of the thread as a parameter.
// 这个函数在我们设置的每个线程中启动。在我们的示例中，我们将线程号作为参数传递。
fn thread_function(num: usize) !void {
    std.time.sleep(200 * num * std.time.ns_per_ms);
    std.debug.print("thread {d}: {s}\n", .{ num, "started." });

    // This timer simulates the work of the thread.
    // 这个计时器模拟线程的工作。
    const work_time = 3 * ((5 - num % 3) - 2);
    std.time.sleep(work_time * std.time.ns_per_s);

    std.debug.print("thread {d}: {s}\n", .{ num, "finished." });
}
// This is the easiest way to run threads in parallel.
// In general, however, more management effort is required,
// e.g. by setting up a pool and allowing the threads to communicate
// with each other using semaphores.
// 这是并行运行线程的最简单方法。但通常需要更多的管理工作，
// 例如通过设置池并允许线程使用信号量相互通信。
//
// But that's a topic for another exercise.
// 但这是另一个练习的主题。
