class Node
    attr_accessor :value, :children, :parent, :euclidean_distance
    def initialize(value=nil)
        @value = value
        @children = []
        @parent = nil
        @euclidean_distance = nil
    end
end

class Knight_travails
    attr_accessor :start_position, :end_position, :shorter_path, :queue_of_nodes
    def initialize(array)
        @start_position = Node.new(array[0])
        @end_position = array[1]
        @shorter_path = []
        @queue_of_nodes = []
    end

    def generate_tree_of_knight_movements (node=@start_position, movements=0)
        return "You are already on the end position" if @start_position.value == @end_position 
        movements += 1
        if node.value == @end_position
            refresh_shorter_path(node)
        elsif @shorter_path.length == 0 || movements < @shorter_path.length
            node.children = node.children + [Node.new([node.value[0]+2, node.value[1]+1])] if node.value[0]+2 <= 8 && node.value[1]+1 <= 8 && is_node_in_tree?([node.value[0]+2, node.value[1]+1]) == false
            node.children = node.children + [Node.new([node.value[0]+2, node.value[1]-1])] if node.value[0]+2 <= 8 && node.value[1]-1 >= 1 && is_node_in_tree?([node.value[0]+2, node.value[1]-1]) == false
            node.children = node.children + [Node.new([node.value[0]-2, node.value[1]+1])] if node.value[0]-2 >= 1 && node.value[1]+1 <= 8 && is_node_in_tree?([node.value[0]-2, node.value[1]+1]) == false
            node.children = node.children + [Node.new([node.value[0]-2, node.value[1]-1])] if node.value[0]-2 >= 1 && node.value[1]-1 >= 1 && is_node_in_tree?([node.value[0]-2, node.value[1]-1]) == false
            node.children = node.children + [Node.new([node.value[0]+1, node.value[1]+2])] if node.value[0]+1 <= 8 && node.value[1]+2 <= 8 && is_node_in_tree?([node.value[0]+1, node.value[1]+2]) == false
            node.children = node.children + [Node.new([node.value[0]+1, node.value[1]-2])] if node.value[0]+1 <= 8 && node.value[1]-2 >= 1 && is_node_in_tree?([node.value[0]+1, node.value[1]-2]) == false
            node.children = node.children + [Node.new([node.value[0]-1, node.value[1]+2])] if node.value[0]-1 >= 1 && node.value[1]+2 <= 8 && is_node_in_tree?([node.value[0]-1, node.value[1]+2]) == false
            node.children = node.children + [Node.new([node.value[0]-1, node.value[1]-2])] if node.value[0]-1 >= 1 && node.value[1]-2 >= 1 && is_node_in_tree?([node.value[0]-1, node.value[1]-2]) == false
            
            node.children.each do |child|
                child.parent = node
                child.euclidean_distance = claculate_euclidean_distance(child.value)
                @queue_of_nodes.push(child)
            end

            @queue_of_nodes.sort_by { |node| node.euclidean_distance}
            next_node_of_the_tree = @queue_of_nodes.shift()
            generate_tree_of_knight_movements(next_node_of_the_tree, movements)
        end
    end

    def is_node_in_tree?(value)
        queue = [@start_position]
        while queue.length > 0
            if queue[0].value == value
                return true
            else
                children_node = queue[0].children
                children_node.each { |node| queue.push(node)}
                queue.shift()
            end
        end
        false
    end

    def refresh_shorter_path(node)
        @shorter_path.unshift(node.value)
        if node.parent == nil
            return
        else
            refresh_shorter_path(node.parent)
        end
    end

    def claculate_euclidean_distance(array)
        return Math.sqrt((@end_position[0]-array[0])**2 + (@end_position[1]-array[1])**2)
    end
end

prueba = Knight_travails.new([[7, 1], [2, 7]])
prueba.generate_tree_of_knight_movements
p prueba.shorter_path