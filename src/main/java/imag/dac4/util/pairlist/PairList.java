package imag.dac4.util.pairlist;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * @author Ribesg
 */
public class PairList<K, V> implements Iterable<Pair<K, V>> {

    private final List<Pair<K, V>> pairList;

    public PairList() {
        this.pairList = new ArrayList<>();
    }

    public Iterator<Pair<K, V>> iterator() {
        return this.pairList.iterator();
    }

    public void clear() {
        this.pairList.clear();
    }

    public int size() {
        return this.pairList.size();
    }

    public boolean isEmpty() {
        return this.pairList.isEmpty();
    }

    public void put(final K key, final V value) {
        this.pairList.add(new Pair<>(key, value));
    }

    public Pair<K, V> get(final int index) {
        return this.pairList.get(index);
    }

    public K getKey(final int index) {
        return this.get(index).getKey();
    }

    public V getValue(final int index) {
        return this.get(index).getValue();
    }
}
