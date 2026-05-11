/// This file contains common utilities / helper functions to use in the examples.
/// It is not meant to be a perfect abstraction, but rather a simple way to avoid repeating the same code.
/// If you are learning perhaps you will not understand some of the code here, but don't worry about it.
/// It is not important to understand how it works, has little to no logic inside, it is just a wrapper.
const std = @import("std");

/// Declarations for the output
var stdout_buffer: [256]u8 = undefined;
var stdout_file_writer: std.Io.File.Writer = undefined;
pub var writer: *std.Io.Writer = undefined;

/// Declarations for the input
var stdin_buffer: [256]u8 = undefined;
var stdin_file_reader: std.Io.File.Reader = undefined;
pub var reader: *std.Io.Reader = undefined;

/// Call this at the beginning of your main function. Use the `Juicy Main` to provide the `std.process.Init` argument to your main function,
/// and then call this function with the `io` field of it.
/// This will initialize the `writer` and `reader` variables, which are used by the other functions in this file to read and write to the console.
pub fn init(io: std.Io) void {
    stdout_file_writer = .init(.stdout(), io, &stdout_buffer);
    stdin_file_reader = .init(.stdin(), io, &stdin_buffer);

    writer = &stdout_file_writer.interface;
    reader = &stdin_file_reader.interface;
}

/// Probably not necessary but is here for completeness.
pub fn flush() !void {
    try writer.flush();
}

/// This writes a string to the standard output. If you want to output a formatted string, use `writeFormatted` instead.
pub fn writeString(s: []const u8) !void {
    try writer.writeAll(s);
    try flush();
}

/// This writes a formatted string to the standard output. If you want to output a simple string, use `writeString` instead.
pub fn writeFormatted(comptime format: []const u8, args: anytype) !void {
    try writer.print(format, args);
    try flush();
}

/// This reads a line of input from the standard input.
/// It returns `null` if there was an error reading the input or if no input was provided.
/// It doesn't distinguish between these two cases.
/// It doesn't trim the input.
pub fn readLine() !?[]const u8 {
    const line = reader.takeDelimiter('\n') catch {
        try writeString("Failed to read input. Please try again.\n");
        return null;
    } orelse {
        try writeString("No input provided. Please try again.\n");
        return null;
    };
    return line;
}

/// This reads a line of input from the standard input and tries to parse it as an integer.
/// It returns `null` if there was an error reading the input, if no input was provided, or if the input was not a valid integer.
/// It doesn't distinguish between these cases.
/// It uses only `u8` integers for simplicity, you can change to bigger integers if you want.
pub fn readInt() !?u8 {
    const line = try readLine() orelse return null;
    const num = std.fmt.parseInt(u8, line, 10) catch {
        try writeString("Invalid input. Please enter a valid number.\n");
        return null;
    };
    return num;
}
