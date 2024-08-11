const std = @import("std");

fn Panick(msg : []const u8) !void {
    @panic(msg);
}

fn Allocator() !void {
    return struct {

    };
}



fn KeyValuePair(comptime KeyType: type, comptime ValueType: type, _Key: KeyType, _Value: ValueType) type {
    return struct {
        
        var Key: KeyType = _Key;
        var Value: ValueType = _Value;
    };
}
fn KeyValuePairNull(comptime KeyType: type, comptime ValueType: type) type {
    return struct {
        var int: u256 = 0;
        var Key: KeyType = null;
        var Value: ValueType = null;
    };
}

const Algorithm = enum(u32) {
    SHA512 = 512,
    SHA256 = 256,
    SHA128 = 128,
};
fn AlgorithmType(_Algorithm: Algorithm) type { 
    switch (_Algorithm) {
        (Algorithm.SHA128) => {return u128;},
        (Algorithm.SHA256) => {return u256;},
        (Algorithm.SHA512) => {return u512;},
        else => {
            Panick("Algorithm Not Contained in Algorithm Enum");
        }
    }
}

fn Hash(Value: anytype, comptime _Algorithm: Algorithm) AlgorithmType(_Algorithm) {
    _ = Value;
}

fn FastMap(_Allocator: *Allocator, comptime _Algorithm: Algorithm, comptime KeyType: type, comptime ValueType: type) type {
    _ = _Allocator;
    return struct {
        var Values = @Vector((2^_Algorithm)/1000, KeyValuePairNull(KeyType, ValueType));
    };
}

fn UpdateMapKey(fm: FastMap) void {
    _ = fm;
}

test "CreateFastMapObject" {
    var FM = FastMap(Allocator(), Algorithm.SHA128, u128, u32);
    std.debug.print("{}", .{FM.GetValue(0)});
    
}