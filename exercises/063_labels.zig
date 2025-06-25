//
// Loop bodies are blocks, which are also expressions. We've seen
// 循环体是块，它们也是表达式。我们已经看到
// how they can be used to evaluate and return values. To further
// 它们如何用于评估和返回值。为了进一步
// expand on this concept, it turns out we can also give names to
// 扩展这个概念，事实证明我们也可以通过应用
// blocks by applying a 'label':
// '标签'来给块命名：
//
//     my_label: { ... }
//
// Once you give a block a label, you can use 'break' to exit
// 一旦你给块一个标签，你可以使用'break'
// from that block.
// 从该块退出。
//
//     outer_block: {           // outer block
//     outer_block: {           // 外部块
//         while (true) {       // inner block
//         while (true) {       // 内部块
//             break :outer_block;
//         }
//         unreachable;
//     }
//
// As we've just learned, you can return a value using a break
// 正如我们刚刚学到的，你可以使用break语句返回一个值。
// statement. Does that mean you can return a value from any
// 这是否意味着你可以从任何标记的块返回一个值？
// labeled block? Yes it does!
// 是的！
//
//     const foo = make_five: {
//         const five = 1 + 1 + 1 + 1 + 1;
//         break :make_five five;
//     };
//
// Labels can also be used with loops. Being able to break out of
// 标签也可以用于循环。能够在特定级别跳出
// nested loops at a specific level is one of those things that
// 嵌套循环是那些你不会每天使用的东西之一，
// you won't use every day, but when the time comes, it's
// 但当时机到来时，它
// incredibly convenient. Being able to return a value from an
// 非常方便。能够从内部循环返回一个值
// inner loop is sometimes so handy, it almost feels like cheating
// 有时如此便利，几乎感觉像作弊
// (and can help you avoid creating a lot of temporary variables).
// （并且可以帮助你避免创建大量临时变量）。
//
//     const bar: u8 = two_loop: while (true) {
//         while (true) {
//             break :two_loop 2;
//         }
//     } else 0;
//
// In the above example, the break exits from the outer loop
// 在上面的例子中，break从标记为"two_loop"的外部循环
// labeled "two_loop" and returns the value 2. The else clause is
// 退出并返回值2。else子句附加到外部two_loop，
// attached to the outer two_loop and would be evaluated if the
// 如果循环以某种方式结束而没有调用break，
// loop somehow ended without the break having been called.
// 则会被评估。
//
// Finally, you can also use block labels with the 'continue'
// 最后，你也可以将块标签与'continue'语句一起使用：
// statement:
//
//     my_while: while (true) {
//         continue :my_while;
//     }
//
const print = @import("std").debug.print;

// As mentioned before, we'll soon understand why these two
// 如前所述，我们很快就会理解为什么这两个
// numbers don't need explicit types. Hang in there!
// 数字不需要显式类型。坚持住！
const ingredients = 4;
const foods = 4;

const Food = struct {
    name: []const u8,
    requires: [ingredients]bool,
};

//                 Chili  Macaroni  Tomato Sauce  Cheese
//                 辣椒   通心粉     番茄酱       奶酪
// ------------------------------------------------------
//  Mac & Cheese              x                     x
//  Mac & Cheese              x                     x
//  Chili Mac        x        x
//  Chili Mac        x        x
//  Pasta                     x          x
//  Pasta                     x          x
//  Cheesy Chili     x                              x
//  Cheesy Chili     x                              x
// ------------------------------------------------------

const menu: [foods]Food = [_]Food{
    Food{
        .name = "Mac & Cheese",
        .requires = [ingredients]bool{ false, true, false, true },
    },
    Food{
        .name = "Chili Mac",
        .requires = [ingredients]bool{ true, true, false, false },
    },
    Food{
        .name = "Pasta",
        .requires = [ingredients]bool{ false, true, true, false },
    },
    Food{
        .name = "Cheesy Chili",
        .requires = [ingredients]bool{ true, false, false, true },
    },
};

pub fn main() void {
    // Welcome to Cafeteria USA! Choose your favorite ingredients
    // 欢迎来到美国自助餐厅！选择你最喜欢的食材，
    // and we'll produce a delicious meal.
    // 我们将制作美味的餐点。
    //
    // Cafeteria Customer Note: Not all ingredient combinations
    // 自助餐厅顾客须知：不是所有的食材组合
    // make a meal. The default meal is macaroni and cheese.
    // 都能做成餐点。默认餐点是通心粉奶酪。
    //
    // Software Developer Note: Hard-coding the ingredient
    // 软件开发者须知：硬编码食材
    // numbers (based on array position) will be fine for our
    // 编号（基于数组位置）对我们的
    // tiny example, but it would be downright criminal in a real
    // 小例子来说是可以的，但在真实应用中这将是
    // application!
    // 彻头彻尾的犯罪！
    const wanted_ingredients = [_]u8{ 0, 3 }; // Chili, Cheese
    // 辣椒，奶酪

    // Look at each Food on the menu...
    // 查看菜单上的每种食物...
    const meal = food_loop: for (menu) |food| {

        // Now look at each required ingredient for the Food...
        for (food.requires, 0..) |required, required_ingredient| {

            // This ingredient isn't required, so skip it.
            if (!required) continue;

            // See if the customer wanted this ingredient.
            // (Remember that want_it will be the index number of
            // the ingredient based on its position in the
            // required ingredient list for each food.)
            const found = for (wanted_ingredients) |want_it| {
                if (required_ingredient == want_it) break true;
            } else false;

            // We did not find this required ingredient, so we
            // can't make this Food. Continue the outer loop.
            if (!found) continue :food_loop;
        }

        // If we get this far, the required ingredients were all
        // wanted for this Food.
        //
        // Please return this Food from the loop.
        break;
    };
    // ^ Oops! We forgot to return Mac & Cheese as the default
    // Food when the requested ingredients aren't found.

    print("Enjoy your {s}!\n", .{meal.name});
}

// Challenge: You can also do away with the 'found' variable in
// the inner loop. See if you can figure out how to do that!
