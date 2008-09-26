module BySite
  module ActMethods
    
    def by_site(options={})
      belongs_to :site
      
      before_validation :set_site
      
      extend ClassMethods
      include InstanceMethods
    end
    
    module ClassMethods
      
      def with_site
        with_scope :find => {:conditions => {:site_id => Site.current}} do
          yield
        end
      end
      
      def find_site(*args)
        with_site {find(*args)}
      end
      
      def site_tag_counts(*args)
        with_site {tag_counts(*args)}
      end
      
      def site_related_tags(*args)
        with_site {find_related_tags(*args)}
      end
      
      def method_missing(method, *args, &block)
        if method.to_s =~ /^find_(all_)?site_by/
          with_site do
            super(method.to_s.sub('site_', ''), *args, &block)
          end
        else
          super(method, *args, &block)
        end
      end
      
    end
    
    module InstanceMethods
      
      def set_site
        self.site = Site.current unless site_id
      end
      
    end
  end
end
  