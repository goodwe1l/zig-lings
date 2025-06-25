//
// Help! Evil alien creatures have hidden eggs all over the Earth
// 救命！邪恶的外星生物在地球各处藏了蛋
// and they're starting to hatch!
// 而且它们开始孵化了！
//
// Before you jump into battle, you'll need to know three things:
// 在你投入战斗之前，你需要知道三件事：
//
// 1. You can attach functions to structs (and other "type definitions"):
// 1. 你可以将函数附加到结构体（和其他"类型定义"）：
//
//     const Foo = struct{
//         pub fn hello() void {
//             std.debug.print("Foo says hello!\n", .{});
//         }
//     };
//
// 2. A function that is a member of a struct is "namespaced" within
// 2. 作为结构体成员的函数在该结构体内"命名空间化"，
//    that struct and is called by specifying the "namespace" and then
//    通过指定"命名空间"然后使用"点语法"来调用：
//    using the "dot syntax":
//    通过指定"命名空间"然后使用"点语法"来调用：
//
//     Foo.hello();
//
// 3. The NEAT feature of these functions is that if their first argument
// 3. 这些函数的巧妙特性是，如果它们的第一个参数
//    is an instance of the struct (or a pointer to one) then we can use
//    是结构体的实例（或指向它的指针），那么我们可以使用
//    the instance as the namespace instead of the type:
//    实例作为命名空间而不是类型：
//
//     const Bar = struct{
//         pub fn a(self: Bar) void {}
//         pub fn b(this: *Bar, other: u8) void {}
//         pub fn c(bar: *const Bar) void {}
//     };
//
//    var bar = Bar{};
//    bar.a() // is equivalent to Bar.a(bar)
//    bar.a() // 等价于 Bar.a(bar)
//    bar.b(3) // is equivalent to Bar.b(&bar, 3)
//    bar.b(3) // 等价于 Bar.b(&bar, 3)
//    bar.c() // is equivalent to Bar.c(&bar)
//    bar.c() // 等价于 Bar.c(&bar)
//
//    Notice that the name of the parameter doesn't matter. Some use
//    注意参数的名称并不重要。有些使用
//    self, others use a lowercase version of the type name, but feel
//    self，其他使用类型名称的小写版本，但可以
//    free to use whatever is most appropriate.
//    随意使用最合适的。
//
// Okay, you're armed.
// 好的，你已经武装起来了。
//
// Now, please zap the alien structs until they're all gone or
// 现在，请把外星人结构体全部消灭，否则
// the Earth will be doomed!
// 地球将会毁灭！
//
const std = @import("std");

// Look at this hideous Alien struct. Know your enemy!
// 看看这个丑陋的外星人结构体。了解你的敌人！
const Alien = struct {
    health: u8,

    // We hate this method:
    // 我们讨厌这个方法：
    pub fn hatch(strength: u8) Alien {
        return Alien{
            .health = strength * 5,
        };
    }
};

// Your trusty weapon. Zap those aliens!
// 你可信赖的武器。消灭那些外星人！
const HeatRay = struct {
    damage: u8,

    // We love this method:
    // 我们喜欢这个方法：
    pub fn zap(self: HeatRay, alien: *Alien) void {
        alien.health -= if (self.damage >= alien.health) alien.health else self.damage;
    }
};

pub fn main() void {
    // Look at all of these aliens of various strengths!
    // 看看这些各种强度的外星人！
    var aliens = [_]Alien{
        Alien.hatch(2),
        Alien.hatch(1),
        Alien.hatch(3),
        Alien.hatch(3),
        Alien.hatch(5),
        Alien.hatch(3),
    };

    var aliens_alive = aliens.len;
    const heat_ray = HeatRay{ .damage = 7 }; // We've been given a heat ray weapon.
                                             // 我们得到了一个热射线武器。

    // We'll keep checking to see if we've killed all the aliens yet.
    // 我们将继续检查是否已经杀死了所有外星人。
    while (aliens_alive > 0) {
        aliens_alive = 0;

        // Loop through every alien by reference (* makes a pointer capture value)
        // 通过引用循环遍历每个外星人（*使指针捕获值）
        for (&aliens) |*alien| {

            // *** Zap the alien with the heat ray here! ***
            // *** 在这里用热射线消灭外星人！ ***
            ???.zap(???);

            // If the alien's health is still above 0, it's still alive.
            // 如果外星人的健康值仍然大于0，它仍然活着。
            if (alien.health > 0) aliens_alive += 1;
        }

        std.debug.print("{} aliens. ", .{aliens_alive});
    }

    std.debug.print("Earth is saved!\n", .{});
    std.debug.print("地球得救了！\n", .{});
}
