const std = @import("std");
const common = @import("common.zig");

pub fn main(init: std.process.Init) !void {
    common.init(init.io);

    try common.writeString("Enter a string to check if it's a palindrome: ");
    const input = try common.readLine() orelse return;

    const trimmed_input = std.mem.trim(u8, input, " \t\r\n");

    for (0..@divTrunc(trimmed_input.len, 2)) |i| {
        if (trimmed_input[i] != trimmed_input[trimmed_input.len - 1 - i]) {
            try common.writeString("The string is not a palindrome.\n");
            return;
        }
    }

    try common.writeString("The string is a palindrome.\n");
}
