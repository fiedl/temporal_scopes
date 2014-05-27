require 'active_record'

module TemporalScopes
  module HasTemporalScopes
    
    # Adds scopes and methods for handing temporal filtering.
    # 
    # ## Make an `ActiveRecord` have temporal scopes
    #
    #     class Article < ActiveRecord::Base
    #       has_temporal_scopes
    #       
    #     end
    # 
    # ## Archive an object
    # 
    #     current_article = Article.create(title: 'My new article', body: 'Lorem ipsum')
    #     
    #     past_article = Article.create(title: 'My new article', body: 'Lorem ipsum')
    #     past_article.archive
    #     
    #     # or provide a datetime:
    #     past_article.archive at: 1.hour.ago
    # 
    # ## Use temporal scopes for filtering
    # 
    #     Article.now                          #  => [current_article]
    #     Article.past                         #  => [past_article]
    #     Article.with_past                    #  => [current_article, past_article]
    # 
    # Note that the **default scope** is set to `now`.
    # 
    #     Article.all                          #  => [current_article]
    #     Article.now                          #  => [current_article]
    #     Article.with_past                    #  => [current_article, past_article]
    #     Article.without_temporal_condition   #  => [current_article, past_article]
    #
    def has_temporal_scopes
      
      default_scope { now }
      
      extend ClassMethods
      include InstanceMethods
    end
    
    module ClassMethods

      # Removes temporal conditions from the query.
      #
      # @example
      #     Article.where(valid_to: 10.days.ago..1.day.ago)                             # => []  (due to default scope.)
      #     Article.without_temporal_condition.where(valid_to: 10.days.ago..1.day.ago)  # returns the desired articles.
      #
      # @return [ActiveRecord::Relation] the relation without temporal conditions on `valid_from` and `valid_to`.
      #
      def without_temporal_condition
        relation = unscope(where: [:valid_from, :valid_to]) 
        relation.where_values.delete_if { |query| query.to_sql.include?("\"valid_from\"") || query.to_sql.include?("\"valid_to\"") }
        relation
      end

      # Filters for only current objects.
      #
      # This is the default scope.
      #
      # @return [ActiveRecord::Relation] only current objects.
      #
      def now
        without_temporal_condition
        .where(arel_table[:valid_from].eq(nil).or(arel_table[:valid_from].lteq(Time.zone.now)))
        .where(arel_table[:valid_to].eq(nil).or(arel_table[:valid_to].gteq(Time.zone.now)))
      end
      
      def past
        without_temporal_condition.where('valid_to < ?', Time.zone.now)
      end
      
      def with_past
        without_temporal_condition
      end

    end
    
    module InstanceMethods
      
      def archive(params = {})
        unless self.valid_to
          archive_at = params[:at] || Time.zone.now
          update_attribute(:valid_to, archive_at)
        end
      end

    end

  end
end

ActiveRecord::Base.send(:extend, TemporalScopes::HasTemporalScopes)