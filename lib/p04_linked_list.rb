class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil, nxt = nil, prev = nil)
    @key, @val, @next, @prev = key, val, nxt, prev
  end

  def to_s
    "#{@key}, #{@val}"
  end
end

class LinkedList
  include Enumerable

  attr_reader :head

  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    pointer = @head
    until pointer.nil?
      return pointer.val if pointer.key == key
      pointer = pointer.next
    end

    nil
  end

  def get_link(key)
    pointer = @head
    until pointer.nil?
      return pointer if pointer.key == key
      pointer = pointer.next
    end

    nil
  end

  def include?(key)
    pointer = @head
    until pointer.nil?
      return true if pointer.key == key
      pointer = pointer.next
    end

    false
  end

  def insert(key, val)
    link = Link.new(key, val, @tail, @tail.prev)
    @tail.prev.next = link
    @tail.prev = link

    link
  end

  def unshift(link)
    link_next = @head.next
    @head.next = link
    link.prev = @head
    link.next = link_next

    link.next.prev = link

  end

  def remove(key)
    return nil unless include?(key)

    pointer = @head

    until pointer.next.key == key
      pointer = pointer.next
    end

    # if pointer.next == last
    #   @tail = pointer
    #   pointer.next = nil
    # else
    pointer.next = pointer.next.next
    pointer.next.prev = pointer
    #end
  end

  def remove_last
    @tail.prev = @tail.prev.prev
    @tail.prev.next = @tail
  end

  def each
    pointer = @head.next
    until pointer.nil?
      yield(pointer)
      pointer = pointer.next
    end

    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
