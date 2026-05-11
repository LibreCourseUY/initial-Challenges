const std = @import("std");
const common = @import("common.zig");

pub fn main(init: std.process.Init) !void {
    // Initialize the common module with the `io` implementation
    common.init(init.io);

    // Use the common module to write "Hello World" to stdout
    try common.writeString("Hello World\n");
}
