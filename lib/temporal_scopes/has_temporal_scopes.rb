require 'active_record'

module TemporalScopes
  module HasTemporalScopes
    
    def has_temporal_scopes
      
      scope :without_temporal_condition, -> { 
        relation = unscope(where: [:valid_from, :valid_to]) 
        relation.where_values.delete_if { |query| query.to_sql.include?("\"valid_from\"") || query.to_sql.include?("\"valid_to\"") }
        relation
      }
      
      scope :now, -> { 
        without_temporal_condition
        .where(arel_table[:valid_from].eq(nil).or(arel_table[:valid_from].lteq(Time.zone.now)))
        .where(arel_table[:valid_to].eq(nil).or(arel_table[:valid_to].gteq(Time.zone.now)))
      }
      scope :past, -> { without_temporal_condition.where('valid_to < ?', Time.zone.now) }
      scope :with_past, -> { without_temporal_condition }
      
      default_scope { now }
      
      extend ClassMethods
      include InstanceMethods
    end
    
    module ClassMethods
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