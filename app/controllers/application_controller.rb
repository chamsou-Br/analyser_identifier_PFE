class ApplicationController < ActionController::Base

    def get_class_info(ast)
        extractor = ASTExtractorHelper.new
        extractor.process(ast)
        class_name = extractor.class_name || extractor.module_name
        [class_name, extractor.methods_list , extractor.called_methods , extractor.module_name , extractor.receivers , extractor.variables ]
    end




end
