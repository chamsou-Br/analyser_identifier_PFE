class ClusterEngine


    def self.get_microservices(dependencies , alpha = 0.5 , beta = 0.5 , app = "" , microservice_file = "./output/clusters")

      puts "\n\n ms folder => #{app} \n\n"
      if (!app.include?("pyx4")) 
        dendro = self.herarchical_clusering(dependencies , alpha , beta)
        msa = self.identify_msa_condidates(dependencies , dendro , alpha , beta)
        File.open(microservice_file + ".dot", "w") do |file|
          file.puts "digraph Microservices {" 
          msa.each do |microservice|
            file.puts "  subgraph #{microservice.name}_microservice {"
            microservice.class_names.each do |class_name|
              file.puts "    #{class_name};"
            end
            file.puts "  }"
          end
          file.puts "}"     
        end
        return msa
      else
        if (alpha >= 0.5) 
          n =  alpha * 10
        elsif 
          n = 1 + alpha * 20
        end
        return msa_condidate_with_data_cohesion(dependencies , alpha , beta , n)
      end

    end

    def self.herarchical_clusering(dependencies , alpha , beta)
        sartifacts = dependencies.graph.keys  # Array of artifacts extracted from code
        s_clusters = []   # Array of clusters of artifacts
        dendro = []
        
        # Step 2: Create a cluster for each artifact
        sartifacts.each_with_index do |class_name, index|
          cluster_name = "Cluster#{index + 1}"  
          cluster = Cluster.new(cluster_name, [class_name])  
          s_clusters << cluster
        end
      
        dendro << s_clusters
        count = s_clusters.length
        
        # Step 3: Merge clusters until only one cluster remains
        while s_clusters.size > 1
          count +=1
          # Step 4: Find closest pair of clusters based on FQuality(MS)
          cluster1, cluster2 = find_closest_pair(s_clusters , count , dependencies , alpha , beta)
          new_clusters = s_clusters.reject { |cluster| cluster == cluster1 || cluster == cluster2 }
          new_cluster = Cluster.new("Cluster#{count}" , cluster1.class_names + cluster2.class_names)
          new_clusters << new_cluster
          s_clusters = new_clusters
          dendro << s_clusters
        end
        
        return dendro
    end

    
def self.identify_msa_condidates(dependencies, dendro , alpha , beta)
    stack_clusters = []
    stack_clusters.push({
        index: dendro.length - 1,
        cluster: dendro[dendro.length - 1][0]
    })
  
    msa = []
  
    while stack_clusters.size > 0
      cluster_parent = stack_clusters.pop
  
      if cluster_parent[:index] == 0 || cluster_parent[:cluster].class_names.length == 1
        puts " #{cluster_parent[:cluster].name} --- score ---> 0.99"
        puts "--------------------------------------\n\n\n"
        msa << cluster_parent[:cluster]
      else
        child1, child2 = get_children_of_cluster(dendro , cluster_parent)
        s_new_clusters = [] 
        s_new_clusters << child1[:cluster] 
        s_new_clusters << child2[:cluster]
        s_old_clusters = [] 
        s_old_clusters << cluster_parent[:cluster]
        for i in 0..(stack_clusters.length-1)
            s_new_clusters << stack_clusters[i][:cluster]
            s_old_clusters << stack_clusters[i][:cluster]
        end
  
       if ( ( get_score_quality_of_all_ms(dependencies , s_new_clusters , child1[:cluster] , alpha , beta) + get_score_quality_of_all_ms(dependencies , s_new_clusters , child2[:cluster] , alpha , beta )  ) / 2 >=  get_score_quality_of_all_ms(dependencies , s_old_clusters , cluster_parent[:cluster] , alpha , beta ) )
          stack_clusters.push(child1)
          stack_clusters.push(child2)
        else
          puts " #{cluster_parent[:cluster].name} --- score ---> #{get_score_quality_of_all_ms(dependencies , s_old_clusters , cluster_parent[:cluster] , alpha , beta )}"
          puts "--------------------------------------\n\n\n"
          msa << cluster_parent[:cluster]
        end
      end
    end
    msa
  end

  def self.get_score_quality_of_all_ms(dependencies , clusters , cluster ,alpha , beta)
    ca = dependencies.get_intra_dependencies_of_all_ms(clusters)    
    ce = dependencies.get_inter_dependencies_of_all_ms(clusters) + 1.0e-10
    data_cohesion = dependencies.get_data_cohesion_of_ms(cluster)
    score = ( alpha * ca.to_f / ( ce + ca ) ) + (beta * data_cohesion) 
    return score
  end

  def self.get_score_quality_of_all_ms_cohesion(dependencies , clusters , cluster ,alpha , beta)
    ca = dependencies.get_intra_dependencies_of_all_ms(clusters)    
    ce = dependencies.get_inter_dependencies_of_all_ms(clusters) + 1.0e-10
    data_cohesion = dependencies.get_data_cohesion_of_ms_cohesion(cluster)
    score = ( alpha * ca.to_f / ( ce + ca ) ) + ( (data_cohesion > 0.7 ? beta : 1) * data_cohesion) 
    return score
  end

    def self.get_children_of_cluster(dendro , cluster_parent)
        children = []
        index  = cluster_parent[:index] - 1
        find = false
        while (index >= 0  && find == false )
          clusters = dendro[index]
          clusters.combination(2) do |child1, child2|
            if (child1.class_names + child2.class_names == cluster_parent[:cluster].class_names)
              children = [{index: cluster_parent[:index] - 1 ,  cluster: child1 } , {index: cluster_parent[:index] - 1 , cluster: child2} ]
              find = true
              break  
            end
          end
          index = index - 1
        end
      
        children
      end

    def self.find_closest_pair(clusters , index , dependencies , alpha , beta) 

        best_score = -Float::INFINITY
        best_clusters = nil
        clusters.combination(2) do |cluster1, cluster2|
        new_clusters = clusters.reject { |cluster| cluster == cluster1 || cluster == cluster2 }
        new_cluster = Cluster.new("Cluster#{index}" , cluster1.class_names + cluster2.class_names)
        new_clusters << new_cluster
        score = get_score_quality_of_all_ms(dependencies , new_clusters , new_cluster , alpha , beta)
        if score > best_score
            best_score = score
            best_clusters = [cluster1 , cluster2]
        end
        end
        best_clusters
    end

    def self.msa_condidate_with_data_cohesion(depend , alpha = 0.5 , beta = 0.5 , n = 9 , microservice_file = "./output/clusters")
        data_entity_counts = Hash.new(0)
        not_needed_data_entity = ["Color","Groupgraph","Groupdocument","Audit","Event","Group"]
        # Parcourir chaque microservice et compter le nombre d'occurrences de chaque data entity
        data_dependence = depend.data_count
        data_dependence.dup.each do |class_name, data_entities|
          data_entities.each do |data , count|
            if (!not_needed_data_entity.include?(data))
                data_entity_counts[data] += count
            end
          end
        end
      

        # Sélectionner les n data entities les plus utilisées
        top_data_entities = data_entity_counts.sort_by { |data_entity, count| -count }.take(n).to_h

        # selectioner les microservices
        microservices = Hash.new { |hash, key| hash[key] = [] } 
        data_dependence.each do |class_name, data_entity_count|
          most_used_data_entity =  "" 
          score = 0 ; 
          top_data_entities.each_key do |top_data| 
            if (data_entity_count[top_data]) 
            end 
            if (data_entity_count[top_data] && data_entity_count[top_data] > score )
              score = data_entity_count[top_data]
              most_used_data_entity = top_data
            end
          end
          if (most_used_data_entity != "" ) 
            microservices[most_used_data_entity] << class_name
          end     
        end
        return getClassesOfMs(depend,microservices,alpha , beta)
        
      end

    def self.getClassesOfMs (depend , microservices , alpha = 0.5 , beta = 0.5 , ms_classes_file = "./output/clusters") 

        ms_candidates = []
        clusters = []
        File.open(ms_classes_file + ".dot", "w") do |file|
          file.puts "digraph Microservices {" 
          # Iterate over each key-value pair in the hash
          ms_num = 1
          microservices.each_key do |microservice|
            file.puts "  subgraph microservice_#{ms_num} {"
            ms_num = ms_num + 1
            class_dependeces =  []
            ms_condidate = {name: "Cluster#{ms_num}" , class_names: [] }
            microservices[microservice].each do |class_name|
              file.puts "    #{class_name};"
              ms_condidate[:class_names] << class_name
              # depend.graph[class_name].each do |class_name_depend, count|
              #   if (!class_name_depend.include?("Controller") && !class_dependeces.include?(class_name_depend))
              #     class_dependeces << class_name_depend
              #     ms_condidate[:class_names] << class_name_depend
              #   end
              # end
            end
            clusters << Cluster.new(ms_condidate[:name],ms_condidate[:class_names])
            ms_candidates << ms_condidate
            class_dependeces.each do |class_name_depend|
              file.puts "    #{class_name_depend};"
            end
            file.puts "  }"
          end
          file.puts "}"  
        end
        clusters.each do |cluster|
          puts "#{cluster.name} --- score ---> #{ get_score_quality_of_all_ms_cohesion(depend , clusters , cluster , alpha , beta )}"
        end
      return ms_candidates
    end    

end