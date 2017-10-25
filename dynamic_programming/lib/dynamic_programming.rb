class DynamicProgramming

  def initialize
    @blair_cache = { 1 => 1, 2 => 2 }
    @frog_cache = {
      1 => [[1]],
      2 => [[1,1], [2]],
      3 => [[1,1,1], [1,2], [2,1], [3]]
    }
    @super_cache = {
      [1, 1] => [[1]],
      [2, 1] => [[1,1]],
      [2, 2] => [[1,1], [2]],
      [3, 1] => [[1,1,1]],
      [3, 2] => [[1,1,1],[1,2],[2,1]],
      [3, 3] => [[1,1,1], [1,2], [2,1], [3]]
    }
  end

  def blair_nums(n)
    return @blair_cache[n] if @blair_cache[n]

    ans = blair_nums(n - 1) + blair_nums(n - 2) + (2*(n - 2) + 1)
    @blair_cache[n] = ans
    ans
  end

  def frog_hops_bottom_up(n)
    cache = frog_cache_builder(n)
    cache[n]
  end

  def frog_cache_builder(n)
    cache = {
      1 => [[1]],
      2 => [[1,1], [2]],
      3 => [[1,1,1], [1,2], [2,1], [3]]
    }
    return cache if n <= 3

    # build the rest of cache
    (4..n).each do |i|
      ans = []
      (1..3).each do |j|
        #j = 1
        cache[i-j].each do |seq|
          pre = [j] + seq
          pos = seq + [j]
          ans << pre unless ans.include?(pre)
          ans << pos unless ans.include?(pos)
        end
      end
      cache[i] = ans
    end
    cache
  end

  def frog_hops_top_down(n)
    return @frog_cache[n] if @frog_cache[n]
    frog_hops_top_down_helper(n)
    @frog_cache[n]
  end

  def frog_hops_top_down_helper(n)
    return @frog_cache[n] if @frog_cache[n]
    @frog_cache[n] = [1,2,3].map{|leap| frog_hops_top_down_helper(n - leap).map{|hops| hops + [leap] }}.flatten(1)
  end

  def super_frog_cache_builder(n, k)
    super_frog_cache = {
      1 => [[1]]
    }
    (2..n).to_a.each{|step| super_frog_cache[step] = (1..[k, step - 1].min).map{|leap| super_frog_cache[step - leap].map{|hops| hops + [leap] }}.flatten(1) + (step <= k ? [[step]] : [])}
    super_frog_cache
  end

  def super_frog_hops(n, k)
    super_frog_cache_builder(n, k)[n]
  end

  def knapsack(weights, values, capacity)

  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)
    return 0 if capacity == 1
  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
