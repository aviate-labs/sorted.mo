import Hash "mo:base-0.7.3/Hash";
import Iter "mo:base-0.7.3/Iter";
import Map "../src/Map";
import Nat32 "mo:base-0.7.3/Nat32";
import O "../src/Order";
import Text "mo:base-0.7.3/Text";

do {
    let m = Map.SortedMap<Nat32, Text>(
        0, Nat32.equal, func (n : Nat32) : Nat32 { n },
        O.Descending(Nat32.compare),
    );
    m.put(1, "a");
    m.put(0, "b");
    m.put(2, "c");
    assert(Iter.toArray(m.entries()) == [(2, "c"), (1, "a"), (0, "b")]);
    assert(m.remove(1) == ?(1, "a"));
    assert(Iter.toArray(m.entries()) == [(2, "c"), (0, "b")]);
    assert(m.remove(1) == null);

    assert(m.getIndexOf(1) == null);
    assert(m.getIndexOf(0) == ?1);
    assert(m.getKey(1) == ?0);
    assert(m.getValue(1) == ?"b");
};

do {
    let m = Map.SortedValueMap<Nat32, Text>(
        0, Nat32.equal, func (n : Nat32) : Nat32 { n },
        O.Ascending(Text.compare),
    );
    m.put(1, "a");
    m.put(0, "b");
    m.put(2, "c");
    assert(Iter.toArray(m.entries()) == [(1, "a"), (0, "b"), (2, "c")]);
    assert(m.remove(0) == ?(0, "b"));
    assert(Iter.toArray(m.entries()) == [(1, "a"), (2, "c")]);
    assert(m.remove(0) == null);

    assert(m.getIndexOf(0) == null);
    assert(m.getIndexOf(2) == ?1);
    assert(m.getKey(1) == ?2);
    assert(m.getValue(1) == ?"c");
};
