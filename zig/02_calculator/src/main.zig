const std = @import("std");
const common = @import("common.zig");

pub fn main(init: std.process.Init) !void {
    common.init(init.io);

    try common.writeString(
        \\ ----------
        \\ Calculator
        \\ ----------
        \\ Available operations:
        \\ 1. Addition (+)
        \\ 2. Subtraction (-)
        \\ 3. Multiplication (*)
        \\ 4. Division (/)
        \\ Please enter your option (1-4):
    );

    try common.writeString("Enter your option (1-4): ");
    const option = try common.readInt() orelse return;

    // Check if the option is valid, if not we print an error message and return
    if (option < 1 or option > 4) {
        try common.writeString("Invalid option. Please enter a number between 1 and 4.\n");
        return;
    }

    try common.writeString("Enter the first number: ");
    const num1 = try common.readInt() orelse return;

    try common.writeString("Enter the second number: ");
    const num2 = try common.readInt() orelse return;

    const result: f64 = brk: {
        switch (option) {
            1 => break :brk num1 + num2,
            2 => break :brk num1 - num2,
            3 => break :brk num1 * num2,
            4 => {
                if (num2 == 0) {
                    try common.writeString("Error: Division by zero is not allowed.\n");
                    return;
                }
                break :brk @as(f64, @floatFromInt(num1)) / @as(f64, @floatFromInt(num2));
            },
            else => unreachable,
        }
    };

    try common.writeFormatted("Result: {d}\n", .{result});
}
