import Hash "mo:base/Hash";
import Iter "mo:base/Iter";
import Map "../src/Map";
import Nat "mo:base/Nat";
import O "../src/Order";
import Text "mo:base/Text";

do {
    let m = Map.SortedMap<Nat, Text>(
        0, Nat.equal, Hash.hash,
        O.Descending(Nat.compare),
    );
    m.insert(1, "a");
    m.insert(0, "b");
    m.insert(2, "c");
    assert(Iter.toArray(m.entries()) == [(2, "c"), (1, "a"), (0, "b")]);
    assert(m.delete(1) == ?(1, "a"));
    assert(Iter.toArray(m.entries()) == [(2, "c"), (0, "b")]);
};

do {
    let m = Map.SortedValueMap<Nat, Text>(
        0, Nat.equal, Hash.hash,
        O.Ascending(Text.compare),
    );
    m.insert(1, "a");
    m.insert(0, "b");
    m.insert(2, "c");
    assert(Iter.toArray(m.entries()) == [(1, "a"), (0, "b"), (2, "c")]);
    assert(m.delete(0) == ?(0, "b"));
    assert(Iter.toArray(m.entries()) == [(1, "a"), (2, "c")]);
};
