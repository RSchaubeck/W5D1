require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      # find node associated w/ key
      # my_node = @map[key.hash % @map.length].find { |node| node.key == key }
      my_node = @map[key]
      update_node!(my_node)
      my_node.val
    else
      calc!(key)
      eject! if count > @max
      @map[key].val
    end

  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
      val = @prc.call(key)
      @store.append(key, val)
      @map.set(key, @store.last)
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    node.remove
    tail = @store.last.next
    old_last = @store.last
    old_last.next = node
    node.prev = old_last
    node.next = tail
    tail.prev = node

    # @store.append(node.key, node.val)
  end

  def eject!
    lru = @store.first
    lru.remove
    @map.delete(lru.key)
  end
end
