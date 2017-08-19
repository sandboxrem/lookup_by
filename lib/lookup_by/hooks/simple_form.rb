require "active_support/concern"

module LookupBy
  module Hooks
    module SimpleForm
      extend ActiveSupport::Concern

      def input(method, options = {}, &block)
        klass = object.class

        if klass.respond_to?(:lookups) && klass.lookups.include?(method.to_sym)
          target = method.to_s.classify.constantize

          options[:collection] ||= target.pluck(target.lookup.field) if target.lookup.has_cache?
        end
      end
    end
  end
end

::SimpleForm::FormBuilder.send :prepend, LookupBy::Hooks::SimpleForm
