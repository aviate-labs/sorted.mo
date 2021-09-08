import Hash "mo:base/Hash";
import Iter "mo:base/Iter";
import Map "../src/Map";
import Nat "mo:base/Nat";
import Order "../src/Order";

do {
    let m = Map.SortedMap<Nat, Text>(
        0, Nat.equal, Hash.hash,
        Order.Descending(Nat.compare),
    );
    m.insert(1, "a");
    m.insert(0, "b");
    m.insert(2, "c");
    assert(Iter.toArray(m.entries()) == [(2, "c"), (1, "a"), (0, "b")]);
    assert(m.delete(1) == ?(1, "a"));
    assert(Iter.toArray(m.entries()) == [(2, "c"), (0, "b")]);
};
