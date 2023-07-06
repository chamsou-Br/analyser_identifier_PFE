# frozen_string_literal: true

require "sidekiq/api"
# == Schema Information
#
# Table name: graphs
#
#  id                      :integer          not null, primary key
#  uid                     :string(255)
#  title                   :string(255)      not null
#  type                    :string(255)
#  level                   :integer
#  state                   :string(255)
#  reference               :string(255)
#  domain                  :text(65535)
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  version                 :string(255)
#  model_id                :integer
#  purpose                 :string(12000)
#  directory_id            :integer
#  customer_id             :integer
#  comment_index_int       :boolean          default(TRUE)
#  author_id               :integer
#  parent_id               :integer
#  news                    :string(765)
#  groupgraph_id           :integer
#  confidential            :boolean          default(FALSE)
#  svg                     :text(16777215)
#  pilot_id                :integer
#  tree                    :boolean          default(FALSE)
#  print_footer            :string(100)
#  read_confirm_reminds_at :datetime
#  graph_background_id     :integer
#  imported_package_id     :integer
#  imported_uid            :string(255)
#  imported_groupgraph_uid :string(255)
#
# Indexes
#
#  fk_graphs_groupgraph          (groupgraph_id)
#  index_graphs_on_author_id     (author_id)
#  index_graphs_on_customer_id   (customer_id)
#  index_graphs_on_directory_id  (directory_id)
#  index_graphs_on_level         (level)
#  index_graphs_on_model_id      (model_id)
#  index_graphs_on_parent_id     (parent_id)
#  index_graphs_on_pilot_id      (pilot_id)
#  index_graphs_on_reference     (reference)
#  index_graphs_on_state         (state)
#  index_graphs_on_title         (title)
#  index_graphs_on_updated_at    (updated_at)
#
class Graph < ApplicationRecord
  # include Contributable
  # Elasticsearch
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  # include SearchableGraph
  # TODO: create a state machine for graphs.
  # include Workflow
  # include GraphsHelper
  include Sanitizable
  # include Discussion::Discussable
  # include PrintableFooter
  # include EntityExporter

  include LinkableFieldable

  sanitize_fields :domain, :news, :print_footer, :purpose, :reference, :title

  # discussable_by :author, :contributors

  attr_accessor :confirm_read

  has_many :graphs_roles, dependent: :destroy
  has_many :roles, through: :graphs_roles

  belongs_to :model, optional: true

  has_many :elements, -> { order "zindex asc" }, dependent: :destroy
  has_many :arrows, dependent: :destroy
  has_many :lanes, dependent: :destroy

  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings

  has_many :favorites, as: :favorisable, dependent: :destroy

  belongs_to :directory, optional: true
  belongs_to :customer

  # @!attribute [rw] author
  #   @return [User]
  belongs_to :author, foreign_key: "author_id", class_name: "User"
  belongs_to :pilot, foreign_key: "pilot_id", class_name: "User", optional: true

  belongs_to :groupgraph, optional: true

  belongs_to :background,
             foreign_key: "graph_background_id",
             class_name: "GraphBackground",
             optional: true

  has_many :likers, through: :favorites, source: :user

  # Actors

  has_many :graphs_viewers, dependent: :destroy
  has_many :viewers, through: :graphs_viewers, source_type: "User"
  has_many :viewergroups, through: :graphs_viewers, source_type: "Group", source: :viewer
  has_many :viewerroles, through: :graphs_viewers, source_type: "Role", source: :viewer

  has_many :graphs_verifiers, dependent: :destroy
  has_many :verifiers, -> { where "graphs_verifiers.historized = ?", false }, through: :graphs_verifiers

  has_many :graphs_approvers, dependent: :destroy
  has_many :approvers, -> { where "graphs_approvers.historized = ?", false }, through: :graphs_approvers

  # @!attribute [rw] graph_publisher
  #   @return [GraphPublisher]
  has_one :graph_publisher, dependent: :destroy

  # @!attribute [rw] publisher
  #   @return [User]
  has_one :publisher, through: :graph_publisher

  has_many :graphs_logs, dependent: :destroy

  has_many :impactables_impacts, as: :impact, dependent: :destroy
  has_many :events, through: :impactables_impacts, source: :impactable, source_type: "Event"
  has_many :acts, through: :impactables_impacts, source: :impactable, source_type: "Act"
  has_many :risks, through: :impactables_impacts, source: :impactable, source_type: "Risk"

  has_many :read_confirmations, as: :process, dependent: :destroy

  has_many :graph_steps, dependent: :destroy

  # /Actors

  # FIXME: This `parent/child` semantic seems to be the way to do the
  #        versioning of graphs before `Groupgraph`s was introduced.
  #        This does not seem to be used anymore,
  has_one :child, class_name: "Graph", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Graph", optional: true

  self.inheritance_column = nil
  validates :level, inclusion: { in: [1, 2, 3] }
  validates :type, inclusion: { in: %w[process human environment] }
  validates :state, inclusion: {
    in: %w[new verificationInProgress approvalInProgress approved applicable deactivated archived]
  }
  validates :reference, presence: true,
                        uniqueness: { is: true, scope: %i[customer_id version] }

end
