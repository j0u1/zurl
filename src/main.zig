const std = @import("std");

pub fn main(init: std.process.Init) !void {
    const allocator = init.gpa;
    const io = init.io;
    const arena = init.arena.allocator();

    const args = try init.minimal.args.toSlice(arena);

    if (args.len < 2) {
        std.debug.print("Usage: {s} <url>\n", .{args[0]});
        return;
    }

    const url = args[1];

    var client = std.http.Client{ .allocator = allocator, .io = io };
    defer client.deinit();

    const res = client.fetch(.{
        .location = .{ .url = url },
        .method = .GET,
    }) catch |err| {
        std.debug.print("Failed to get status: {s}\n", .{@errorName(err)});
        return;
    };

    const code: u10 = @intFromEnum(res.status);
    std.debug.print("Status: {s} ({d})\n", .{ @tagName(res.status), code });
}
