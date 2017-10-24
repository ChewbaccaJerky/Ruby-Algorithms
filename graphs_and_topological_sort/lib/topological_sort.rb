require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms
require 'byebug'
def topological_sort(vertices)
  sorted = []
  top = []

  vertices.each do |vert|
    top.push(vert) if vert.in_edges.empty?
  end

  until top.empty?
    curr = top.pop
    sorted << curr

    curr.out_edges.each do |edge|
      # puts edge.to_vertex.value

      if edge.from_vertex == curr
        top << edge.to_vertex
      end
      edge.destroy!
    end
  end

  # handles cyclic
  return [] if sorted.length > vertices.length
  # print vertices.map {|vert| vert.in_edges.length}
  # puts ""
  # print sorted.map {|vert| vert.in_edges.length}
  sorted
end
