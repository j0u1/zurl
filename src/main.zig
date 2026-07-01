const std = @import("std");
const log = std.log.scoped(.zurl);

pub fn main(init: std.process.Init) !void {
    const allocator = init.gpa;
    const io = init.io;
    const arena = init.arena.allocator();

    const args = try init.minimal.args.toSlice(arena);

    if (args.len < 2) {
        const name = if (args.len > 0) args[0] else "zurl";
        log.warn("Usage: {s} <url>", .{name});
        std.process.exit(1);
    }

    const url = args[1];

    var client = std.http.Client{ .allocator = allocator, .io = io };
    defer client.deinit();

    const res = client.fetch(.{ .location = .{ .url = url }, .method = .HEAD, .redirect_behavior = .init(10) }) catch |err| {
        log.err("Failed to get status: {s}", .{@errorName(err)});
        std.process.exit(1);
    };

    const code: u10 = @intFromEnum(res.status);
    const phrase = res.status.phrase() orelse "unknown";

    log.info("Status: {s} ({d})", .{ phrase, code });
}
