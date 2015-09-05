require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count

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
      link = @map[key]
      update_link!(link)
      return link.val
    else
      val = calc!(key)
      eject! if count > @max
      val
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    val = @prc.call(key)
    link = @store.unshift(Link.new(key, val))
    @map[key] = link
    val
  end

  def update_link!(link)
    @store.remove(link.key)
    @store.unshift(link)
  end

  def eject!
    key = @store.last.key
    #@store.remove(key)
    @store.remove_last
    @map.delete(key)
  end
end
