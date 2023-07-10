# frozen_string_literal: true

# The best_in_place gem, which we use for in-place editing, allows formatters ("display methods")
# that are applied to the values of in-place editing field. For example, we use a markdown formatter
# for certain textareas.
#
# Unfortunately, the formatter definitions are stored in a class variable by the gem, which is not
# shared between the unicorn worker instances of the application. Therefore, it is not ensured
# that all display methods required are loaded by the worker that responds to the ajax request
# of `respond_with_bip` in the controller.
#
# This initializer circumvents this problem by defining all needed definitions by hand in order to
# ensure that all worker instances have the same definitions.
#
# See also this issue on github:
# https://github.com/bernat/best_in_place/issues/321
#
# The following `BestInPlace::DisplayMethods` are defined here:
# https://github.com/bernat/best_in_place/blob/master/lib/best_in_place/display_methods.rb
#

# This calls a helper method `render_for_html(str)`.
#

# This file has to be initialized after initializers/devise,rb
# Otherwise there will be an error on adding helper methods for User model

# BestInPlace::DisplayMethods.add_helper_method(Document, :title, :render_for_html)
# BestInPlace::DisplayMethods.add_helper_method(Document, :reference, :render_for_html)
# BestInPlace::DisplayMethods.add_helper_method(Document, :purpose, :render_for_html)
# BestInPlace::DisplayMethods.add_helper_method(Document, :domain, :render_for_html)
# BestInPlace::DisplayMethods.add_helper_method(Document, :news, :render_for_html)
# BestInPlace::DisplayMethods.add_helper_method(Document, :custom_print_footer, :render_for_html)

# BestInPlace::DisplayMethods.add_helper_method(Graph, :title, :render_for_html)
# BestInPlace::DisplayMethods.add_helper_method(Graph, :reference, :render_for_html)
# BestInPlace::DisplayMethods.add_helper_method(Graph, :purpose, :render_for_html)
# BestInPlace::DisplayMethods.add_helper_method(Graph, :domain, :render_for_html)
# BestInPlace::DisplayMethods.add_helper_method(Graph, :news, :render_for_html)
# BestInPlace::DisplayMethods.add_helper_method(Graph, :custom_print_footer, :render_for_html)

# BestInPlace::DisplayMethods.add_helper_method(Resource, :title, :render_for_html)
# BestInPlace::DisplayMethods.add_helper_method(Resource, :resource_type, :render_for_html)
# BestInPlace::DisplayMethods.add_helper_method(Resource, :purpose, :render_for_html)

# BestInPlace::DisplayMethods.add_helper_method(Role, :title, :render_for_html)
# BestInPlace::DisplayMethods.add_helper_method(Role, :purpose, :render_for_html)
# BestInPlace::DisplayMethods.add_helper_method(Role, :mission, :render_for_html)
# BestInPlace::DisplayMethods.add_helper_method(Role, :activities, :render_for_html)

# BestInPlace::DisplayMethods.add_helper_method(Group, :description, :render_for_html)

# BestInPlace::DisplayMethods.add_helper_method(User, :lastname, :render_for_html)
# BestInPlace::DisplayMethods.add_helper_method(User, :firstname, :render_for_html)
# BestInPlace::DisplayMethods.add_helper_method(User, :language, :render_for_html)
# BestInPlace::DisplayMethods.add_helper_method(User, :phone, :render_for_html)
# BestInPlace::DisplayMethods.add_helper_method(User, :mobile_phone, :render_for_html)
# BestInPlace::DisplayMethods.add_helper_method(User, :function, :render_for_html)
# BestInPlace::DisplayMethods.add_helper_method(User, :service, :render_for_html)
# BestInPlace::DisplayMethods.add_model_method(User, :supervisor_id, :display_supervisor_name)
