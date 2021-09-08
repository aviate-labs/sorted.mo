import Hash "mo:base/Hash";
import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";

import O "Order";
import SList "List";

module {
    public class SortedMap<K,V>(
        capacity : Nat,
        equal    : (K, K) -> Bool,
        hash     : (K) -> Hash.Hash,
        order    : O.Order<K>,
    ) {
        let map = HashMap.HashMap<K,V>(
            capacity, equal, hash,
        );
        var keys : SList.SortedList<K> = null;

        public func insert(k : K, v : V) {
            map.put(k, v);
            keys := SList.insert(keys, k, order);
        };

        public func delete(k : K) : ?(K, V) {
            switch (map.get(k)) {
                case (null) { null; };
                case (? v)  {
                    map.delete(k);
                    let (_, keys_) = SList.delete(keys, k, equal);
                    keys := keys_;
                    ?(k, v);
                };
            };
        };

        public func entries() : Iter.Iter<(K, V)> = object {
            var xs = keys;
            public func next() : ?(K, V) {
                switch (xs) {
                    case (null) { null; };
                    case (? (y, ys)) {
                        xs := ys;
                        switch (map.get(y)) {
                            case (null) { null; };
                            case (? v)  {
                                ?(y, v);
                            };
                        };
                    };
                };
            };
        };
    };
};
