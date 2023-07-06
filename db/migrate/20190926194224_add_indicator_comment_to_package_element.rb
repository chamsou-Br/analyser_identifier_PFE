class AddIndicatorCommentToPackageElement < ActiveRecord::Migration[5.0]
  def change
    # This field is added because its equivalent in the elements table was
    # added for rennaissace developement. In the event that renaissance ever
    # makes it to production, we add it here to have creation of packages
    # functonal.
    #
    add_column :package_elements, :indicator_comment, :text
  end
end
