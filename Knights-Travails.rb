#Genera algún tipo de bucle infinito

class Node
    attr_accessor :value, :children, :parent
    def initialize(value=nil)
        @value = value
        @children = []
        @parent = nil
    end
end

class Knight_travails
    attr_accessor :start_position, :end_position, :shorter_path
    def initialize(array)
        @start_position = Node.new(array[0])
        @end_position = array[1]
        @shorter_path = []
    end

    def generate_tree_of_knight_movements (node=@start_position, movements=0)
        return "You are already on the end position" if @start_position.value == @end_position 
        movements += 1
        if node.value == @end_position
            refresh_shorter_path(node)
        elsif @shorter_path.length == 0 || movements < @shorter_path.length
            node.children = node.children + [Node.new([node.value[0]+2, node.value[1]+1])] if node.value[0]+2 <= 8 && node.value[1]+1 <= 8 && find_previous_move?(node, [node.value[0]+2, node.value[1]+1]) == false
            node.children = node.children + [Node.new([node.value[0]+2, node.value[1]-1])] if node.value[0]+2 <= 8 && node.value[1]-1 >= 1 && find_previous_move?(node, [node.value[0]+2, node.value[1]-1]) == false
            node.children = node.children + [Node.new([node.value[0]-2, node.value[1]+1])] if node.value[0]-2 >= 1 && node.value[1]+1 <= 8 && find_previous_move?(node, [node.value[0]-2, node.value[1]+1]) == false
            node.children = node.children + [Node.new([node.value[0]-2, node.value[1]-1])] if node.value[0]-2 >= 1 && node.value[1]-1 >= 1 && find_previous_move?(node, [node.value[0]-2, node.value[1]-1]) == false
            node.children = node.children + [Node.new([node.value[0]+1, node.value[1]+2])] if node.value[0]+1 <= 8 && node.value[1]+2 <= 8 && find_previous_move?(node, [node.value[0]+1, node.value[1]+2]) == false
            node.children = node.children + [Node.new([node.value[0]+1, node.value[1]-2])] if node.value[0]+1 <= 8 && node.value[1]-2 >= 1 && find_previous_move?(node, [node.value[0]+1, node.value[1]-2]) == false
            node.children = node.children + [Node.new([node.value[0]-1, node.value[1]+2])] if node.value[0]-1 >= 1 && node.value[1]+2 <= 8 && find_previous_move?(node, [node.value[0]-1, node.value[1]+2]) == false
            node.children = node.children + [Node.new([node.value[0]-1, node.value[1]-2])] if node.value[0]-1 >= 1 && node.value[1]-2 >= 1 && find_previous_move?(node, [node.value[0]-1, node.value[1]-2]) == false
            i = 0
            while i < node.children.length
                node.children[i].parent = node
                generate_tree_of_knight_movements(node.children[i], movements)
                i += 1
            end
        end
    end

    def find_previous_move?(node, value)
        if node.value == value
            true
        elsif node.parent != nil
            find_previous_move?(node.parent, value)
        else
            false
        end
    end

    def refresh_shorter_path(node)
        @shorter_path.unshift(node.value)
        if node.parent == nil
            return
        else
            refresh_shorter_path(node.parent)
        end
    end
end

prueba = Knight_travails.new([[4, 4], [8, 4]])
p prueba.start_position
p prueba.generate_tree_of_knight_movements
p prueba.shorter_path