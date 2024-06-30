class ClustersController < ApplicationController

    skip_before_action :verify_authenticity_token
    
    def ms_identifiyer 

        folder_path =  params[:path]

        alpha = params[:alpha].to_f || 0.5

        beta = params[:beta].to_f || 0.5

        puts "=> #{folder_path} => #{alpha} => #{beta}"

        fileManager = FilesManager.new()

        classNodes = fileManager.generate_ast_parsers("#{folder_path}/services")

        dataNodes = fileManager.generate_ast_data_parser("#{folder_path}/data")

        @dependencies = DependencyAnalyzer.new(classNodes , dataNodes)

        clusters = ClusterEngine.get_microservices(@dependencies , alpha , beta , folder_path)

        render json: {clusters: clusters}

    end

end