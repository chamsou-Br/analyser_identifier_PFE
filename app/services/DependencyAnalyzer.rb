class DependencyAnalyzer

    attr_reader :graph , :data ,  :data_count , :classNodes , :dataNodes

    include Helpers 
    
    def initialize(classes , dataNodes)
      @classNodes = classes
      @dataNodes = dataNodes
      @graph = Hash.new { |hash, key| hash[key] = {} }
      @data = Hash.new { |hash, key| hash[key] = {} } 
      @data_count = Hash.new { |hash, key| hash[key] = {} } 
      classes.each do |classNode|
        @graph[classNode.class_name] = {}  
        @data[classNode.class_name] = []    
        @data_count[classNode.class_name] = {}
      end   
      generate_graph()
    end


  def generate_graph()

      not_needed_methods = ['send' ,'new', 'initialize', 'find', 'save', 'update', 'delete', 'destroy', 'join',
      'split', 'sort', 'length', 'size', 'count', 'get', 'set', 'include', 'is_a']

      @classNodes.each do |classNode|

        class_structure = {
          module: classNode.module_name,
          class: classNode.class_name,
          methods: format_calls_architecture(classNode)  , 
          receivers: classNode.data_entities
        }

        if (classNode.class_name.include?("Controller"))
          class_structure[:receivers].each do |receiver|
            @dataNodes.each do |dataNode|
              if (dataNode.class_name == receiver.to_s || to_muniscule_class_name(dataNode.class_name) == receiver.to_s || to_muniscule_plural_class_name(dataNode.class_name) == receiver.to_s ) 
                add_data(classNode.class_name, singularize( receiver.to_s))
              end
            end
          end
        end

        class_structure[:methods].each do |method|
          method[:called_methods].each do |called_method|
            if (!not_needed_methods.include?(called_method[:name].to_s))
              @classNodes.each do |class_node_depend|
                if class_node_depend.has_method?(called_method) 
                  add_dependency(classNode.class_name , class_node_depend.class_name)
                end
              end
            end
          end            
        end
      end

  end

  
    def add_dependency(classNode, classNodeDepend)
        if @graph[classNode][classNodeDepend] 
            @graph[classNode][classNodeDepend] += 1
        else 
            @graph[classNode][classNodeDepend] = 1
        end 
    end

  

    def get_intra_dependencies(classNode) 
        @graph[classNode.class_name][classNode.class_name] || 0
    end


    def get_inter_dependencies_of_class(classNode) 
      count = 0
      @graph[classNode.class_name].each_value do |dependency_count|
        count += dependency_count
      end
      if (@graph[classNode.class_name][classNode.class_name]) 
          count = count - @graph[class_name][class_name]
      end
      count      
    end


    def get_intra_dependencies_of_ms(cluster)
      count = 0
      cluster.class_names.each do |class_name|
        @graph[class_name].each do |key, value|
            if (cluster.class_names.include?(key) && key != class_name)
              count += value
            end
        end
      end
      return count
    end

    def get_intra_dependencies_of_all_ms(clusters)
      count = 0
      clusters.each do |cluster| 
        count += get_intra_dependencies_of_ms(cluster)
      end
      return count
    end

    def get_inter_dependencies_of_ms(clusters , new_cluster) 
      count = 0
      clusters.each do |cluster|
          cluster.class_names.each do |class_name_of_cluster| 
            @graph[class_name_of_cluster].each do |key, value|
              if ( (!new_cluster.class_names.include?(class_name_of_cluster) && new_cluster.class_names.include?(key) ) || (new_cluster.class_names.include?(class_name_of_cluster) && !new_cluster.class_names.include?(key) ) )
                count += value
              end
            end
          end
      end
      return count
    end

    def get_inter_dependencies_of_all_ms(clusters) 
      count = 0
      clusters.each do |cluster|
        cluster.class_names.each do |class_name_of_cluster| 
          @graph[class_name_of_cluster].each do |key, value|
            if (!cluster.class_names.include?(key))
              count += value
            end
          end
        end
    end
      return count
    end

    def get_data_cohesion_of_ms(cluster)
      if cluster.class_names.length == 1 
        return 1
      end
      f_data = 0
      cluster.class_names.combination(2) do |class1 , class2| 
        f_sim_data = ( @data[class1] & @data[class2] ).size / ( (@data[class1] | @data[class2] ).size  + 1.0e-10 )
        f_data += f_sim_data
      end
      f_data = f_data / ( cluster.class_names.size * (cluster.class_names.size - 1 ) / 2  + 1.0e-10)
      # if (f_data != 0 )
      #   puts "\n\n cluster #{cluster.class_names} => #{f_data}"
      # end
      f_data 
    end

    def get_essential_data_used_from_class(data)
      not_needed_data_entity = ["Color","Groupgraph","Groupdocument","Audit","Event","Group","Auditelement" , "Fieldvalue"] 
      filtered_data = data.reject { |key, _| not_needed_data_entity.include?(key) }

      # Step 2: Sort the remaining hash by the scores in descending order
      sorted_data = filtered_data.sort_by { |_, value| -value }.to_h

      # Step 3: Select the top 3 items if the length is greater than 3, otherwise return all items
      result = sorted_data.first(2).map(&:first)


      result
    end

    def get_data_cohesion_of_ms_cohesion(cluster)
      if cluster.class_names.length == 1 
        return 1
      end
      f_data = 0   
      cpt = 0
      cluster.class_names.combination(2) do |class1 , class2| 
        data1 = get_essential_data_used_from_class(@data_count[class1])
        data2 = get_essential_data_used_from_class(@data_count[class2])
        f_sim_data = ( data1 & data2 ).size / ( (data1 | data2 ).size  + 1.0e-10 )
        f_data += f_sim_data
        cpt +=1
      end
      f_data = f_data / ( cpt  + 1.0e-100)
      # if (f_data != 0 )
      #   puts "\n\n cluster #{cluster.class_names} => #{f_data}"
      # end
      f_data 
    end
  

    def add_data(class_name , data_entity)
      if (!@data[class_name].include?(data_entity)) 
          @data[class_name] << data_entity
      end
      if @data_count[class_name][data_entity] 
        @data_count[class_name][data_entity] += 1
      else 
        @data_count[class_name][data_entity] = 1
      end 
    end

  end
