
require 'parser/current'

class AnalyzeController < ApplicationController
  

  skip_before_action :verify_authenticity_token

  include DotFile
  include FilesAccess

  def global 
    
  folder_path =  params[:path] + "/services"
  folder_data_path = params[:path] + "/data"
  
  def name_of_project(path)
    return path.split('/').last
  end

  def format_calls_architecture(methods_list , called_methods)
    calls_architecture = []

    methods_list.each do |calling_method|
      called_methods_list = called_methods[calling_method[:name]] || []
      formatted_method = {
        calling_method: calling_method[:name].to_s,
        called_methods: called_methods_list,
      }
      calls_architecture << formatted_method
    end
  
    return calls_architecture
  end
  
  def singularize(word)
    case word
    when /s$/
      # Remove the 's' at the end and lowercase the first letter
      word.chomp('s').capitalize
    else
      # Add more transformation rules if needed
      word
    end
  end


def getDataEntity(folder_data_path)
  
  files_list = getFilesFromFolder(folder_data_path) #return paths of all files inside a folder in addition to its children folders
  all_data = []

  for i in 0..(files_list.length-1)
      file_path = files_list[i]
      file_name = get_file_name(file_path) #return filename from the file path    
      source_code = File.read(files_list[i])    
      buffer = Parser::Source::Buffer.new(files_list[i]).tap do |buffer| 
            buffer.source = source_code
      end
    
      parser = Parser::CurrentRuby.new
    
      ast = parser.parse(buffer)

      extractor = ASTExtractorHelper.new
      extractor.process(ast)

      all_data << extractor.class_name.to_s

      all_data << extractor.class_name.downcase.to_s + "s"


  end
  all_data

end

def get_dependencies(folder_path)

 files_list = getFilesFromFolder(folder_path) #return paths of all files inside a folder in addition to its children folders
 all_methods = []
 class_of_all_methods = []
 all_dots = []


  for i in 0..(files_list.length-1)

      file_path = files_list[i]
      file_name = get_file_name(file_path) #return filename from the file path
    
      source_code = File.read(files_list[i])
    
      buffer = Parser::Source::Buffer.new(files_list[i]).tap do |buffer| 
            buffer.source = source_code
      end
    
      parser = Parser::CurrentRuby.new
    
      ast = parser.parse(buffer)
    
      File.write('./output/parse_ast.txt', ast)

      class_name, methods_list, called_methods , module_name , receivers , variables  = get_class_info(ast)

      methods_name = methods_list.map { |m| m[:name].to_sym}


    class_structure = {
      module: module_name,
      class: class_name,
      methods: format_calls_architecture(methods_list , called_methods )  , 
      receivers: receivers  ,
      variables: variables
    }

    methods_name.each do |calling_method| 
      class_of_all_methods << class_name.to_s
    end

    all_methods.concat(methods_list)

    all_dots << class_structure

  end

  [all_dots , all_methods , class_of_all_methods]
end


def get_results(folder_path , all_dots , all_methods , class_of_all_methods , data , dot_file_path = './output/call_graph' , dot_file_path_data = "./output/call_graph_data")

  
  files_list = getFilesFromFolder(folder_path)

  dot_file_content = []

  dot_file_data_content = []

  
  for i in 0..(all_dots.length-1)
  
  
      file_path = files_list[i]
      file_name = get_file_name(file_path)
  
      class_structure = all_dots[i]

      class_structure[:methods].each do |method|
        method[:called_methods].select! do |m|
            all_methods.any? { |am| am[:name] == m[:name] && am[:num_args] == m[:num_args] }
        end
      end


      dot_structure , _ , _ = geDotFileObject(class_structure , all_methods , class_of_all_methods , class_structure[:variables]) 

      dot_structure_data = geDotFileObjectForData(class_structure , data);

      dot_file_content << dot_structure

      dot_file_data_content << dot_structure_data

  
  end
  

  createDotFile(dot_file_content , "#{dot_file_path}_#{name_of_project(params[:path])}.dot" , true)

  
  system("dot -Tsvg ./output/call_graph_#{name_of_project(params[:path])}.dot -o ./output/call_graph_#{name_of_project(params[:path])}.svg")

  createDotFile(dot_file_data_content , "#{dot_file_path_data}.dot")
  
  system("dot -Tsvg #{dot_file_path_data}.dot -o #{dot_file_path_data}.svg")

  puts "\n\ file done => #{dot_file_path}.svg " 
  puts "\n\ file done => #{dot_file_path_data}.svg"
  
end
  
  
  
all_dots ,  all_methods  , class_of_all_methods = get_dependencies(folder_path)

data = getDataEntity(folder_data_path)

get_results(folder_path , all_dots , all_methods , class_of_all_methods , data)

render json: {callGraph: "/output/call_graph_#{name_of_project(params[:path])}" , callGraphData: "/output/call_graph_data"}

end




  def multiple 

  folder_path = params[:path]  + "/services"

def format_calls_architecture(methods_list , called_methods)
  calls_architecture = []

  methods_list.each do |calling_method|
    called_methods_list = called_methods[calling_method[:name]] || []
    formatted_method = {
      calling_method: calling_method[:name].to_s,
      called_methods: called_methods_list,
    }
    calls_architecture << formatted_method
  end

  return calls_architecture
end
  

  def geDotFileObjectMult(structure)
    desired_table = []
    dot_line = ""
  
    structure[:methods].each do |method|
        called_methods = method[:called_methods]
        calling_method = method[:calling_method]
  
        if (calling_method !~ /[\[\],]/) #if calling_method does not contain [ or ] or ,
          if (calling_method.include?("?"))
            calling_method.sub!("?", "")
          elsif (calling_method.include?("!"))
            calling_method.sub!("!", "")
          end
  
          if method[:called_methods].empty?
              dot_line = calling_method + ";"
              desired_table.push(dot_line)
          else
              called_methods.each do |called_method|
                  if (called_method[:name].include?("?"))
                    called_method[:name].sub!("?", "")
                      dot_line = calling_method + " -> " + called_method[:name] + ";"
                  elsif (called_method[:name].include?("!"))
                    called_method[:name].sub!("!", "")
                      dot_line = calling_method + " -> " + called_method[:name] + ";"
                  else
                      dot_line = calling_method + " -> " + called_method[:name] + ";"
                  end
                  desired_table.push(dot_line)
              end
          end
        end
  
      end
  
    return desired_table
  end


all_methods = []
all_dots = []
class_of_all_methods = []
  
files_list = getFilesFromFolder(folder_path) #return paths of all files inside a folder in addition to its children folders

for i in 0..(files_list.length-1)

  file_path = files_list[i]
  file_name = get_file_name(file_path) #return filename from the file path

  source_code = File.read(files_list[i])

  buffer = Parser::Source::Buffer.new(files_list[i]).tap do |buffer| 
        buffer.source = source_code
   end

  parser = Parser::CurrentRuby.new

  ast = parser.parse(buffer)

  File.write('./output/parse_ast.txt', ast)


  class_name, methods_list, called_methods , module_name , _ , variables = get_class_info(ast)

  class_structure = {
    module: module_name,
    class: class_name,
    methods: format_calls_architecture(methods_list , called_methods),
    variables: variables
  }

  all_methods.concat(methods_list)

  methods_name = methods_list.map { |m| m[:name].to_sym}

  methods_name.each do |calling_method| 
    class_of_all_methods << class_name.to_s
  end

  all_dots << class_structure

end

data_render = []
for i in 0..(all_dots.length-1)

    file_path = files_list[i]
    file_name = get_file_name(file_path)

    class_structure = all_dots[i]


    class_structure[:methods].each do |method|
      method[:called_methods].select! do |m|
          all_methods.any? { |am| am[:name] == m[:name] && am[:num_args] == m[:num_args] }
      end
    end

    class_render = {class_name: class_structure[:class] , methods: class_structure[:methods].map { |entry| entry[:calling_method] } , }


    dot_structure , intra , inter = geDotFileObject(class_structure , all_methods , class_of_all_methods , class_structure[:variables] , true) 

    class_render[:intradependences] = intra 
    class_render[:interdependences] = inter
    class_render[:filename] = "/output/callgraphs/#{class_structure[:class]}"

    createDotFile(dot_structure , "./output/callgraphs/#{class_structure[:class]}.dot",true)

    system("dot -Tsvg ./output/callgraphs/#{class_structure[:class]}.dot -o ./output/callgraphs/#{class_structure[:class]}.svg")

    data_render << class_render
end

    render json: {classes: data_render}

  end
  
end
